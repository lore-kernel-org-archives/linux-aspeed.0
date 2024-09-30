From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 13:34:22 +0930
Subject: [PATCH v6 4/7] gpio: aspeed: Support G7 Aspeed gpio controller
In-Reply-To: <20240927111744.3511373-5-billy_tsai@aspeedtech.com>
References: <20240927111744.3511373-1-billy_tsai@aspeedtech.com>
	 <20240927111744.3511373-5-billy_tsai@aspeedtech.com>
Message-ID: <24164aadbe5628cea4f10b0028a5ddf6c1fb29f2.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-27 at 19:17 +0800, Billy Tsai wrote:
> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin's
> value, direction, interrupt type, and other settings. The permission for
> coprocessor access is supported by the hardware but hasn't been
> implemented in the current patch.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 132 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 3ed58289a4a8..1be9a7aa9e8b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -30,6 +30,27 @@
>  #include <linux/gpio/consumer.h>
>  #include "gpiolib.h"
>  
> +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
> +
> +#define GPIO_G7_IRQ_STS_BASE 0x100
> +#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
> +#define GPIO_G7_CTRL_REG_BASE 0x180
> +#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
> +#define GPIO_G7_CTRL_OUT_DATA BIT(0)
> +#define GPIO_G7_CTRL_DIR BIT(1)
> +#define GPIO_G7_CTRL_IRQ_EN BIT(2)
> +#define GPIO_G7_CTRL_IRQ_TYPE0 BIT(3)
> +#define GPIO_G7_CTRL_IRQ_TYPE1 BIT(4)
> +#define GPIO_G7_CTRL_IRQ_TYPE2 BIT(5)
> +#define GPIO_G7_CTRL_RST_TOLERANCE BIT(6)
> +#define GPIO_G7_CTRL_DEBOUNCE_SEL2 BIT(7)
> +#define GPIO_G7_CTRL_DEBOUNCE_SEL1 BIT(8)
> +#define GPIO_G7_CTRL_INPUT_MASK BIT(9)
> +#define GPIO_G7_CTRL_IRQ_STS BIT(12)
> +#define GPIO_G7_CTRL_IN_DATA BIT(13)
> +
>  struct aspeed_bank_props {
>  	unsigned int bank;
>  	u32 input;
> @@ -95,6 +116,7 @@ struct aspeed_gpio_bank {
>   */
>  
>  static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
> +static const int g7_debounce_timers[4] = { 0x00, 0x04, 0x00, 0x08 };

Why is 0 listed twice here?

That might be worth a comment if there's a good reason?

>  
>  static const struct aspeed_gpio_copro_ops *copro_ops;
>  static void *copro_data;
> @@ -250,6 +272,39 @@ static void __iomem *aspeed_gpio_g4_bank_reg(struct aspeed_gpio *gpio,
>  	BUG();
>  }
>  
> +static u32 aspeed_gpio_g7_reg_mask(const enum aspeed_gpio_reg reg)
> +{
> +	switch (reg) {
> +	case reg_val:
> +		return GPIO_G7_CTRL_OUT_DATA;
> +	case reg_dir:
> +		return GPIO_G7_CTRL_DIR;
> +	case reg_irq_enable:
> +		return GPIO_G7_CTRL_IRQ_EN;
> +	case reg_irq_type0:
> +		return GPIO_G7_CTRL_IRQ_TYPE0;
> +	case reg_irq_type1:
> +		return GPIO_G7_CTRL_IRQ_TYPE1;
> +	case reg_irq_type2:
> +		return GPIO_G7_CTRL_IRQ_TYPE2;
> +	case reg_tolerance:
> +		return GPIO_G7_CTRL_RST_TOLERANCE;
> +	case reg_debounce_sel1:
> +		return GPIO_G7_CTRL_DEBOUNCE_SEL1;
> +	case reg_debounce_sel2:
> +		return GPIO_G7_CTRL_DEBOUNCE_SEL2;
> +	case reg_rdata:
> +		return GPIO_G7_CTRL_OUT_DATA;
> +	case reg_irq_status:
> +		return GPIO_G7_CTRL_IRQ_STS;
> +	case reg_cmdsrc0:
> +	case reg_cmdsrc1:
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +
>  #define GPIO_BANK(x)	((x) >> 5)
>  #define GPIO_OFFSET(x)	((x) & 0x1f)
>  #define GPIO_BIT(x)	BIT(GPIO_OFFSET(x))
> @@ -1106,6 +1161,59 @@ static const struct aspeed_gpio_llops aspeed_g4_llops = {
>  	.privilege_ctrl = aspeed_g4_privilege_ctrl,
>  	.privilege_init = aspeed_g4_privilege_init,
>  };
> +
> +static void aspeed_g7_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg, bool val)
> +{
> +	u32 mask = aspeed_gpio_g7_reg_mask(reg);
> +	void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> +	u32 write_val;
> +
> +	if (mask) {
> +		write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
> +		iowrite32(write_val, addr);
> +	}
> +}
> +
> +static bool aspeed_g7_reg_bit_get(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg)
> +{
> +	u32 mask = aspeed_gpio_g7_reg_mask(reg);
> +	void __iomem *addr;
> +
> +	addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> +	if (reg == reg_val)
> +		mask = GPIO_G7_CTRL_IN_DATA;
> +
> +	if (mask)
> +		return field_get(mask, ioread32(addr));
> +	else
> +		return 0;
> +}
> +
> +static int aspeed_g7_reg_bank_get(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg)
> +{
> +	void __iomem *addr;
> +
> +	if (reg == reg_irq_status) {
> +		addr = gpio->base + GPIO_G7_IRQ_STS_OFFSET(offset >> 5);
> +		return ioread32(addr);
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct aspeed_gpio_llops aspeed_g7_llops = {
> +	.copro_request = NULL,
> +	.copro_release = NULL,
> +	.reg_bit_set = aspeed_g7_reg_bit_set,
> +	.reg_bit_get = aspeed_g7_reg_bit_get,
> +	.reg_bank_get = aspeed_g7_reg_bank_get,
> +	.privilege_ctrl = NULL,
> +	.privilege_init = NULL,
> +};

Same minor nitpick about the ordering if you respin the series.

Andrew

From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 24 Sep 2024 11:09:09 +0930
Subject: [PATCH v5 4/6] gpio: aspeed: Support G7 Aspeed gpio controller
In-Reply-To: <20240923100611.1597113-5-billy_tsai@aspeedtech.com>
References: <20240923100611.1597113-1-billy_tsai@aspeedtech.com>
	 <20240923100611.1597113-5-billy_tsai@aspeedtech.com>
Message-ID: <fe54dfef05d67a44a60eb497cdc052aeeed4a4d0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Mon, 2024-09-23 at 18:06 +0800, Billy Tsai wrote:
> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin's
> value, direction, interrupt type, and other settings. The permission for
> coprocessor access is supported by the hardware but hasn't been
> implemented in the current patch.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 122 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index d3994d833684..7418d65be721 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -30,6 +30,23 @@
>  #include <linux/gpio/consumer.h>
>  #include "gpiolib.h"
>  
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
> @@ -95,6 +112,7 @@ struct aspeed_gpio_bank {
>   */
>  
>  static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
> +static const int g7_debounce_timers[4] = { 0x00, 0x04, 0x00, 0x08 };
>  
>  static const struct aspeed_gpio_copro_ops *copro_ops;
>  static void *copro_data;
> @@ -250,6 +268,39 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
>  	BUG();
>  }
>  
> +static inline u32 reg_mask(const enum aspeed_gpio_reg reg)

This is specific to the AST2700/G7, can you name it as such? Also I
find in helpful when reading backtraces if even static functions are
prefixed with e.g. aspeed_gpio_.

Other than that, the broad preference is to not mark functions as
inline. The function is already static and the keyword is at best a
hint, the compiler will decide what it thinks is best either way.

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
> @@ -1106,6 +1157,53 @@ static const struct aspeed_gpio_llops aspeed_g4_llops = {
>  	.privilege_ctrl = aspeed_g4_privilege_ctrl,
>  	.privilege_init = aspeed_g4_privilege_init,
>  };
> +
> +static void aspeed_g7_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg, bool val)
> +{
> +	u32 mask = reg_mask(reg);
> +	void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> +	u32 write_val = (ioread32(addr) & ~(mask)) | (((val) << (ffs(mask) - 1)) & (mask));

Might be worth poking@whether there are existing macros or functions
that can more clearly describe this bit-hackery :)

Subtracting 1 from 0 to feed a shift is problematic.

> +
> +	iowrite32(write_val, addr);
> +}
> +
> +static bool aspeed_g7_reg_bit_get(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg)
> +{
> +	u32 mask = reg_mask(reg);
> +	void __iomem *addr;
> +
> +	addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
> +	if (reg == reg_val)
> +		mask = GPIO_G7_CTRL_IN_DATA;
> +
> +	return (((ioread32(addr)) & (mask)) >> (ffs(mask) - 1));

Again, can we avoid open-coding the bit-hackery? The subtraction is
still problematic.

Andrew

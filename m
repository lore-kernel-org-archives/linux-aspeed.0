From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Jun 2018 15:08:13 +0930
Subject: [PATCH 3/4] gpio: aspeed: Add command source registers
In-Reply-To: <20180612001043.9327-4-benh@kernel.crashing.org>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-4-benh@kernel.crashing.org>
Message-ID: <CACPK8XeDaGm+mTih4+-oM9nSnkuN0EJrC+ugKz0O_jYxHu+kTg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12 June 2018 at 09:40, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This adds the definitions for the command source registers
> and a helper to set them.
>
> Those registers allow to control which bus master on the
> SoC is allowed to modify a given bank of GPIOs and will
> be used by subsequent patches.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 55 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 210c3fcc7a40..06510634ddd6 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -66,6 +66,7 @@ struct aspeed_gpio_bank {
>         uint16_t        irq_regs;
>         uint16_t        debounce_regs;
>         uint16_t        tolerance_regs;
> +       uint16_t        cmdsrc_regs;
>         const char      names[4][3];
>  };
>
> @@ -78,6 +79,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
>                 .irq_regs = 0x0008,
>                 .debounce_regs = 0x0040,
>                 .tolerance_regs = 0x001c,
> +               .cmdsrc_regs = 0x0060,
>                 .names = { "A", "B", "C", "D" },
>         },
>         {
> @@ -86,6 +88,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
>                 .irq_regs = 0x0028,
>                 .debounce_regs = 0x0048,
>                 .tolerance_regs = 0x003c,
> +               .cmdsrc_regs = 0x0068,
>                 .names = { "E", "F", "G", "H" },
>         },
>         {
> @@ -94,21 +97,25 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
>                 .irq_regs = 0x0098,
>                 .debounce_regs = 0x00b0,
>                 .tolerance_regs = 0x00ac,
> +               .cmdsrc_regs = 0x0090,
>                 .names = { "I", "J", "K", "L" },
>         },
>         {
>                 .val_regs = 0x0078,
> -               .rdata_reg = 0x00d0,
> +               .rdata_reg = 0x00cc,
>                 .irq_regs = 0x00e8,
>                 .debounce_regs = 0x0100,
>                 .tolerance_regs = 0x00fc,
> +               .cmdsrc_regs = 0x00e0,
>                 .names = { "M", "N", "O", "P" },
>         },
>         {
>                 .val_regs = 0x0080,
> +               .rdata_reg = 0x00d0,

See the comments in patch 2.

>                 .irq_regs = 0x0118,
>                 .debounce_regs = 0x0130,
>                 .tolerance_regs = 0x012c,
> +               .cmdsrc_regs = 0x0110,
>                 .names = { "Q", "R", "S", "T" },
>         },
>         {
> @@ -117,22 +124,25 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
>                 .irq_regs = 0x0148,
>                 .debounce_regs = 0x0160,
>                 .tolerance_regs = 0x015c,
> +               .cmdsrc_regs = 0x0140,
>                 .names = { "U", "V", "W", "X" },
>         },
>         {
>                 .val_regs = 0x01E0,
> -               .rdata_reg = 0x00d4,
> +               .rdata_reg = 0x00d8,
>                 .irq_regs = 0x0178,
>                 .debounce_regs = 0x0190,
>                 .tolerance_regs = 0x018c,
> +               .cmdsrc_regs = 0x0170,
>                 .names = { "Y", "Z", "AA", "AB" },
>         },
>         {
>                 .val_regs = 0x01e8,
> -               .rdata_reg = 0x00d8,
> +               .rdata_reg = 0x00dc,
>                 .irq_regs = 0x01a8,
>                 .debounce_regs = 0x01c0,
>                 .tolerance_regs = 0x01bc,
> +               .cmdsrc_regs = 0x01a0,
>                 .names = { "AC", "", "", "" },
>         },
>  };
> @@ -149,6 +159,8 @@ enum aspeed_gpio_reg {
>         reg_debounce_sel1,
>         reg_debounce_sel2,
>         reg_tolerance,
> +       reg_cmdsrc0,
> +       reg_cmdsrc1,
>  };
>
>  #define GPIO_VAL_VALUE 0x00
> @@ -163,6 +175,12 @@ enum aspeed_gpio_reg {
>  #define GPIO_DEBOUNCE_SEL1 0x00
>  #define GPIO_DEBOUNCE_SEL2 0x04
>
> +#define GPIO_CMDSRC_0  0x00
> +#define GPIO_CMDSRC_1  0x04
> +#define  GPIO_CMDSRC_ARM               0
> +#define  GPIO_CMDSRC_LPC               1
> +#define  GPIO_CMDSRC_COLDFIRE          2

Something like this to document that 0b11 is illegal, for people who
don't have the datasheet handy?

#define GPIO_CMDSRC_RESERVED 3

> +
>  /* This will be resolved at compile time */
>  static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
>                                      const struct aspeed_gpio_bank *bank,
> @@ -191,6 +209,10 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
>                 return gpio->base + bank->debounce_regs + GPIO_DEBOUNCE_SEL2;
>         case reg_tolerance:
>                 return gpio->base + bank->tolerance_regs;
> +       case reg_cmdsrc0:
> +               return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_0;
> +       case reg_cmdsrc1:
> +               return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
>         }
>         BUG_ON(1);
>  }
> @@ -257,6 +279,33 @@ static inline bool have_output(struct aspeed_gpio *gpio, unsigned int offset)
>         return !props || (props->output & GPIO_BIT(offset));
>  }
>
> +static void aspeed_gpio_change_cmd_source(struct aspeed_gpio *gpio,
> +                                         const struct aspeed_gpio_bank *bank,
> +                                         int bindex, int cmdsrc)
> +{
> +       void __iomem *c0 = bank_reg(gpio, bank, reg_cmdsrc0);
> +       void __iomem *c1 = bank_reg(gpio, bank, reg_cmdsrc1);
> +       u32 bit, reg;
> +
> +       bit = 1u << ((bindex & 3) << 3);

I didn't follow this on first go. If you can think of a way to make it
clearer that the first 3 is just to mask off the first two bits that
would be handy.

And perhaps this?

bit = BIT((bindex & 3) << 3);

> +
> +       /* Source 1 first to avoid illegal 11 combination */
> +       reg = ioread32(c1);
> +       if (cmdsrc & 2)
> +               reg |= bit;
> +       else
> +               reg &= ~bit;
> +       iowrite32(reg, c1);
> +
> +       /* Then Source 0 */
> +       reg = ioread32(c0);
> +       if (cmdsrc & 1)
> +               reg |= bit;
> +       else
> +               reg &= ~bit;
> +       iowrite32(reg, c0);
> +}
> +
>  static int aspeed_gpio_get(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct aspeed_gpio *gpio = gpiochip_get_data(gc);
> --
> 2.17.0
>

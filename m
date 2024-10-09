From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 9 Oct 2024 02:28:10 +0000
Subject: [PATCH v7 7/7] gpio: aspeed: Support G7 Aspeed gpio controller
In-Reply-To: <66e619a9085a2ecb62e3945cd024822de5317f92.camel@codeconstruct.com.au>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
	 <20241008081450.1490955-8-billy_tsai@aspeedtech.com>
 <66e619a9085a2ecb62e3945cd024822de5317f92.camel@codeconstruct.com.au>
Message-ID: <OSQPR06MB72526C8FE71BF336D8AF50758B7F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > In the 7th generation of the SoC from Aspeed, the control logic of the
> > GPIO controller has been updated to support per-pin control. Each pin now
> > has its own 32-bit register, allowing for individual control of the pin's
> > value, direction, interrupt type, and other settings. The permission for
> > coprocessor access is supported by the hardware but hasn't been
> > implemented in the current patch.
> >
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 147 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 147 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index 5d583cc9cbc7..208f95fb585e 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -30,6 +30,27 @@
> >  #include <linux/gpio/consumer.h>
> >  #include "gpiolib.h"
> >
> > +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#define field_get(_mask, _reg)       (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#define field_prep(_mask, _val)      (((_val) << (ffs(_mask) - 1)) & (_mask))
> > +
> > +#define GPIO_G7_IRQ_STS_BASE 0x100
> > +#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
> > +#define GPIO_G7_CTRL_REG_BASE 0x180
> > +#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
> > +#define GPIO_G7_CTRL_OUT_DATA BIT(0)
> > +#define GPIO_G7_CTRL_DIR BIT(1)
> > +#define GPIO_G7_CTRL_IRQ_EN BIT(2)
> > +#define GPIO_G7_CTRL_IRQ_TYPE0 BIT(3)
> > +#define GPIO_G7_CTRL_IRQ_TYPE1 BIT(4)
> > +#define GPIO_G7_CTRL_IRQ_TYPE2 BIT(5)
> > +#define GPIO_G7_CTRL_RST_TOLERANCE BIT(6)
> > +#define GPIO_G7_CTRL_DEBOUNCE_SEL1 BIT(7)
> > +#define GPIO_G7_CTRL_DEBOUNCE_SEL2 BIT(8)
> > +#define GPIO_G7_CTRL_INPUT_MASK BIT(9)
> > +#define GPIO_G7_CTRL_IRQ_STS BIT(12)
> > +#define GPIO_G7_CTRL_IN_DATA BIT(13)
> > +
> >  struct aspeed_bank_props {
> >       unsigned int bank;
> >       u32 input;
> > @@ -95,6 +116,22 @@ struct aspeed_gpio_bank {
> >   */
> >
> >  static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
> > +static const int g7_debounce_timers[4] = { 0x00, 0x00, 0x04, 0x08 };
> > +
> > +/*
> > + * The debounce timers array is used to configure the debounce timer settings.Here?s how it works:
> > + * Array Value: Indicates the offset for configuring the debounce timer.
> > + * Array Index: Corresponds to the debounce setting register.
> > + * The debounce timers array follows this pattern for configuring the debounce setting registers:
> > + * Array Index 0: No debounce timer is set;
> > + *             Array Value is irrelevant (don?t care).
> > + * Array Index 1: Debounce setting #2 is set to 1, and debounce setting #1 is set to 0.
> > + *             Array Value: offset for configuring debounce timer 0 (g4: 0x50, g7: 0x00)
> > + * Array Index 2: Debounce setting #2 is set to 0, and debounce setting #1 is set to 1.
> > + *             Array Value: offset for configuring debounce timer 1 (g4: 0x54, g7: 0x04)
> > + * Array Index 3: Debounce setting #2 is set to 1, and debounce setting #1 is set to 1.
> > + *             Array Value: offset for configuring debounce timer 2 (g4: 0x58, g7: 0x8)
> > + */
> >
> >  static const struct aspeed_gpio_copro_ops *copro_ops;
> >  static void *copro_data;
> > @@ -250,6 +287,39 @@ static void __iomem *aspeed_gpio_g4_bank_reg(struct aspeed_gpio *gpio,
> >       BUG();
> >  }
> >
> > +static u32 aspeed_gpio_g7_reg_mask(const enum aspeed_gpio_reg reg)
> > +{
> > +     switch (reg) {
> > +     case reg_val:
> > +             return GPIO_G7_CTRL_OUT_DATA;

> I think a problem is that we want this to be GPIO_G7_CTRL_IN_DATA for
> reads, but GPIO_G7_CTRL_OUT_DATA for writes?

Yes. So in my aspeed_g7_bit_get, I will change the mask to GPIO_G7_CTRL_IN_DATA.

+static bool aspeed_g7_reg_bit_get(struct aspeed_gpio *gpio, unsigned int offset,
+                                 const enum aspeed_gpio_reg reg)
+{
+       u32 mask = aspeed_gpio_g7_reg_mask(reg);
+       void __iomem *addr;
+
+       addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
+       if (reg == reg_val)
+               mask = GPIO_G7_CTRL_IN_DATA;
+
+       if (mask)
+               return field_get(mask, ioread32(addr));
+       else
+               return 0;
+}
+

From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Thu, 20 May 2021 11:31:41 +0800
Subject: [PATCH 1/3] i2c: aspeed: avoid new registers definition of AST2600
In-Reply-To: <CACPK8XdNXiGMQZOtsfMMK+w_PSvO20XT8B9MG+rGhdjYoV4ZuQ@mail.gmail.com>
References: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
 <20210519080436.18975-2-jamin_lin@aspeedtech.com>
 <CACPK8XdNXiGMQZOtsfMMK+w_PSvO20XT8B9MG+rGhdjYoV4ZuQ@mail.gmail.com>
Message-ID: <20210520033140.GA3656@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/19/2021 22:59, Joel Stanley wrote:
> On Wed, 19 May 2021 at 08:05, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> >
> > The register definition between AST2600 A2 and A3 is different.
> > This patch avoid new registers definition of AST2600 to use
> > this driver. We will submit the path for the new registers
> > definition of AST2600.
> 
> The AST2600 v9 datasheet says that bit 2 selects between old and new
> register sets, and that the old register set is the default.
> 
> Has the default changed for the A3?, and the datasheet is incorrect?
> 
> Does the A3 still support the old register set?
> 
We suggest user to use the new i2c driver for AST2600 and we will sumbit
it. This driver is used to AST2500 and AST2400 SOCs. Change this
driver to check global register of i2c to avoid user build the wrong driver. 

> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  drivers/i2c/busses/i2c-aspeed.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> > index 724bf30600d6..007309077d9f 100644
> > --- a/drivers/i2c/busses/i2c-aspeed.c
> > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > @@ -19,14 +19,20 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/reset.h>
> >  #include <linux/slab.h>
> >
> > +/* I2C Global Registers */
> > +/* 0x0c : I2CG Global Control Register (AST2500)  */
> > +#define ASPEED_I2CG_GLOBAL_CTRL_REG                    0x0c
> > +
> >  /* I2C Register */
> >  #define ASPEED_I2C_FUN_CTRL_REG                                0x00
> >  #define ASPEED_I2C_AC_TIMING_REG1                      0x04
> > @@ -973,6 +979,22 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> >         struct resource *res;
> >         int irq, ret;
> >
> > +       if (of_device_is_compatible(pdev->dev.of_node,
> > +                                   "aspeed,ast2600-i2c-bus")) {
> > +               u32 global_ctrl;
> > +               struct regmap *gr_regmap;
> > +
> > +               gr_regmap = syscon_regmap_lookup_by_compatible("aspeed,ast2600-i2c-global");
> > +
> > +               if (IS_ERR(gr_regmap)) {
> > +                       ret = PTR_ERR(gr_regmap);
> > +               } else {
> > +                       regmap_read(gr_regmap, ASPEED_I2CG_GLOBAL_CTRL_REG, &global_ctrl);
> > +                       if (global_ctrl & BIT(2))
> > +                               return -EIO;
> > +               }
> > +       }
> > +
> >         bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> >         if (!bus)
> >                 return -ENOMEM;
> > --
> > 2.17.1
> >

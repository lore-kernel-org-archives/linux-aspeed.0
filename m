From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 21 Mar 2022 08:20:01 +0000
Subject: [PATCH 1/2] net: mdio: add reset deassertion for Aspeed MDIO
In-Reply-To: <84f2c72ced35506522ea3a6be72879d1699f885b.camel@pengutronix.de>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
 <20220321070131.23363-2-dylan_hung@aspeedtech.com>
 <84f2c72ced35506522ea3a6be72879d1699f885b.camel@pengutronix.de>
Message-ID: <HK0PR06MB28349EC113B35E5C2741BC3A9C169@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Philipp Zabel [mailto:p.zabel at pengutronix.de]
> Sent: 2022?3?21? 4:15 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>; robh+dt at kernel.org;
> joel at jms.id.au; andrew at aj.id.au; andrew at lunn.ch; hkallweit1 at gmail.com;
> linux at armlinux.org.uk; davem at davemloft.net; kuba at kernel.org;
> pabeni at redhat.com; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; netdev at vger.kernel.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; stable at vger.kernel.org
> Subject: Re: [PATCH 1/2] net: mdio: add reset deassertion for Aspeed MDIO
> 
> Hi Dylan,
> 
> On Mo, 2022-03-21 at 15:01 +0800, Dylan Hung wrote:
> > Add reset deassertion for Aspeed MDIO.? There are 4 MDIO controllers
> > embedded in Aspeed AST2600 SOC and share one reset control register
> > SCU50[3]. So devm_reset_control_get_shared is used in this change.
> >
> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > Cc: stable at vger.kernel.org
> > ---
> > ?drivers/net/mdio/mdio-aspeed.c | 8 ++++++++
> > ?1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-
> > aspeed.c index e2273588c75b..8ac262a12d13 100644
> > --- a/drivers/net/mdio/mdio-aspeed.c
> > +++ b/drivers/net/mdio/mdio-aspeed.c
> > @@ -3,6 +3,7 @@
> >
> > ?#include <linux/bitfield.h>
> > ?#include <linux/delay.h>
> > +#include <linux/reset.h>
> > ?#include <linux/iopoll.h>
> > ?#include <linux/mdio.h>
> > ?#include <linux/module.h>
> > @@ -37,6 +38,7 @@
> >
> > ?struct aspeed_mdio {
> > ????????void __iomem *base;
> > +???????struct reset_control *reset;
> > ?};
> >
> > ?static int aspeed_mdio_read(struct mii_bus *bus, int addr, int
> > regnum)
> > @@ -120,6 +122,12 @@ static int aspeed_mdio_probe(struct
> > platform_device *pdev)
> > ????????if (IS_ERR(ctx->base))
> > ????????????????return PTR_ERR(ctx->base);
> >
> > +???????ctx->reset = devm_reset_control_get_shared(&pdev->dev, NULL);
> 
> The device tree bindings should have a required reset control property
> documented before this is added.
> 

OK, I will add a commit for the document in V2.

> > +???????if (IS_ERR(ctx->reset))
> > +???????????????return PTR_ERR(ctx->reset);
> > +
> > +???????reset_control_deassert(ctx->reset);
> > +
> 
> This is missing a corresponding reset_control_assert() in
> aspeed_mdio_remove() and in the error path of of_mdiobus_register().
> That would allow to assert the reset line again after all MDIO controllers are
> unbound.

Thank you for your comment. I will fix it in V2.

> 
> regards
> Philipp

--
Dylan

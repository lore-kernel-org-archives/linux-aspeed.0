From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 24 Nov 2021 10:33:24 +0000
Subject: [PATCH] net:phy: Fix "Link is Down" issue
In-Reply-To: <CACPK8Xc8aD8nY0M442=BdvrpRhYNS1HW7BNQgAQ+ExTfQMsMyQ@mail.gmail.com>
References: <20211124061057.12555-1-dylan_hung@aspeedtech.com>
 <CACPK8Xc8aD8nY0M442=BdvrpRhYNS1HW7BNQgAQ+ExTfQMsMyQ@mail.gmail.com>
Message-ID: <HK0PR06MB2834489E23CA1F4281840D799C619@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley [mailto:joel at jms.id.au]
> Sent: 2021?11?24? 6:06 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>; Networking
> <netdev@vger.kernel.org>; Andrew Jeffery <andrew@aj.id.au>; Jakub Kicinski
> <kuba@kernel.org>; David S . Miller <davem@davemloft.net>; Russell King
> <linux@armlinux.org.uk>; hkallweit1 at gmail.com; Andrew Lunn
> <andrew@lunn.ch>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] net:phy: Fix "Link is Down" issue
> 
> On Wed, 24 Nov 2021 at 06:11, Dylan Hung <dylan_hung@aspeedtech.com>
> wrote:
> >
> > The issue happened randomly in runtime.  The message "Link is Down" is
> > popped but soon it recovered to "Link is Up".
> >
> > The "Link is Down" results from the incorrect read data for reading
> > the PHY register via MDIO bus.  The correct sequence for reading the
> > data shall be:
> > 1. fire the command
> > 2. wait for command done (this step was missing) 3. wait for data idle
> > 4. read data from data register
> 
> I consulted the datasheet and it doesn't mention this. Perhaps something to be
> added?
We will add this sequence into the datasheet, thank you.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> >
> > Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new
> > subdirectory")
> 
> I think this should be:
> 
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
I will change this in V2.
> 
> We should cc stable too.
I will change this in V2.
> 
> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > ---
> >  drivers/net/mdio/mdio-aspeed.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/mdio/mdio-aspeed.c
> > b/drivers/net/mdio/mdio-aspeed.c index cad820568f75..966c3b4ad59d
> > 100644
> > --- a/drivers/net/mdio/mdio-aspeed.c
> > +++ b/drivers/net/mdio/mdio-aspeed.c
> > @@ -61,6 +61,13 @@ static int aspeed_mdio_read(struct mii_bus *bus,
> > int addr, int regnum)
> >
> >         iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> >
> > +       rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
> > +                               !(ctrl & ASPEED_MDIO_CTRL_FIRE),
> > +                               ASPEED_MDIO_INTERVAL_US,
> > +                               ASPEED_MDIO_TIMEOUT_US);
> > +       if (rc < 0)
> > +               return rc;
> > +
> >         rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_DATA, data,
> >                                 data & ASPEED_MDIO_DATA_IDLE,
> >                                 ASPEED_MDIO_INTERVAL_US,
> > --
> > 2.25.1
> >

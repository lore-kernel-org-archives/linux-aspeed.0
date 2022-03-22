From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 22 Mar 2022 09:10:28 +0000
Subject: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
In-Reply-To: <YjhrUrXzLxvKtDP8@lunn.ch>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
 <YjhrUrXzLxvKtDP8@lunn.ch>
Message-ID: <HK0PR06MB283430933D2FE015531B52749C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 2022?3?21? 8:11 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: robh+dt at kernel.org; joel at jms.id.au; andrew at aj.id.au;
> hkallweit1 at gmail.com; linux at armlinux.org.uk; davem at davemloft.net;
> kuba at kernel.org; pabeni at redhat.com; p.zabel at pengutronix.de;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> netdev at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
> 
> On Mon, Mar 21, 2022 at 03:01:29PM +0800, Dylan Hung wrote:
> > Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs
> > embedded in Aspeed AST2600 and share one reset control bit SCU50[3].
> 
> Is the reset limited to the MDIO bus masters, or are PHYs one the bus
> potentially also reset?

It is limited to the MDIO bus masters.

> 
> Who asserts the reset in the first place? 

The hardware asserts the reset by default.

> Don't you want the first MDIO bus to
> probe to assert and then deassert the reset in order that all the hardware is
> reset?

Do I still need to add a reset assertion/deassertion if the hardware asserts the reset by default?

> 
>     Andrew

--
Dylan


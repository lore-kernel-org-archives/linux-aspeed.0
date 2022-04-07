From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Thu, 7 Apr 2022 06:29:26 +0000
Subject: [PATCH v3 2/3] net: mdio: add reset control for Aspeed MDIO
In-Reply-To: <YkVUWV0czTzo6MrJ@shell.armlinux.org.uk>
References: <20220325041451.894-1-dylan_hung@aspeedtech.com>
 <20220325041451.894-3-dylan_hung@aspeedtech.com>
 <YkVUWV0czTzo6MrJ@shell.armlinux.org.uk>
Message-ID: <HK0PR06MB2834DA2D814BC55A10F6584D9CE69@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Russell,

> -----Original Message-----
> From: Russell King [mailto:linux at armlinux.org.uk]
> Sent: 2022?3?31? 3:12 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: robh+dt at kernel.org; joel at jms.id.au; andrew at aj.id.au; andrew at lunn.ch;
> hkallweit1 at gmail.com; davem at davemloft.net; kuba at kernel.org;
> pabeni at redhat.com; p.zabel at pengutronix.de; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; netdev at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3 2/3] net: mdio: add reset control for Aspeed MDIO
> 
> Hi,
> 
> On Fri, Mar 25, 2022 at 12:14:50PM +0800, Dylan Hung wrote:
> > Add reset assertion/deassertion for Aspeed MDIO.  There are 4 MDIO
> > controllers embedded in Aspeed AST2600 SOC and share one reset control
> > register SCU50[3].  To work with old DT blobs which don't have the
> > reset property, devm_reset_control_get_optional_shared is used in this
> change.
> >
> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Should this really be specific to one driver rather than being handled in the
> core mdio code?
> 

Is the core mdio code able to know the reset is shared or exclusive? I supposed that
the reset property is hardware dependent. Did I get that right?

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 22 Mar 2022 04:00:43 +0100
Subject: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties into MDIO
 nodes
In-Reply-To: <HK0PR06MB2834CFADF087A439B06F87C29C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-4-dylan_hung@aspeedtech.com>
 <eefe6dd8-6542-a5c2-6bdf-2c3ffe06e06b@kernel.org>
 <HK0PR06MB2834CFADF087A439B06F87C29C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
Message-ID: <Yjk722CyEW3q1ntm@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 22, 2022 at 02:32:13AM +0000, Dylan Hung wrote:
> > -----Original Message-----
> > From: Krzysztof Kozlowski [mailto:krzk at kernel.org]
> > Sent: 2022?3?21? 11:53 PM
> > To: Dylan Hung <dylan_hung@aspeedtech.com>; robh+dt at kernel.org;
> > joel at jms.id.au; andrew at aj.id.au; andrew at lunn.ch; hkallweit1 at gmail.com;
> > linux at armlinux.org.uk; davem at davemloft.net; kuba at kernel.org;
> > pabeni at redhat.com; p.zabel at pengutronix.de; devicetree at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> > linux-kernel at vger.kernel.org; netdev at vger.kernel.org
> > Cc: BMC-SW <BMC-SW@aspeedtech.com>; stable at vger.kernel.org
> > Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties into MDIO
> > nodes
> > 
> > On 21/03/2022 10:56, Dylan Hung wrote:
> > > Add reset control properties into MDIO nodes.  The 4 MDIO controllers in
> > > AST2600 SOC share one reset control bit SCU50[3].
> > >
> > > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > > Cc: stable at vger.kernel.org
> > 
> > Please describe the bug being fixed. See stable-kernel-rules.
> 
> Thank you for your comment.
> The reset deassertion of the MDIO device was usually done by the bootloader (u-boot).
> However, one of our clients uses proprietary bootloader and doesn't deassert the MDIO
> reset so failed to access the HW in kernel driver.

So are you saying mainline u-boot releases the reset?

> The reset deassertion is missing in the
> kernel driver since it was created, should I add a BugFix for the first commit of this driver?

Yes, that is normal. Ideally the kernel should not depend on u-boot,
because often people want to use other bootloaders, e.g. barebox. You
should also consider kexec, where one kernel hands over to another
kernel, without the bootloader being involved. In such a situation,
you ideally want to assert and deassert the reset just to clean away
any state the old kernel left around.

But please do note, that the reset is optional, since you need to be
able to work with old DT blobs which don't have the reset property in
them.

	Andrew




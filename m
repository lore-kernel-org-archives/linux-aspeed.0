From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 22 Mar 2022 08:44:43 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties into MDIO
 nodes
In-Reply-To: <216b98d5-a254-4527-c569-9f3397811e70@kernel.org>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-4-dylan_hung@aspeedtech.com>
 <eefe6dd8-6542-a5c2-6bdf-2c3ffe06e06b@kernel.org>
 <HK0PR06MB2834CFADF087A439B06F87C29C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
 <216b98d5-a254-4527-c569-9f3397811e70@kernel.org>
Message-ID: <HK0PR06MB2834EDCF527EE9DE79C1A6AE9C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk at kernel.org]
> Sent: 2022?3?22? 4:40 PM
> To: Dylan Hung <dylan_hung@aspeedtech.com>; robh+dt at kernel.org;
> joel at jms.id.au; andrew at aj.id.au; andrew at lunn.ch; hkallweit1 at gmail.com;
> linux at armlinux.org.uk; davem at davemloft.net; kuba at kernel.org;
> pabeni at redhat.com; p.zabel at pengutronix.de; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; netdev at vger.kernel.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; stable at vger.kernel.org
> Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties into MDIO
> nodes
> 
> On 22/03/2022 03:32, Dylan Hung wrote:
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski [mailto:krzk at kernel.org]
> >> Sent: 2022?3?21? 11:53 PM
> >> To: Dylan Hung <dylan_hung@aspeedtech.com>; robh+dt at kernel.org;
> >> joel at jms.id.au; andrew at aj.id.au; andrew at lunn.ch;
> >> hkallweit1 at gmail.com; linux at armlinux.org.uk; davem at davemloft.net;
> >> kuba at kernel.org; pabeni at redhat.com; p.zabel at pengutronix.de;
> >> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >> netdev at vger.kernel.org
> >> Cc: BMC-SW <BMC-SW@aspeedtech.com>; stable at vger.kernel.org
> >> Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties
> >> into MDIO nodes
> >>
> >> On 21/03/2022 10:56, Dylan Hung wrote:
> >>> Add reset control properties into MDIO nodes.  The 4 MDIO
> >>> controllers in
> >>> AST2600 SOC share one reset control bit SCU50[3].
> >>>
> >>> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> >>> Cc: stable at vger.kernel.org
> >>
> >> Please describe the bug being fixed. See stable-kernel-rules.
> >
> > Thank you for your comment.
> > The reset deassertion of the MDIO device was usually done by the
> bootloader (u-boot).
> > However, one of our clients uses proprietary bootloader and doesn't
> > deassert the MDIO reset so failed to access the HW in kernel driver.
> > The reset deassertion is missing in the kernel driver since it was created,
> should I add a BugFix for the first commit of this driver?
> > Or would it be better if I remove " Cc: stable at vger.kernel.org"?
> 
> This rather looks like a missing feature, not a bug. Anyway any description
> must be in commit message.

Thank you. I will remove " Cc: stable at vger.kernel.org" and add more description
in commit message in V3.

> 
> 
> Best regards,
> Krzysztof

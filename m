From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Thu, 25 Nov 2021 01:42:08 +0000
Subject: [PATCH] net:phy: Fix "Link is Down" issue
In-Reply-To: <20211124153042.54d164dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211124061057.12555-1-dylan_hung@aspeedtech.com>
 <20211124153042.54d164dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <HK0PR06MB2834A8D8845F53F6CE228F019C629@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Jakub Kicinski [mailto:kuba at kernel.org]
> Sent: 2021?11?25? 7:31 AM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: linux-kernel at vger.kernel.org; linux-aspeed at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org;
> andrew at aj.id.au; joel at jms.id.au; davem at davemloft.net;
> linux at armlinux.org.uk; hkallweit1 at gmail.com; andrew at lunn.ch; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] net:phy: Fix "Link is Down" issue
> 
> On Wed, 24 Nov 2021 14:10:57 +0800 Dylan Hung wrote:
> > Subject: [PATCH] net:phy: Fix "Link is Down" issue
> 
> Since there will be v2, please also add a space between net: and phy:.

Should I use "net: mdio: " instead of "net: phy: "? Since this file was moved from net/phy to net/mdio by commit a9770eac511a.

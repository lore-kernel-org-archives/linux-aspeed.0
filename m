From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Thu, 25 Nov 2021 03:08:22 +0000
Subject: [PATCH] net:phy: Fix "Link is Down" issue
In-Reply-To: <YZ5adFBpaJzPwfvc@lunn.ch>
References: <20211124061057.12555-1-dylan_hung@aspeedtech.com>
 <CACPK8Xc8aD8nY0M442=BdvrpRhYNS1HW7BNQgAQ+ExTfQMsMyQ@mail.gmail.com>
 <YZ5adFBpaJzPwfvc@lunn.ch>
Message-ID: <HK0PR06MB283498AF35B397F05CC627A99C629@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 2021?11?24? 11:30 PM
> To: Joel Stanley <joel@jms.id.au>
> Cc: Dylan Hung <dylan_hung@aspeedtech.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-aspeed <linux-aspeed@lists.ozlabs.org>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; Networking
> <netdev@vger.kernel.org>; Andrew Jeffery <andrew@aj.id.au>; Jakub Kicinski
> <kuba@kernel.org>; David S . Miller <davem@davemloft.net>; Russell King
> <linux@armlinux.org.uk>; hkallweit1 at gmail.com; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] net:phy: Fix "Link is Down" issue
> 
> > We should cc stable too.
> 
> https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html#how-do-
> i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in
> 
> 	Andrew

Sorry, I got this mail after I sent v2 out.  Should I prepare patch v3 with --subject-prefix='PATCH net'?

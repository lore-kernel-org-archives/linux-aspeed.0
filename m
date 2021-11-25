From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 24 Nov 2021 19:18:54 -0800
Subject: [PATCH] net:phy: Fix "Link is Down" issue
In-Reply-To: <HK0PR06MB283498AF35B397F05CC627A99C629@HK0PR06MB2834.apcprd06.prod.outlook.com>
References: <20211124061057.12555-1-dylan_hung@aspeedtech.com>
 <CACPK8Xc8aD8nY0M442=BdvrpRhYNS1HW7BNQgAQ+ExTfQMsMyQ@mail.gmail.com>
 <YZ5adFBpaJzPwfvc@lunn.ch>
 <HK0PR06MB283498AF35B397F05CC627A99C629@HK0PR06MB2834.apcprd06.prod.outlook.com>
Message-ID: <20211124191854.4666a185@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 25 Nov 2021 03:08:22 +0000 Dylan Hung wrote:
> > > We should cc stable too.  
> > 
> > https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html#how-do-
> > i-indicate-which-tree-net-vs-net-next-my-patch-should-be-in
>
> Sorry, I got this mail after I sent v2 out.  Should I prepare patch
> v3 with --subject-prefix='PATCH net'?

That's leave it be now, but please keep this in mind in the future.

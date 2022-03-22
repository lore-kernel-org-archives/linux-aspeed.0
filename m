From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 22 Mar 2022 13:17:45 +0100
Subject: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
In-Reply-To: <HK0PR06MB283430933D2FE015531B52749C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
 <YjhrUrXzLxvKtDP8@lunn.ch>
 <HK0PR06MB283430933D2FE015531B52749C179@HK0PR06MB2834.apcprd06.prod.outlook.com>
Message-ID: <Yjm+aQwXuWh5TLpr@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Do I still need to add a reset assertion/deassertion if the hardware
> asserts the reset by default?

One use case would be kexec when one kernel is used to boot another
kernel. But since this is shared by multiple busses, it is probably
not worth the complexity unless that is something you expect you
customers to do, e.g. during kernel development work.

	Andrew

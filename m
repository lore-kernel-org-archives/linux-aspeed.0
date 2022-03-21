From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 21 Mar 2022 13:45:30 +0100
Subject: [PATCH v2 0/3]  Add reset deassertion for Aspeed MDIO
In-Reply-To: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
Message-ID: <YjhzatUg09SoH9DR@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 21, 2022 at 05:56:45PM +0800, Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs embedded
> in Aspeed AST2600 and share one reset control bit SCU50[3].

Hi Dylan

Please wait at least 24 hours between posting versions, to give other
people times to comment.

The danger here is that my comments on the previous version are going
to get ignored, and this version merged containing the issues i
pointed out.

	Andrew

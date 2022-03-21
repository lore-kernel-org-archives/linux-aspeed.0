From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 21 Mar 2022 13:10:58 +0100
Subject: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
In-Reply-To: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
Message-ID: <YjhrUrXzLxvKtDP8@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 21, 2022 at 03:01:29PM +0800, Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs
> embedded in Aspeed AST2600 and share one reset control bit SCU50[3].

Is the reset limited to the MDIO bus masters, or are PHYs one the bus
potentially also reset?

Who asserts the reset in the first place? Don't you want the first
MDIO bus to probe to assert and then deassert the reset in order that
all the hardware is reset?

    Andrew

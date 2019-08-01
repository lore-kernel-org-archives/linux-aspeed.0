From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 1 Aug 2019 05:56:27 +0200
Subject: [PATCH net-next v2 4/4] net: ftgmac100: Select ASPEED MDIO
 driver for the AST2600
In-Reply-To: <20190731053959.16293-5-andrew@aj.id.au>
References: <20190731053959.16293-1-andrew@aj.id.au>
 <20190731053959.16293-5-andrew@aj.id.au>
Message-ID: <20190801035627.GI2713@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 31, 2019 at 03:09:59PM +0930, Andrew Jeffery wrote:
> Ensures we can talk to a PHY via MDIO on the AST2600, as the MDIO
> controller is now separate from the MAC.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

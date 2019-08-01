From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 1 Aug 2019 05:53:15 +0200
Subject: [PATCH net-next v2 2/4] net: phy: Add mdio-aspeed
In-Reply-To: <20190731053959.16293-3-andrew@aj.id.au>
References: <20190731053959.16293-1-andrew@aj.id.au>
 <20190731053959.16293-3-andrew@aj.id.au>
Message-ID: <20190801035315.GG2713@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 31, 2019 at 03:09:57PM +0930, Andrew Jeffery wrote:
> The AST2600 design separates the MDIO controllers from the MAC, which is
> where they were placed in the AST2400 and AST2500. Further, the register
> interface is reworked again, so now we have three possible different
> interface implementations, however this driver only supports the
> interface provided by the AST2600. The AST2400 and AST2500 will continue
> to be supported by the MDIO support embedded in the FTGMAC100 driver.
> 
> The hardware supports both C22 and C45 mode, but for the moment only C22
> support is implemented.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

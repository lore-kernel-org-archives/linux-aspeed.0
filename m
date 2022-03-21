From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 21 Mar 2022 13:48:32 +0100
Subject: [PATCH v2 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <20220321095648.4760-2-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-2-dylan_hung@aspeedtech.com>
Message-ID: <Yjh0IAFPLnf8H5v+@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 21, 2022 at 05:56:46PM +0800, Dylan Hung wrote:
> The AST2600 MDIO bus controller has a reset control bit and must be
> deasserted before the manipulating the MDIO controller.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: stable at vger.kernel.org

Please read the netdev FAQ. You need to indicates which networking
tree this is for in the Subject line, and you need to make use of the
correct git tree. You should also have a Fixes: tag, indicating where
the issue was introduced.

    Andrew

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 12 Apr 2022 16:24:27 +0200
Subject: [PATCH v4 2/3] net: mdio: add reset control for Aspeed MDIO
In-Reply-To: <20220412065611.8930-3-dylan_hung@aspeedtech.com>
References: <20220412065611.8930-1-dylan_hung@aspeedtech.com>
 <20220412065611.8930-3-dylan_hung@aspeedtech.com>
Message-ID: <YlWLm8mRfP07VkcP@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 12, 2022 at 02:56:10PM +0800, Dylan Hung wrote:
> Add reset assertion/deassertion for Aspeed MDIO.  There are 4 MDIO
> controllers embedded in Aspeed AST2600 SOC and share one reset control
> register SCU50[3].  To work with old DT blobs which don't have the reset
> property, devm_reset_control_get_optional_shared is used in this change.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

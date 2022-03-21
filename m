From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 21 Mar 2022 11:15:24 +0100
Subject: [PATCH v2 2/3] net: mdio: add reset control for Aspeed MDIO
In-Reply-To: <20220321095648.4760-3-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-3-dylan_hung@aspeedtech.com>
Message-ID: <15c3836ecc42c1fea36a51b11a0f47757d06605f.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mo, 2022-03-21 at 17:56 +0800, Dylan Hung wrote:
> Add reset assertion/deassertion for Aspeed MDIO.? There are 4 MDIO
> controllers embedded in Aspeed AST2600 SOC and share one reset
> control
> register SCU50[3]. So devm_reset_control_get_shared is used in this
> change.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>


regards
Philipp

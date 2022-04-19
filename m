From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 19 Apr 2022 10:22:21 +0930
Subject: [PATCH net-next RESEND v5 2/3] net: mdio: add reset control for
 Aspeed MDIO
In-Reply-To: <20220418014059.3054-3-dylan_hung@aspeedtech.com>
References: <20220418014059.3054-1-dylan_hung@aspeedtech.com>
 <20220418014059.3054-3-dylan_hung@aspeedtech.com>
Message-ID: <74dac063-1e2a-4a67-8fc4-622795b43ee2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 18 Apr 2022, at 11:10, Dylan Hung wrote:
> Add reset assertion/deassertion for Aspeed MDIO.  There are 4 MDIO
> controllers embedded in Aspeed AST2600 SOC and share one reset control
> register SCU50[3].  To work with old DT blobs which don't have the reset
> property, devm_reset_control_get_optional_shared is used in this change.
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

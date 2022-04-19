From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 19 Apr 2022 10:21:15 +0930
Subject: [PATCH net-next RESEND v5 1/3] dt-bindings: net: add reset
 property for aspeed, ast2600-mdio binding
In-Reply-To: <20220418014059.3054-2-dylan_hung@aspeedtech.com>
References: <20220418014059.3054-1-dylan_hung@aspeedtech.com>
 <20220418014059.3054-2-dylan_hung@aspeedtech.com>
Message-ID: <c4d4d135-7d52-455a-9623-4c7badb46f9d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 18 Apr 2022, at 11:10, Dylan Hung wrote:
> The AST2600 MDIO bus controller has a reset control bit and must be
> deasserted before manipulating the MDIO controller. By default, the
> hardware asserts the reset so the driver only need to deassert it.
>
> Regarding to the old DT blobs which don't have reset property in them,
> the reset deassertion is usually done by the bootloader so the reset
> property is optional to work with them.
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

From: Rob Herring <robh@kernel.org>
Date: Mon, 21 Mar 2022 08:35:11 -0500
Subject: [PATCH v2 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <20220321095648.4760-2-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-2-dylan_hung@aspeedtech.com>
Message-ID: <1647869711.893197.4125325.nullmailer@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 21 Mar 2022 17:56:46 +0800, Dylan Hung wrote:
> The AST2600 MDIO bus controller has a reset control bit and must be
> deasserted before the manipulating the MDIO controller.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: stable at vger.kernel.org
> ---
>  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1607671


mdio at 1e650000: 'resets' is a required property
	arch/arm/boot/dts/aspeed-ast2600-evb-a1.dt.yaml
	arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-inventec-transformers.dt.yaml

mdio at 1e650008: 'resets' is a required property
	arch/arm/boot/dts/aspeed-ast2600-evb-a1.dt.yaml
	arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dt.yaml

mdio at 1e650010: 'resets' is a required property
	arch/arm/boot/dts/aspeed-ast2600-evb-a1.dt.yaml
	arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml

mdio at 1e650018: 'resets' is a required property
	arch/arm/boot/dts/aspeed-ast2600-evb-a1.dt.yaml
	arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dt.yaml


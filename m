From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 11 Apr 2022 09:45:23 +0930
Subject: [PATCH RESEND v3 1/3] dt-bindings: net: add reset property for
 aspeed, ast2600-mdio binding
In-Reply-To: <20220407075734.19644-2-dylan_hung@aspeedtech.com>
References: <20220407075734.19644-1-dylan_hung@aspeedtech.com>
 <20220407075734.19644-2-dylan_hung@aspeedtech.com>
Message-ID: <41242dce-15e6-471e-bb44-bf8659175045@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dylan,

On Thu, 7 Apr 2022, at 17:27, Dylan Hung wrote:
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
> ---
>  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git 
> a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml 
> b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index 1c88820cbcdf..7f43b4fe86a3 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -20,10 +20,14 @@ allOf:
>  properties:
>    compatible:
>      const: aspeed,ast2600-mdio
> +
>    reg:
>      maxItems: 1
>      description: The register range of the MDIO controller instance
> 
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -39,6 +43,7 @@ examples:
>              reg = <0x1e650000 0x8>;
>              #address-cells = <1>;
>              #size-cells = <0>;
> +            resets = <&syscon 35>;

This is just the example but we should probably have it do the 
canonical thing and use ASPEED_RESET_MII from 
include/dt-bindings/clock/ast2600-clock.h

Andrew

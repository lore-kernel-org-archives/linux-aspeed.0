From: Joel Stanley <joel@jms.id.au>
Date: Wed, 13 Apr 2022 02:34:08 +0000
Subject: [PATCH v4 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <20220412065611.8930-2-dylan_hung@aspeedtech.com>
References: <20220412065611.8930-1-dylan_hung@aspeedtech.com>
 <20220412065611.8930-2-dylan_hung@aspeedtech.com>
Message-ID: <CACPK8Xd0gh5pDafP3ysu7odhnP=YPNSYPV9u36CEoMPDtQxEJw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 12 Apr 2022 at 06:55, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
>
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
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index 1c88820cbcdf..1174c14898e1 100644
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
> +            resets = <&syscon ASPEED_RESET_MII>;

You will need to include the definition for ASPEED_RESET_MII at the
start of the example:

#include <dt-bindings/clock/ast2600-clock.h>

You can test the bindings example by doing this:

pip install dtschema

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml

Cheers,

Joel

>
>              ethphy0: ethernet-phy at 0 {
>                      compatible = "ethernet-phy-ieee802.3-c22";
> --
> 2.25.1
>

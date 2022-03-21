From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 21 Mar 2022 16:51:07 +0100
Subject: [PATCH v2 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <20220321095648.4760-2-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-2-dylan_hung@aspeedtech.com>
Message-ID: <3aae94bd-d39d-ddfc-2b06-356173f6b1f8@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/2022 10:56, Dylan Hung wrote:
> The AST2600 MDIO bus controller has a reset control bit and must be
> deasserted before the manipulating the MDIO controller.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: stable at vger.kernel.org

No bugs fixes, no cc-stable. Especially that you break existing devices...

> ---
>  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index 1c88820cbcdf..8ba108e25d94 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -23,12 +23,15 @@ properties:
>    reg:
>      maxItems: 1
>      description: The register range of the MDIO controller instance

Missing empty line.

> +  resets:
> +    maxItems: 1
>  
>  required:
>    - compatible
>    - reg
>    - "#address-cells"
>    - "#size-cells"
> +  - resets

You break the ABI. This isusually not accepted in a regular kernel and
even totally not accepted accepted for stable kernel.

>  
>  unevaluatedProperties: false
>  
> @@ -39,6 +42,7 @@ examples:
>              reg = <0x1e650000 0x8>;
>              #address-cells = <1>;
>              #size-cells = <0>;
> +            resets = <&syscon 35>;
>  
>              ethphy0: ethernet-phy at 0 {
>                      compatible = "ethernet-phy-ieee802.3-c22";


Best regards,
Krzysztof

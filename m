From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 8 Aug 2024 12:14:49 +0200
Subject: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
Message-ID: <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/08/2024 09:59, Ryan Chen wrote:
> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
> and example for AST2700 scu.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index 86ee69c0f45b..c0965f08ae8c 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> @@ -21,6 +21,8 @@ properties:
>            - aspeed,ast2400-scu
>            - aspeed,ast2500-scu
>            - aspeed,ast2600-scu
> +          - aspeed,ast2700-scu0
> +          - aspeed,ast2700-scu1

What are the differences between these two?

>        - const: syscon
>        - const: simple-mfd
>  
> @@ -30,10 +32,12 @@ properties:
>    ranges: true
>  
>    '#address-cells':
> -    const: 1
> +    minimum: 1
> +    maximum: 2
>  
>    '#size-cells':
> -    const: 1
> +    minimum: 1
> +    maximum: 2
>  
>    '#clock-cells':
>      const: 1
> @@ -56,6 +60,8 @@ patternProperties:
>              - aspeed,ast2400-pinctrl
>              - aspeed,ast2500-pinctrl
>              - aspeed,ast2600-pinctrl
> +            - aspeed,ast2700-soc0-pinctrl
> +            - aspeed,ast2700-soc1-pinctrl
>  
>      required:
>        - compatible
> @@ -76,6 +82,7 @@ patternProperties:
>                - aspeed,ast2400-silicon-id
>                - aspeed,ast2500-silicon-id
>                - aspeed,ast2600-silicon-id
> +              - aspeed,ast2700-silicon-id
>            - const: aspeed,silicon-id
>  
>        reg:
> @@ -115,4 +122,24 @@ examples:
>              reg = <0x7c 0x4>, <0x150 0x8>;
>          };
>      };
> +  - |
> +    soc0 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

That's the same example as previous, right? The drop, no need.

Best regards,
Krzysztof


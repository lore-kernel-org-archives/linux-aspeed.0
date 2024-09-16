From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 16 Sep 2024 12:08:50 +0200
Subject: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
Message-ID: <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/09/2024 11:10, Ryan Chen wrote:
> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id for AST2700 scu.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index 86ee69c0f45b..127a357051cd 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> @@ -9,6 +9,8 @@ title: Aspeed System Control Unit
>  description:
>    The Aspeed System Control Unit manages the global behaviour of the SoC,
>    configuring elements such as clocks, pinmux, and reset.
> +  In AST2700 SOC which has two soc connection, each soc have its own scu
> +  register control, ast2700-scu0 for soc0, ast2700-scu1 for soc1.
>  
>  maintainers:
>    - Joel Stanley <joel@jms.id.au>
> @@ -21,6 +23,8 @@ properties:
>            - aspeed,ast2400-scu
>            - aspeed,ast2500-scu
>            - aspeed,ast2600-scu
> +          - aspeed,ast2700-scu0
> +          - aspeed,ast2700-scu1
>        - const: syscon
>        - const: simple-mfd
>  
> @@ -30,10 +34,12 @@ properties:
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

Why do the children have 64 bit addressing?

>  
>    '#clock-cells':
>      const: 1
> @@ -56,6 +62,8 @@ patternProperties:
>              - aspeed,ast2400-pinctrl
>              - aspeed,ast2500-pinctrl
>              - aspeed,ast2600-pinctrl
> +            - aspeed,ast2700-soc0-pinctrl
> +            - aspeed,ast2700-soc1-pinctrl

Are these devices different?

Where is this binding documented (fully)? Provide link to lore patch in
the changelog.

>  
>      required:
>        - compatible
> @@ -76,6 +84,7 @@ patternProperties:
>                - aspeed,ast2400-silicon-id
>                - aspeed,ast2500-silicon-id
>                - aspeed,ast2600-silicon-id
> +              - aspeed,ast2700-silicon-id

This one is fine.

>            - const: aspeed,silicon-id
>  
>        reg:

Best regards,
Krzysztof


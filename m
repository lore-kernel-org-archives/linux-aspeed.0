From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 2 Aug 2024 11:13:52 +0200
Subject: [PATCH v2 1/9] dt-bindings: mfd: aspeed,ast2x00-scu: Add ASPEED
 AST2700-SCUX schema
In-Reply-To: <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
Message-ID: <1b420e2e-6983-49fb-946c-a4bbf7fa54eb@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 11:05, Kevin Chen wrote:
> Add compatible for two SCU of SCU0 and SCU1 in AST2700.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---

A nit, subject: drop second/last, redundant "schema". The "dt-bindings"
prefix is already stating that these are bindings in the schema.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 70 +++++++++++++------
>  1 file changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index 86ee69c0f45b..3426b1c84132 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> @@ -13,33 +13,62 @@ description:
>  maintainers:
>    - Joel Stanley <joel@jms.id.au>
>    - Andrew Jeffery <andrew@aj.id.au>
> +  - Kevin Chen <kevin_chen@aspeedtech.com>
>  
> -properties:
> -  compatible:
> -    items:
> -      - enum:
> -          - aspeed,ast2400-scu
> -          - aspeed,ast2500-scu
> -          - aspeed,ast2600-scu
> -      - const: syscon
> -      - const: simple-mfd
> +scu at ast2xx00-scu:
> +  properties:
> +    compatible:
> +      items:
> +        - enum:
> +            - aspeed,ast2400-scu
> +            - aspeed,ast2500-scu
> +            - aspeed,ast2600-scu
> +        - const: syscon
> +        - const: simple-mfd

No, no, no, this code is neither correct nor makes any sense.

>  
> -  reg:
> -    maxItems: 1
> +    reg:
> +      maxItems: 1
>  
> -  ranges: true
> +    ranges: true

What?


Best regards,
Krzysztof


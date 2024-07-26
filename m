From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Jul 2024 13:15:08 +0200
Subject: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb
 compatible string
In-Reply-To: <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
Message-ID: <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 71c31c08a8ad..b21551817f44 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -99,4 +99,9 @@ properties:
>                - ufispace,ncplite-bmc
>            - const: aspeed,ast2600
>  
> +      - description: AST2700 based boards
> +        items:
> +          - enum:
> +              - aspeed,ast2700-evb

NAK, this cannot be alone. Look at all other examples. Why are you doing
things differently?

Best regards,
Krzysztof


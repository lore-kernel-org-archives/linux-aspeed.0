From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 23 Sep 2024 11:09:38 +0200
Subject: [PATCH v4 1/3] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <20240923075012.2264573-2-ryan_chen@aspeedtech.com>
References: <20240923075012.2264573-1-ryan_chen@aspeedtech.com>
 <20240923075012.2264573-2-ryan_chen@aspeedtech.com>
Message-ID: <c02f84d2-1306-480b-b6b3-15d3ccae16ad@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/09/2024 09:50, Ryan Chen wrote:
> Add reset, clk dt bindings headers, and update compatible
> support for AST2700 clk, silicon-id in yaml.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   8 +-
>  .../dt-bindings/clock/aspeed,ast2700-scu.h    | 163 ++++++++++++++++++
>  .../dt-bindings/reset/aspeed,ast2700-scu.h    | 124 +++++++++++++
>  3 files changed, 294 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-scu.h
>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-scu.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index 86ee69c0f45b..c800d5e53b65 100644
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
> @@ -30,7 +34,8 @@ properties:
>    ranges: true
>  
>    '#address-cells':
> -    const: 1
> +    minimum: 1
> +    maximum: 2

I would still argue that children do not need full 64-bit addressing,
but fine, you can grow their space as much as possible.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


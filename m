From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Feb 2023 09:52:45 +0100
Subject: [PATCH v4 1/3] dt-bindings: i2c-ast2600: Add support for AST2600
 I2C global controller
In-Reply-To: <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
Message-ID: <fcb460cd-f435-e52a-e335-ccea3ac56a30@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/02/2023 11:33, Ryan Chen wrote:
> AST2600 I2C global register controller, add bindings document
> to support driver of i2c global register set.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../i2c/aspeed,i2c-ast2600-global.yaml        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> new file mode 100644
> index 000000000000..d92a0878d03b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600-global.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Global Register on the AST26XX SoCs Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-i2c-global

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

I'll stop review till you test the patches before sending.

Best regards,
Krzysztof


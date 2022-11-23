From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 23 Nov 2022 09:24:34 +0100
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <20221123061635.32025-2-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
Message-ID: <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/11/2022 07:16, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.

Subject: drop second, redundant "bindings".
Also use proper PATCH prefix.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..e2a7be2e0a18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller
> +
> +description: |
> +  The PWM Tach controller is represented as a multi-function device which
> +  includes:
> +    PWM
> +    Tach
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-pwm-tach
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

If this is simple-mfd then it cannot take clocks or resets.  Usually the
recommendation for such case is: This is not simple-mfd, drop it. Drop
also syscon and make a proper device.

However I am surprised to see such change, so I have no clue why this
was done.

> +
> +  pwm:
> +    type: object
> +    $ref: "/schemas/pwm/aspeed,ast2600-pwm.yaml"

Drop quotes.

There is no such file. Are you sure you ordered the patches correctly?

> +
> +  tach:
> +    type: object
> +    $ref: "/schemas/hwmon/aspeed,ast2600-tach.yaml"

Drop quotes.

There is no such file.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets

Best regards,
Krzysztof


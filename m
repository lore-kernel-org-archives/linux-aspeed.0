From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 23 Nov 2022 09:33:19 +0100
Subject: [v4 3/5] dt-bindings: hwmon: Add bindings for aspeed tach
 controller
In-Reply-To: <20221123061635.32025-4-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-4-billy_tsai@aspeedtech.com>
Message-ID: <d7538ba3-c326-ffcb-afe0-5abb7f0deff1@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/11/2022 07:16, Billy Tsai wrote:
> Add the aspeed tach device bindings which should be the child-node of
> pwm-tach mfd.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..f42114f8e3c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.

Same comments as before. When you receive feedback about something,
please correct it everywhere, not only in one place.

> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach


Missing blank line.

> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object

Missing description. But more important - why do you have such child
nodes? Your example does not have them. What's the point? Do you expect
different number of fans per one device (one compatible)?

> +    properties:
> +      reg:
> +        description:
> +          The tach channel used for this node.
> +        maxItems: 1

Missing blank line.

> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

Best regards,
Krzysztof


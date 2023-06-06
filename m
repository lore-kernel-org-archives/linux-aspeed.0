From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 6 Jun 2023 12:46:29 +0200
Subject: [v5 2/5] dt-bindings: hwmon: Add bindings for aspeed tach
 controller
In-Reply-To: <20230606094535.5388-3-billy_tsai@aspeedtech.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-3-billy_tsai@aspeedtech.com>
Message-ID: <d7d0d46f-853d-ca78-9e6c-8b05011f2f69@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the aspeed tach device which should be the child-node of pwm-tach mfd.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..50b3d8c98d55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,40 @@
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
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object

additionalProperties: false


> +    description:
> +      Child nodes used to enable the tach channel.

Anyway you did not respond to our concerns. Why do you need it at the
first place?

I clearly asked:
But more important - why do you have such child
nodes? Your example does not have them. What's the point? Do you expect
different number of fans per one device (one compatible)?

Where is the answer to these?

Sorry, but ignoring the feedback and resending same stuff will bring you
nowhere. Several comments in the patchset were ignored.


Best regards,
Krzysztof


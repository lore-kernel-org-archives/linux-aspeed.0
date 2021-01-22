From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 22 Jan 2021 14:56:44 +1030
Subject: [PATCH v3 1/4] dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
In-Reply-To: <20210118065059.2478078-2-troy_lee@aspeedtech.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
 <20210118065059.2478078-2-troy_lee@aspeedtech.com>
Message-ID: <647428e4-49fb-4e2b-9291-895488c9c7f5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 18 Jan 2021, at 17:20, Troy Lee wrote:
> We add binding for supporting a new AST2600 PWM/Fan hwmon driver.
> 
> Changes since v2:
>  - Fixed yamllint warnings/errors
> 
> Changes since v1:
>  - dt binding with DT schema format
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Reported-by: Rob Herring <robh@kernel.org>
> ---
>  .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> 
> diff --git 
> a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> new file mode 100644
> index 000000000000..fa5340f5a43f
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: 
> http://devicetree.org/schemas/hwmon/aspeed,ast2600-pwm-tachometer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2600 PWM and Fan Tacho controller device driver
> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support upto 16 PWM outputs. The 
> ASPEED Fan Tacho
> +  controller can support upto 16 Fan tachometer inputs.
> +  There can be upto 16 fans supported. Each fan can have one PWM 
> output and
> +  one Fan tach inputs.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2600-pwm-tachometer
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#cooling-cells":
> +    const: 2
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^fan@[0-9a-f]$":
> +    type: object
> +    description:
> +      Under fan subnode there can upto 16 child nodes, with each child 
> node
> +      representing a fan. There are 16 fans each fan can have one PWM 
> port and one
> +      Fan tach inputs.
> +      For PWM port can be configured cooling-levels to create cooling 
> device.
> +      Cooling device could be bound to a thermal zone for the thermal 
> control.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 15
> +        description:
> +          This property identify the PWM control channel of this fan.
> +
> +      fan-tach-ch:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        minimum: 0
> +        maximum: 15
> +        description:
> +          This property identify the fan tach input channel.
> +
> +      pulses-per-revolution:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 2
> +        minimum: 1
> +        description:
> +          Specify tacho pulse per revolution of the fan.
> +
> +      cooling-levels:
> +        description:
> +          PWM duty cycle values in a range from 0 to 255
> +          which correspond to thermal cooling states.
> +
> +      aspeed,pwm-freq-hz:
> +        default: 25000
> +        minimum: 24
> +        maximum: 780000
> +        description:
> +          Specify the frequency of PWM.

What about using 'bus-frequency' instead?

> +
> +      aspeed,inverse-pin:
> +        type: boolean
> +        description:
> +          Inverse PWM output signal.

What's the benefit? I know the hardware provides the function, but do we need to expose it?

> +
> +      aspeed,falling-point:
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        default: 10

I feel like it probably shouldn't have a default value.

> +        description:
> +          Initialize the pulse width.

Then can we make the property name a bit more intuitive? 'pwm-duty'? Alternatively, [1] calls the duty "cooling-levels", can we use something in that vein instead?

[1] Documentation/devicetree/bindings/hwmon/pwm-fan.txt

Andrew

From: Troy Lee <troy_lee@aspeedtech.com>
Date: Fri, 15 Jan 2021 01:46:31 +0000
Subject: [PATCH v2 1/4] dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
In-Reply-To: <20210114141317.GA2823834@robh.at.kernel.org>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
 <20210113070850.1184506-2-troy_lee@aspeedtech.com>
 <20210114141317.GA2823834@robh.at.kernel.org>
Message-ID: <20210115014631.GA1391@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

Thanks for reviewing.

The 01/14/2021 22:13, Rob Herring wrote:
> On Wed, Jan 13, 2021 at 07:08:45AM +0000, Troy Lee wrote:
> > We add binding for supporting a new AST2600 PWM/Fan hwmon driver.
> > 
> > Changes since v1:
> > - dt binding with DT schema format
> > 
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > ---
> >  .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 137 ++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > new file mode 100644
> > index 000000000000..b84076a4a338
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-pwm-tachometer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED AST2600 PWM and Fan Tacho controller device driver
> > +
> > +maintainers:
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +description: |
> > +  The ASPEED PWM controller can support upto 16 PWM outputs. The ASPEED Fan Tacho
> > +  controller can support upto 16 Fan tachometer inputs.
> > +  There can be upto 16 fans supported. Each fan can have one PWM output and
> > +  one Fan tach inputs.
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2600-pwm-tachometer
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#cooling-cells":
> > +    const: 2
> > +
> > +  reg:
> > +    description:
> > +      Address and length of the register set for the device.
> 
> No need for generic descriptions. That's every 'reg'.
> 
> What you need is how many entries and what each one is if more than 1. 
> If only 1, then just 'maxItems: 1'
> 
> > +
> > +  clocks:
> > +    description:
> > +      phandle to clock provider with the clock number in the second cell
> 
> Same here.
> 
> > +
> > +  resets:
> > +    description:
> > +      phandle to reset controller with the reset number in the second cell
> 
> And here.
> 
> > +
> > +patternProperties:
> > +  "@[0-9]+$":
> 
> If every node is a fan and there are up to 16:
> 
> ^fan@[0-9a-f]$
> 
I will update these in v3 patch set.

> > +    type: object
> > +    description:
> > +      Under fan subnode there can upto 16 child nodes, with each child node
> > +      representing a fan. There are 16 fans each fan can have one PWM port and one
> > +      Fan tach inputs.
> > +      For PWM port can be configured cooling-levels to create cooling device.
> > +      Cooling device could be bound to a thermal zone for the thermal control.
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 15
> > +        description:
> > +          This property identify the PWM control channel of this fan.
> > +
> > +      fan-tach-ch:
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        minimum: 0
> > +        maximum: 15
> > +        description:
> > +          This property identify the fan tach input channel.
> > +
> > +      pulses-per-revolution:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 2
> > +        minimum: 1
> > +        description:
> > +          Specify tacho pulse per revolution of the fan.
> > +
> > +      cooling-levels:
> > +        description:
> > +          PWM duty cycle values in a range from 0 to 255
> > +          which correspond to thermal cooling states.
> > +
> > +      aspeed,pwm-freq:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 25000
> > +        minimum: 24
> > +        maximum: 780000
> > +        description:
> > +          Specify the frequency of PWM.
> 
> Units? Use a unit suffix and then drop the $ref.
> 
I'll change it to pwm-freq-hz.

> > +
> > +      aspeed,inverse-pin:
> > +        type: boolean
> > +        description:
> > +          Inverse PWM output signal.
> > +
> > +      aspeed,falling-point:
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        default: 10
> > +        minimum: 0
> > +        maximum: 255
> 
> 0-255 is already the range of uint8, so drop.
> 
I'll drop it in v3.

Thanks,
Troy Lee
> > +        description:
> > +          Initialize the pulse width.
> > +
> > +    required:
> > +      - fan-tach-ch
> > +      - reg
> > +
> > +    additionalProperties: true
> > +
> > +required:
> > + - compatible
> > + - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm_tacho: pwm-tacho-controller at 1e610000 {
> > +        compatible = "aspeed,ast2600-pwm-tachometer";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <0x1e610000 0x100>;
> > +
> > +        fan at 1 {
> > +            reg = <0x00>;
> > +            aspeed,pwm-freq = <25000>;
> > +            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> > +            fan-tach-ch = /bits/ 8 <0x00>;
> > +            pulses-per-revolution = <2>;
> > +        };
> > +
> > +        fan at 2 {
> > +            reg = <0x01>;
> > +            aspeed,pwm-freq = <25000>;
> > +            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> > +            fan-tach-ch = /bits/ 8 <0x01>;
> > +            pulses-per-revolution = <2>;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.25.1
> > 

From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 7 Sep 2023 07:17:55 +0000
Subject: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <20230905170010.GA3505375-robh@kernel.org>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
 <20230905170010.GA3505375-robh@kernel.org>
Message-ID: <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 30, 2023 at 08:32:00PM +0800, Billy Tsai wrote:
>> From: Naresh Solanki <naresh.solanki@9elements.com>
>> 
>> Add common fan properties bindings to a schema.
>> 
>> Bindings for fan controllers can reference the common schema for the
>> fan
>> 
>> child nodes:
>> 
>>   patternProperties:
>>     "^fan@[0-2]":
>>       type: object
>>       $ref: fan-common.yaml#

>        unevaluatedProperties: false

OK, I will add this.

>> 
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> ---
>>  .../devicetree/bindings/hwmon/fan-common.yaml | 63 +++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/>hwmon/fan-common.yaml
>> new file mode 100644
>> index 000000000000..a69b4d553e45
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause

> Drop 'or-later'. It's GPL2 only.

OK, I will fix it.

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common Fan Properties
>> +
>> +maintainers:
>> +  - Naresh Solanki <naresh.solanki@9elements.com>
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>
>> +
>> +properties:
>> +  max-rpm:
>> +    description:
>> +      Max RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32

> Physics will limit this to something much less than 2^32. Add some 
> constraints. 10000?


>> +
>> +  min-rpm:
>> +    description:
>> +      Min RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32

> ditto

>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      The number of pulse from fan sensor per revolution.
>> +    $ref: /schemas/types.yaml#/definitions/uint32

>Needs constraints. I assume this is never more than 4 (or 2 even)?

Do you think we should add the contraint in the common binding?
In my option, the limit of the max/min rpm should be declared by
the binding if necessary, because the usage of each fan monitor is
based on the connection of the tach pin.


>> +  div:

> Too generic of a name.

>> +    description:
>> +      Fan clock divisor

> But what is a fan clock?

This is the divisor for the tachometer sampling clock, which determines the sensitivity of the tach pin.
So, if the name of the property changes to 'tach-div,' is it acceptable to you?


>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  target-rpm:
>> +    description:
>> +      Target RPM the fan should be configured during driver probe.

> What driver? By the time the OS driver runs, a bunch of other boot 
> software has already run on modern systems. So this value would likely 
> be used much earlier. The point is that when exactly is outside the 
> scope of DT. This is "what RPM do I use in case of no other information 
> (e.g. temperature)".

So, the description should be changed to 'The default desired fan speed in RPM,'
and we shouldn't mention the timing of the property's operation in the DT, is that correct?

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  mode:

> Too generic.

>> +    description:
>> +      Select the operational mode of the fan.

> What are modes? Spin and don't spin?

The mode is used to indicate the driving mode of the fan (DC, PWM and so on).
So, if the name of the property changes to 'fan-driving-mode,' is it acceptable to you?

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  pwms:
>> +    description:
>> +      PWM provider.

> maxItems: 1

> I don't think there are fans with more than 1 PWM input?

Ok, I will add the constraint for the pwm input.

>> +
>> +  tach-ch:
>> +    description:
>> +      The tach channel used for the fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32

> The existing ASpeed version of this property allows more than 1 entry. I 
> don't understand how a fan would have 2 tach signals, but if so, the 
> generic property should allow for that.

Ok, I will modify it to the uint32-array

> Perhaps 'reg' should be defined in here with some text saying 'reg' 
> corresponds to the fan controller specific id which may be the PWM+TACH 
> channel, PWM channel (deprecated), or TACH channel. I think there are 
> examples of all 3 of these cases.

I don't think it's necessary for the 'reg' because the case you mentioned is
already covered by the property 'tach-ch' and the 'pwms'.

> +
> +  label:
> +    description:
> +      Optional fan label
> +
> +  fan-supply:
> +    description:
> +      Power supply for fan.
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.25.1
> 

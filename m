From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 5 Oct 2023 01:04:32 +0000
Subject: [PATCH v9 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <20231002152343.GA1747496-robh@kernel.org>
References: <20230918064111.2221594-1-billy_tsai@aspeedtech.com>
 <20230918064111.2221594-2-billy_tsai@aspeedtech.com>
 <20231002152343.GA1747496-robh@kernel.org>
Message-ID: <SG2PR06MB3365ED5D60E709045FD010F38BCAA@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
>>       unevaluatedProperties: false
>>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> ---
>>  .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> new file mode 100644
>> index 000000000000..2bd2f57fc9d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
>> +    maximum: 100000
>> +
>> +  min-rpm:
>> +    description:
>> +      Min RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 1000
>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      The number of pulse from fan sensor per revolution.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 4
>> +
>> +  tach-div:
>> +    description:
>> +      Divisor for the tach sampling clock, which determines the sensitivity of the tach pin.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  target-rpm:
>> +    description:
>> +      The default desired fan speed in RPM.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  fan-driving-mode:
>> +    description:
>> +      Select the driving mode of the fan.(DC, PWM and so on)
>> +    $ref: /schemas/types.yaml#/definitions/uint32

> What value corresponds to what mode? I'd do strings instead. 'dc',
> 'pwm', etc.


Ok, I will change the type to the string for next patch.

Thanks

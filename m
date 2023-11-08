From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 8 Nov 2023 10:38:27 -0800
Subject: [PATCH RESEND v10 1/3] dt-bindings: hwmon: fan: Add fan binding
 to schema
In-Reply-To: <20231108181654.GA2664986-robh@kernel.org>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-2-billy_tsai@aspeedtech.com>
 <20231108181654.GA2664986-robh@kernel.org>
Message-ID: <d3204361-2d4c-41f9-8365-5826195aa884@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/8/23 10:16, Rob Herring wrote:
> On Tue, Nov 07, 2023 at 06:50:23PM +0800, Billy Tsai wrote:
>> From: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> Add common fan properties bindings to a schema.
>>
>> Bindings for fan controllers can reference the common schema for the
>> fan
>>
>> child nodes:
>>
>>    patternProperties:
>>      "^fan@[0-2]":
>>        type: object
>>        $ref: fan-common.yaml#
>>        unevaluatedProperties: false
>>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> ---
>>   .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> Looking pretty good to me. It's disappointing that no one else
> interested in upstreaming their fan controller can be bothered to
> comment.
> 

FWIW, I declined to comment since it basically looks ok to me
and because at this point I'd rather have something (whatever it is)
instead of nothing.

>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> new file mode 100644
>> index 000000000000..be4ce3bd7f22
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
>> +    $ref: /schemas/types.yaml#/definitions/string
> 
> You need to define the possible values. I assume it's:
> 
> enum:
>    - dc
>    - pwm
>    - anything else???
> 

I am not aware of any other possible method. dc and pwm is all
I have ever seen.

Guenter

> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


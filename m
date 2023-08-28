From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 28 Aug 2023 05:33:18 +0000
Subject: [PATCH v7 1/2] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
In-Reply-To: <20230823131334.GA2059582-robh@kernel.org>
References: <20230817120029.221484-1-billy_tsai@aspeedtech.com>
 <20230817120029.221484-2-billy_tsai@aspeedtech.com>
 <20230823131334.GA2059582-robh@kernel.org>
Message-ID: <SG2PR06MB3365BA3D9C5C50398D8449A98BE0A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 17, 2023 at 08:00:28PM +0800, Billy Tsai wrote:
>> Document the compatible for aspeed,ast2600-pwm-tach device, which can
>> support upto 16 PWM outputs and 16 fan tach input.
>>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> ---
>>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>> new file mode 100644
>> index 000000000000..1666304d0b0f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2021 Aspeed, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ASPEED G6 PWM and Fan Tach controller device driver
>> +
>> +maintainers:
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>
>> +
>> +description: |
>> +  The ASPEED PWM controller can support upto 16 PWM outputs.
>> +  The ASPEED Fan Tacho controller can support upto 16 fan tach input.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - aspeed,ast2600-pwm-tach
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 3
>> +
>> +  aspeed,fan-tach-ch:
>> +    description: Specify the Fan tach input channels.
>> +    $ref: "/schemas/types.yaml#/definitions/uint8-array"
 
>This property is already defined in aspeed-pwm-tacho.txt as a single u8
>that goes in a fan node. You can't redefine its type and location here.
 
Hi Rob,
 
I didn't redefine the type of property. The type of the aspeed,fan-tach-ch is unit8-array
in aspeed-pwm-tacho.txt.
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt#L48
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt#L71
 
>To repeat what I've said in previous versions, work with others to
>define a common fan and fan controller binding. Otherwise, anything new
>with fan related properties is simply going to be rejected.
 
Okay I will try to work with Naresh for defining a common fan binding.
 
Thanks for your suggestion.
 
Hi Naresh,
 
As Rob mentioned, it would be advisable for my dt-bindings to reference the common fan bindings instead of introducing specific properties.
I noticed that you have already submitted a related patch to the community, which seems to be pending for around 10 months.
https://lore.kernel.org/lkml/20221116213615.1256297-2-Naresh.Solanki at 9elements.com/
Do you have plans to send the next version of the patch? Alternatively, can I proceed to cherry-pick this version of the patch and continue with
the upstreaming process in my patch serial?
 
Thanks
Best Regards,
Billy Tsai

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 15 Jan 2024 10:26:41 +0100
Subject: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
In-Reply-To: <OSQPR06MB72520BD77D68B7940273F2498B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-3-billy_tsai@aspeedtech.com>
 <20240113015556.GA3829553-robh@kernel.org>
 <OSQPR06MB725208AEF8779B0BC971DFF48B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <40210196-3852-4c8b-94e6-e744890f003f@linaro.org>
 <OSQPR06MB72520BD77D68B7940273F2498B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Message-ID: <c4550e34-17c8-4c67-9483-d654aa051d2d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15/01/2024 09:43, Billy Tsai wrote:
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/aspeed-clock.h>
>>>>> +    pwm_tach: pwm-tach-controller at 1e610000 {
>>>>> +      compatible = "aspeed,ast2600-pwm-tach";
>>>>> +      reg = <0x1e610000 0x100>;
>>>>> +      clocks = <&syscon ASPEED_CLK_AHB>;
>>>>> +      resets = <&syscon ASPEED_RESET_PWM>;
>>>>> +      #pwm-cells = <3>;
>>>>> +
>>>>> +      fan-0 {
>>>>> +        tach-ch = /bits/ 8 <0x0>;
>>>>> +      };
>>>>> +
>>>>> +      fan-1 {
>>>>> +        tach-ch = /bits/ 8 <0x1 0x2>;
>>>>> +      };
>>>
>>>> NAK on this based on how you are using pwm-fan in v10 discussion. See my
>>>> comments there.
>>>
>>> Okay, I will merge everything from the pwm-fan0 node into the fan-0 node
>>> and add the 'simple-bus' to the compatible string of the pwm_tach node.
> 
>> What simple-bus has anything to do with it? This is not a bus. Just to
>> remind: we talk about bindings, not driver.
> 
> Hi Krzysztof,
> 
> If I want to create a dt-binding to indicate that the child nodes
> should be treated as platform devices, which will be probed based on the

probed? Bindings do not probe. You ignored:
"we talk about bindings, not driver."

> compatible string, can I add "simple-bus" for our pwm_tach node like the
> following?

No, because this is not a bus.

> pwm_tach: pwm-tach-controller at 1e610000 {
>         compatible = "aspeed,ast2600-pwm-tach", "simple-bus";
>         reg = <0x1e610000 0x100>;
>         clocks = <&syscon ASPEED_CLK_AHB>;
>         resets = <&syscon ASPEED_RESET_PWM>;
>         #pwm-cells = <3>;
>   
>         fan-0 {
>           tach-ch = /bits/ 8 <0x0>;
>           compatible = "pwm-fan";
>           pwms = <&pwm_tach 0 40000 0>;
>         };
>   
>         fan-1 {
>           tach-ch = /bits/ 8 <0x1 0x2>;
>           compatible = "pwm-fan";
>           pwms = <&pwm_tach 1 40000 0>;
>         };
>       };
> Or do you have any other suggestions for describing this in the dt-bindings?


There is no need to describe it in the bindings. The existing compatible
describes it sufficiently. Your pwms now duplicate the tach-ch... I
don't understand what you want to achieve here in terms of hardware
description (again, please steer away from talking about Linux drivers
and probing, it's not related).

Best regards,
Krzysztof


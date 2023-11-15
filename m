From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 15 Nov 2023 13:13:29 +0100
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
In-Reply-To: <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
References: <20231114112722.28506-4-zev@bewilderbeest.net>
 <20231114112722.28506-6-zev@bewilderbeest.net>
 <cde26249-1d47-496f-b198-a0c4c02bed5c@linaro.org>
 <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
Message-ID: <863a0fe2-c258-47d9-8563-6f12bb55b4ad@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/11/2023 23:37, Zev Weiss wrote:

> 
>>> +	};
>>> +
>>> +	memory at 80000000 {
>>> +		reg = <0x80000000 0x20000000>;
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		heartbeat {
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).

The node names are clearly wrong and you got output. It's easy to spot
if your patch worked in the first place:

 fatal error: dt-bindings/watchdog/aspeed-wdt.h: No such file or directory


Best regards,
Krzysztof


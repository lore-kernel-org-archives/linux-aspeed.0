From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 15 Nov 2023 18:39:21 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
In-Reply-To: <863a0fe2-c258-47d9-8563-6f12bb55b4ad@linaro.org>
References: <20231114112722.28506-4-zev@bewilderbeest.net>
 <20231114112722.28506-6-zev@bewilderbeest.net>
 <cde26249-1d47-496f-b198-a0c4c02bed5c@linaro.org>
 <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
 <863a0fe2-c258-47d9-8563-6f12bb55b4ad@linaro.org>
Message-ID: <1e1c1493-d3f5-4c96-b85f-158d720b2ab5@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 15, 2023 at 04:13:29AM PST, Krzysztof Kozlowski wrote:
>On 14/11/2023 23:37, Zev Weiss wrote:
>
>>
>>>> +	};
>>>> +
>>>> +	memory at 80000000 {
>>>> +		reg = <0x80000000 0x20000000>;
>>>> +	};
>>>> +
>>>> +	leds {
>>>> +		compatible = "gpio-leds";
>>>> +
>>>> +		heartbeat {
>>>
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check W=1` (see
>>> Documentation/devicetree/bindings/writing-schema.rst or
>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>> for instructions).
>
>The node names are clearly wrong and you got output. It's easy to spot
>if your patch worked in the first place:
>
> fatal error: dt-bindings/watchdog/aspeed-wdt.h: No such file or directory
>

The patch series was based on Linus's tree at the time I sent it; that 
file was added in commit 9931be2cfca3 ("dt-bindings: watchdog: 
aspeed-wdt: Add aspeed,reset-mask property"), which was included in the 
6.7-rc1 tag, FWIW.

After some debugging I discovered that the reason I wasn't getting any 
output from dtbs_check was that I had neglected to specify ARCH=arm when 
invoking it, and when that defaulted to x86 it silently did a whole 
bunch of nothing.  It might be nice if something emitted some sort of 
warning when invoked with nonsensical parameters (especially if I've 
explicitly specified a dtstree=... argument pointing to arch/arm/...), 
but oh well.

After re-running it with ARCH=arm, it produced a fairly voluminous spew 
of output, though after combing through it all as best I can tell only 
one or two lines of it actually pertain to the .dts in question itself 
(the vast majority being from a .dtsi it #includes).  I've fixed the one 
remaining issue it reported (missing #address-cells and #size-cells on 
the FRU eeprom node) and will post a v2 in the next few days (and 
likewise on the spc621d8hm3 series).


Zev


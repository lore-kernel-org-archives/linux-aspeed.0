From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 1 Feb 2023 11:14:04 +0100
Subject: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
In-Reply-To: <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com>
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-4-jordan.chang@ufispace.com>
 <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
 <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com>
Message-ID: <307017b7-2ecf-2ce5-4031-27bb6f09feb1@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/02/2023 11:06, Jordan Chang wrote:
>>> +     gpio-keys {
>>> +             compatible = "gpio-keys";
>>> +
>>> +             fan-status-int-l {
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>> These will bring warnings. Missing generic name,
>>
> I have run the `make dtbs_check` command, and did not notice the warning
> message 'Missing generic name'. It shows lots of compatible failed messages.
> - /ahb/ftgmac at 1e670000: failed to match any schema with compatible:

You can run it with DT_SCHEMA_FILES=gpio-keys

> 
>>> +                     label = "fan-status-int-l";
>>> +                     gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <ASPEED_GPIO(M, 2)>;
>>> +             };
>>> +

(...)

>>> +
>>> +&i2c4 {
>>> +     status = "okay";
>>> +
>>> +     psu at 58 {
>>> +             compatible = "pmbus";
>>
>> Where is this compatible documented?
> Can not find the corresponding document.
>>
>> Did you run checkpatch? Did it pass without warnings?
> Yes, I did run the ./scripts/checkpatch.pl and there were two warnings left.
> - WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> - WARNING: line length of 104 exceeds 100 columns
> I just ignore those warnings that Joel has informed me in the previous
> mail loop.
> 

Hm, is it then correct compatible?


Best regards,
Krzysztof


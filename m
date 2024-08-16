From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 16 Aug 2024 07:08:02 +0200
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYxIDA4LzEwXSBhcm02NDogZHRzOiBh?=
 =?UTF-8?Q?speed=3A_Add_initial_AST27XX_device_tree?=
In-Reply-To: <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
 <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
 <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <aa3a1835-19e0-43a5-b6a4-4a7e531f3b2e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15/08/2024 07:50, Kevin Chen wrote:
>>> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>> new file mode 100644
>>> index 000000000000..858ab95251e4
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>> @@ -0,0 +1,217 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
>>> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>>> +
>>> +/ {
>>> +     model = "Aspeed BMC";
>>
>> Model of what? No, drop.
> Can I change to "model = "AST2700 EVB""

Model of what? No, it does not make sense here.


..


>>> +
>>> +             uart12: serial at 14c33b00 {
>>> +                     compatible = "ns16550a";
>>> +                     reg = <0x0 0x14c33b00 0x0 0x100>;
>>> +                     reg-shift = <2>;
>>> +                     reg-io-width = <4>;
>>> +                     clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
>>> +                     no-loopback-test;
>>> +                     pinctrl-names = "default";
>>
>> What is this?
> BMC uart using in uart12 in soc1.

No, that line. pinctrl-names do not make sense here without values.

> 
>>
>>> +             };
>>> +     };
>>> +};
>>> +
> 
> --
> Best Regards,
> Kevin. Chen
> ________________________________
> ???: Krzysztof Kozlowski <krzk@kernel.org>
> ????: 2024?7?26? ?? 07:19
> ???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
> ??: Re: [PATCH v1 08/10] arm64: dts: aspeed: Add initial AST27XX device tree
> 

Why do you quote my email twice?


...

>> +             uart12: serial at 14c33b00 {
>> +                     compatible = "ns16550a";
>> +                     reg = <0x0 0x14c33b00 0x0 0x100>;
>> +                     reg-shift = <2>;
>> +                     reg-io-width = <4>;
>> +                     clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
>> +                     no-loopback-test;
>> +                     pinctrl-names = "default";
> 
> What is this?
> 
>> +             };
>> +     };
>> +};
>> +
> 
> Best regards,
> Krzysztof
> 
> ************* Email Confidentiality Notice ********************
> ????:
> ???(????)????????????????? ???????????????????????????, ??????????????????????????????!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.

Maybe I am the intended recipient of your message, maybe not. I don't
want to have any legal questions regarding upstream, public
collaboration, thus probably I should just remove your messages.

Please talk with your IT that such disclaimers in open-source are not
desired (and maybe even harmful).
If you do not understand why, please also see:
https://www.youtube.com/live/fMeH7wqOwXA?si=GY7igfbda6vnjXlJ&t=835

If you need to go around company SMTP server, then consider using b4
web-relay: https://b4.docs.kernel.org/en/latest/contributor/send.html

Please be informed that by responding to this email you agree that all
communications from you and/or your company is made public. In other
words, all messages originating from you and/or your company will be
made public.

Best regards,
Krzysztof


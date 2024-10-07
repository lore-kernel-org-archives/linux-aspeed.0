From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 7 Oct 2024 13:05:07 +0200
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYxIDA4LzEwXSBhcm02NDogZHRzOiBh?=
 =?UTF-8?Q?speed=3A_Add_initial_AST27XX_device_tree?=
In-Reply-To: <PSAPR06MB4949B860119DCC42C9BC0E42897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
 <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
 <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <aa3a1835-19e0-43a5-b6a4-4a7e531f3b2e@kernel.org>
 <PSAPR06MB4949B860119DCC42C9BC0E42897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <843b411f-8a71-4766-a657-70d326676f9c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/10/2024 11:26, Kevin Chen wrote:
>>>>> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>>>> b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..858ab95251e4
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>>>> @@ -0,0 +1,217 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later #include
>>>>> +<dt-bindings/clock/aspeed,ast2700-clk.h>
>>>>> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>>>>> +
>>>>> +/ {
>>>>> +     model = "Aspeed BMC";
>>>>
>>>> Model of what? No, drop.
>>> Can I change to "model = "AST2700 EVB""
>>
>> Model of what? No, it does not make sense here.
> Should I change to model = "Aspeed BMC SoC";

SoCs do not have models. Please take a look how *every* other SoC is doing.

Best regards,
Krzysztof


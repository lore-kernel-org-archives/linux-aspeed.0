From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 9 Feb 2024 13:38:42 +0100
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
In-Reply-To: <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
Message-ID: <dda6c22e-8f35-4c18-9fea-6a6295dee3a1@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/02/2024 15:57, Supreeth Venkatesh wrote:
> This patch is pending for a month now.
> 
> Can DT maintainers please help review this and provide feedback?

I don't have the original patch in my inbox anymore, so probably you
should resend. Anyway quick look points to obvious issues (comments below).

> 
> On 1/9/24 21:35, Supreeth Venkatesh wrote:
>> This patch adds initial device tree and makefile updates for
>> AMD Onyx platform.
>>
>> AMD Onyx platform is an AMD customer reference board with an Aspeed
>> ast2600 BMC manufactured by AMD.
>> It describes I2c devices, Fans, Kcs devices, Uarts, Mac, LEDs, etc.
>> present on AMD Onyx platform.
>>
>> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |  1 +
>>   .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 98 +++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index fb9cc95f1b60..2b27d377aae2 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-ast2600-evb.dtb \
>>   	aspeed-bmc-amd-daytonax.dtb \
>>   	aspeed-bmc-amd-ethanolx.dtb \
>> +	aspeed-bmc-amd-onyx.dtb \
>>   	aspeed-bmc-ampere-mtjade.dtb \
>>   	aspeed-bmc-ampere-mtmitchell.dtb \
>>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>> new file mode 100644
>> index 000000000000..a7056cd29553
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright (c) 2021 - 2024 AMD Inc.
>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +       model = "AMD Onyx BMC";
>> +       compatible = "amd,onyx-bmc", "aspeed,ast2600";

Undocumented compatibles.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

>> +
>> +       aliases {
>> +               serial0 = &uart1;
>> +               serial4 = &uart5;
>> +      };
>> +
>> +       chosen {
>> +               stdout-path = &uart5;
>> +               bootargs = "console=ttyS4,115200 earlyprintk vmalloc=512MB";

earlyprintk is debugging, not for mainline, so drop.

Console should be encoded in stdout-path.

vmalloc looks like OS tuning, so also not suitable for mainline DTS.


>> +       };
>> +
>> +       memory at 80000000 {
>> +               device_type = "memory";
>> +               reg = <0x80000000 0x80000000>;
>> +       };
>> +

Drop redundant blank lines.

>> +};
>> +
>> +&mdio0 {
>> +       status = "okay";
>> +
>> +       ethphy0: ethernet-phy at 0 {
>> +               compatible = "ethernet-phy-ieee802.3-c22";
>> +               reg = <0>;
>> +       };
>> +};
>> +
>> +&mac3 {
>> +       status = "okay";
>> +       phy-mode = "rgmii";
>> +       phy-handle = <&ethphy0>;
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_rgmii4_default>;
>> +};
>> +
>> +>> +

Drop redundant blank lines. You can open existing, recent DTS from
maintained platforms like Qcom or TI and look there at coding style.



Best regards,
Krzysztof


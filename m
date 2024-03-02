From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 2 Mar 2024 17:25:46 +0100
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
In-Reply-To: <023f6f6c-dadd-4933-ac2c-15dfe77bd90e@amd.com>
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
 <dda6c22e-8f35-4c18-9fea-6a6295dee3a1@linaro.org>
 <023f6f6c-dadd-4933-ac2c-15dfe77bd90e@amd.com>
Message-ID: <66a2e36e-2fde-4041-8a1d-b0f7ae0b3f6b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/03/2024 22:02, Supreeth Venkatesh wrote:
>>>> ---
>>>>    arch/arm/boot/dts/aspeed/Makefile             |  1 +
>>>>    .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 98 +++++++++++++++++++
>>>>    2 files changed, 99 insertions(+)
>>>>    create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>>
>>>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>>>> index fb9cc95f1b60..2b27d377aae2 100644
>>>> --- a/arch/arm/boot/dts/aspeed/Makefile
>>>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>>>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>>       aspeed-ast2600-evb.dtb \
>>>>       aspeed-bmc-amd-daytonax.dtb \
>>>>       aspeed-bmc-amd-ethanolx.dtb \
>>>> +    aspeed-bmc-amd-onyx.dtb \
>>>>       aspeed-bmc-ampere-mtjade.dtb \
>>>>       aspeed-bmc-ampere-mtmitchell.dtb \
>>>>       aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>> new file mode 100644
>>>> index 000000000000..a7056cd29553
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>> @@ -0,0 +1,98 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +// Copyright (c) 2021 - 2024 AMD Inc.
>>>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "aspeed-g6.dtsi"
>>>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>>>> +
>>>> +/ {
>>>> +       model = "AMD Onyx BMC";
>>>> +       compatible = "amd,onyx-bmc", "aspeed,ast2600";
>> Undocumented compatibles.
> This is a new device tree file.

It's obvious, so what does it even mean?

Anyway, fix warnings.


Best regards,
Krzysztof


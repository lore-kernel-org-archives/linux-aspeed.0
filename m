From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Mon, 14 Oct 2024 22:02:44 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <975ab37a-7429-4c52-b1e7-6ec9ba63048a@kernel.org>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
 <975ab37a-7429-4c52-b1e7-6ec9ba63048a@kernel.org>
Message-ID: <01c3d596-197a-46c6-b56c-05ef602b9c96@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 14/10/2024 18:58, Krzysztof Kozlowski wrote:
> On 14/10/2024 12:50, Chanh Nguyen wrote:
>> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
>> hardware reference platform with AmpereOne(TM)M processor.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 646 ++++++++++++++++++
>>   2 files changed, 647 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index c4f064e4b073..b1fb0853a789 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-bmc-amd-daytonax.dtb \
>>   	aspeed-bmc-amd-ethanolx.dtb \
>>   	aspeed-bmc-ampere-mtjade.dtb \
>> +	aspeed-bmc-ampere-mtjefferson.dtb \
>>   	aspeed-bmc-ampere-mtmitchell.dtb \
>>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>   	aspeed-bmc-asrock-e3c246d4i.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
>> new file mode 100644
>> index 000000000000..f24111ab9e65
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
>> @@ -0,0 +1,646 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright 2024 Ampere Computing LLC.
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/i2c/i2c.h>
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +	model = "Ampere Mt. Jefferson BMC";
>> +	compatible = "ampere,mtjefferson-bmc", "aspeed,ast2600";
> 
> Missing binding.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
> 

Thank Krzysztof for your review!

I will add my board to dt-bindings in patch v2.

Follow some previous patches on 
Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml

https://lore.kernel.org/all/20240805-potin-catalina-dts-v7-1-286bfd2ab93b at gmail.com/
https://lore.kernel.org/all/20240522192524.3286237-13-eajames at linux.ibm.com/
https://lore.kernel.org/all/20240502002836.17862-7-zev at bewilderbeest.net/

Best regards,
Chanh

> Best regards,
> Krzysztof
> 


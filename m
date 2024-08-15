From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 05:50:44 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDA4LzEwXSBhcm02NDogZHRzOiBhc3BlZWQ6IEFkZCBp?=
 =?big5?Q?nitial_AST27XX_device_tree?=
In-Reply-To: <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
 <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
Message-ID: <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

>> ---
>>  arch/arm64/boot/dts/Makefile              |   1 +
>>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 217 ++++++++++++++++++++++
>>  2 files changed, 218 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 21cd3a87f385..c909c19dc5dd 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -34,3 +34,4 @@ subdir-y += tesla
>>  subdir-y += ti
>>  subdir-y += toshiba
>>  subdir-y += xilinx
>> +subdir-y += aspeed
>> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>> new file mode 100644
>> index 000000000000..858ab95251e4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>> @@ -0,0 +1,217 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
>> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>> +
>> +/ {
>> +     model = "Aspeed BMC";
>
>Model of what? No, drop.
Can I change to "model = "AST2700 EVB""

>
>> +     compatible = "aspeed,ast2700";
>
>Please run scripts/checkpatch.pl and fix reported warnings. Then please
>run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
>Some warnings can be ignored, especially from --strict run, but the code
>here looks like it needs a fix. Feel free to get in touch if the warning
>is not clear.
>
>
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +     interrupt-parent = <&gic>;
>> +
>> +     aliases {
>> +             serial12 = &uart12;
>
>Nope. Such aliases are board specific.
Agree, I will move to ast2700-evb.dts.
>
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     compatible = "arm,cortex-a35";
>> +                     enable-method = "psci";
>> +                     device_type = "cpu";
>> +                     reg = <0>;
>> +                     d-cache-size = <0x8000>;
>> +                     d-cache-line-size = <64>;
>> +                     d-cache-sets = <128>;
>> +                     i-cache-size = <0x8000>;
>> +                     i-cache-line-size = <64>;
>> +                     i-cache-sets = <256>;
>> +                     next-level-cache = <&l2>;
>> +             };
>> +
>> +             cpu at 1 {
>> +                     compatible = "arm,cortex-a35";
>> +                     enable-method = "psci";
>> +                     device_type = "cpu";
>> +                     reg = <1>;
>> +                     d-cache-size = <0x8000>;
>> +                     d-cache-line-size = <64>;
>> +                     d-cache-sets = <128>;
>> +                     i-cache-size = <0x8000>;
>> +                     i-cache-line-size = <64>;
>> +                     i-cache-sets = <256>;
>> +                     next-level-cache = <&l2>;
>> +             };
>> +
>> +             cpu at 2 {
>> +                     compatible = "arm,cortex-a35";
>> +                     enable-method = "psci";
>> +                     device_type = "cpu";
>> +                     reg = <2>;
>> +                     d-cache-size = <0x8000>;
>> +                     d-cache-line-size = <64>;
>> +                     d-cache-sets = <128>;
>> +                     i-cache-size = <0x8000>;
>> +                     i-cache-line-size = <64>;
>> +                     i-cache-sets = <256>;
>> +                     next-level-cache = <&l2>;
>> +             };
>> +
>> +             cpu at 3 {
>> +                     compatible = "arm,cortex-a35";
>> +                     enable-method = "psci";
>> +                     device_type = "cpu";
>> +                     reg = <3>;
>> +                     d-cache-size = <0x8000>;
>> +                     d-cache-line-size = <64>;
>> +                     d-cache-sets = <128>;
>> +                     i-cache-size = <0x8000>;
>> +                     i-cache-line-size = <64>;
>> +                     i-cache-sets = <256>;
>> +                     next-level-cache = <&l2>;
>> +             };
>> +
>> +             l2: l2-cache0 {
>> +                     compatible = "cache";
>> +                     cache-size = <0x80000>;
>> +                     cache-line-size = <64>;
>> +                     cache-sets = <1024>;
>> +                     cache-level = <2>;
>> +             };
>> +     };
>> +
>> +     pmu {
>> +             compatible = "arm,cortex-a35-pmu";
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>> +     };
>> +
>> +     psci {
>
>Order the nodes according to DTS coding style.
>
>Fix all your patches:
>1. To pass flawlessly checkpatch (you did not run it)
>2. To pass dt_binding_check and dtbs_check (you did not run these)
>3. To adhere to kernel coding style
>4. To adhere to DTS coding style
Agree.
>
>> +             compatible = "arm,psci-1.0";
>> +             method = "smc";
>> +     };
>> +
>> +     gic: interrupt-controller at 12200000 {
>
>Nope, this cannot be outside of SoC.
Agree.
>
>> +             compatible = "arm,gic-v3";
>> +             interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>> +             #interrupt-cells = <3>;
>> +             interrupt-controller;
>> +             interrupt-parent = <&gic>;
>> +             #redistributor-regions = <1>;
>> +             reg =   <0 0x12200000 0 0x10000>,               //GICD
>> +                     <0 0x12280000 0 0x80000>,               //GICR
>> +                     <0 0x40440000 0 0x1000>;                //GICC
>
>Read DTS coding style and order this correctly.
Agree.
>
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +                             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +                             <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +                             <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> +             arm,cpu-registers-not-fw-configured;
>> +             always-on;
>> +     };
>> +
>> +     soc0: soc at 10000000 {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             soc0_sram: sram at 10000000 {
>> +                     compatible = "mmio-sram";
>> +                     reg = <0x0 0x10000000 0x0 0x20000>;     /* 128KiB SRAM on soc0 */
>> +                     ranges = <0x0 0x0 0x0 0x10000000 0x0 0x20000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     no-memory-wc;
>> +
>> +                     exported at 0 {
>> +                             reg = <0 0x0 0 0x20000>;
>> +                             export;
>> +                     };
>> +             };
>> +
>> +             syscon0: syscon at 12c02000 {
>> +                     compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
>> +                     reg = <0x0 0x12c02000 0x0 0x1000>;
>> +                     ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     #clock-cells = <1>;
>> +                     #reset-cells = <1>;
>> +
>> +                     silicon-id at 0 {
>> +                             compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
>> +                             reg = <0 0x0 0 0x4>;
>> +                     };
>> +
>> +                     scu_ic0: interrupt-controller at 1D0 {
>
>DTS coding style...
Agree. I will fix to "scu_ic0: interrupt-controller at 1d0 {"

>
>> +                             #interrupt-cells = <1>;
>> +                             compatible = "aspeed,ast2700-scu-ic0";
>> +                             reg = <0 0x1d0 0 0xc>;
>> +                             interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +                             interrupt-controller;
>> +                     };
>> +
>> +                     scu_ic1: interrupt-controller at 1E0 {
>> +                             #interrupt-cells = <1>;
>> +                             compatible = "aspeed,ast2700-scu-ic1";
>> +                             reg = <0 0x1e0 0 0xc>;
>> +                             interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +                             interrupt-controller;
>> +                     };
>> +
>> +                     soc0_rst: reset-controller at 200 {
>> +                             reg = <0 0x200 0 0x40>;
>> +                     };
>> +
>> +                     soc0_clk: clock-controller at 240 {
>> +                             reg = <0 0x240 0 0x1c0>;
>> +                     };
>> +             };
>> +
>> +     };
>> +
>> +     soc1: soc at 14000000 {
>
>Wait, what, to socs?
Yes, two socs in different die.

>
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             syscon1: syscon at 14c02000 {
>> +                     compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
>> +                     reg = <0x0 0x14c02000 0x0 0x1000>;
>> +                     ranges = <0x0 0x0 0x0 0x14c02000 0x0 0x1000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     #clock-cells = <1>;
>> +                     #reset-cells = <1>;
>> +
>> +                     soc1_rst: reset-controller at 200 {
>> +                             #reset-cells = <1>;
>> +                     };
>> +
>> +                     soc1_clk: clock-controller at 240 {
>> +                             reg = <0 0x240 0 0x1c0>;
>> +                     };
>> +             };
>> +
>> +             uart12: serial at 14c33b00 {
>> +                     compatible = "ns16550a";
>> +                     reg = <0x0 0x14c33b00 0x0 0x100>;
>> +                     reg-shift = <2>;
>> +                     reg-io-width = <4>;
>> +                     clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
>> +                     no-loopback-test;
>> +                     pinctrl-names = "default";
>
>What is this?
BMC uart using in uart12 in soc1.

>
>> +             };
>> +     };
>> +};
>> +

--
Best Regards,
Kevin. Chen
________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?7?26? ?? 07:19
???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
??: Re: [PATCH v1 08/10] arm64: dts: aspeed: Add initial AST27XX device tree

On 26/07/2024 13:03, Kevin Chen wrote:
> ---
>  arch/arm64/boot/dts/Makefile              |   1 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 217 ++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 21cd3a87f385..c909c19dc5dd 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -34,3 +34,4 @@ subdir-y += tesla
>  subdir-y += ti
>  subdir-y += toshiba
>  subdir-y += xilinx
> +subdir-y += aspeed
> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> new file mode 100644
> index 000000000000..858ab95251e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +
> +/ {
> +     model = "Aspeed BMC";

Model of what? No, drop.

> +     compatible = "aspeed,ast2700";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> +     #address-cells = <2>;
> +     #size-cells = <2>;
> +     interrupt-parent = <&gic>;
> +
> +     aliases {
> +             serial12 = &uart12;

Nope. Such aliases are board specific.

> +     };
> +
> +     cpus {
> +             #address-cells = <1>;
> +             #size-cells = <0>;
> +
> +             cpu at 0 {
> +                     compatible = "arm,cortex-a35";
> +                     enable-method = "psci";
> +                     device_type = "cpu";
> +                     reg = <0>;
> +                     d-cache-size = <0x8000>;
> +                     d-cache-line-size = <64>;
> +                     d-cache-sets = <128>;
> +                     i-cache-size = <0x8000>;
> +                     i-cache-line-size = <64>;
> +                     i-cache-sets = <256>;
> +                     next-level-cache = <&l2>;
> +             };
> +
> +             cpu at 1 {
> +                     compatible = "arm,cortex-a35";
> +                     enable-method = "psci";
> +                     device_type = "cpu";
> +                     reg = <1>;
> +                     d-cache-size = <0x8000>;
> +                     d-cache-line-size = <64>;
> +                     d-cache-sets = <128>;
> +                     i-cache-size = <0x8000>;
> +                     i-cache-line-size = <64>;
> +                     i-cache-sets = <256>;
> +                     next-level-cache = <&l2>;
> +             };
> +
> +             cpu at 2 {
> +                     compatible = "arm,cortex-a35";
> +                     enable-method = "psci";
> +                     device_type = "cpu";
> +                     reg = <2>;
> +                     d-cache-size = <0x8000>;
> +                     d-cache-line-size = <64>;
> +                     d-cache-sets = <128>;
> +                     i-cache-size = <0x8000>;
> +                     i-cache-line-size = <64>;
> +                     i-cache-sets = <256>;
> +                     next-level-cache = <&l2>;
> +             };
> +
> +             cpu at 3 {
> +                     compatible = "arm,cortex-a35";
> +                     enable-method = "psci";
> +                     device_type = "cpu";
> +                     reg = <3>;
> +                     d-cache-size = <0x8000>;
> +                     d-cache-line-size = <64>;
> +                     d-cache-sets = <128>;
> +                     i-cache-size = <0x8000>;
> +                     i-cache-line-size = <64>;
> +                     i-cache-sets = <256>;
> +                     next-level-cache = <&l2>;
> +             };
> +
> +             l2: l2-cache0 {
> +                     compatible = "cache";
> +                     cache-size = <0x80000>;
> +                     cache-line-size = <64>;
> +                     cache-sets = <1024>;
> +                     cache-level = <2>;
> +             };
> +     };
> +
> +     pmu {
> +             compatible = "arm,cortex-a35-pmu";
> +             interrupt-parent = <&gic>;
> +             interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +     };
> +
> +     psci {

Order the nodes according to DTS coding style.

Fix all your patches:
1. To pass flawlessly checkpatch (you did not run it)
2. To pass dt_binding_check and dtbs_check (you did not run these)
3. To adhere to kernel coding style
4. To adhere to DTS coding style

> +             compatible = "arm,psci-1.0";
> +             method = "smc";
> +     };
> +
> +     gic: interrupt-controller at 12200000 {

Nope, this cannot be outside of SoC.

> +             compatible = "arm,gic-v3";
> +             interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +             #interrupt-cells = <3>;
> +             interrupt-controller;
> +             interrupt-parent = <&gic>;
> +             #redistributor-regions = <1>;
> +             reg =   <0 0x12200000 0 0x10000>,               //GICD
> +                     <0 0x12280000 0 0x80000>,               //GICR
> +                     <0 0x40440000 0 0x1000>;                //GICC

Read DTS coding style and order this correctly.

> +     };
> +
> +     timer {
> +             compatible = "arm,armv8-timer";
> +             interrupt-parent = <&gic>;
> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                             <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                             <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +             arm,cpu-registers-not-fw-configured;
> +             always-on;
> +     };
> +
> +     soc0: soc at 10000000 {
> +             compatible = "simple-bus";
> +             #address-cells = <2>;
> +             #size-cells = <2>;
> +             ranges;
> +
> +             soc0_sram: sram at 10000000 {
> +                     compatible = "mmio-sram";
> +                     reg = <0x0 0x10000000 0x0 0x20000>;     /* 128KiB SRAM on soc0 */
> +                     ranges = <0x0 0x0 0x0 0x10000000 0x0 0x20000>;
> +                     #address-cells = <2>;
> +                     #size-cells = <2>;
> +                     no-memory-wc;
> +
> +                     exported at 0 {
> +                             reg = <0 0x0 0 0x20000>;
> +                             export;
> +                     };
> +             };
> +
> +             syscon0: syscon at 12c02000 {
> +                     compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
> +                     reg = <0x0 0x12c02000 0x0 0x1000>;
> +                     ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
> +                     #address-cells = <2>;
> +                     #size-cells = <2>;
> +                     #clock-cells = <1>;
> +                     #reset-cells = <1>;
> +
> +                     silicon-id at 0 {
> +                             compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
> +                             reg = <0 0x0 0 0x4>;
> +                     };
> +
> +                     scu_ic0: interrupt-controller at 1D0 {

DTS coding style...

> +                             #interrupt-cells = <1>;
> +                             compatible = "aspeed,ast2700-scu-ic0";
> +                             reg = <0 0x1d0 0 0xc>;
> +                             interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +                             interrupt-controller;
> +                     };
> +
> +                     scu_ic1: interrupt-controller at 1E0 {
> +                             #interrupt-cells = <1>;
> +                             compatible = "aspeed,ast2700-scu-ic1";
> +                             reg = <0 0x1e0 0 0xc>;
> +                             interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +                             interrupt-controller;
> +                     };
> +
> +                     soc0_rst: reset-controller at 200 {
> +                             reg = <0 0x200 0 0x40>;
> +                     };
> +
> +                     soc0_clk: clock-controller at 240 {
> +                             reg = <0 0x240 0 0x1c0>;
> +                     };
> +             };
> +
> +     };
> +
> +     soc1: soc at 14000000 {

Wait, what, to socs?

> +             compatible = "simple-bus";
> +             #address-cells = <2>;
> +             #size-cells = <2>;
> +             ranges;
> +
> +             syscon1: syscon at 14c02000 {
> +                     compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
> +                     reg = <0x0 0x14c02000 0x0 0x1000>;
> +                     ranges = <0x0 0x0 0x0 0x14c02000 0x0 0x1000>;
> +                     #address-cells = <2>;
> +                     #size-cells = <2>;
> +                     #clock-cells = <1>;
> +                     #reset-cells = <1>;
> +
> +                     soc1_rst: reset-controller at 200 {
> +                             #reset-cells = <1>;
> +                     };
> +
> +                     soc1_clk: clock-controller at 240 {
> +                             reg = <0 0x240 0 0x1c0>;
> +                     };
> +             };
> +
> +             uart12: serial at 14c33b00 {
> +                     compatible = "ns16550a";
> +                     reg = <0x0 0x14c33b00 0x0 0x100>;
> +                     reg-shift = <2>;
> +                     reg-io-width = <4>;
> +                     clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
> +                     no-loopback-test;
> +                     pinctrl-names = "default";

What is this?

> +             };
> +     };
> +};
> +

Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/5620dfdb/attachment-0001.htm>

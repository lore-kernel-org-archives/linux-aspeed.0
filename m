From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 14 Nov 2023 14:55:38 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
In-Reply-To: <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
References: <20231114112722.28506-4-zev@bewilderbeest.net>
 <20231114112722.28506-6-zev@bewilderbeest.net>
 <cde26249-1d47-496f-b198-a0c4c02bed5c@linaro.org>
 <e766e663-0985-4a2e-8023-26ad0228157d@hatter.bewilderbeest.net>
Message-ID: <beafed87-a77d-4347-9648-24a51890eaa6@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 14, 2023 at 02:37:10PM PST, Zev Weiss wrote:
>On Tue, Nov 14, 2023 at 12:35:37PM PST, Krzysztof Kozlowski wrote:
>>On 14/11/2023 12:27, Zev Weiss wrote:
>>>Like the E3C246D4I, this is a reasonably affordable off-the-shelf
>>>mini-ITX AST2500/Xeon motherboard with good potential as an OpenBMC
>>>development platform.  Booting the host requires a modicum of eSPI
>>>support that's not yet in the mainline kernel, but most other basic
>>>BMC functionality is available with this device-tree.
>>>
>>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>---
>>> arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>> .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 314 ++++++++++++++++++
>>> 2 files changed, 315 insertions(+)
>>> create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
>>>
>>>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>>>index d3ac20e316d0..3398ee53f034 100644
>>>--- a/arch/arm/boot/dts/aspeed/Makefile
>>>+++ b/arch/arm/boot/dts/aspeed/Makefile
>>>@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>> 	aspeed-bmc-ampere-mtmitchell.dtb \
>>> 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>> 	aspeed-bmc-asrock-e3c246d4i.dtb \
>>>+	aspeed-bmc-asrock-e3c256d4i.dtb \
>>> 	aspeed-bmc-asrock-romed8hm3.dtb \
>>> 	aspeed-bmc-bytedance-g220a.dtb \
>>> 	aspeed-bmc-delta-ahe50dc.dtb \
>>>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
>>>new file mode 100644
>>>index 000000000000..4c55272afd4f
>>>--- /dev/null
>>>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
>>>@@ -0,0 +1,314 @@
>>>+// SPDX-License-Identifier: GPL-2.0+
>>>+/dts-v1/;
>>>+
>>>+#include "aspeed-g5.dtsi"
>>>+#include <dt-bindings/gpio/aspeed-gpio.h>
>>>+#include <dt-bindings/i2c/i2c.h>
>>>+#include <dt-bindings/interrupt-controller/irq.h>
>>>+#include <dt-bindings/watchdog/aspeed-wdt.h>
>>>+
>>>+/{
>>>+	model = "ASRock E3C256D4I BMC";
>>>+	compatible = "asrock,e3c256d4i-bmc", "aspeed,ast2500";
>>>+
>>>+	aliases {
>>>+		serial4 = &uart5;
>>>+
>>>+		i2c20 = &i2c2mux0ch0;
>>>+		i2c21 = &i2c2mux0ch1;
>>>+		i2c22 = &i2c2mux0ch2;
>>>+		i2c23 = &i2c2mux0ch3;
>>>+	};
>>>+
>>>+	chosen {
>>>+		stdout-path = &uart5;
>>>+		bootargs = "console=tty0 console=ttyS4,115200 earlycon";
>>
>>Drop bootargs.
>>
>
>Ack.
>
>>>+	};
>>>+
>>>+	memory at 80000000 {
>>>+		reg = <0x80000000 0x20000000>;
>>>+	};
>>>+
>>>+	leds {
>>>+		compatible = "gpio-leds";
>>>+
>>>+		heartbeat {
>>
>>It does not look like you tested the DTS against bindings. Please run
>>`make dtbs_check W=1` (see
>>Documentation/devicetree/bindings/writing-schema.rst or
>>https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>for instructions).
>>
>
>As with my spc621d8hm3 dts patch, I did run that and got no output, so 
>if there are other specific problems please let me know what they are.
>

Whoops, and of course now I realize I also sent the first reply to this 
thread instead of the spc621d8hm3 one...


Zev


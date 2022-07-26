From: logananth hcl <logananth13.hcl@gmail.com>
Date: Tue, 26 Jul 2022 17:07:06 +0530
Subject: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
In-Reply-To: <20220720231605.GA30806@packtop>
References: <20220720105331.GA23472@logan-ThinkPad-T14-Gen-1> <20220720231605.GA30806@packtop>
Message-ID: <CAGpPFEGs5BHPvY0VCMJofASTLd5hCD5uovDpfLembX+EMs+rnw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 21, 2022 at 4:46 AM Zev Weiss <zweiss@equinix.com> wrote:

> On Wed, Jul 20, 2022 at 03:53:31AM PDT, Logananth Sundararaj wrote:
> >The Yosemite V3.5 is a facebook multi-node server
> >platform that host four OCP server. The BMC
> >in the Yosemite V3.5 platform based on AST2600 SoC.
> >
> >This patch adds linux device tree entry related to
> >Yosemite V3.5 specific devices connected to BMC SoC.
> >
> >Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>
> >
> >---
> >--- v4 - Bootagrs and memory removed.
> >--- v3 - Addressed v2 patch comments.
> >--- v2 - Enabled i2c drivers.
> >--- v1 - Initial draft.
> >---
> >---
> > arch/arm/boot/dts/Makefile                    |   1 +
> > .../boot/dts/aspeed-bmc-facebook-fby35.dts    | 260 ++++++++++++++++++
> > 2 files changed, 261 insertions(+)
> > create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> >
> >diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >index 7e0934180724..58add093e5fb 100644
> >--- a/arch/arm/boot/dts/Makefile
> >+++ b/arch/arm/boot/dts/Makefile
> >@@ -1465,6 +1465,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >       aspeed-bmc-facebook-cloudripper.dtb \
> >       aspeed-bmc-facebook-cmm.dtb \
> >       aspeed-bmc-facebook-elbert.dtb \
> >+      aspeed-bmc-facebook-fby35.dtb \
> >       aspeed-bmc-facebook-fuji.dtb \
> >       aspeed-bmc-facebook-galaxy100.dtb \
> >       aspeed-bmc-facebook-minipack.dtb \
> >diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> b/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> >new file mode 100644
> >index 000000000000..05efba7117a8
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
> >@@ -0,0 +1,260 @@
> >+// SPDX-License-Identifier: GPL-2.0-or-later
> >+// Copyright (c) 2020 Facebook Inc.
> >+
> >+/dts-v1/;
> >+
> >+#include "aspeed-g6.dtsi"
> >+#include <dt-bindings/gpio/aspeed-gpio.h>
> >+#include <dt-bindings/i2c/i2c.h>
> >+
> >+/ {
> >+      model = "Facebook fby35";
> >+      compatible = "facebook,fby35", "aspeed,ast2600";
> >+
> >+      aliases {
> >+              serial4 = &uart5;
> >+      };
> >+
> >+      chosen {
> >+              stdout-path = &uart5;
> >+      };
> >+
> >+      iio-hwmon {
> >+              compatible = "iio-hwmon";
> >+              io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> >+                      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> >+                      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> >+                      <&adc1 4>, <&adc1 5>, <&adc1 6>;
> >+      };
>
> A blank line here would be nice for formatting consistency...
>
> will fix it.

> >+      spi_gpio: spi-gpio {
> >+              status = "okay";
> >+              compatible = "spi-gpio";
> >+              #address-cells = <1>;
> >+              #size-cells = <0>;
> >+
> >+              gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> >+              gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> >+              gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> >+              num-chipselects = <1>;
> >+              cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> >+
> >+              tpmdev at 0 {
> >+                      compatible = "tcg,tpm_tis-spi";
> >+                      spi-max-frequency = <33000000>;
> >+                      reg = <0>;
> >+              };
> >+      };
> >+
>
> ...and this one could be removed.
>
> will fix it.

> >+};
> >+
> >+&mac3 {
> >+      status = "okay";
> >+
> >+      pinctrl-names = "default";
> >+      pinctrl-0 = <&pinctrl_rmii4_default>;
> >+      no-hw-checksum;
> >+      use-ncsi;
> >+      mlx,multi-host;
> >+      ncsi-ctrl,start-redo-probe;
> >+      ncsi-ctrl,no-channel-monitor;
> >+      ncsi-package = <1>;
> >+      ncsi-channel = <1>;
> >+      ncsi-rexmit = <1>;
> >+      ncsi-timeout = <2>;
> >+};
> >+
> >+&uart1 {
> >+      status = "okay";
> >+};
> >+
> >+&uart2 {
> >+      status = "okay";
> >+};
> >+
> >+&uart3 {
> >+      status = "okay";
> >+};
> >+
> >+&uart4 {
> >+      status = "okay";
> >+};
> >+
> >+&uart5 {
> >+      status = "okay";
> >+      compatible = "snps,dw-apb-uart";
> >+};
> >+
> >+&wdt1 {
> >+      status = "okay";
> >+      pinctrl-names = "default";
> >+      pinctrl-0 = <&pinctrl_wdtrst1_default>;
> >+      aspeed,reset-type = "soc";
> >+      aspeed,external-signal;
> >+      aspeed,ext-push-pull;
> >+      aspeed,ext-active-high;
> >+      aspeed,ext-pulse-duration = <256>;
> >+};
> >+
> >+&rtc {
> >+      status = "okay";
> >+};
> >+
> >+&fmc {
> >+      status = "okay";
> >+      flash at 0 {
> >+              status = "okay";
> >+              m25p,fast-read;
> >+              label = "spi0.1";
> >+              spi-max-frequency = <50000000>;
> >+              #include "openbmc-flash-layout-128.dtsi"
> >+      };
> >+      flash at 1 {
> >+              status = "okay";
> >+              m25p,fast-read;
> >+              label = "spi0.0";
> >+              spi-max-frequency = <50000000>;
> >+              #include "openbmc-flash-layout.dtsi"
> >+      };
>
> The labels on these look backwards from what I'd guess was probably
> intended (flash at 0 is spi0.1 and flash at 1 is spi0.0).
>
> Let's check into this, and fix it.

> >+};
> >+
> >+&i2c0 {
> >+      //Host1 IPMB bus
>
> While it's not currently 100% consistent, I think the generally
> preferred style is to put a space after '//' (here and elsewhere).
>
will fix it.

>
> >+      status = "okay";
> >+      multi-master;
> >+      ipmb0 at 10 {
> >+              compatible = "ipmb-dev";
> >+              reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> >+              i2c-protocol;
> >+      };
> >+};
> >+
> >+&i2c1 {
> >+      //Host2 IPMB bus
> >+      status = "okay";
> >+      multi-master;
> >+      ipmb1 at 10 {
> >+              compatible = "ipmb-dev";
> >+              reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> >+              i2c-protocol;
> >+      };
> >+};
> >+
> >+&i2c2 {
> >+      //Host3 IPMB bus
> >+      status = "okay";
> >+      multi-master;
> >+      ipmb2 at 10 {
> >+              compatible = "ipmb-dev";
> >+              reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> >+              i2c-protocol;
> >+      };
> >+};
> >+
> >+&i2c3 {
> >+      //Host1 IPMB bus
> >+      status = "okay";
> >+      multi-master;
> >+      ipmb3 at 10 {
> >+              compatible = "ipmb-dev";
> >+              reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> >+              i2c-protocol;
> >+      };
> >+};
> >+
> >+&i2c4 {
> >+      status = "okay";
> >+};
> >+
> >+&i2c5 {
> >+      status = "okay";
> >+};
> >+
> >+&i2c6 {
> >+      status = "okay";
> >+};
> >+
> >+&i2c7 {
> >+      status = "okay";
> >+};
> >+
> >+&i2c8 {
> >+      //NIC SENSOR TEMP
> >+      status = "okay";
> >+      tmp421 at 1f {
> >+              compatible = "ti,tmp421";
> >+              reg = <0x1f>;
> >+      };
> >+};
> >+
> >+&i2c9 {
> >+      // Debug-Card IPMB bus
> >+      status = "okay";
> >+      multi-master;
> >+      ipmb9 at 30 {
> >+              compatible = "ipmb-dev";
> >+              reg = <(0x30 | I2C_OWN_SLAVE_ADDRESS)>;
> >+              i2c-protocol;
> >+      };
> >+};
> >+
> >+&i2c10 {
> >+      status = "okay";
> >+};
> >+
> >+&i2c11 {
> >+      status = "okay";
> >+      //FRU EEPROM
> >+      eeprom at 51 {
> >+              compatible = "atmel,24c64";
> >+              reg = <0x51>;
> >+              pagesize = <32>;
> >+      };
> >+};
> >+
> >+&i2c12 {
> >+      status = "okay";
> >+      //INLET TEMP
> >+      tmp75 at 4e {
> >+              compatible = "ti,tmp75";
> >+              reg = <0x4e>;
> >+      };
> >+      //OUTLET TEMP
> >+      tmp75 at 4f {
> >+              compatible = "ti,tmp75";
> >+              reg = <0x4f>;
> >+      };
> >+};
> >+
> >+&i2c13 {
> >+      status = "okay";
> >+};
> >+
> >+&adc0 {
> >+      ref_voltage = <2500>;
> >+      status = "okay";
> >+
> >+      pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> >+              &pinctrl_adc2_default &pinctrl_adc3_default
> >+              &pinctrl_adc4_default &pinctrl_adc5_default
> >+              &pinctrl_adc6_default &pinctrl_adc7_default>;
> >+};
> >+
> >+&adc1 {
> >+      ref_voltage = <2500>;
> >+      status = "okay";
> >+
> >+      pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> >+              &pinctrl_adc10_default &pinctrl_adc11_default
> >+              &pinctrl_adc12_default &pinctrl_adc13_default>;
> >+};
>
> Missing blank line.
>
> will fix.

> >+&ehci0 {
> >+      status = "okay";
> >+};
> >+
> >+&ehci1 {
> >+      status = "okay";
> >+};
> >+
> >+&uhci {
> >+      status = "okay";
> >+};
> >--
> >2.17.1
> >

Thanks
-Logananth
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220726/d23da5d5/attachment-0001.htm>

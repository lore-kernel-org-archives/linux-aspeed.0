From: Kelly Hung(洪嘉莉) <Kelly_Hung@asus.com>
Date: Thu, 29 Feb 2024 07:23:49 -0000
Subject: [PATCH 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
In-Reply-To: <20240223215620.GA9299@packtop>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
 <20240222085914.1218037-2-Kelly_Hung@asus.com>
 <20240223215620.GA9299@packtop>
Message-ID: <TYZPR04MB65969645367EEDF9667FE8339D5F2@TYZPR04MB6596.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Zev,

>+      flash at 0 {
>+              status = "okay";
>+              m25p,fast-read;
>+              label = "bmc-spi";

Is this specific label needed or desired for some particular reason?
Most OpenBMC platforms just call it "bmc", and I think some of the firmware-update machinery may have assumptions about that baked in, so I wouldn't be surprised if this naming breaks things...

>+              spi-max-frequency = <50000000>;
>+#include "openbmc-flash-layout-128.dtsi"

Just to confirm, this is actually a 128MB flash chip?  I ask because the previous version of this patch had some indication of it being 64MB (though there was a lot that looked wonky with the partition layout, so maybe that was wrong too).

>+      };
>+};

Reply by Kelly:
I will correct the label with "bmc" and use 64M patition then update in v3 patch.


>+      flash at 0 {
>+              status = "okay";
>+              m25p,fast-read;
>+              label = "bmc-spi";

Is this specific label needed or desired for some particular reason?
Most OpenBMC platforms just call it "bmc", and I think some of the firmware-update machinery may have assumptions about that baked in, so I wouldn't be surprised if this naming breaks things...

>+              spi-max-frequency = <50000000>;
>+#include "openbmc-flash-layout-128.dtsi"

Just to confirm, this is actually a 128MB flash chip?  I ask because the previous version of this patch had some indication of it being 64MB (though there was a lot that looked wonky with the partition layout, so maybe that was wrong too).

>+      };

Reply by Kelly:
I also remove bios partition section and rename label with "bios".


Thanks for review.

Best Regards
Kelly
-----Original Message-----
From: Zev Weiss <zweiss@equinix.com>
Sent: Saturday, February 24, 2024 5:57 AM
To: Kelly Hung <ppighouse@gmail.com>
Cc: robh+dt at kernel.org; devicetree at vger.kernel.org; conor+dt at kernel.org; linux-aspeed at lists.ozlabs.org; openbmc at lists.ozlabs.org; linux-kernel at vger.kernel.org; Kelly Hung(???) <Kelly_Hung@asus.com>; joel at jms.id.au; krzysztof.kozlowski+dt at linaro.org; AllenYY Hsu(???) <AllenYY_Hsu@asus.com>; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

External email : Ensure your email is secure before opening links and attachments.

On Thu, Feb 22, 2024 at 12:59:14AM PST, Kelly Hung wrote:
>Base on aspeed-g6.dtsi and can boot into BMC console.
>
>Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
>---
> arch/arm/boot/dts/aspeed/Makefile             |   1 +
> .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 592 ++++++++++++++++++
> 2 files changed, 593 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile
>b/arch/arm/boot/dts/aspeed/Makefile
>index d3ac20e31..32c41f3d9 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>       aspeed-bmc-arm-stardragon4800-rep2.dtb \
>       aspeed-bmc-asrock-e3c246d4i.dtb \
>       aspeed-bmc-asrock-romed8hm3.dtb \
>+      aspeed-bmc-asus-x4tf.dtb \
>       aspeed-bmc-bytedance-g220a.dtb \
>       aspeed-bmc-delta-ahe50dc.dtb \
>       aspeed-bmc-facebook-bletchley.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>new file mode 100644
>index 000000000..1bda14a66
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>@@ -0,0 +1,592 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later // Copyright 2024 ASUS
>+Corp.
>+
>+/dts-v1/;
>+
>+#include "aspeed-g6.dtsi"
>+#include "aspeed-g6-pinctrl.dtsi"
>+#include <dt-bindings/i2c/i2c.h>
>+#include <dt-bindings/gpio/aspeed-gpio.h>
>+
>+/ {
>+      model = "ASUS-X4TF";
>+      compatible = "asus,x4tf", "aspeed,ast2600";
>+
>+      aliases {
>+              serial4 = &uart5;
>+      };
>+
>+      chosen {
>+              stdout-path = "serial4:115200n8";
>+      };
>+
>+      memory at 80000000 {
>+              device_type = "memory";
>+              reg = <0x80000000 0x40000000>;
>+      };
>+
>+      reserved-memory {
>+              #address-cells = <1>;
>+              #size-cells = <1>;
>+              ranges;
>+
>+              video_engine_memory: video {
>+                      size = <0x04000000>;
>+                      alignment = <0x01000000>;
>+                      compatible = "shared-dma-pool";
>+                      reusable;
>+              };
>+      };
>+
>+      iio-hwmon {
>+              compatible = "iio-hwmon";
>+              io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
>+                              <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
>+                              <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
>+                              <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
>+      };
>+
>+      leds {
>+              compatible = "gpio-leds";
>+
>+              led-heartbeat {
>+                      gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
>+                      linux,default-trigger = "heartbeat";
>+              };
>+
>+              led-uid {
>+                      gpios = <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>+                      default-state = "off";
>+              };
>+
>+              led-status_Y {
>+                      gpios = <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
>+                      default-state = "off";
>+              };
>+
>+              led-sys_boot_status {
>+                      gpios = <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
>+                      default-state = "off";
>+              };
>+      };
>+};
>+
>+&adc0 {
>+      vref = <2500>;
>+      status = "okay";
>+      pinctrl-names = "default";
>+      pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
>+              &pinctrl_adc2_default &pinctrl_adc3_default
>+              &pinctrl_adc4_default &pinctrl_adc5_default
>+              &pinctrl_adc6_default &pinctrl_adc7_default>; };
>+
>+&adc1 {
>+      vref = <2500>;
>+      status = "okay";
>+      pinctrl-names = "default";
>+      pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
>+              &pinctrl_adc10_default &pinctrl_adc11_default
>+              &pinctrl_adc12_default &pinctrl_adc13_default
>+              &pinctrl_adc14_default &pinctrl_adc15_default>; };
>+
>+&peci0 {
>+      status = "okay";
>+};
>+
>+&lpc_snoop {
>+      snoop-ports = <0x80>;
>+      status = "okay";
>+};
>+
>+&mac2 {
>+      status = "okay";
>+      phy-mode = "rmii";
>+      use-ncsi;
>+      pinctrl-names = "default";
>+      pinctrl-0 = <&pinctrl_rmii3_default>; };
>+
>+&mac3 {
>+      status = "okay";
>+      phy-mode = "rmii";
>+      use-ncsi;
>+      pinctrl-names = "default";
>+      pinctrl-0 = <&pinctrl_rmii4_default>; };
>+
>+&fmc {
>+      status = "okay";
>+
>+      flash at 0 {
>+              status = "okay";
>+              m25p,fast-read;
>+              label = "bmc-spi";

Is this specific label needed or desired for some particular reason?
Most OpenBMC platforms just call it "bmc", and I think some of the firmware-update machinery may have assumptions about that baked in, so I wouldn't be surprised if this naming breaks things...

>+              spi-max-frequency = <50000000>;
>+#include "openbmc-flash-layout-128.dtsi"

Just to confirm, this is actually a 128MB flash chip?  I ask because the previous version of this patch had some indication of it being 64MB (though there was a lot that looked wonky with the partition layout, so maybe that was wrong too).

>+      };
>+};
>+
>+&spi1 {
>+      status = "okay";
>+      pinctrl-names = "default";
>+      pinctrl-0 = <&pinctrl_spi1_default>;
>+
>+      flash at 0 {
>+              status = "okay";
>+              label = "bios-spi";
>+              spi-max-frequency = <50000000>;
>+
>+              partitions {
>+                      compatible = "fixed-partitions";
>+                      #address-cells = <1>;
>+                      #size-cells = <1>;
>+
>+                      biosfullimg at 0 {
>+                              reg = <0x0 0x2000000>; //32768 *1024 = 32 MB
>+                              label = "biosfullimg";
>+                      };
>+              };

If there's only one partition that's just covering the whole chip there's no need to include the 'partitions' child node.

>+      };
>+};
>+
>+&i2c0 {
>+      status = "okay";
>+};
>+
>+&i2c1 {
>+      status = "okay";
>+};
>+
>+&i2c2 {
>+      status = "okay";
>+};
>+
>+&i2c3 {
>+      status = "okay";
>+};
>+
>+&i2c4 {
>+      status = "okay";
>+
>+      temperature-sensor at 48 {
>+              compatible = "ti,tmp75";
>+              reg = <0x48>;
>+      };
>+
>+      temperature-sensor at 49 {
>+              compatible = "ti,tmp75";
>+              reg = <0x49>;
>+      };
>+
>+      pca9555_4_20: gpio at 20 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x20>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+
>+      pca9555_4_22: gpio at 22 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x22>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+
>+      pca9555_4_24: gpio at 24 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x24>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+              gpio-line-names =
>+              /*A0 - A3 0*/   "", "STRAP_BMC_BATTERY_GPIO1", "", "",
>+              /*A4 - A7 4*/   "", "", "", "",
>+              /*B0 - B7 8*/   "", "", "", "", "", "", "", "";
>+      };
>+
>+      pca9555_4_26: gpio at 26 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x26>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+
>+      i2c-mux at 70 {
>+              compatible = "nxp,pca9546";
>+              status = "okay";
>+              reg = <0x70>;
>+              #address-cells = <1>;
>+              #size-cells = <0>;
>+
>+              channel_1: i2c at 0 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <0>;
>+              };
>+
>+              channel_2: i2c at 1 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <1>;
>+              };
>+
>+              channel_3: i2c at 2 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <2>;
>+              };
>+
>+              channel_4: i2c at 3 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <3>;
>+              };
>+      };
>+};
>+
>+&i2c5 {
>+      status = "okay";
>+
>+      pca9555_5_24: gpio at 24 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x24>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+
>+      i2c-mux at 70  {
>+              compatible = "nxp,pca9546";
>+              status = "okay";
>+              reg = <0x70 >;
>+              #address-cells = <1>;
>+              #size-cells = <0>;
>+
>+              channel_5: i2c at 0 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <0>;
>+
>+                      pca9555_5_5_20: gpio at 20 {
>+                              compatible = "nxp,pca9555";
>+                              reg = <0x20>;
>+                              gpio-controller;
>+                              #gpio-cells = <2>;
>+                              gpio-line-names =
>+                                      "", "", "", "", "", "", "", "",
>+                                      "", "", "SYS_FAN6", "SYS_FAN5",
>+                                      "SYS_FAN4", "SYS_FAN3",
>+                                      "SYS_FAN2", "SYS_FAN1";
>+                      };
>+
>+                      pca9555_5_5_21: gpio at 21 {
>+                              compatible = "nxp,pca9555";
>+                              reg = <0x21>;
>+                              gpio-controller;
>+                              #gpio-cells = <2>;
>+                      };
>+
>+                      power-monitor at 44 {
>+                              compatible = "ti,ina219";
>+                              reg = <0x44>;
>+                              shunt-resistor = <2>;
>+                      };
>+              };
>+
>+              channel_6: i2c at 1 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <1>;
>+              };
>+
>+              channel_7: i2c at 2 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <2>;
>+              };
>+
>+              channel_8: i2c at 3 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <3>;
>+              };
>+      };
>+};
>+
>+&i2c6 {
>+      status = "okay";
>+
>+      pca9555_6_27: gpio at 27 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x27>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+
>+      pca9555_6_20: gpio at 20 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x20>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+              gpio-line-names =
>+              /*A0 0*/        "", "", "", "", "", "", "", "",
>+              /*B0 8*/        "Drive_NVMe1", "Drive_NVMe2", "", "",
>+              /*B4 12*/       "", "", "", "";
>+      };
>+
>+      pca9555_6_21: gpio at 21 {
>+              compatible = "nxp,pca9555";
>+              reg = <0x21>;
>+              gpio-controller;
>+              #gpio-cells = <2>;
>+      };
>+};
>+
>+&i2c7 {
>+      status = "okay";
>+
>+      i2c-mux at 70 {
>+              compatible = "nxp,pca9546";
>+              status = "okay";
>+              reg = <0x70>;
>+              #address-cells = <1>;
>+              #size-cells = <0>;
>+              idle-state = <1>;
>+
>+              channel_9: i2c at 0 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <0>;
>+
>+                      temperature-sensor at 48 {
>+                              compatible = "ti,tmp75";
>+                              reg = <0x48>;
>+                      };
>+
>+                      temperature-sensor at 49 {
>+                              compatible = "ti,tmp75";
>+                              reg = <0x49>;
>+                      };
>+
>+                      power-monitor at 40 {
>+                              compatible = "ti,ina219";
>+                              reg = <0x40>;
>+                              shunt-resistor = <2>;
>+                      };
>+
>+                      power-monitor at 41 {
>+                              compatible = "ti,ina219";
>+                              reg = <0x41>;
>+                              shunt-resistor = <5>;
>+                      };
>+              };
>+
>+              channel_10: i2c at 1 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <1>;
>+              };
>+
>+              channel_11: i2c at 2 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <2>;
>+              };
>+
>+              channel_12: i2c at 3 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <3>;
>+              };
>+      };
>+
>+      i2c-mux at 71 {
>+              compatible = "nxp,pca9546";
>+              status = "okay";
>+              reg = <0x71>;
>+              #address-cells = <1>;
>+              #size-cells = <0>;
>+              i2c-mux-idle-disconnect;
>+
>+              channel_13: i2c at 0 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <0>;
>+              };
>+
>+              channel_14: i2c at 1 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <1>;
>+              };
>+
>+              channel_15: i2c at 2 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <2>;
>+              };
>+
>+              channel_16: i2c at 3 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <3>;
>+              };
>+      };
>+};
>+
>+&i2c8 {
>+      status = "okay";
>+
>+      i2c-mux at 70 {
>+              compatible = "nxp,pca9546";
>+              status = "okay";
>+              reg = <0x70>;
>+              #address-cells = <1>;
>+              #size-cells = <0>;
>+              i2c-mux-idle-disconnect;
>+
>+              channel_17: i2c at 0 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <0>;
>+              };
>+
>+              channel_18: i2c at 1 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <1>;
>+
>+                      temperature-sensor at 48 {
>+                              compatible = "ti,tmp75";
>+                              reg = <0x48>;
>+                      };
>+
>+                      power-monitor at 41 {
>+                              compatible = "ti,ina219";
>+                              reg = <0x41>;
>+                              shunt-resistor = <5>;
>+                      };
>+              };
>+
>+              channel_19: i2c at 2 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <2>;
>+              };
>+
>+              channel_20: i2c at 3 {
>+                      #address-cells = <1>;
>+                      #size-cells = <0>;
>+                      reg = <3>;
>+              };
>+      };
>+};
>+
>+&i2c9 {
>+      status = "okay";
>+};
>+
>+&i2c10 {
>+      status = "okay";
>+};
>+
>+&i2c11 {
>+      status = "okay";
>+};
>+
>+&i2c14 {
>+      status = "okay";
>+      multi-master;
>+
>+      eeprom at 50 {
>+              compatible = "atmel,24c08";
>+              reg = <0x50>;
>+      };
>+
>+      eeprom at 51 {
>+              compatible = "atmel,24c08";
>+              reg = <0x51>;
>+      };
>+};
>+
>+&sgpiom0 {
>+      status = "okay";
>+      ngpios = <128>;
>+};
>+
>+&video {
>+      status = "okay";
>+      memory-region = <&video_engine_memory>; };
>+
>+&sdc {
>+      status = "okay";
>+};
>+
>+&lpc_snoop {
>+      status = "okay";
>+      snoop-ports = <0x80>;
>+};
>+
>+&kcs1 {
>+      aspeed,lpc-io-reg = <0xca0>;
>+      status = "okay";
>+};
>+
>+&kcs2 {
>+      aspeed,lpc-io-reg = <0xca8>;
>+      status = "okay";
>+};
>+
>+&kcs3 {
>+      aspeed,lpc-io-reg = <0xca2>;
>+      status = "okay";
>+};
>+
>+&uart3 {
>+      status = "okay";
>+};
>+
>+&uart5 {
>+      status = "okay";
>+};
>+
>+&uart_routing {
>+      status = "okay";
>+};
>+
>+&vhub {
>+      status = "okay";
>+};
>+
>+&gpio0 {
>+      gpio-line-names =
>+      /*A0 0*/        "", "", "", "", "", "", "", "",
>+      /*B0 8*/        "", "", "", "", "", "", "PS_PWROK", "",
>+      /*C0 16*/       "", "", "", "", "", "", "", "",
>+      /*D0 24*/       "", "", "", "", "", "", "", "",
>+      /*E0 32*/       "", "", "", "", "", "", "", "",
>+      /*F0 40*/       "", "", "", "", "", "", "", "",
>+      /*G0 48*/       "", "", "", "", "", "", "", "",
>+      /*H0 56*/       "", "", "", "", "", "", "", "",
>+      /*I0 64*/       "", "", "", "", "", "", "", "",
>+      /*J0 72*/       "", "", "", "", "", "", "", "",
>+      /*K0 80*/       "", "", "", "", "", "", "", "",
>+      /*L0 88*/       "", "", "", "", "", "", "", "",
>+      /*M0 96*/       "", "", "", "", "", "", "", "",
>+      /*N0 104*/      "", "", "", "",
>+      /*N4 108*/      "POST_COMPLETE", "ESR1_GPIO_AST_SPISEL", "", "",
>+      /*O0 112*/      "", "", "", "", "", "", "", "",
>+      /*P0 120*/      "ID_BUTTON", "ID_OUT", "POWER_BUTTON", "POWER_OUT",
>+      /*P4 124*/      "RESET_BUTTON", "RESET_OUT", "", "HEARTBEAT",
>+      /*Q0 128*/      "", "", "", "", "", "", "", "",
>+      /*R0 136*/      "", "", "", "", "", "", "", "",
>+      /*S0 144*/      "", "", "", "", "", "", "", "",
>+      /*T0 152*/      "", "", "", "", "", "", "", "",
>+      /*U0 160*/      "", "", "", "", "", "", "", "",
>+      /*V0 168*/      "", "", "", "", "", "", "", "",
>+      /*W0 176*/      "", "", "", "", "", "", "", "",
>+      /*X0 184*/      "", "", "", "", "", "", "", "",
>+      /*Y0 192*/      "", "", "", "", "", "", "", "",
>+      /*Z0 200*/      "", "", "", "", "", "", "", "";
>+};
>--
>2.25.1
>
<p></p>

===================================================================================================================================
This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
===================================================================================================================================

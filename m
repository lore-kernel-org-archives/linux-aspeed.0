From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Aug 2023 05:43:18 +0000
Subject: [PATCH v8 2/2] ARM: dts: aspeed: yosemite4: add Facebook Yosemite
 4 BMC
In-Reply-To: <20230810034421.742166-3-Delphine_CC_Chiu@wiwynn.com>
References: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com> <20230810034421.742166-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CACPK8XfA8=dWgEo42shs-Qa+S=+T42tP-aDTCiQDpLP5E2rW+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 at 03:44, Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Add linux device tree entry for Yosemite 4 devices connected to BMC.
> The Yosemite 4 is a Meta multi-node server platform, based on AST2600 SoC.
>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
> v8 - Add description of Yosemite 4
>    - Remove unsupported ncsi config
>    - Revise i2c-mux config
>    - Correct power sensor i2c address
>    - Restore i2c 11 bus-frequency to default
> v7 - Revise changelog format
> v6 - Change project name from yosemitev4 to yosemite4
> v5 - Revise rtc setting
>    - Remove duplicated multi-master setting
> v3 - Revise the bootargs to stdout-path
>    - Revise i2c devices
> v2 - Revise the DTS node name
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 627 ++++++++++++++++++
>  2 files changed, 628 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index c68984322a86..5b9264b823f3 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-facebook-wedge400.dtb \
>         aspeed-bmc-facebook-yamp.dtb \
>         aspeed-bmc-facebook-yosemitev2.dtb \
> +       aspeed-bmc-facebook-yosemite4.dtb \
>         aspeed-bmc-ibm-bonnell.dtb \
>         aspeed-bmc-ibm-everest.dtb \
>         aspeed-bmc-ibm-rainier.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> new file mode 100644
> index 000000000000..cb64417564bb
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +       model = "Facebook Yosemite 4 BMC";
> +       compatible = "facebook,yosemite4-bmc", "aspeed,ast2600";
> +
> +       aliases {
> +               serial4 = &uart5;
> +               serial5 = &uart6;
> +               serial6 = &uart7;
> +               serial7 = &uart8;
> +               serial8 = &uart9;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial4:57600n8";
> +       };
> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                               <&adc1 0>, <&adc1 1>;
> +       };
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       status = "okay";
> +};
> +
> +&uart6 {
> +       status = "okay";
> +};
> +
> +&uart7 {
> +       status = "okay";
> +};
> +
> +&uart8 {
> +       status = "okay";
> +};
> +
> +&uart9 {
> +       status = "okay";
> +};
> +
> +&wdt1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +       aspeed,reset-type = "soc";
> +       aspeed,external-signal;
> +       aspeed,ext-push-pull;
> +       aspeed,ext-active-high;
> +       aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac2 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii3_default>;
> +       no-hw-checksum;

Are you sure you need to set no-hw-checksum?

The driver when running on an ast2600 already disables tx hw checksum
if ncsi is enabled:

        /* AST2600 tx checksum with NCSI is broken */
        if (priv->use_ncsi && of_device_is_compatible(np, "aspeed,ast2600-mac"))
                netdev->hw_features &= ~NETIF_F_HW_CSUM;

The rest of the patch looks good.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel



> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash at 0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-rx-bus-width = <4>;
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +       };
> +       flash at 1 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc2";
> +               spi-rx-bus-width = <4>;
> +               spi-max-frequency = <50000000>;
> +       };
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +       mctp-controller;
> +       bus-frequency = <400000>;
> +       multi-master;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +       i2c-mux at 70 {
> +               compatible = "nxp,pca9544";
> +               idle-state = <0>;
> +               i2c-mux-idle-disconnect;
> +               reg = <0x70>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +       i2c-mux at 71 {
> +               compatible = "nxp,pca9544";
> +               idle-state = <0>;
> +               i2c-mux-idle-disconnect;
> +               reg = <0x71>;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +       power-sensor at 10 {
> +               compatible = "adi, adm1272";
> +               reg = <0x10>;
> +       };
> +
> +       power-sensor at 12 {
> +               compatible = "adi, adm1272";
> +               reg = <0x12>;
> +       };
> +
> +       gpio at 20 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       gpio at 21 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x21>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       gpio at 22 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x22>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       gpio at 23 {
> +               compatible = "nxp,pca9555";
> +               reg = <0x23>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       temperature-sensor at 48 {
> +               compatible = "ti,tmp75";
> +               reg = <0x48>;
> +       };
> +
> +       temperature-sensor at 49 {
> +               compatible = "ti,tmp75";
> +               reg = <0x49>;
> +       };
> +
> +       temperature-sensor at 4a {
> +               compatible = "ti,tmp75";
> +               reg = <0x4a>;
> +       };
> +
> +       temperature-sensor at 4b {
> +               compatible = "ti,tmp75";
> +               reg = <0x4b>;
> +       };
> +
> +       eeprom at 54 {
> +               compatible = "atmel,24c256";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +
> +       temperature-sensor at 48 {
> +               compatible = "ti,tmp75";
> +               reg = <0x48>;
> +       };
> +
> +       eeprom at 50 {
> +               compatible = "atmel,24c128";
> +               reg = <0x50>;
> +       };
> +
> +       rtc at 6f {
> +               compatible = "nuvoton,nct3018y";
> +               reg = <0x6f>;
> +       };
> +};
> +
> +&i2c13 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +};
> +
> +&i2c14 {
> +       status = "okay";
> +       bus-frequency = <400000>;
> +       adc at 1d {
> +               compatible = "ti,adc128d818";
> +               reg = <0x1d>;
> +               ti,mode = /bits/ 8 <2>;
> +       };
> +
> +       adc at 35 {
> +               compatible = "ti,adc128d818";
> +               reg = <0x35>;
> +               ti,mode = /bits/ 8 <2>;
> +       };
> +
> +       adc at 37 {
> +               compatible = "ti,adc128d818";
> +               reg = <0x37>;
> +               ti,mode = /bits/ 8 <2>;
> +       };
> +
> +       power-sensor at 40 {
> +               compatible = "ti,ina230";
> +               reg = <0x40>;
> +       };
> +
> +       power-sensor at 41 {
> +               compatible = "ti,ina230";
> +               reg = <0x41>;
> +       };
> +
> +       power-sensor at 42 {
> +               compatible = "ti,ina230";
> +               reg = <0x42>;
> +       };
> +
> +       power-sensor at 43 {
> +               compatible = "ti,ina230";
> +               reg = <0x43>;
> +       };
> +
> +       power-sensor at 44 {
> +               compatible = "ti,ina230";
> +               reg = <0x44>;
> +       };
> +
> +       temperature-sensor at 4e {
> +               compatible = "ti,tmp75";
> +               reg = <0x4e>;
> +       };
> +
> +       temperature-sensor at 4f {
> +               compatible = "ti,tmp75";
> +               reg = <0x4f>;
> +       };
> +
> +       eeprom at 51 {
> +               compatible = "atmel,24c128";
> +               reg = <0x51>;
> +       };
> +
> +       i2c-mux at 71 {
> +               compatible = "nxp,pca9846";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               idle-state = <0>;
> +               i2c-mux-idle-disconnect;
> +               reg = <0x71>;
> +
> +               i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +
> +                       adc at 1f {
> +                               compatible = "ti,adc128d818";
> +                               reg = <0x1f>;
> +                               ti,mode = /bits/ 8 <2>;
> +                       };
> +
> +                       pwm at 20{
> +                               compatible = "max31790";
> +                               reg = <0x20>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +
> +                       gpio at 22{
> +                               compatible = "ti,tca6424";
> +                               reg = <0x22>;
> +                       };
> +
> +                       pwm at 23{
> +                               compatible = "max31790";
> +                               reg = <0x23>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +
> +                       adc at 33 {
> +                               compatible = "maxim,max11615";
> +                               reg = <0x33>;
> +                       };
> +
> +                       eeprom at 52 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x52>;
> +                       };
> +
> +                       gpio at 61 {
> +                               compatible = "nxp,pca9552";
> +                               reg = <0x61>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                       };
> +               };
> +
> +               i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +
> +                       adc at 1f {
> +                               compatible = "ti,adc128d818";
> +                               reg = <0x1f>;
> +                               ti,mode = /bits/ 8 <2>;
> +                       };
> +
> +                       pwm at 20{
> +                               compatible = "max31790";
> +                               reg = <0x20>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +
> +                       gpio at 22{
> +                               compatible = "ti,tca6424";
> +                               reg = <0x22>;
> +                       };
> +
> +                       pwm at 23{
> +                               compatible = "max31790";
> +                               reg = <0x23>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +
> +                       adc at 33 {
> +                               compatible = "maxim,max11615";
> +                               reg = <0x33>;
> +                       };
> +
> +                       eeprom at 52 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x52>;
> +                       };
> +
> +                       gpio at 61 {
> +                               compatible = "nxp,pca9552";
> +                               reg = <0x61>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                       };
> +               };
> +       };
> +
> +       i2c-mux at 73 {
> +               compatible = "nxp,pca9544";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               idle-state = <0>;
> +               i2c-mux-idle-disconnect;
> +               reg = <0x73>;
> +
> +               i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +
> +                       adc at 35 {
> +                               compatible = "maxim,max11617";
> +                               reg = <0x35>;
> +                       };
> +               };
> +
> +               i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +
> +                       adc at 35 {
> +                               compatible = "maxim,max11617";
> +                               reg = <0x35>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c15 {
> +       status = "okay";
> +       mctp-controller;
> +       multi-master;
> +       bus-frequency = <400000>;
> +
> +       mctp at 10 {
> +               compatible = "mctp-i2c-controller";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       i2c-mux at 72 {
> +               compatible = "nxp,pca9544";
> +               idle-state = <0>;
> +               i2c-mux-idle-disconnect;
> +               reg = <0x72>;
> +       };
> +};
> +
> +&adc0 {
> +       ref_voltage = <2500>;
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +                       &pinctrl_adc2_default &pinctrl_adc3_default
> +                       &pinctrl_adc4_default &pinctrl_adc5_default
> +                       &pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +       ref_voltage = <2500>;
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
> +};
> +
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> --
> 2.25.1
>

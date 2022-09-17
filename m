From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 17 Sep 2022 17:57:34 +0100
Subject: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
In-Reply-To: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
Message-ID: <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15/09/2022 08:23, Bonnie Lo wrote:
> From: Bonnie Lo <Bonnie_Lo@wiwynn.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> Add linux device tree entry related to
> greatlakes specific devices connected to BMC SoC.

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248 ++++++++++++++++++

Missing documentation of board compatible (bindings) as first patch.

>  2 files changed, 249 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..40fa906ab17f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-asrock-e3c246d4i.dtb \
>         aspeed-bmc-asrock-romed8hm3.dtb \
>         aspeed-bmc-bytedance-g220a.dtb \
> +       aspeed-bmc-facebook-greatlakes.dtb \

Wrong order.

>         aspeed-bmc-facebook-bletchley.dtb \
>         aspeed-bmc-facebook-cloudripper.dtb \
>         aspeed-bmc-facebook-cmm.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> new file mode 100644
> index 000000000000..f011cc4d370f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +       model = "AST2600 EVB";

Wrong name.

> +       compatible = "aspeed,ast2600";

Missing board compatible.

> +
> +       aliases {
> +               serial4 = &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";

Bootargs usually do not belong to mainline DTS.

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
> +                               <&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
> +                               <&adc1 5>, <&adc1 6>;
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
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;
> +};
> +
> +&rtc {
> +       status = "okay";
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
> +       multi-master;
> +       ipmb0 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       multi-master;
> +       ipmb1 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +       multi-master;
> +       ipmb2 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +       multi-master;
> +       ipmb3 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +       tmp421 at 1f {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
> +       // NIC EEPROM
> +       eeprom at 50 {
> +               compatible = "st,24c32";
> +               reg = <0x50>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +       multi-master;
> +       ipmb9 at 10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +       eeprom at 51 {
> +               compatible = "atmel,24c128";
> +               reg = <0x51>;
> +       };
> +       eeprom at 54 {
> +               compatible = "atmel,24c128";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +       lm75 at 4f {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +               compatible = "lm75";
> +               reg = <0x4f>;
> +       };
> +};
> +

(...)

> +
> +&gpio0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> +};
> +
> +
> --
> 2.17.1
> 
> WIWYNN PROPRIETARY This email (and any attachments) contains proprietary or confidential information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited. If you are not the intended recipient, please notify the sender and delete this email immediately.

This means we cannot take this patch. Proprietary and/or confidential
patches cannot be merged.

Please license the patch as you wrote in SPDX header.

Best regards,
Krzysztof

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:36:44 +0200
Subject: [PATCH v3 14/14] ARM: dts: aspeed: Add IBM P11 Fuji BMC system
In-Reply-To: <20240425213701.655540-15-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-15-eajames@linux.ibm.com>
Message-ID: <e13eca2b-b4aa-4583-878c-e88cebec0753@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:37, Eddie James wrote:
> Add the device tree for the new BMC system. The Fuji is a P11
> system with eight processors.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    2 +
>  .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3984 +++++++++++++++++
>  2 files changed, 3986 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 715106b3baa1..783409b7c206 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -33,8 +33,10 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-facebook-yosemitev2.dtb \
>  	aspeed-bmc-facebook-yosemite4.dtb \
> +	aspeed-bmc-ibm-blueridge.dtb \
>  	aspeed-bmc-ibm-bonnell.dtb \
>  	aspeed-bmc-ibm-everest.dtb \
> +	aspeed-bmc-ibm-fuji.dtb \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
> new file mode 100644
> index 000000000000..dc41fa815761
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
> @@ -0,0 +1,3984 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 IBM Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +	model = "Fuji";
> +	compatible = "ibm,fuji-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		i2c500 = &cfam4_i2c0;
> +		i2c501 = &cfam4_i2c1;
> +		i2c510 = &cfam4_i2c10;
> +		i2c511 = &cfam4_i2c11;
> +		i2c512 = &cfam4_i2c12;
> +		i2c513 = &cfam4_i2c13;
> +		i2c514 = &cfam4_i2c14;
> +		i2c515 = &cfam4_i2c15;
> +		i2c602 = &cfam5_i2c2;
> +		i2c603 = &cfam5_i2c3;
> +		i2c610 = &cfam5_i2c10;
> +		i2c611 = &cfam5_i2c11;
> +		i2c614 = &cfam5_i2c14;
> +		i2c615 = &cfam5_i2c15;
> +		i2c616 = &cfam5_i2c16;
> +		i2c617 = &cfam5_i2c17;
> +		i2c700 = &cfam6_i2c0;
> +		i2c701 = &cfam6_i2c1;
> +		i2c710 = &cfam6_i2c10;
> +		i2c711 = &cfam6_i2c11;
> +		i2c712 = &cfam6_i2c12;
> +		i2c713 = &cfam6_i2c13;
> +		i2c714 = &cfam6_i2c14;
> +		i2c715 = &cfam6_i2c15;
> +		i2c802 = &cfam7_i2c2;
> +		i2c803 = &cfam7_i2c3;
> +		i2c810 = &cfam7_i2c10;
> +		i2c811 = &cfam7_i2c11;
> +		i2c814 = &cfam7_i2c14;
> +		i2c815 = &cfam7_i2c15;
> +		i2c816 = &cfam7_i2c16;
> +		i2c817 = &cfam7_i2c17;
> +
> +		i2c16 = &i2c4mux0chn0;
> +		i2c17 = &i2c4mux0chn1;
> +		i2c18 = &i2c4mux0chn2;
> +		i2c19 = &i2c5mux0chn0;
> +		i2c20 = &i2c5mux0chn1;
> +		i2c21 = &i2c5mux0chn2;
> +		i2c22 = &i2c5mux0chn3;
> +		i2c23 = &i2c6mux0chn0;
> +		i2c24 = &i2c6mux0chn1;
> +		i2c25 = &i2c6mux0chn2;
> +		i2c26 = &i2c6mux0chn3;
> +		i2c27 = &i2c14mux0chn0;
> +		i2c28 = &i2c14mux0chn1;
> +		i2c29 = &i2c14mux0chn2;
> +		i2c30 = &i2c14mux0chn3;
> +		i2c31 = &i2c14mux1chn0;
> +		i2c32 = &i2c14mux1chn1;
> +		i2c33 = &i2c14mux1chn2;
> +		i2c34 = &i2c14mux1chn3;
> +		i2c35 = &i2c15mux0chn0;
> +		i2c36 = &i2c15mux0chn1;
> +		i2c37 = &i2c15mux0chn2;
> +		i2c38 = &i2c15mux0chn3;
> +		i2c39 = &i2c15mux1chn0;
> +		i2c40 = &i2c15mux1chn1;
> +		i2c41 = &i2c15mux1chn2;
> +		i2c42 = &i2c15mux1chn3;
> +		i2c43 = &i2c15mux2chn0;
> +		i2c44 = &i2c15mux2chn1;
> +		i2c45 = &i2c15mux2chn2;
> +		i2c46 = &i2c15mux2chn3;
> +		i2c47 = &i2c8mux0chn0;
> +		i2c48 = &i2c8mux0chn1;
> +
> +		serial4 = &uart5;
> +
> +		sbefifo500 = &sbefifo500;
> +		sbefifo501 = &sbefifo501;
> +		sbefifo510 = &sbefifo510;
> +		sbefifo511 = &sbefifo511;
> +		sbefifo512 = &sbefifo512;
> +		sbefifo513 = &sbefifo513;
> +		sbefifo514 = &sbefifo514;
> +		sbefifo515 = &sbefifo515;
> +		sbefifo602 = &sbefifo602;
> +		sbefifo603 = &sbefifo603;
> +		sbefifo610 = &sbefifo610;
> +		sbefifo611 = &sbefifo611;
> +		sbefifo614 = &sbefifo614;
> +		sbefifo615 = &sbefifo615;
> +		sbefifo616 = &sbefifo616;
> +		sbefifo617 = &sbefifo617;
> +		sbefifo700 = &sbefifo700;
> +		sbefifo701 = &sbefifo701;
> +		sbefifo710 = &sbefifo710;
> +		sbefifo711 = &sbefifo711;
> +		sbefifo712 = &sbefifo712;
> +		sbefifo713 = &sbefifo713;
> +		sbefifo714 = &sbefifo714;
> +		sbefifo715 = &sbefifo715;
> +		sbefifo802 = &sbefifo802;
> +		sbefifo803 = &sbefifo803;
> +		sbefifo810 = &sbefifo810;
> +		sbefifo811 = &sbefifo811;
> +		sbefifo814 = &sbefifo814;
> +		sbefifo815 = &sbefifo815;
> +		sbefifo816 = &sbefifo816;
> +		sbefifo817 = &sbefifo817;
> +
> +		scom500 = &scom500;
> +		scom501 = &scom501;
> +		scom510 = &scom510;
> +		scom511 = &scom511;
> +		scom512 = &scom512;
> +		scom513 = &scom513;
> +		scom514 = &scom514;
> +		scom515 = &scom515;
> +		scom602 = &scom602;
> +		scom603 = &scom603;
> +		scom610 = &scom610;
> +		scom611 = &scom611;
> +		scom614 = &scom614;
> +		scom615 = &scom615;
> +		scom616 = &scom616;
> +		scom617 = &scom617;
> +		scom700 = &scom700;
> +		scom701 = &scom701;
> +		scom710 = &scom710;
> +		scom711 = &scom711;
> +		scom712 = &scom712;
> +		scom713 = &scom713;
> +		scom714 = &scom714;
> +		scom715 = &scom715;
> +		scom802 = &scom802;
> +		scom803 = &scom803;
> +		scom810 = &scom810;
> +		scom811 = &scom811;
> +		scom814 = &scom814;
> +		scom815 = &scom815;
> +		scom816 = &scom816;
> +		scom817 = &scom817;
> +
> +		spi50 = &cfam4_spi0;
> +		spi51 = &cfam4_spi1;
> +		spi52 = &cfam4_spi2;
> +		spi53 = &cfam4_spi3;
> +		spi60 = &cfam5_spi0;
> +		spi61 = &cfam5_spi1;
> +		spi62 = &cfam5_spi2;
> +		spi63 = &cfam5_spi3;
> +		spi70 = &cfam6_spi0;
> +		spi71 = &cfam6_spi1;
> +		spi72 = &cfam6_spi2;
> +		spi73 = &cfam6_spi3;
> +		spi80 = &cfam7_spi0;
> +		spi81 = &cfam7_spi1;
> +		spi82 = &cfam7_spi2;
> +		spi83 = &cfam7_spi3;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";


Drop bootargs. Everywhere.

> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		event_log: tcg_event_log at b3d00000 {

Same problem



> +
> +	usb_power-hog {

No underscores.

> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
> +		output-high;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom at 51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +	};
> +
> +	pca1: pca9552 at 62 {

All my previous comments apply.



Best regards,
Krzysztof


From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 May 2019 02:06:05 -0400
Subject: [PATCH] ARM: dts: aspeed: Add Facebook YAMP BMC
In-Reply-To: <20190509035549.2203169-1-taoren@fb.com>
References: <20190509035549.2203169-1-taoren@fb.com>
Message-ID: <29d7503b-6c14-4990-aadc-7cbce2897fc2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 9 May 2019, at 13:26, Tao Ren wrote:
> Add initial version of device tree for Facebook YAMP ast2500 BMC.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 160 ++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..710616dcb62e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1254,6 +1254,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-facebook-cmm.dtb \
>  	aspeed-bmc-facebook-tiogapass.dtb \
> +	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-palmetto.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
> new file mode 100644
> index 000000000000..4e09a9cf32b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +
> +/ {
> +	model = "Facebook YAMP 100 BMC";
> +	compatible = "facebook,yamp-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		/*
> +		 * Override the default uart aliases to avoid breaking
> +		 * the legacy applications.
> +		 */
> +		serial0 = &uart5;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
> +	};
> +
> +	memory at 80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +};
> +
> +&pinctrl {
> +	aspeed,external-nodes = <&gfx &lhc>;
> +};
> +
> +/*
> + * Update reset type to "system" (full chip) to fix warm reboot hang 
> issue
> + * when reset type is set to default ("soc", gated by reset mask 
> registers).
> + */
> +&wdt1 {
> +	status = "okay";
> +	aspeed,reset-type = "system";
> +};
> +
> +/*
> + * wdt2 is not used by Yamp.
> + */
> +&wdt2 {
> +	status = "disabled";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +#include "facebook-bmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +		     &pinctrl_rxd1_default>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd2_default
> +		     &pinctrl_rxd2_default>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd3_default
> +		     &pinctrl_rxd3_default>;
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	use-ncsi;
> +	no-hw-checksum;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	i2c-switch at 75 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x75>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> -- 
> 2.17.1
> 
>

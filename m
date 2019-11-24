From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Nov 2019 08:36:30 +1030
Subject: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
In-Reply-To: <20191122103022.GA15913@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com> <20191121074843.GA10607@cnn>
 <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
 <20191122103022.GA15913@cnn>
Message-ID: <7402f01e-9678-4373-9326-d25d569d408a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 22 Nov 2019, at 21:00, Manikandan wrote:
> 
> From 9a17872b5faf2c00ab0b572bac0072e44a3d8b91 Mon Sep 17 00:00:00 2001
> From: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> Date: Thu, 21 Nov 2019 11:57:07 +0530
> Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
> 
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 152 +++++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> new file mode 100644
> index 0000000..5f9a2e1
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook Yosemitev2 BMC";
> +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> +	aliases {
> +		serial0 = &uart1;

Is this necessary now that you're not enabling uart1?

But otherwise:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

However, I'm guessing you copy/pasted the patch as we still have the
reply text at the bottom. Copy/paste can lead to mangled whitespace
or other errors that prevent the patch from being applied cleanly. I
recommend getting set up and familiar with `git send-email` to give
your patch the best chance of being applied without trouble. The
`git format-patch` / `git send-email` pair also take care of iterating
on your patch with e.g. the `-v` switch that injects the version number
of the patch in the appropriate places.

Andrew

> +		serial4 = &uart5;
> +	};
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory at 80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	iio-hwmon {
> +		// VOLATAGE SENSOR
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +	};
> +};
> +
> +&uart5 {
> +	// BMC Console
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	use-ncsi;
> +};
> +
> +&adc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default
> +		&pinctrl_adc1_default
> +		&pinctrl_adc2_default
> +		&pinctrl_adc3_default
> +		&pinctrl_adc4_default
> +		&pinctrl_adc5_default
> +		&pinctrl_adc6_default
> +		&pinctrl_adc7_default
> +		&pinctrl_adc8_default
> +		&pinctrl_adc9_default
> +		&pinctrl_adc10_default
> +		&pinctrl_adc11_default
> +		&pinctrl_adc12_default
> +		&pinctrl_adc13_default
> +		&pinctrl_adc14_default
> +		&pinctrl_adc15_default>;
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +	//FRU EEPROM
> +	eeprom at 51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +	tmp421 at 4e {
> +	//INLET TEMP
> +		compatible = "ti,tmp421";
> +		reg = <0x4e>;
> +	};
> +	//OUTLET TEMP
> +	tmp421 at 4f {
> +		compatible = "ti,tmp421";
> +		reg = <0x4f>;
> +	};
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +	//HSC
> +	adm1278 at 40 {
> +		compatible = "adi,adm1278";
> +		reg = <0x40>;
> +	};
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +	//MEZZ_TEMP_SENSOR
> +	tmp421 at 1f {
> +		compatible = "ti,tmp421";
> +		reg = <0x1f>;
> +	};
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +	//MEZZ_FRU
> +	eeprom at 51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&pwm_tacho {
> +	status = "okay";
> +	//FSC
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +	fan at 0 {
> +		reg = <0x00>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +	};
> +	fan at 1 {
> +		reg = <0x01>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> On Fri, Nov 22, 2019 at 09:16:39AM +1030, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 21 Nov 2019, at 18:18, Manikandan wrote:
> > > 
> > > Hi Andrew/Vijay,
> > > 
> > > Thanks for the review .
> > > 
> > > The following changes done in dts and tested in Facebook Yosemite V2 
> > > BMC platform,
> > >   1. LPC feature removed as not supported .
> > >   2. VUART feature removed as not supported.
> > >   3. Host UART feature removed as not in the current scope.
> > >   4. ADC pinctrl details added in dts.
> > 
> > Can you please re-send the patch as a v2 and inline to the mail rather than
> > as an attachment?
> > 
> > Cheers,
> > 
> > Andrew
>

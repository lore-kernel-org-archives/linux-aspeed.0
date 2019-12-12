From: Manikandan <manikandan.hcl.ers.epl@gmail.com>
Date: Thu, 12 Dec 2019 18:00:50 +0530
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
In-Reply-To: <78c346a0-217c-4216-b16a-498f80e7303a@www.fastmail.com>
References: <20191211202620.GA31628@cnn>
 <78c346a0-217c-4216-b16a-498f80e7303a@www.fastmail.com>
Message-ID: <20191212123050.GA8443@cnn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2019 at 11:39:59AM +1030, Andrew Jeffery wrote:
> 
> 
> On Thu, 12 Dec 2019, at 06:56, Manikandan Elumalai wrote:
> > The Yosemite V2 is a facebook multi-node server
> > platform that host four OCP server. The BMC
> > in the Yosemite V2 platform based on AST2500 SoC.
> > 
> > This patch adds linux device tree entry related to
> > Yosemite V2 specific devices connected to BMC SoC.
> > 
> > --- Reviews summary
> > --- v4[2/2] - Spell and contributor name correction.
> > ---         - License identifier changed to GPL-2.0-or-later.
> > ---         - aspeed-gpio.h removed.
> > ---         - FAN2 tacho channel changed.
> > ---      v4 - Bootargs removed.
> > ---         - Reviewed-by: Vijay Khemka <vkhemka@fb.com>
> > ---      v3 - Uart1 Debug removed .
> > ---         - Acked-by:Andrew Jeffery <andrew@aj.id.au>
> 
> You need to put the Reviewed-by / Acked-by tags down below your Signed-off-by. That
> way we know that the patch is still ready to go (and they appear in patchwork - you can
> (currently) see that they're missing[1]).
> 
> [1] https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=147912&state=%2A&archive=both
>
  Thanks for your patience on explaining the procedure for newbies like me . There is change in dts for FAN2 tacho channel needs to review. I will resumit again. 
> Andrew
> 
> > ---      v2 - LPC and VUART removed .
> > ---      v1 - Initial draft.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > ---
> >  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 148 +++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
> > b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > new file mode 100644
> > index 0000000..ffd7f4c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright (c) 2018 Facebook Inc.
> > +
> > +/dts-v1/;
> > +
> > +#include "aspeed-g5.dtsi"
> > +/ {
> > +	model = "Facebook Yosemitev2 BMC";
> > +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> > +	aliases {
> > +		serial4 = &uart5;
> > +	};
> > +	chosen {
> > +		stdout-path = &uart5;
> > +	};
> > +
> > +	memory at 80000000 {
> > +		reg = <0x80000000 0x20000000>;
> > +	};
> > +
> > +	iio-hwmon {
> > +		// VOLATAGE SENSOR
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> > +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> > +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> > +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> > +	};
> > +};
> > +
> > +&fmc {
> > +	status = "okay";
> > +	flash at 0 {
> > +		status = "okay";
> > +		m25p,fast-read;
> > +#include "openbmc-flash-layout.dtsi"
> > +	};
> > +};
> > +
> > +&spi1 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_spi1_default>;
> > +	flash at 0 {
> > +		status = "okay";
> > +		m25p,fast-read;
> > +		label = "pnor";
> > +	};
> > +};
> > +
> > +&uart5 {
> > +	// BMC Console
> > +	status = "okay";
> > +};
> > +
> > +&mac0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_rmii1_default>;
> > +	use-ncsi;
> > +};
> > +
> > +&adc {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_adc0_default
> > +			&pinctrl_adc1_default
> > +			&pinctrl_adc2_default
> > +			&pinctrl_adc3_default
> > +			&pinctrl_adc4_default
> > +			&pinctrl_adc5_default
> > +			&pinctrl_adc6_default
> > +			&pinctrl_adc7_default
> > +			&pinctrl_adc8_default
> > +			&pinctrl_adc9_default
> > +			&pinctrl_adc10_default
> > +			&pinctrl_adc11_default
> > +			&pinctrl_adc12_default
> > +			&pinctrl_adc13_default
> > +			&pinctrl_adc14_default
> > +			&pinctrl_adc15_default>;
> > +};
> > +
> > +&i2c8 {
> > +	//FRU EEPROM
> > +	status = "okay";
> > +	eeprom at 51 {
> > +		compatible = "atmel,24c64";
> > +		reg = <0x51>;
> > +		pagesize = <32>;
> > +	};
> > +};
> > +
> > +&i2c9 {
> > +	//INLET & OUTLET TEMP
> > +	status = "okay";
> > +	tmp421 at 4e {
> > +		compatible = "ti,tmp421";
> > +		reg = <0x4e>;
> > +	};
> > +	tmp421 at 4f {
> > +		compatible = "ti,tmp421";
> > +		reg = <0x4f>;
> > +	};
> > +};
> > +
> > +&i2c10 {
> > +	//HSC
> > +	status = "okay";
> > +	adm1278 at 40 {
> > +		compatible = "adi,adm1278";
> > +		reg = <0x40>;
> > +	};
> > +};
> > +
> > +&i2c11 {
> > +	//MEZZ_TEMP_SENSOR
> > +	status = "okay";
> > +	tmp421 at 1f {
> > +		compatible = "ti,tmp421";
> > +		reg = <0x1f>;
> > +	};
> > +};
> > +
> > +&i2c12 {
> > +	//MEZZ_FRU
> > +	status = "okay";
> > +	eeprom at 51 {
> > +		compatible = "atmel,24c64";
> > +		reg = <0x51>;
> > +		pagesize = <32>;
> > +	};
> > +};
> > +
> > +&pwm_tacho {
> > +	//FSC
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> > +	fan at 0 {
> > +		reg = <0x00>;
> > +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> > +	};
> > +	fan at 1 {
> > +		reg = <0x01>;
> > +		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> > +	};
> > +};
> > -- 
> > 2.7.4
> > 
> >

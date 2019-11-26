From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 26 Nov 2019 18:12:50 +0000
Subject: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
In-Reply-To: <20191126133726.GA2578@cnn>
References: <20191125130420.GA24018@cnn>
 <7F15A2E0-14C7-4C86-B589-35619A390B72@fb.com> <20191126133726.GA2578@cnn>
Message-ID: <BF7BF1A3-00F8-49FE-83CB-7EF585448D03@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 11/26/19, 5:38 AM, "Manikandan" <manikandan.hcl.ers.epl@gmail.com> wrote:

    On Mon, Nov 25, 2019 at 07:23:32PM +0000, Vijay Khemka wrote:
    > 
    > On 11/25/19, 5:04 AM, "manikandan-e" <manikandan.hcl.ers.epl@gmail.com> wrote:
    > 
    >     The Yosemite V2 is a facebook multi-node server
    >     platform that host four OCP server. The BMC
    >     in the Yosemite V2 platorm based on AST2500 SoC.
    >     
    >     This patch adds linux device tree entry related to
    >     Yosemite V2 specific devices connected to BMC SoC.
    > Nit: comments inline. Otherwise
    > Reviewed-by: Vijay Khemka <vijaykhemka@fb.com>
    >     
    > 
    >     Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
    >     ---
    >      .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 151 +++++++++++++++++++++
    >      1 file changed, 151 insertions(+)
    >      create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    >     
    >     diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    >     new file mode 100644
    >     index 0000000..09bffcd
    >     --- /dev/null
    >     +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    >     @@ -0,0 +1,151 @@
    >     +// SPDX-License-Identifier: GPL-2.0+
    >     +// Copyright (c) 2018 Facebook Inc.
    >     +/dts-v1/;
    >     +
    >     +#include "aspeed-g5.dtsi"
    >     +#include <dt-bindings/gpio/aspeed-gpio.h>
    >     +
    >     +/ {
    >     +	model = "Facebook Yosemitev2 BMC";
    >     +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
    >     +	aliases {
    >     +		serial4 = &uart5;
    >     +	};
    >     +	chosen {
    >     +		stdout-path = &uart5;
    >     +		bootargs = "console=ttyS4,115200 earlyprintk";
    > bootargs are not required as it is overwritten by uboot. And baud rate is 57600
               
              As of now SPL and U-boot Baudrate based 115200 baudrate. Do we need to change it there. I understand that we can use SERIAL_CONSOLES           in meta-facebook.
             Do i need to remove 'console=ttyS4.115200' or complete bootargs . If we remove bootargs, how can add any bootargs params in future.
Bootargs are overwritten by u-boot and have no impact whatever you choose here. So you can remove bootargs. 
    
    >     +	};
    >     +
    >     +	memory at 80000000 {
    >     +		reg = <0x80000000 0x20000000>;
    >     +	};
    >     +
    >     +	iio-hwmon {
    >     +		// VOLATAGE SENSOR
    >     +		compatible = "iio-hwmon";
    >     +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
    >     +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
    >     +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
    >     +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
    >     +	};
    >     +};
    >     +
    >     +&fmc {
    >     +	status = "okay";
    >     +	flash at 0 {
    >     +		status = "okay";
    >     +		m25p,fast-read;
    >     +#include "openbmc-flash-layout.dtsi"
    >     +	};
    >     +};
    >     +
    >     +&spi1 {
    >     +	status = "okay";
    >     +	pinctrl-names = "default";
    >     +	pinctrl-0 = <&pinctrl_spi1_default>;
    >     +	flash at 0 {
    >     +		status = "okay";
    >     +		m25p,fast-read;
    >     +		label = "pnor";
    >     +	};
    >     +};
    >     +
    >     +&uart5 {
    >     +	// BMC Console
    >     +	status = "okay";
    >     +};
    >     +
    >     +&mac0 {
    >     +	status = "okay";
    >     +	pinctrl-names = "default";
    >     +	pinctrl-0 = <&pinctrl_rmii1_default>;
    >     +	use-ncsi;
    >     +};
    >     +
    >     +&adc {
    >     +	status = "okay";
    >     +        pinctrl-names = "default";
    > Use tab for alignment
    
    
    Checkpatch didn't shown any issue warning .As i checked in many dts file , format is same.
    It will helpful if i get more clarification. 
If you see in above line, spaces are being used instead of tab. This is only one 
line where spaces are being used instead of tab.
    
    >     +	pinctrl-0 = <&pinctrl_adc0_default
    >     +			&pinctrl_adc1_default
    >     +			&pinctrl_adc2_default
    >     +			&pinctrl_adc3_default
    >     +			&pinctrl_adc4_default
    >     +			&pinctrl_adc5_default
    >     +			&pinctrl_adc6_default
    >     +			&pinctrl_adc7_default
    >     +			&pinctrl_adc8_default
    >     +			&pinctrl_adc9_default
    >     +			&pinctrl_adc10_default
    >     +			&pinctrl_adc11_default
    >     +			&pinctrl_adc12_default
    >     +			&pinctrl_adc13_default
    >     +			&pinctrl_adc14_default
    >     +			&pinctrl_adc15_default>;
    >     +};
    >     +
    >     +&i2c8 {
    >     +	status = "okay";
    >     +	//FRU EEPROM
    >     +	eeprom at 51 {
    >     +		compatible = "atmel,24c64";
    >     +		reg = <0x51>;
    >     +		pagesize = <32>;
    >     +	};
    >     +};
    >     +
    >     +&i2c9 {
    >     +	status = "okay";
    >     +	tmp421 at 4e {
    >     +	//INLET TEMP
    >     +		compatible = "ti,tmp421";
    >     +		reg = <0x4e>;
    >     +	};
    >     +	//OUTLET TEMP
    >     +	tmp421 at 4f {
    >     +		compatible = "ti,tmp421";
    >     +		reg = <0x4f>;
    >     +	};
    >     +};
    >     +
    >     +&i2c10 {
    >     +	status = "okay";
    >     +	//HSC
    >     +	adm1278 at 40 {
    >     +		compatible = "adi,adm1278";
    >     +		reg = <0x40>;
    >     +	};
    >     +};
    >     +
    >     +&i2c11 {
    >     +	status = "okay";
    >     +	//MEZZ_TEMP_SENSOR
    >     +	tmp421 at 1f {
    >     +		compatible = "ti,tmp421";
    >     +		reg = <0x1f>;
    >     +	};
    >     +};
    >     +
    >     +&i2c12 {
    >     +	status = "okay";
    >     +	//MEZZ_FRU
    >     +	eeprom at 51 {
    >     +		compatible = "atmel,24c64";
    >     +		reg = <0x51>;
    >     +		pagesize = <32>;
    >     +	};
    >     +};
    >     +
    >     +&pwm_tacho {
    >     +	status = "okay";
    >     +	//FSC
    >     +	pinctrl-names = "default";
    >     +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
    >     +	fan at 0 {
    >     +		reg = <0x00>;
    >     +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
    >     +	};
    >     +	fan at 1 {
    >     +		reg = <0x01>;
    >     +		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
    >     +	};
    >     +};
    >     -- 
    >     2.7.4
    >     
    >     
    > 
    


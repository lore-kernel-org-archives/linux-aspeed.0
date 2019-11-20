From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 20 Nov 2019 06:50:15 +0000
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
In-Reply-To: <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
Message-ID: <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 11/19/19, 9:56 PM, "Linux-aspeed on behalf of Andrew Jeffery" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of andrew@aj.id.au> wrote:

    
    
    On Mon, 18 Nov 2019, at 23:07, manikandan-e wrote:
    > The Yosemite V2 is a facebook multi-node server
    > platform that host four OCP server. The BMC
    > in the Yosemite V2 platorm based on AST2500 SoC.
    > 
    > This patch adds linux device tree entry related to
    > Yosemite V2 specific devices connected to BMC SoC.
    > 
    > Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
    > ---
    >  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 170 +++++++++++++++++++++
    >  1 file changed, 170 insertions(+)
    >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    > 
    > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
    > b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    > new file mode 100644
    > index 0000000..46a285a
    > --- /dev/null
    > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
    > @@ -0,0 +1,170 @@
    > +// SPDX-License-Identifier: GPL-2.0+
    > +// Copyright (c) 2018 Facebook Inc.
    > +// Author:
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
    > +&lpc_snoop {
    > +	status = "okay";
    > +	snoop-ports = <0x80>;
    > +};
No lpc in Yosemite so please remove.

    > +
    > +&lpc_ctrl {
    > +	// Enable lpc clock
    > +	status = "okay";
Same here remove.
    
    Something I'm intending to fix in the devicetrees using LPC is to hog
    the pins in the pinctrl node. You should consider doing the same here.
    
    > +};
    > +
    > +&vuart {
    > +	// VUART Host Console
    > +	status = "okay";
    > +};
No Vuart.

    > +
    > +&uart1 {
    > +	// Host Console
    > +	status = "okay";
    > +	pinctrl-names = "default";
    > +	pinctrl-0 = <&pinctrl_txd1_default
    > +		     &pinctrl_rxd1_default>;
    > +};
    > +
    > +&uart2 {
    > +	// SoL Host Console
    > +	status = "okay";

uart1-4 are all assigned for 4 multiple hosts so define accordingly.  
    
    Also needs pinctrl configuration.
    
    > +};
    > +
    > +&uart3 {
    > +	// SoL BMC Console
    > +	status = "okay";
    
    Again needs pinctrl.
    
    > +};
    > +
    > +&uart5 {
    > +	// BMC Console
    > +	status = "okay";
    > +};
    > +
    > +&mac0 {
    > +	status = "okay";
    > +
    > +	pinctrl-names = "default";
    > +	pinctrl-0 = <&pinctrl_rmii1_default>;
    > +	use-ncsi;
    > +};
    > +
    > +&adc {
    > +	status = "okay";
    
    Strongly suggest adding the pinctrl properties here to ensure
    exclusive access for the ADC pins.
    
    Otherwise it looks reasonable.
    
    Andrew
    


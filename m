From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 15:03:37 +1030
Subject: [PATCH v5 09/21] ARM: dts: aspeed: yosemite4: Enable interrupt
 setting for pca9555
In-Reply-To: <20240131084134.328307-10-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-10-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <b07068223fbc64c453fde6913edce842647dd2c8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Enable interrupt setting for pca9555
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
>   - v4
>     - Revise device node name
>   - v1
>     - enable interrupt setting for pca9555
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index cbf385e72e57..4b23e467690f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -832,30 +832,78 @@ power-sensor at 12 {
>  
>  	gpio at 20 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x20>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"P48V-OCP-GPIO1","P48V-OCP-GPIO2",
> +		"P48V-OCP-GPIO3","FAN-BOARD-0-REVISION-0-R",
> +		"FAN-BOARD-0-REVISION-1-R","FAN-BOARD-1-REVISION-0-R",
> +		"FAN-BOARD-1-REVISION-1-R","RST-MUX-R-N",
> +		"RST-LED-CONTROL-FAN-BOARD-0-N","RST-LED-CONTROL-FAN-BOARD-1-N",
> +		"RST-IOEXP-FAN-BOARD-0-N","RST-IOEXP-FAN-BOARD-1-N",
> +		"PWRGD-LOAD-SWITCH-FAN-BOARD-0-R","PWRGD-LOAD-SWITCH-FAN-BOARD-1-R",
> +		"","";

Perhaps the addition of the line names should go in a separate patch?
They seem unrelated to the interrupt configuration. The query applies
to the hunks below as well.

>  	};
>  
>  	gpio at 21 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x21>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x21>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"HSC-OCP-SLOT-ODD-GPIO1","HSC-OCP-SLOT-ODD-GPIO2",
> +		"HSC-OCP-SLOT-ODD-GPIO3","HSC-OCP-SLOT-EVEN-GPIO1",
> +		"HSC-OCP-SLOT-EVEN-GPIO2","HSC-OCP-SLOT-EVEN-GPIO3",
> +		"ADC-TYPE-0-R","ADC-TYPE-1-R",
> +		"MEDUSA-BOARD-REV-0","MEDUSA-BOARD-REV-1",
> +		"MEDUSA-BOARD-REV-2","MEDUSA-BOARD-TYPE",
> +		"DELTA-MODULE-TYPE","P12V-HSC-TYPE",
> +		"","";
>  	};
>  
>  	gpio at 22 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x22>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"CARD-TYPE-SLOT1","CARD-TYPE-SLOT2",
> +		"CARD-TYPE-SLOT3","CARD-TYPE-SLOT4",
> +		"CARD-TYPE-SLOT5","CARD-TYPE-SLOT6",
> +		"CARD-TYPE-SLOT7","CARD-TYPE-SLOT8",
> +		"OC-P48V-HSC-0-N","FLT-P48V-HSC-0-N",
> +		"OC-P48V-HSC-1-N","FLT-P48V-HSC-1-N",
> +		"EN-P48V-AUX-0","EN-P48V-AUX-1",
> +		"PWRGD-P12V-AUX-0","PWRGD-P12V-AUX-1";
>  	};
>  
>  	gpio at 23 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x23>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x23>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;

Just confirming the interrupt lines from the expanders are all wired up
to the one GPIO input pin on the BMC?

Andrew

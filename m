From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 11 Dec 2023 09:04:02 +0100
Subject: [PATCH v2 08/14] ARM: dts: aspeed: yosemite4: Revise i2c11 and
 i2c12 schematic change
In-Reply-To: <20231211024947.3990898-9-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
 <20231211024947.3990898-9-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <1f59a4f5-7082-4a36-806e-2fff4d1e5d7d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/12/2023 03:49, Delphine CC Chiu wrote:
> Revise i2c11 and i2c12 schematic change:
> - remove space for adm1272 compatible
> - enable interrupt setting for pca9555
> - add eeprom for yosemite4 medusa board/BSM use
> - remove temperature sensor for yosemite4 schematic change
> - add power sensor for power module reading

You should split your patch into several, per one logical change.


> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 118 ++++++++++++++----
>  1 file changed, 93 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index da413325ce30..ccb5ecd8d9a6 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -821,41 +821,94 @@ imux29: i2c at 1 {
>  &i2c11 {
>  	status = "okay";
>  	power-sensor at 10 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x10>;
>  	};
>  
>  	power-sensor at 12 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x12>;
>  	};
>  
> -	gpio at 20 {
> +	gpio_ext1: pca9555 at 20 {

That's not a correct change. You replace good code with bad.

>  		compatible = "nxp,pca9555";
> -		reg = <0x20>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio at 21 {
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",
> +		"P48V_OCP_GPIO3","FAN_BOARD_0_REVISION_0_R",
> +		"FAN_BOARD_0_REVISION_1_R","FAN_BOARD_1_REVISION_0_R",
> +		"FAN_BOARD_1_REVISION_1_R","RST_MUX_R_N",
> +		"RST_LED_CONTROL_FAN_BOARD_0_N","RST_LED_CONTROL_FAN_BOARD_1_N",
> +		"RST_IOEXP_FAN_BOARD_0_N","RST_IOEXP_FAN_BOARD_1_N",
> +		"PWRGD_LOAD_SWITCH_FAN_BOARD_0_R","PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
> +		"","";
> +	};
> +
> +	gpio_ext2: pca9555 at 21 {

Nope

>  		compatible = "nxp,pca9555";
> -		reg = <0x21>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio at 22 {
> +		reg = <0x21>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"DELTA_MODULE_TYPE","VSENSE_ERR_VDROP_R",
> +		"EN_P48V_AUX_0","EN_P48V_AUX_1",
> +		"MEDUSA_BOARD_REV_0","MEDUSA_BOARD_REV_1",
> +		"MEDUSA_BOARD_REV_2","MEDUSA_BOARD_TYPE",
> +		"HSC_OCP_SLOT_ODD_GPIO1","HSC_OCP_SLOT_ODD_GPIO2",
> +		"HSC_OCP_SLOT_ODD_GPIO3","HSC_OCP_SLOT_EVEN_GPIO1",
> +		"HSC_OCP_SLOT_EVEN_GPIO2","HSC_OCP_SLOT_EVEN_GPIO3",
> +		"ADC_TYPE_0_R","ADC_TYPE_1_R";
> +	};
> +
> +	gpio_ext3: pca9555 at 22 {

Nope

>  		compatible = "nxp,pca9555";
> -		reg = <0x22>;
> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> -	};
> -
> -	gpio at 23 {
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"CARD_TYPE_SLOT1","CARD_TYPE_SLOT2",
> +		"CARD_TYPE_SLOT3","CARD_TYPE_SLOT4",
> +		"CARD_TYPE_SLOT5","CARD_TYPE_SLOT6",
> +		"CARD_TYPE_SLOT7","CARD_TYPE_SLOT8",
> +		"OC_P48V_HSC_0_N","FLT_P48V_HSC_0_N",
> +		"PWRGD_P12V_AUX_1","OC_P48V_HSC_1_N",
> +		"FLT_P48V_HSC_1_N","PWRGD_P12V_AUX_1",
> +		"MEDUSA_ADC_EFUSE_TYPE_R","P12V_HSC_TYPE";
> +	};
> +
> +	gpio_ext4: pca9555 at 23 {

Nope



Best regards,
Krzysztof


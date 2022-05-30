From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 30 May 2022 01:27:32 +0000
Subject: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller
 node
In-Reply-To: <20220523030134.2977116-3-neal_liu@aspeedtech.com>
References: <20220523030134.2977116-1-neal_liu@aspeedtech.com>
 <20220523030134.2977116-3-neal_liu@aspeedtech.com>
Message-ID: <TY2PR06MB32135A0DAA9F152E2498CD1C80DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Gentle ping on this path, thanks.

> -----Original Message-----
> From: Neal Liu <neal_liu@aspeedtech.com>
> Sent: Monday, May 23, 2022 11:02 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Felipe Balbi <balbi@kernel.org>; Sumit Semwal
> <sumit.semwal@linaro.org>; Christian K?nig <christian.koenig@amd.com>;
> Geert Uytterhoeven <geert@linux-m68k.org>; Li Yang <leoyang.li@nxp.com>
> Cc: Neal Liu <neal_liu@aspeedtech.com>; linux-aspeed at lists.ozlabs.org;
> linux-usb at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-media at vger.kernel.org; dri-devel at lists.freedesktop.org;
> linaro-mm-sig at lists.linaro.org
> Subject: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller node
> 
> Add USB2.0 device controller(udc) node to device tree for AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 3d5ce9da42c3..822f4fd854f5 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -298,6 +298,16 @@ vhub: usb-vhub at 1e6a0000 {
>  			status = "disabled";
>  		};
> 
> +		udc: usb at 1e6a2000 {
> +			compatible = "aspeed,ast2600-udc";
> +			reg = <0x1e6a2000 0x300>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2bd_default>;
> +			status = "disabled";
> +		};
> +
>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> --
> 2.25.1


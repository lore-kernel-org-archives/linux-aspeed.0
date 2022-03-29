From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 29 Mar 2022 12:57:39 +1030
Subject: [PATCH v3 1/2] ARM: dts: aspeed: Add video engine
In-Reply-To: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Message-ID: <8de31099-3695-4d9c-a656-525ff1945112@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Howard,

On Tue, 29 Mar 2022, at 12:08, Howard Chiu wrote:
> The ast2600 SoC has an embedded video engine
> This node was removed by commit 645afe7

The summary line of the commit should follow the commit ID (which 
should also be 12 characters not 7) here, so:

645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node")

>

And then you also need a fixes tag:

Fixes: 645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node")


> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index c32e87fad4dc..aac55b3aeded 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -389,6 +389,16 @@ sbc: secure-boot-controller at 1e6f2000 {
>  				reg = <0x1e6f2000 0x1000>;
>  			};
> 
> +			video: video at 1e700000 {
> +				compatible = "aspeed,ast2600-video-engine";
> +				reg = <0x1e700000 0x1000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +					 <&syscon ASPEED_CLK_GATE_ECLK>;
> +				clock-names = "vclk", "eclk";
> +				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>  			gpio0: gpio at 1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 2.25.1

Cheers,

Andrew

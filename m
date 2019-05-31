From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 31 May 2019 17:29:58 +0930
Subject: [PATCH v2] ARM: dts: aspeed: g4: add video engine support
In-Reply-To: <20190530093544.12215-1-a.filippov@yadro.com>
References: <20190530093544.12215-1-a.filippov@yadro.com>
Message-ID: <af088bbb-d55f-4477-a564-ef9fcc306433@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 30 May 2019, at 19:06, Alexander Filippov wrote:
> Add a node to describe the video engine on AST2400.
> 
> These changes were copied from aspeed-g5.dtsi
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 6011692df15a..5a9e3f684359 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -195,6 +195,16 @@
>  				reg = <0x1e720000 0x8000>;	// 32K
>  			};
>  
> +			video: video at 1e700000 {
> +				compatible = "aspeed,ast2400-video-engine";
> +				reg = <0x1e700000 0x1000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +					 <&syscon ASPEED_CLK_GATE_ECLK>;
> +				clock-names = "vclk", "eclk";
> +				interrupts = <7>;
> +				status = "disabled";
> +			};
> +
>  			gpio: gpio at 1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 2.20.1
> 
>

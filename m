From: Andrew Jeffery <andrew@aj.id.au>
Date: Sun, 07 Apr 2019 20:38:27 -0400
Subject: [PATCH] ARM: dts: aspeed: Rename flash-controller nodes
In-Reply-To: <20190405033230.8150-1-joel@jms.id.au>
References: <20190405033230.8150-1-joel@jms.id.au>
Message-ID: <17075e22-9655-4135-a0f3-edfcb044f84d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 5 Apr 2019, at 14:02, Joel Stanley wrote:
> The device tree compiler has started spitting out warnings about these
> names, insisting they be called 'spi':
> 
>  ../arch/arm/boot/dts/aspeed-g5.dtsi:108.35-128.5: Warning
>  (spi_bus_bridge): /ahb/flash-controller at 1e631000: node name for SPI
>  buses should be 'spi'
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++--
>  arch/arm/boot/dts/aspeed-g5.dtsi | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 9549f867aa1e..5156afccc8ed 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -53,7 +53,7 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		fmc: flash-controller at 1e620000 {
> +		fmc: spi at 1e620000 {
>  			reg = < 0x1e620000 0x94
>  				0x20000000 0x10000000 >;
>  			#address-cells = <1>;
> @@ -69,7 +69,7 @@
>  			};
>  		};
>  
> -		spi: flash-controller at 1e630000 {
> +		spi: spi at 1e630000 {
>  			reg = < 0x1e630000 0x18
>  				0x30000000 0x10000000 >;
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 85ed9dbec196..551528ccb7b8 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -60,7 +60,7 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		fmc: flash-controller at 1e620000 {
> +		fmc: spi at 1e620000 {
>  			reg = < 0x1e620000 0xc4
>  				0x20000000 0x10000000 >;
>  			#address-cells = <1>;
> @@ -86,7 +86,7 @@
>  			};
>  		};
>  
> -		spi1: flash-controller at 1e630000 {
> +		spi1: spi at 1e630000 {
>  			reg = < 0x1e630000 0xc4
>  				0x30000000 0x08000000 >;
>  			#address-cells = <1>;
> @@ -106,7 +106,7 @@
>  			};
>  		};
>  
> -		spi2: flash-controller at 1e631000 {
> +		spi2: spi at 1e631000 {
>  			reg = < 0x1e631000 0xc4
>  				0x38000000 0x08000000 >;
>  			#address-cells = <1>;
> -- 
> 2.20.1
> 
>

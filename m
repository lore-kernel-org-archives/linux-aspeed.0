From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 14:52:05 +1030
Subject: [PATCH v5 05/21] ARM: dts: aspeed: yosemite4: Revise quad mode
 to dual mode
In-Reply-To: <20240131084134.328307-6-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-6-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <aebd29d6890e54e93b46a102e7ea7532ad7b32f4.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Revise quad mode to dual mode to avoid WP pin influnece the SPI

What do you mean by this? Can you unpack what's going on a little more
in the commit message?

Andrew

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index f8bfdefbefc6..23006dca5f26 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -149,15 +149,17 @@ flash at 0 {
>  		status = "okay";
>  		m25p,fast-read;
>  		label = "bmc";
> -		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
>  		spi-max-frequency = <50000000>;
> -#include "openbmc-flash-layout-64.dtsi"
> +#include "openbmc-flash-layout-128.dtsi"
>  	};
>  	flash at 1 {
>  		status = "okay";
>  		m25p,fast-read;
>  		label = "bmc2";
> -		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
>  		spi-max-frequency = <50000000>;
>  	};
>  };


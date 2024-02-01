From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 14:43:12 +1030
Subject: [PATCH v5 02/21] ARM: dts: aspeed: yosemite4: Enable adc15
In-Reply-To: <20240131084134.328307-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <3050b9cb85cc2d308ada602794fd2ba09014334f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Enable Yosemite 4 adc15 config

This should have a description. What's motivating the change? Why make
it? What are we monitoring with ADC15? Why wasn't it necessary
previously?

The expectations on commit messages are outlined here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.7#n45

Andrew

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index dac58d3ea63c..6846aab893ad 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -51,7 +51,7 @@ iio-hwmon {
>  		compatible = "iio-hwmon";
>  		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> -				<&adc1 0>, <&adc1 1>;
> +				<&adc1 0>, <&adc1 1>, <&adc1 7>;
>  	};
>  };
>  
> @@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
>  &adc1 {
>  	ref_voltage = <2500>;
>  	status = "okay";
> -	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +	    &pinctrl_adc15_default>;
>  };
>  
> -
>  &ehci0 {
>  	status = "okay";
>  };


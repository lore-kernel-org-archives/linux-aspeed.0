From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 14:45:29 +1030
Subject: [PATCH v5 03/21] ARM: dts: aspeed: yosemite4: Enable spi-gpio
 setting
In-Reply-To: <20240131084134.328307-4-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-4-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <c14428e5b6fc863cf29606842f49895a82fa3539.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> enable spi-gpio setting for spi flash

I suspect I know what's motivating this as a design, but can you add an
explanation to the commit message?

Again, expectations on commit messages are outlined here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.7#n45

Andrew

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 6846aab893ad..ea8fd3ec0982 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -53,6 +53,24 @@ iio-hwmon {
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
>  				<&adc1 0>, <&adc1 1>, <&adc1 7>;
>  	};
> +
> +	spi_gpio: spi-gpio {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpmdev at 0 {
> +			compatible = "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};
>  };
>  
>  &uart1 {


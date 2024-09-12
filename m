From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 11:49:24 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
In-Reply-To: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-10 at 11:03 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Enable spi-gpio setting for spi flash in yosemite4.

Is there actually a flash chip on the same bus? You've only described a
TPM. If there's no flash then this seems misleading.

Andrew

> Add tpm device under spi.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..fdf9040d655b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -34,6 +34,24 @@ iio-hwmon {
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
>  				<&adc1 0>, <&adc1 1>;
>  	};
> +
> +	spi {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +		num-chipselects = <1>;
> +
> +		tpm at 0 {
> +			reg = <0>;
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +		};
> +	};
>  };
>  
>  &uart1 {


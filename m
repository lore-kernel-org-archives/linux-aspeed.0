From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 19 Aug 2024 10:26:13 +0930
Subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO
 linename typo
In-Reply-To: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <96c1ab665e28f49b5f52b0bc3397280a47edbbb5.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-16 at 17:24 +0800, Delphine CC Chiu wrote:
> Fix GPIO linename typo and add missing GPIO pin initial state.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
>  1 file changed, 455 insertions(+), 99 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index abd4a9173de4..4090725160f9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -285,6 +285,8 @@ &mac2 {
>  	pinctrl-0 = <&pinctrl_rmii3_default>;
>  	use-ncsi;
>  	mellanox,multi-host;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;
>  };
>  
>  &mac3 {
> @@ -293,6 +295,8 @@ &mac3 {
>  	pinctrl-0 = <&pinctrl_rmii4_default>;
>  	use-ncsi;
>  	mellanox,multi-host;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;
>  };
>  
>  &fmc {
> @@ -327,6 +331,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -348,13 +359,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -373,6 +377,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -394,13 +405,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -419,6 +423,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -440,13 +451,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -465,6 +469,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -486,13 +497,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -511,6 +515,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -532,13 +543,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -557,6 +561,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -578,13 +589,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -603,6 +607,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -624,13 +635,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -649,6 +653,13 @@ mctp at 10 {
>  		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>  	};
>  
> +	gpio at 24 {
> +		compatible = "nxp,pca9506";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gpio at 21 {
>  		compatible = "nxp,pca9506";
>  		reg = <0x21>;
> @@ -670,13 +681,6 @@ gpio at 23 {
>  		#gpio-cells = <2>;
>  	};
>  
> -	gpio at 24 {
> -		compatible = "nxp,pca9506";
> -		reg = <0x24>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
>  	power-sensor at 40 {
>  		compatible = "adi,adm1281", "mps,mp5990";
>  		reg = <0x40>;
> @@ -687,6 +691,7 @@ power-sensor at 40 {
>  &i2c8 {
>  	status = "okay";
>  	bus-frequency = <400000>;
> +	i2c-clk-high-min-percent = <40>;
>  	i2c-mux at 70 {
>  		compatible = "nxp,pca9544";
>  		i2c-mux-idle-disconnect;
> @@ -798,6 +803,7 @@ eeprom at 54 {
>  &i2c9 {
>  	status = "okay";
>  	bus-frequency = <400000>;
> +	i2c-clk-high-min-percent = <40>;
>  	i2c-mux at 71 {
>  		compatible = "nxp,pca9544";
>  		i2c-mux-idle-disconnect;
> @@ -993,7 +999,7 @@ power-sensor at 13 {
>  		reg = <0x13>;
>  	};
>  
> -	gpio at 20 {
> +	gpio_ext1: pca9555 at 20 {
>  		compatible = "nxp,pca9555";
>  		pinctrl-names = "default";
>  		gpio-controller;
> @@ -1012,7 +1018,7 @@ gpio at 20 {
>  		"","";
>  	};
>  
> -	gpio at 21 {
> +	gpio_ext2: pca9555 at 21 {
>  		compatible = "nxp,pca9555";
>  		pinctrl-names = "default";
>  		gpio-controller;
> @@ -1031,7 +1037,7 @@ gpio at 21 {
>  		"","";
>  	};
>  
> -	gpio at 22 {
> +	gpio_ext3: pca9555 at 22 {
>  		compatible = "nxp,pca9555";
>  		pinctrl-names = "default";
>  		gpio-controller;
> @@ -1050,7 +1056,7 @@ gpio at 22 {
>  		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
>  	};
>  
> -	gpio at 23 {
> +	gpio_ext4: pca9555 at 23 {
>  		compatible = "nxp,pca9555";
>  		pinctrl-names = "default";
>  		gpio-controller;
> @@ -1070,21 +1076,21 @@ gpio at 23 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "mps,mp5023";
> -		reg = <0x40>;
> +			compatible = "mps,mp5023";
> +			reg = <0x40>;
>  	};
>  
>  	power-sensor at 41 {
> -			compatible = "ti,ina233";
> -			resistor-calibration = /bits/ 16 <0x0a00>;
> -			current-lsb= /bits/ 16 <0x0001>;
> -			reg = <0x41>;
> +		compatible = "ti,ina233";
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
> +		reg = <0x41>;
>  	};
>  
>  	power-sensor at 44 {
> -			compatible = "ti,ina238";
> -			shunt-resistor = <1000>;
> -			reg = <0x44>;
> +		compatible = "ti,ina238";
> +		shunt-resistor = <1000>;
> +		reg = <0x44>;
>  	};
>  
>  	temperature-sensor at 48 {
> @@ -1156,33 +1162,32 @@ rtc at 6f {
>  				compatible = "nuvoton,nct3018y";
>  				reg = <0x6f>;
>  			};
> -
>  			gpio at 20 {
> -				compatible = "nxp,pca9506";
> -				reg = <0x20>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> +					compatible = "nxp,pca9506";
> +					reg = <0x20>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
>  			};
>  
>  			gpio at 21 {
> -				compatible = "nxp,pca9506";
> -				reg = <0x21>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> +					compatible = "nxp,pca9506";
> +					reg = <0x21>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
>  			};
>  
>  			gpio at 22 {
> -				compatible = "nxp,pca9506";
> -				reg = <0x22>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> +					compatible = "nxp,pca9506";
> +					reg = <0x22>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
>  			};
>  
>  			gpio at 23 {
> -				compatible = "nxp,pca9506";
> -				reg = <0x23>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> +					compatible = "nxp,pca9506";
> +					reg = <0x23>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
>  			};
>  		};
>  
> @@ -1242,35 +1247,35 @@ adc at 37 {
>  	power-sensor at 40 {
>  		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x40>;
> -		resistor-calibration = /bits/ 16 <0x0a00>;
> +		resistor-calibration = /bits/ 16 <0x0400>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 41 {
>  		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x41>;
> -		resistor-calibration = /bits/ 16 <0x0a00>;
> +		resistor-calibration = /bits/ 16 <0x0400>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 42 {
>  		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x42>;
> -		resistor-calibration = /bits/ 16 <0x0a00>;
> +		resistor-calibration = /bits/ 16 <0x0400>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 43 {
>  		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x43>;
> -		resistor-calibration = /bits/ 16 <0x0a00>;
> +		resistor-calibration = /bits/ 16 <0x0400>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 44 {
>  		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x44>;
> -		resistor-calibration = /bits/ 16 <0x0a00>;
> +		resistor-calibration = /bits/ 16 <0x0400>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
> @@ -1323,6 +1328,42 @@ channel at 5 {
>  				};
>  			};
>  
> +			hwmon0: hwmon at 21 {
> +				compatible = "nuvoton,nct7363";

It looks like this series didn't progress any further?

https://lore.kernel.org/all/20240322081158.4106326-2-kcfeng0 at nuvoton.com/

Please drop these nodes for now and send a follow-up patch once the
driver and binding have been reworked and merged.

Andrew

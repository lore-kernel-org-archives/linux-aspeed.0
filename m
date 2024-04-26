From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Apr 2024 10:21:45 +0930
Subject: [PATCH v1 1/2] Revise mux and hardware in yosemite4 dts
In-Reply-To: <20240425060626.2558515-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240425060626.2558515-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <f355ad1adb96cd8398c4ac81d1c72df289a2aaf0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-25 at 14:06 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:

This should be in the patch subject, not the body of the commit
message.

> Change hardware configuration, consequently modifying the mux in the dts.

Perhaps "We have a new iteration of the hardware design, so update the
devicetree to match."?

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Overall it feels a bit untidy updating the description of distinct
devices in the one patch.

> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 78 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..e45293762316 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -433,16 +433,14 @@ eeprom at 51 {
>  		reg = <0x51>;
>  	};
>  
> -	i2c-mux at 71 {
> -		compatible = "nxp,pca9846";
> +	i2c-mux at 74 {
> +		compatible = "nxp,pca9546";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -
> -		idle-state = <0>;
>  		i2c-mux-idle-disconnect;
> -		reg = <0x71>;
> +		reg = <0x74>;
>  
> -		i2c at 0 {
> +		inux30: i2c at 0{

'inux'? 'imux'?

>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> @@ -450,26 +448,46 @@ i2c at 0 {
>  			adc at 1f {
>  				compatible = "ti,adc128d818";
>  				reg = <0x1f>;
> -				ti,mode = /bits/ 8 <2>;
> +				ti,mode = /bits/ 8 <1>;
>  			};
>  
>  			pwm at 20{
> -				compatible = "max31790";
> -				reg = <0x20>;
> +				compatible = "maxim,max31790";

This looks like a change motivated by binding validation or a driver
change rather than hardware design :)

>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				reg = <0x20>;
> +				channel at 4 {
> +					reg = <4>;
> +					sensor-type = "TACH";
> +				};
> +
> +				channel at 5 {
> +					reg = <5>;
> +					sensor-type = "TACH";
> +				};
>  			};
>  
>  			gpio at 22{
>  				compatible = "ti,tca6424";
>  				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
>  			};
>  
> -			pwm at 23{
> -				compatible = "max31790";
> -				reg = <0x23>;
> +			pwm at 2f{
> +				compatible = "maxim,max31790";

Again here

Andrew

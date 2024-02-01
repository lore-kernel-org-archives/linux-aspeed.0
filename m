From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Feb 2024 14:16:24 +1030
Subject: [PATCH v5 01/21] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
In-Reply-To: <20240131084134.328307-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <ff1df8af596c907e969d9011ce2f42ef96974d37.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Revise Yosemite 4 devicetree for devices behind i2c-mux
> - Add gpio and eeprom behind i2c-mux
> - Remove redundant idle-state setting for i2c-mux

Generally if you find yourself listing things the patch does in the
commit message it's an indicator you should split the patch up.

It looks like there's a lot of stuff to be fixed, but it doesn't need
to all be fixed in the one commit (as 01/21 suggests I guess). The
devicetree is already inaccurate, it's okay if a subset of the
inaccuracies survive for another patch or so.

Otherwise, if they must be changed together, it would be good to have a
description of *why*. Broadly, the commit message should explain *why*
the change is need regardless, not discuss *what* the patch changes
(that's evident from the patch itself).

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
>  1 file changed, 347 insertions(+), 34 deletions(-)
> 
>  
> -	i2c-mux at 71 {
> -		compatible = "nxp,pca9846";
> +	i2c-mux at 74 {
> +		compatible = "nxp,pca9546";

Aside from splitting the patch on adding more devices and removing the
redundant idle-state settings, things like this should probably be
separate too.

Why was the address changed? Was it always wrong? Or has there been a
new revision of the board? A separate commit with some explanation here
would be useful.

>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -
> -		idle-state = <0>;
>  		i2c-mux-idle-disconnect;
> -		reg = <0x71>;
> +		reg = <0x74>;
>  
> -		i2c at 0 {
> +		imux30: i2c at 0 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> @@ -450,26 +726,26 @@ i2c at 0 {
>  			adc at 1f {
>  				compatible = "ti,adc128d818";
>  				reg = <0x1f>;
> -				ti,mode = /bits/ 8 <2>;
> +				ti,mode = /bits/ 8 <1>;

This isn't discussed anywhere. There should probably be a separate
change for anything adc128d818-related that explains what's going on
here.

>  			};
>  
>  			pwm at 20{
> -				compatible = "max31790";
> +				compatible = "maxim,max31790";
> +				pwm-as-tach = <4 5>;
>  				reg = <0x20>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;

This also isn't discussed anywhere. There should probably be a separate
change for anything max31790-related that explains what's going on
here.

>  			};
>  
>  			gpio at 22{
>  				compatible = "ti,tca6424";
>  				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;

Also not discussed. Separate change for anything tca6424-related that
explains what's going on here.

>  			};
>  
> -			pwm at 23{
> -				compatible = "max31790";
> -				reg = <0x23>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> +			pwm at 2f{
> +				compatible = "maxim,max31790";
> +				pwm-as-tach = <4 5>;
> +				reg = <0x2f>;
>  			};

Should go in the max31790-related patch.

>  
>  			adc at 33 {
> @@ -492,34 +768,34 @@ gpio at 61 {
>  			};
>  		};
>  
> -		i2c at 1 {
> +		imux31: i2c at 1 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			reg = <0>;
> +			reg = <1>;
>  
>  			adc at 1f {
>  				compatible = "ti,adc128d818";
>  				reg = <0x1f>;
> -				ti,mode = /bits/ 8 <2>;
> +				ti,mode = /bits/ 8 <1>;

Should go in the adc128d818 patch

>  			};
>  
>  			pwm at 20{
> -				compatible = "max31790";
> +				compatible = "maxim,max31790";
> +				pwm-as-tach = <4 5>;
>  				reg = <0x20>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  			};

Should go in the max31790 patch

>  
>  			gpio at 22{
>  				compatible = "ti,tca6424";
>  				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;

Should go in the tca6424 patch

>  			};
>  
> -			pwm at 23{
> -				compatible = "max31790";
> -				reg = <0x23>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> +			pwm at 2f{
> +				compatible = "maxim,max31790";
> +				pwm-as-tach = <4 5>;
> +				reg = <0x2f>;

Should go in the max31790 patch

Andrew

From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 14:04:37 +0930
Subject: [PATCH 1/2] ARM: dts: aspeed: mtmitchell: Add I2C FAN
 controllers
In-Reply-To: <20240905063521.319416-2-chanh@os.amperecomputing.com>
References: <20240905063521.319416-1-chanh@os.amperecomputing.com>
	 <20240905063521.319416-2-chanh@os.amperecomputing.com>
Message-ID: <24ab22b5403adb379f942b3dadb8f49b54f28bb0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-09-05 at 06:35 +0000, Chanh Nguyen wrote:
> Add the MAX31790 nodes as i2c fan controllers.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 0295f5adcfbc..da181f9ae820 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -684,6 +684,16 @@ bmc-ocp0-en-hog {
>  			line-name = "bmc-ocp0-en-n";
>  		};
>  	};
> +
> +	fan-controller0 at 20 {
> +		compatible = "maxim,max31790";
> +		reg = <0x20>;
> +	};
> +
> +	fan-controller1 at 2f {
> +		compatible = "maxim,max31790";
> +		reg = <0x2f>;
> +	};
>  };

This generates some warnings based on v6.11-rc1:

Executing: ./scripts/checkpatch.pl --strict -g HEAD                                                                                                            
WARNING: DT compatible string "maxim,max31790" appears un-documented -- check ./Documentation/devicetree/bindings/                                             
#25: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:689:                                                                                      
+               compatible = "maxim,max31790";                                                                                                                 
                                                                                                                                                               
WARNING: DT compatible string "maxim,max31790" appears un-documented -- check ./Documentation/devicetree/bindings/                                             
#30: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:694:                                                                                      
+               compatible = "maxim,max31790";                                                                                                                 
                                                                                                                                                               
total: 0 errors, 2 warnings, 0 checks, 16 lines checked

However, Guenter's applied the binding here:

https://lore.kernel.org/all/3382f952-daae-43ff-bb85-fa4820ecbc5f at roeck-us.net/

`make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtmitchell.dtb` didn't turn
up anything interesting after merging in hwmon-next, so I've applied
these to be integrated via the BMC tree.

Andrew

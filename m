From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 16:06:47 +0930
Subject: [PATCH v3 02/11] ARM: dts: aspeed: Harma: add VR device
In-Reply-To: <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
	 <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
Message-ID: <7bf4cb57f2b0b41c79f2efea3e0b0211988c0896.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-02 at 00:01 +0800, Peter Yin wrote:
> Add isl69260, xdpe152c4 device
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index d99fba321379..8fb30029e46c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -398,6 +398,30 @@ imux28: i2c at 0 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> +			power-monitor at 61 {
> +				compatible = "isil,isl69260";
> +				reg = <0x61>;
> +			};
> +			power-monitor at 62 {
> +				compatible = "isil,isl69260";
> +				reg = <0x62>;
> +			};
> +			power-monitor at 63 {
> +				compatible = "isil,isl69260";
> +				reg = <0x63>;
> +			};

As of v6.11-rc1 this gives me:

```
$ ./scripts/checkpatch.pl --strict -g HEAD
...
WARNING: DT compatible string "isil,isl69260" appears un-documented -- check ./Documentation/devicetree/bindings/
#24: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:402:
+                               compatible = "isil,isl69260";

WARNING: DT compatible string "isil,isl69260" appears un-documented -- check ./Documentation/devicetree/bindings/
#28: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:406:
+                               compatible = "isil,isl69260";

WARNING: DT compatible string "isil,isl69260" appears un-documented -- check ./Documentation/devicetree/bindings/
#32: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:410:
+                               compatible = "isil,isl69260";

total: 0 errors, 3 warnings, 0 checks, 30 lines checked
```

and

```
$ make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-harma.dtb 2>&1 | grep isil
...
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c at 700/i2c-mux at 70/i2c at 0/power-monitor at 61: failed to match any schema with compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c at 700/i2c-mux at 70/i2c at 0/power-monitor at 62: failed to match any schema with compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c at 700/i2c-mux at 70/i2c at 0/power-monitor at 63: failed to match any schema with compatible: ['isil,isl69260']
```

While there's already an Aspeed-based Quanta platform that also
specifies this device, let's not add to the problems of the Aspeed
devicetrees.

Please make sure to run `make dtbs_check ...` and checkpatch on your
changes. Regarding `make dtbs_check` and related tests, this blog post
is helpful:

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

Andrew

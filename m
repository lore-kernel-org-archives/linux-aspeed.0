From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 26 Jun 2024 11:00:35 +0930
Subject: [PATCH 02/17] ARM: dts: aspeed: minerva: Add spi-gpio
In-Reply-To: <20240625121835.751013-3-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
	 <20240625121835.751013-3-yangchen.openbmc@gmail.com>
Message-ID: <4391083991a16c435c5d8849eb5ee2be2f03793c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-06-25 at 20:18 +0800, Yang Chen wrote:
> From: Yang Chen <yang.chen@quantatw.com>
> 
> Add spi-gpio for TPM device.
> 
> Signed-off-by: Yang Chen <yang.chen@quantatw.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> index e20e31917d6c..7d96a3638448 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> @@ -22,6 +22,8 @@ aliases {
>  		i2c19 = &imux19;
>  		i2c20 = &imux20;
>  		i2c21 = &imux21;
> +
> +		spi1 = &spi_gpio;
>  	};
>  
>  	chosen {
> @@ -49,6 +51,25 @@ led-fan-fault {
>  			default-state = "off";
>  		};
>  	};
> +
> +	spi_gpio: spi-gpio {
> +		status = "okay";
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpmdev at 0 {
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};

I poked at your series with the following script:

```
$ cat dtb-check
#!/usr/bin/bash

set -euo pipefail

DTB="$1"

rm -f arch/arm/boot/dts/"$DTB"
make CHECK_DTBS=y "$DTB" 2>&1 |
    sed "/should not be valid under {'type': 'object'}/d" > curr.log
diff -u ref.log curr.log
```

I ran this after creating a reference output prior to your series using
the same `make CHECK_DTBS=y` command.

This patch gave the following output (which I expect Rob's bot will
follow up with at some point as well):

```
--- ref.log     2024-06-26 10:48:23.767078834 +0930
+++ curr.log    2024-06-26 10:55:56.857034132 +0930
@@ -1,4 +1,6 @@
   DTC_CHK arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /: spi-gpio: {'status': ['okay'], 'compatible': ['spi-gpio'], '#address-cells': [[1]], '#size-cells': [[0]], 'gpio-sck': [[62, 203, 0]], 'gpio-mosi': [[62, 204, 0]], 'gpio-miso': [[62, 205, 0]], 'num-chipselects': [[1]], 'cs-gpios': [[62, 200, 1]], 'tpmdev at 0': {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': [[33000000]], 'reg': [[0]]}} is not of type 'array'
+       from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
 /home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
 /home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: sdram at 1e6e0000: compatible: ['aspeed,ast2600-sdram-edac', 'syscon'] is too long
@@ -38,3 +40,17 @@
        from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: $nodename:0: 'spi-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-sck: False schema does not allow [[62, 203, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-miso: False schema does not allow [[62, 205, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-mosi: False schema does not allow [[62, 204, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: 'sck-gpios' is a required property
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'gpio-miso', 'gpio-mosi', 'gpio-sck', 'tpmdev at 0' were unexpected)
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: tpmdev at 0: $nodename:0: 'tpmdev at 0' does not match '^tpm(@[0-9a-f]+)?$'
+       from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
```

Can you please address these and go over the rest of the patches to
shore them up against the current bindings?

Thanks,

Andrew

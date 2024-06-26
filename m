From: Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 26 Jun 2024 07:31:29 -0600
Subject: [PATCH 00/17] Revise Facebook Minerva BMC DTS
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <171940832692.2961326.910026599869370818.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 25 Jun 2024 20:18:18 +0800, Yang Chen wrote:
> Revise the Linux device tree entry related to Facebook platform Minerva
> specific devices connected to the Aspeed AST2600 BMC.
> 
> Yang Chen (17):
>   ARM: dts: aspeed: minerva: change the address of tmp75
>   ARM: dts: aspeed: minerva: Add spi-gpio
>   ARM: dts: aspeed: minerva: change aliases for uart
>   ARM: dts: aspeed: minerva: add eeprom on i2c bus
>   ARM: dts: aspeed: minerva: change RTC reference
>   ARM: dts: aspeed: minerva: enable mdio3
>   ARM: dts: aspeed: minerva: remove unused bus and device
>   ARM: dts: aspeed: minerva: Define the LEDs node name
>   ARM: dts: aspeed: minerva: Add adc sensors for fan board
>   ARM: dts: aspeed: minerva: add linename of two pins
>   ARM: dts: aspeed: minerva: enable ehci0 for USB
>   ARM: dts: aspeed: minerva: add tmp75 sensor
>   ARM: dts: minerva: add power monitor xdp710
>   ARM: dts: aspeed: minerva: revise sgpio line name
>   ARM: dts: aspeed: minerva: Switch the i2c bus number
>   ARM: dts: aspeed: minerva: remove unused power device
>   ARM: dts: aspeed: minerva: add ltc4287 device
> 
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
>  1 file changed, 373 insertions(+), 143 deletions(-)
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-minerva.dtb' for 20240625121835.751013-1-yangchen.openbmc at gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /: spi-gpio: {'status': ['okay'], 'compatible': ['spi-gpio'], '#address-cells': 1, '#size-cells': 0, 'gpio-sck': [61, 203, 0], 'gpio-mosi': [61, 204, 0], 'gpio-miso': [61, 205, 0], 'num-chipselects': 1, 'cs-gpios': [[61, 200, 1]], 'tpmdev at 0': {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': 33000000, 'reg': [[0]]}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: $nodename:0: 'spi-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-sck: False schema does not allow [61, 203, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-miso: False schema does not allow [61, 205, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-mosi: False schema does not allow [61, 204, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: 'sck-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'gpio-miso', 'gpio-mosi', 'gpio-sck', 'tpmdev at 0' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: tpmdev at 0: $nodename:0: 'tpmdev at 0' does not match '^tpm(@[0-9a-f]+)?$'
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#






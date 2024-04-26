From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Apr 2024 14:22:51 -0000
Subject: [PATCH v3 00/14] ARM: dts: aspeed: Add IBM P11 BMC Boards
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <171414068026.1496203.4393005955298544023.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 25 Apr 2024 16:36:47 -0500, Eddie James wrote:
> Add the Blueridge and Fuji BMC systems. Document many missing FSI related
> properties, and fix existing warnings.
> 
> Changes since v2:
>  - Split up the DTS patches
>  - Add documentation patches
> 
> Eddie James (14):
>   dt-bindings: spi: Document the IBM Power SPI controller
>   dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
>   dt-bindings: fsi: Document the FSI2PIB engine
>   dt-bindings: fsi: p9-occ: Switch to yaml format
>   dt-bindings: fsi: Document the IBM SBEFIFO engine
>   dt-bindings: fsi: Document the FSI controller common properties
>   dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
>   dt-bindings: fsi: ast2600-fsi-master: Switch to yaml format
>   dt-bindings: fsi: Document the FSI Hub Controller
>   dt-bindings: i2c: i2c-fsi: Switch to yaml format
>   dt-bindings: arm: aspeed: add IBM P11 BMC boards
>   ARM: dts: aspeed: Add IBM P11 FSI devices
>   ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
>   ARM: dts: aspeed: Add IBM P11 Fuji BMC system
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    2 +
>  .../fsi/aspeed,ast2600-fsi-master.yaml        |   72 +
>  .../bindings/fsi/fsi-controller.yaml          |   65 +
>  .../bindings/fsi/fsi-master-aspeed.txt        |   36 -
>  .../devicetree/bindings/fsi/ibm,fsi2pib.yaml  |   38 +
>  .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |   11 +
>  .../bindings/fsi/ibm,hub-fsi-controller.yaml  |   44 +
>  .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |    5 +-
>  .../devicetree/bindings/fsi/ibm,p9-occ.txt    |   16 -
>  .../devicetree/bindings/fsi/ibm,p9-occ.yaml   |   41 +
>  .../bindings/fsi/ibm,p9-sbefifo.yaml          |   50 +
>  .../devicetree/bindings/i2c/i2c-fsi.txt       |   40 -
>  .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  |   59 +
>  .../devicetree/bindings/spi/ibm,p10-spi.yaml  |   56 +
>  arch/arm/boot/dts/aspeed/Makefile             |    2 +
>  .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1711 +++++++
>  .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3984 +++++++++++++++++
>  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1696 +++++++
>  18 files changed, 7835 insertions(+), 93 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
> 
> --
> 2.39.3
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-blueridge.dtb aspeed/aspeed-bmc-ibm-fuji.dtb' for 20240425213701.655540-1-eajames at linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /sdram at 1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /sdram at 1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e680000: $nodename:0: 'ftgmac at 1e680000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e670000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e690000: $nodename:0: 'ftgmac at 1e690000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ftgmac at 1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e680000: $nodename:0: 'ftgmac at 1e680000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e670000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e690000: $nodename:0: 'ftgmac at 1e690000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ftgmac at 1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: syscon at 1e6e2000: pinctrl: 
'oneOf' conditional failed, one must be fixed:
	'aspeed,external-nodes' is a required property
	'aspeed,ast2400-pinctrl' was expected
	'aspeed,ast2500-pinctrl' was expected
	'EMMC' is not one of ['ACPI', 'ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'DDCCLK', 'DDCDAT', 'EXTRST', 'FLACK', 'FLBUSY', 'FLWP', 'GPID', 'GPID0', 'GPID2', 'GPID4', 'GPID6', 'GPIE0', 'GPIE2', 'GPIE4', 'GPIE6', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'LPCPD', 'LPCPME', 'LPCRST', 'LPCSMI', 'MAC1LINK', 'MAC2LINK', 'MDIO1', 'MDIO2', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NDTS4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'OSCCLK', 'PWM0', 'PWM1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'RGMII1', 'RGMII2', 'RMII1', 'RMII2', 'ROM16', 'ROM8', 'ROMCS1', 'ROMCS2', 'ROMCS3', 'ROMCS4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT2', 'SALT3', 'SALT4', 'SD1', 'SD2', 'SGPMCK', 'SGPMI', 'SGPMLD', 'SGPMO', 'SG
 PSCK', 'SGPSI0', 'SGPSI1', 'SGPSLD', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1DEBUG', 'SPI1PASSTHRU', 'SPICS1', 'TIMER3', 'TIMER4', 'TIMER5', 'TIMER6', 'TIMER7', 'TIMER8', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART6', 'USB11D1', 'USB11H2', 'USB2D1', 'USB2H1', 'USBCKI', 'VGABIOS_ROM', 'VGAHS', 'VGAVS', 'VPI18', 'VPI24', 'VPI30', 'VPO12', 'VPO24', 'WDTRST1', 'WDTRST2']
	'EMMC' is not one of ['ACPI', 'ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'DDCCLK', 'DDCDAT', 'ESPI', 'FWSPICS1', 'FWSPICS2', 'GPID0', 'GPID2', 'GPID4', 'GPID6', 'GPIE0', 'GPIE2', 'GPIE4', 'GPIE6', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'LAD0', 'LAD1', 'LAD2', 'LAD3', 'LCLK', 'LFRAME', 'LPCHC', 'LPCPD', 'LPCPLUS', 'LPCPME', 'LPCRST', 'LPCSMI', 'LSIRQ', 'MAC1LINK', 'MAC2LINK', 'MDIO1', 'MDIO2', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PNOR', 'PWM0', 'PWM1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'RGMII1', 'RGMII2', 'RMII1', 'RMII2', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT
 2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SCL1', 'SCL2', 'SD1', 'SD2', 'SDA1', 'SDA2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1CS1', 'SPI1DEBUG', 'SPI1PASSTHRU', 'SPI2CK', 'SPI2CS0', 'SPI2CS1', 'SPI2MISO', 'SPI2MOSI', 'TIMER3', 'TIMER4', 'TIMER5', 'TIMER6', 'TIMER7', 'TIMER8', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART6', 'USB11BHID', 'USB2AD', 'USB2AH', 'USB2BD', 'USB2BH', 'USBCKI', 'VGABIOSROM', 'VGAHS', 'VGAVS', 'VPI24', 'VPO', 'WDTRST1', 'WDTRST2']
...
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: syscon at 1e6e2000: 'smp-memram at 180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: syscon at 1e6e2000: 'smp-memram at 180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: usb11bhid_default:function:0: 'USB11BHID' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 
 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD',
  'USB2BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: i3c1_default:function:0: 'I3C1' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS
 1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB
 2BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: i3c1_default:groups:0: 'I3C1' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4
 ', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PWM10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', 'PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0', 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', 'SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1', 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'T
 ACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: i3c1_default:function:0: 'I3C1' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', '
 NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH',
  'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: i3c1_default:groups:0: 'I3C1' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'N
 RI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PWM10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', 'PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0', 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', 'SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1', 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15
 ', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: i3c2_default:function:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', '
 NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH',
  'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: i3c2_default:groups:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'N
 RI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PWM10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', 'PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0', 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', 'SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1', 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15
 ', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: usb2ad_default:function:0: 'USB2AD' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', '
 NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 
 'USB2BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: i3c2_default:function:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS
 1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB
 2BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: i3c2_default:groups:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4
 ', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PWM10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', 'PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0', 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', 'SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1', 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'T
 ACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: pinctrl: usb2ad_default:function:0: 'USB2AD' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1
 ', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2
 BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: pinctrl: usb11bhid_default:function:0: 'USB11BHID' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NR
 I4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB
 2BD', 'USB2BH', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/syscon at 1e6e2000/smp-memram at 180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/display at 1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/xdma at 1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xdma']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: adc at 1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: adc at 1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/syscon at 1e6e2000/smp-memram at 180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/video at 1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: gpio at 1e780000: 'i2c3_mux_oe_n-hog', 'usb_power-hog' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/display at 1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: sgpiom at 1e780500: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/xdma at 1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xdma']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: adc at 1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: sgpiom at 1e780600: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: adc at 1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/timer at 1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/video at 1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: gpio at 1e780000: 'usb_power-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: sgpiom at 1e780500: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: sgpiom at 1e780600: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: lpc at 1e789000: lpc-snoop at 80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: lpc at 1e789000: reg-io-width: [[4]] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/timer at 1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: kcs at 24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: kcs at 28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: kcs at 2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: kcs at 114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/lpc at 1e789000/lhc at a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: lpc at 1e789000: lpc-snoop at 80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: lpc at 1e789000: reg-io-width: [[4]] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: kcs at 24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/lpc at 1e789000/ibt at 140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: sdc at 1e740000: sdhci at 1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: sdc at 1e740000: sdhci at 1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: kcs at 28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: kcs at 2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: kcs at 114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/lpc at 1e789000/lhc at a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/lpc at 1e789000/ibt at 140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: sdc at 1e740000: sdhci at 1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: sdc at 1e740000: sdhci at 1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 200/pca9552 at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 80/pca9552 at 62: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/pca9552 at 65: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/i2c-mux at 70/i2c at 0/pca9551 at 62: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/i2c-mux at 70/i2c at 1/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 1/pca9551 at 61: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/i2c-mux at 70/i2c at 2/pca9551 at 61: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/pca9552 at 66: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 1/pca9551 at 61: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 30: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 2/pca9551 at 62: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 3/pca9551 at 63: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 31: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 380/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 380/i2c-mux at 70/i2c at 1/pca9551 at 62: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 32: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 380/i2c-mux at 70/i2c at 2/pca9551 at 63: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 380/i2c-mux at 70/i2c at 3/pca9551 at 61: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 380/pca9552 at 65: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 33: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 31: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/max31785 at 52: failed to match any schema with compatible: ['maxim,max31785a']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 32: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: dps310 at 76: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 33: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 480/pca9552 at 60: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 480/pca9552 at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 30: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 600/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 34: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 700/pca9552 at 60: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 35: failed to match any schema with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/pca9552 at 60: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 800/pca9552 at 60: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: fsi at 1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: fsi at 1e79b000: Unevaluated properties are not allowed ('#interrupt-cells', 'compatible', 'interrupt-controller' were unexpected)
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 70/i2c at 2/pca9551 at 60: failed to match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 70/i2c at 3/max31785 at 52: failed to match any schema with compatible: ['maxim,max31785a']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 70/i2c at 3/pca9552 at 60: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 70/i2c at 3/pca9552 at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: fsi at 1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: fsi at 1e79b000: Unevaluated properties are not allowed ('#interrupt-cells', 'compatible', 'interrupt-controller' were unexpected)
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: fsi at 1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: fsi at 1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






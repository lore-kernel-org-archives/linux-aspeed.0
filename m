From: Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 26 Jul 2024 08:09:45 -0500
Subject: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
In-Reply-To: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
Message-ID: <172199921421.1507234.14901757413141840919.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 26 Jul 2024 18:26:48 +0800, Potin Lai wrote:
> Add Linux device tree entry related to Meta(Facebook) Catalina specific
> devices connected to BMC(AST2600) SoC.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Changes in v5:
> - fix spi1_gpio node name and properties
> - remove undefind properties in mac3, i2c7 & i2c11
> - Link to v4: https://lore.kernel.org/r/20240725-potin-catalina-dts-v4-0-aa6f235a2e78 at gmail.com
> 
> Changes in v4:
> - change back io_expanderX due to parser error, build passed in v4 version.
> - Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc at gmail.com
> 
> Changes in v3:
> - rename tmp75 nodes to temperature-sensor
> - rename tmp421 nodes to temperature-sensor
> - rename ina230 nodes to power-sensor
> - rename io_expanderX nodes to io-expanderX
> - Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-0-ba8d475c4073 at gmail.com
> 
> Changes in v2:
> - drop commented code in dts
> - rename i2c-mux channel nodes as i2c1muxXchY
> - rename gpio expander as io_expanderX
> - use "stdout-path" instead of "bootargs"
> - Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-potin.lai.pt at gmail.com/
> 
> ---
> Potin Lai (2):
>       dt-bindings: arm: aspeed: add Meta Catalina board
>       ARM: dts: aspeed: catalina: add Meta Catalina BMC
> 
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
>  .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1016 ++++++++++++++++++++
>  3 files changed, 1018 insertions(+)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240724-potin-catalina-dts-fda1ea3297b1
> 
> Best regards,
> --
> Potin Lai <potin.lai.pt@gmail.com>
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-catalina.dtb' for 20240726-potin-catalina-dts-v5-0-8f02305af527 at gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /sdram at 1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac at 1e680000: $nodename:0: 'ftgmac at 1e680000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac at 1e690000: $nodename:0: 'ftgmac at 1e690000' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac at 1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: syscon at 1e6e2000: 'smp-memram at 180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/syscon at 1e6e2000/smp-memram at 180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/display at 1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/xdma at 1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xdma']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc at 1e6e9000: 'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc at 1e6e9100: 'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/video at 1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: gpio at 1e780000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/timer at 1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc at 1e789000: lpc-snoop at 80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc at 1e789000: reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs at 24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs at 28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs at 2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs at 114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc at 1e789000/lhc at a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc at 1e789000/ibt at 140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc at 1e740000: sdhci at 1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc at 1e740000: sdhci at 1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 2/pwm at 21: failed to match any schema with compatible: ['maxim,max31790']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 2/pwm at 27: failed to match any schema with compatible: ['maxim,max31790']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 60: failed to match any schema with compatible: ['isil,raa228004']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 61: failed to match any schema with compatible: ['isil,raa228004']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 62: failed to match any schema with compatible: ['isil,raa228004']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 400/ipmb at 10: failed to match any schema with compatible: ['ipmb-dev']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi at 1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi at 1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






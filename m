From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Jul 2024 16:01:46 +0930
Subject: [PATCH v2] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC machine
In-Reply-To: <172044909462.3146303.7635761790191924717.robh@kernel.org>
References: <20240708062316.208383-1-liuxiwei@ieisystem.com>
	 <172044909462.3146303.7635761790191924717.robh@kernel.org>
Message-ID: <369ecaebb51307cee2c2f2c3a9c56fff3b235db8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi George,

On Mon, 2024-07-08 at 08:34 -0600, Rob Herring (Arm) wrote:
> On Mon, 08 Jul 2024 14:23:16 +0800, George Liu wrote:
> > The IEISystems NF5280M7 is an x86 platform server with an
> > AST2600-based BMC.
> > This dts file provides a basic configuration for its OpenBMC
> > development.
> > 
> > Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed/aspeed-bmc-ieisystems-nf5280m7.dts | 697 ++++++++++++++++++
> >  2 files changed, 698 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb' for 20240708062316.208383-1-liuxiwei at ieisystem.com:
> 
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:169.3-16: Warning (reg_format): /ahb/apb/peci-controller at 1e78b000/peci-client at 30:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:174.3-16: Warning (reg_format): /ahb/apb/peci-controller at 1e78b000/peci-client at 31:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:167.17-170.4: Warning (avoid_default_addr_size): /ahb/apb/peci-controller at 1e78b000/peci-client at 30: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:167.17-170.4: Warning (avoid_default_addr_size): /ahb/apb/peci-controller at 1e78b000/peci-client at 30: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:172.17-175.4: Warning (avoid_default_addr_size): /ahb/apb/peci-controller at 1e78b000/peci-client at 31: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:172.17-175.4: Warning (avoid_default_addr_size): /ahb/apb/peci-controller at 1e78b000/peci-client at 31: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
> 	'ieisystems,nf5280m7-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,galaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
> 	'ieisystems,nf5280m7-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethanolx-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', 'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', 'asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,minipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yosemitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,mihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,witherspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', 'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,centriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc', 'yadro,vegman-sx20-bmc']
> 	'ieisystems,nf5280m7-bmc' is not one of ['ampere,mtmitchell-bmc', 'aspeed,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchley-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc', 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'ibm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'ibm,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jabil,rbp-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
> 	'aspeed,ast2400' was expected
> 	'aspeed,ast2500' was expected
> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /: failed to match any schema with compatible: ['ieisystems,nf5280m7-bmc', 'aspeed,ast2600']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /sdram at 1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e680000: $nodename:0: 'ftgmac at 1e680000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e670000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e690000: $nodename:0: 'ftgmac at 1e690000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac at 1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: syscon at 1e6e2000: 'smp-memram at 180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/syscon at 1e6e2000/smp-memram at 180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/syscon at 1e6e2000/interrupt-controller at 570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/display at 1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/xdma at 1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xdma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: adc at 1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: adc at 1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/video at 1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/timer at 1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: peci-controller at 1e78b000: 'gpios', 'peci-client at 30', 'peci-client at 31' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/peci-controller at 1e78b000/peci-client at 30: failed to match any schema with compatible: ['intel,peci-client']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/peci-controller at 1e78b000/peci-client at 31: failed to match any schema with compatible: ['intel,peci-client']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: lpc at 1e789000: lpc-snoop at 80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: lpc at 1e789000: reg-io-width: [[4]] is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs at 24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs at 28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs at 2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs at 114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/lpc at 1e789000/lhc at a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/lpc at 1e789000/ibt at 140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: sdc at 1e740000: sdhci at 1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: sdc at 1e740000: sdhci at 1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/bus at 1e78a000/i2c at 180/i2c-mux at 70/i2c at 2/temperature-sensor at 4c: failed to match any schema with compatible: ['microchip,emc1413']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/bus at 1e78a000/i2c at 280/ipmb0 at 10: failed to match any schema with compatible: ['ipmb-dev']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c-switch at 70: $nodename:0: 'i2c-switch at 70' does not match '^(i2c-?)?mux'
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c-switch at 70: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c at 0', 'i2c at 1', 'i2c at 2', 'i2c at 3', 'i2c at 4', 'i2c at 5', 'i2c at 6', 'i2c at 7' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c at 400: Unevaluated properties are not allowed ('#retries' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: pca9555 at 21: '#address-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: pca9555 at 22: '#address-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: gpio-keys: 'cpld' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: leds: 'fan-fault', 'heartbeat', 'memory-fault', 'psu-fault', 'system-fault', 'system-hot' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Can you please try to address these issues where reasonable? For
instance, you need to at least resolve the error "'ieisystems,nf5280m7-
bmc' is not one of ...". Please also take a close look at the other
issues; I don't expect you to fix problems caused by the DTSIs, but
your DTS shouldn't add any of its own.

Andrew

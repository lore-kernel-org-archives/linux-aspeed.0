From: Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 09 Sep 2024 10:45:17 -0500
Subject: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4
In-Reply-To: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172589661042.199175.14634437656639420015.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 09 Sep 2024 18:54:15 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Changelog:
>   - v18
>     - Fix warnings for reg_format reporting by dts checking tool.
>   - v17
>     - Add SoB for the patches.
>   - v16
>     - Reorganized the patches.
>     - Add i2c-mux and resolve the dt-validate errors.
>     - Revise Yosemite 4 devicetree for devices behind i2c-mux.
>     - Add mctp config and sensors for NIC after i2c-mux on bus 15.
>     - Add fan led config for BMC to control according the status of fan.
>   - v15
>     - Add ISL28022 support
>   - v14
>     - Add SQ52205 support
>     - Add GPIO I6 pin
>   - v13
>     - Add RTQ6056-support-on-bus-11
>   - v12
>     - Fix GPIO linename typo and add missing GPIO pin initial state.
>   - v11
>     - Revise all GPIO line name with bottom line
>   - v10
>     - adjust mgm cpld ioexp bus
>     - add GPIOO7 name
>     - remove mctp driver
>   - v9
>     - add XDP710 support
>     - add RTQ6056 support
>     - add MP5990 support
>   - v8
>     - add fan led config
>   - v7
>     - Revise pca9506 i2c address
>   - v6
>     - Revise i2c duty-cycle for meeting 400khz spec
>   - v5
>     - Support medusa board adc sensors
>     - support NIC eeprom
>   - v4
>     - Re-format gpio linename
>     - Revise i2c device node names
>     - Split patches by logic changes
>   - v3
>     - Correct patch for revising gpio name
>   - v2
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
>   - v1
>     - Add gpio and eeprom behind i2c-mux
>     - Remove redundant idle-state setting for i2c-mux
>     - Enable adc 15, wdt2,spi gpio for yosemite4 use
>     - Revise quad mode to dual mode to avoid WP pin influnece the SPI
>     - Revise power sensor adm1281 for yosemite4 schematic change
>     - Add gpio pca9506 I/O expander for yosemite4 use
>     - remove space for adm1272 compatible
>     - enable interrupt setting for pca9555
>     - add eeprom for yosemite4 medusa board/BSM use
>     - remove temperature sensor for yosemite4 schematic change
>     - add power sensor for power module reading
>     - Revise adc128d818 adc mode for yosemite4 schematic change
>     - Revise ina233 for yosemite4 schematic change
>     - Remove idle state setting for yosemite4 NIC connection
>     - Initialize bmc gpio state
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
> 
> Ricky CX Wu (3):
>   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
>   ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
>   ARM: dts: aspeed: yosemite4: add fan led config
> 
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 706 ++++++++++++++++--
>  1 file changed, 660 insertions(+), 46 deletions(-)
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240909105420.441607-1-Delphine_CC_Chiu at wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 780/i2c-mux at 74/i2c at 0/gpio at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 780/i2c-mux at 74/i2c at 1/gpio at 61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 0/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 1/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 2/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 3/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']






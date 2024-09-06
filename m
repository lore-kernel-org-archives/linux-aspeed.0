From: Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 06 Sep 2024 14:37:42 -0500
Subject: [PATCH v16 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4
In-Reply-To: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172565139933.2035193.3894583401733279611.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 06 Sep 2024 17:24:34 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Changelog:
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
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 650 ++++++++++++++++--
>  1 file changed, 609 insertions(+), 41 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240906092438.1047225-1-Delphine_CC_Chiu at wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:464.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:492.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:519.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:546.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:583.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:610.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:637.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:664.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:702.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:750.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:833.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:859.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:865.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:871.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1110.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1132.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1154.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1176.4-14: Warning (reg_format): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:461.17-487.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:461.17-487.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:489.17-514.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:489.17-514.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:516.17-541.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:516.17-541.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:543.17-568.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:543.17-568.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/i2c-mux at 70/i2c at 3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:580.17-605.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:580.17-605.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:607.17-632.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:607.17-632.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:634.17-659.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:634.17-659.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:661.17-687.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:661.17-687.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 500/i2c-mux at 71/i2c at 3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:699.17-745.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:699.17-745.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:747.17-751.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:747.17-751.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 580/i2c-mux at 74/i2c at 1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:830.17-854.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:830.17-854.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:856.17-860.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:856.17-860.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:862.17-866.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:862.17-866.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:868.17-872.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:868.17-872.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 680/i2c-mux at 70/i2c at 3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1107.17-1127.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1107.17-1127.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1129.17-1149.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1129.17-1149.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1151.17-1171.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1151.17-1171.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1173.17-1193.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1173.17-1193.5: Warning (avoid_default_addr_size): /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 3: Relying on default #size-cells value
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






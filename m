From: kernel test robot <lkp@intel.com>
Date: Mon, 17 Jun 2024 04:04:17 +0800
Subject: [PATCH v1 2/7] ARM: dts: aspeed: Harma: add VR device
In-Reply-To: <20240613152425.1582059-3-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-3-peteryin.openbmc@gmail.com>
Message-ID: <202406170350.zQo7bJdX-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Yin/ARM-dts-aspeed-Harma-revise-hsc-chip/20240613-232915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240613152425.1582059-3-peteryin.openbmc%40gmail.com
patch subject: [PATCH v1 2/7] ARM: dts: aspeed: Harma: add VR device
config: arm-randconfig-051-20240614 (https://download.01.org/0day-ci/archive/20240617/202406170350.zQo7bJdX-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406170350.zQo7bJdX-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170350.zQo7bJdX-lkp at intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:409.21-412.6: Warning (i2c_bus_reg): /ahb/apb/bus at 1e78a000/i2c-bus at 700/i2c-mux at 70/i2c at 0/power-monitor at 63: I2C bus unit address format error, expected "61"
   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:655.36-659.7: Warning (unique_unit_address_if_enabled): /ahb/apb/lpc at 1e789000/reset-controller at 98: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/uart-routing at 98)
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /: spi-gpio: {'status': ['okay'], 'compatible': ['spi-gpio'], '#address-cells': [[1]], '#size-cells': [[0]], 'gpio-sck': [[58, 203, 0]], 'gpio-mosi': [[58, 204, 0]], 'gpio-miso': [[58, 205, 0]], 'num-chipselects': [[1]], 'cs-gpios': [[58, 200, 1]], 'tpmdev at 0': {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': [[33000000]], 'reg': [[0]]}} is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /sdram at 1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
   	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
--
   	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/sdc at 1e740000/sdhci at 1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: serial at 1e78d000: pinctrl-0: True is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: serial at 1e78f000: pinctrl-0: True is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 80/pwm at 5e: failed to match any schema with compatible: ['max31790']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 180/pwm at 5e: failed to match any schema with compatible: ['max31790']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 280/power-monitor at 69: failed to match any schema with compatible: ['pmbus']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 700/i2c-mux at 70/i2c at 0/power-monitor at 61: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 700/i2c-mux at 70/i2c at 0/power-monitor at 62: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 700/i2c-mux at 70/i2c at 0/power-monitor at 63: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus at 1e78a000/i2c-bus at 780/ipmb at 10: failed to match any schema with compatible: ['ipmb-dev']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/dma-controller at 1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: spi-gpio: $nodename:0: 'spi-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#

vim +/61 +409 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

   387	
   388	&i2c13 {
   389		status = "okay";
   390	
   391		i2c-mux at 70 {
   392			compatible = "nxp,pca9545";
   393			reg = <0x70>;
   394			#address-cells = <1>;
   395			#size-cells = <0>;
   396	
   397			imux28: i2c at 0 {
   398				#address-cells = <1>;
   399				#size-cells = <0>;
   400				reg = <0>;
   401				power-monitor at 61 {
   402					compatible = "isil,isl69260";
   403					reg = <0x61>;
   404				};
   405				power-monitor at 62 {
   406					compatible = "isil,isl69260";
   407					reg = <0x62>;
   408				};
 > 409				power-monitor at 63 {
   410					compatible = "isil,isl69260";
   411					reg = <0x61>;
   412				};
   413				power-monitor at 64 {
   414					compatible = "infineon,xdpe152c4";
   415					reg = <0x64>;
   416				};
   417				power-monitor at 66 {
   418					compatible = "infineon,xdpe152c4";
   419					reg = <0x66>;
   420				};
   421				power-monitor at 68 {
   422					compatible = "infineon,xdpe152c4";
   423					reg = <0x68>;
   424				};
   425			};
   426			imux29: i2c at 1 {
   427				#address-cells = <1>;
   428				#size-cells = <0>;
   429				reg = <1>;
   430				//MB FRU
   431				eeprom at 54 {
   432					compatible = "atmel,24c64";
   433					reg = <0x54>;
   434				};
   435			};
   436			imux30: i2c at 2 {
   437				#address-cells = <1>;
   438				#size-cells = <0>;
   439				reg = <2>;
   440			};
   441			imux31: i2c at 3 {
   442				#address-cells = <1>;
   443				#size-cells = <0>;
   444				reg = <3>;
   445			};
   446		};
   447	};
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

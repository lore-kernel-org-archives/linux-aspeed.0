From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 21 Aug 2024 13:31:08 +0930
Subject: [PATCH] ARM: dts: aspeed: Rework APB nodes
Message-ID: <20240821-dt-warnings-apb-nodes-v1-1-c524923acca5@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The way the APB nodes are currently described causes excessive output
from `make dtbs_check` as demonstrated below (approximately 30KB per
devicetree). This stems from nesting the apb nodes under the top-level
ahb nodes, while the simple-bus binding requires that the ahb subnode
names contain a unit address[1].

In the process of cleaning this up, it became apparent that both the
APB descriptions in the devicetree and datasheet were pretty murky.
I followed up with Troy Lee and Ryan Chen, and received the following
from Ryan:

> Sorry, I double confirm with designer.
> AST2400/AST2500/AST2600: 1e6exxxx, 1e6fxxxx, 1e78xxxx, 1e79xxxx : APB,
> others is AHB

As a result, update the Aspeed DTSIs to describe one APB node per
mapping listed in Ryan's response, and lift all controllers that are not
in the described ranges out of the APB nodes to the AHB node.

This change may impact OpenBMC userspace applications that use
devicetree paths in sysfs to identify hardware components. However,
these uses of sysfs were previously identified as incorrect[2][3][4].
Its expected that any affected applications will reworked so they are
not sensitive to node renames.

The change squashes schema warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: ahb: apb: {'compatible': ['simple-bus'], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': True, 'syscon at 1e6e2000': {'compatible': ['aspeed,ast2400-scu', 'syscon', 'simple-mfd'], 'reg': [[510533632, 424]], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 510533632, 4096]], '#clock-cells': [[1]], '#reset-cells': [[1]], 'phandle': [[2]], 'p2a-control at 2c': {'reg': [[44, 4]], 'compatible': ['aspeed,ast2400-p2a-ctrl'], 'status': ['disabled']}, 'silicon-id at 7c': {'compatible': ['aspeed,ast2400-silicon-id', 'aspeed,silicon-id'], 'reg': [[124, 4]]}, 'pinctrl at 80': {'reg': [[128, 24], [160, 16]], 'compatible': ['aspeed,ast2400-pinctrl'], 'phandle': [[7]], 'acpi_default': {'function': ['ACPI'], 'groups': ['ACPI']}, 'adc0_default': {'function': ['ADC0'], 'groups': ['ADC0']}, 'adc1_default': {'function': ['ADC1'], 'groups': ['ADC1']}, 'adc10_default': {'function': ['ADC10'], 'groups': ['ADC10']}, 'adc11_default': {
 'function': ['ADC11'], 'groups': ['ADC11']}, 'adc12_default': {'function': ['ADC12'], 'groups': ['ADC12']}, 'adc13_default': {'function': ['ADC13'], 'groups': ['ADC13']}, 'adc14_default': {'function': ['ADC14'], 'groups': ['ADC14']}, 'adc15_default': {'function': ['ADC15'], 'groups': ['ADC15']}, 'adc2_default': {'function': ['ADC2'], 'groups': ['ADC2']}, 'adc3_default': {'function': ['ADC3'], 'groups': ['ADC3']}, 'adc4_default': {'function': ['ADC4'], 'groups': ['ADC4']}, 'adc5_default': {'function': ['ADC5'], 'groups': ['ADC5']}, 'adc6_default': {'function': ['ADC6'], 'groups': ['ADC6']}, 'adc7_default': {'function': ['ADC7'], 'groups': ['ADC7']}, 'adc8_default': {'function': ['ADC8'], 'groups': ['ADC8']}, 'adc9_default': {'function': ['ADC9'], 'groups': ['ADC9']}, 'bmcint_default': {'function': ['BMCINT'], 'groups': ['BMCINT']}, 'ddcclk_default': {'function': ['DDCCLK'], 'groups': ['DDCCLK']}, 'ddcdat_default': {'function': ['DDCDAT'], 'groups': ['DDCDAT']}, 'extrst_default': {'fu
 nction': ['EXTRST'], 'groups': ['EXTRST']}, 'flack_default': {'function': ['FLACK'], 'groups': ['FLACK']}, 'flbusy_default': {'function': ['FLBUSY'], 'groups': ['FLBUSY']}, 'flwp_default': {'function': ['FLWP'], 'groups': ['FLWP']}, 'gpid_default': {'function': ['GPID'], 'groups': ['GPID']}, 'gpid0_default': {'function': ['GPID0'], 'groups': ['GPID0']}, 'gpid2_default': {'function': ['GPID2'], 'groups': ['GPID2']}, 'gpid4_default': {'function': ['GPID4'], 'groups': ['GPID4']}, 'gpid6_default': {'function': ['GPID6'], 'groups': ['GPID6']}, 'gpie0_default': {'function': ['GPIE0'], 'groups': ['GPIE0']}, 'gpie2_default': {'function': ['GPIE2'], 'groups': ['GPIE2']}, 'gpie4_default': {'function': ['GPIE4'], 'groups': ['GPIE4']}, 'gpie6_default': {'function': ['GPIE6'], 'groups': ['GPIE6']}, 'i2c10_default': {'function': ['I2C10'], 'groups': ['I2C10'], 'phandle': [[24]]}, 'i2c11_default': {'function': ['I2C11'], 'groups': ['I2C11'], 'phandle': [[25]]}, 'i2c12_default': {'function': ['I2C1
 2'], 'groups': ['I2C12'], 'phandle': [[26]]}, 'i2c13_default': {'function': ['I2C13'], 'groups': ['I2C13'], 'phandle': [[27]]}, 'i2c14_default': {'function': ['I2C14'], 'groups': ['I2C14'], 'phandle': [[28]]}, 'i2c3_default': {'function': ['I2C3'], 'groups': ['I2C3'], 'phandle': [[17]]}, 'i2c4_default': {'function': ['I2C4'], 'groups': ['I2C4'], 'phandle': [[18]]}, 'i2c5_default': {'function': ['I2C5'], 'groups': ['I2C5'], 'phandle': [[19]]}, 'i2c6_default': {'function': ['I2C6'], 'groups': ['I2C6'], 'phandle': [[20]]}, 'i2c7_default': {'function': ['I2C7'], 'groups': ['I2C7'], 'phandle': [[21]]}, 'i2c8_default': {'function': ['I2C8'], 'groups': ['I2C8'], 'phandle': [[22]]}, 'i2c9_default': {'function': ['I2C9'], 'groups': ['I2C9'], 'phandle': [[23]]}, 'lpcpd_default': {'function': ['LPCPD'], 'groups': ['LPCPD']}, 'lpcpme_default': {'function': ['LPCPME'], 'groups': ['LPCPME']}, 'lpcrst_default': {'function': ['LPCRST'], 'groups': ['LPCRST']}, 'lpcsmi_default': {'function': ['LPCSMI
 '], 'groups': ['LPCSMI']}, 'mac1link_default': {'function': ['MAC1LINK'], 'groups': ['MAC1LINK']}, 'mac2link_default': {'function': ['MAC2LINK'], 'groups': ['MAC2LINK']}, 'mdio1_default': {'function': ['MDIO1'], 'groups': ['MDIO1']}, 'mdio2_default': {'function': ['MDIO2'], 'groups': ['MDIO2'], 'phandle': [[4]]}, 'ncts1_default': {'function': ['NCTS1'], 'groups': ['NCTS1']}, 'ncts2_default': {'function': ['NCTS2'], 'groups': ['NCTS2']}, 'ncts3_default': {'function': ['NCTS3'], 'groups': ['NCTS3']}, 'ncts4_default': {'function': ['NCTS4'], 'groups': ['NCTS4']}, 'ndcd1_default': {'function': ['NDCD1'], 'groups': ['NDCD1']}, 'ndcd2_default': {'function': ['NDCD2'], 'groups': ['NDCD2']}, 'ndcd3_default': {'function': ['NDCD3'], 'groups': ['NDCD3']}, 'ndcd4_default': {'function': ['NDCD4'], 'groups': ['NDCD4']}, 'ndsr1_default': {'function': ['NDSR1'], 'groups': ['NDSR1']}, 'ndsr2_default': {'function': ['NDSR2'], 'groups': ['NDSR2']}, 'ndsr3_default': {'function': ['NDSR3'], 'groups': [
 'NDSR3']}, 'ndsr4_default': {'function': ['NDSR4'], 'groups': ['NDSR4']}, 'ndtr1_default': {'function': ['NDTR1'], 'groups': ['NDTR1']}, 'ndtr2_default': {'function': ['NDTR2'], 'groups': ['NDTR2']}, 'ndtr3_default': {'function': ['NDTR3'], 'groups': ['NDTR3']}, 'ndtr4_default': {'function': ['NDTR4'], 'groups': ['NDTR4']}, 'ndts4_default': {'function': ['NDTS4'], 'groups': ['NDTS4'], 'phandle': [[15]]}, 'nri1_default': {'function': ['NRI1'], 'groups': ['NRI1']}, 'nri2_default': {'function': ['NRI2'], 'groups': ['NRI2']}, 'nri3_default': {'function': ['NRI3'], 'groups': ['NRI3']}, 'nri4_default': {'function': ['NRI4'], 'groups': ['NRI4']}, 'nrts1_default': {'function': ['NRTS1'], 'groups': ['NRTS1']}, 'nrts2_default': {'function': ['NRTS2'], 'groups': ['NRTS2']}, 'nrts3_default': {'function': ['NRTS3'], 'groups': ['NRTS3']}, 'oscclk_default': {'function': ['OSCCLK'], 'groups': ['OSCCLK']}, 'pwm0_default': {'function': ['PWM0'], 'groups': ['PWM0']}, 'pwm1_default': {'function': ['PWM
 1'], 'groups': ['PWM1']}, 'pwm2_default': {'function': ['PWM2'], 'groups': ['PWM2']}, 'pwm3_default': {'function': ['PWM3'], 'groups': ['PWM3']}, 'pwm4_default': {'function': ['PWM4'], 'groups': ['PWM4']}, 'pwm5_default': {'function': ['PWM5'], 'groups': ['PWM5']}, 'pwm6_default': {'function': ['PWM6'], 'groups': ['PWM6']}, 'pwm7_default': {'function': ['PWM7'], 'groups': ['PWM7']}, 'rgmii1_default': {'function': ['RGMII1'], 'groups': ['RGMII1']}, 'rgmii2_default': {'function': ['RGMII2'], 'groups': ['RGMII2'], 'phandle': [[3]]}, 'rmii1_default': {'function': ['RMII1'], 'groups': ['RMII1']}, 'rmii2_default': {'function': ['RMII2'], 'groups': ['RMII2']}, 'rom16_default': {'function': ['ROM16'], 'groups': ['ROM16']}, 'rom8_default': {'function': ['ROM8'], 'groups': ['ROM8']}, 'romcs1_default': {'function': ['ROMCS1'], 'groups': ['ROMCS1']}, 'romcs2_default': {'function': ['ROMCS2'], 'groups': ['ROMCS2']}, 'romcs3_default': {'function': ['ROMCS3'], 'groups': ['ROMCS3']}, 'romcs4_defaul
 t': {'function': ['ROMCS4'], 'groups': ['ROMCS4']}, 'rxd1_default': {'function': ['RXD1'], 'groups': ['RXD1'], 'phandle': [[10]]}, 'rxd2_default': {'function': ['RXD2'], 'groups': ['RXD2']}, 'rxd3_default': {'function': ['RXD3'], 'groups': ['RXD3'], 'phandle': [[12]]}, 'rxd4_default': {'function': ['RXD4'], 'groups': ['RXD4'], 'phandle': [[14]]}, 'salt1_default': {'function': ['SALT1'], 'groups': ['SALT1']}, 'salt2_default': {'function': ['SALT2'], 'groups': ['SALT2']}, 'salt3_default': {'function': ['SALT3'], 'groups': ['SALT3']}, 'salt4_default': {'function': ['SALT4'], 'groups': ['SALT4']}, 'sd1_default': {'function': ['SD1'], 'groups': ['SD1']}, 'sd2_default': {'function': ['SD2'], 'groups': ['SD2']}, 'sgpmck_default': {'function': ['SGPMCK'], 'groups': ['SGPMCK']}, 'sgpmi_default': {'function': ['SGPMI'], 'groups': ['SGPMI']}, 'sgpmld_default': {'function': ['SGPMLD'], 'groups': ['SGPMLD']}, 'sgpmo_default': {'function': ['SGPMO'], 'groups': ['SGPMO']}, 'sgpsck_default': {'func
 tion': ['SGPSCK'], 'groups': ['SGPSCK']}, 'sgpsi0_default': {'function': ['SGPSI0'], 'groups': ['SGPSI0']}, 'sgpsi1_default': {'function': ['SGPSI1'], 'groups': ['SGPSI1']}, 'sgpsld_default': {'function': ['SGPSLD'], 'groups': ['SGPSLD']}, 'sioonctrl_default': {'function': ['SIOONCTRL'], 'groups': ['SIOONCTRL']}, 'siopbi_default': {'function': ['SIOPBI'], 'groups': ['SIOPBI']}, 'siopbo_default': {'function': ['SIOPBO'], 'groups': ['SIOPBO']}, 'siopwreq_default': {'function': ['SIOPWREQ'], 'groups': ['SIOPWREQ']}, 'siopwrgd_default': {'function': ['SIOPWRGD'], 'groups': ['SIOPWRGD']}, 'sios3_default': {'function': ['SIOS3'], 'groups': ['SIOS3']}, 'sios5_default': {'function': ['SIOS5'], 'groups': ['SIOS5']}, 'siosci_default': {'function': ['SIOSCI'], 'groups': ['SIOSCI']}, 'spi1_default': {'function': ['SPI1'], 'groups': ['SPI1']}, 'spi1debug_default': {'function': ['SPI1DEBUG'], 'groups': ['SPI1DEBUG']}, 'spi1passthru_default': {'function': ['SPI1PASSTHRU'], 'groups': ['SPI1PASSTHRU
 ']}, 'spics1_default': {'function': ['SPICS1'], 'groups': ['SPICS1']}, 'timer3_default': {'function': ['TIMER3'], 'groups': ['TIMER3']}, 'timer4_default': {'function': ['TIMER4'], 'groups': ['TIMER4']}, 'timer5_default': {'function': ['TIMER5'], 'groups': ['TIMER5']}, 'timer6_default': {'function': ['TIMER6'], 'groups': ['TIMER6']}, 'timer7_default': {'function': ['TIMER7'], 'groups': ['TIMER7']}, 'timer8_default': {'function': ['TIMER8'], 'groups': ['TIMER8']}, 'txd1_default': {'function': ['TXD1'], 'groups': ['TXD1'], 'phandle': [[9]]}, 'txd2_default': {'function': ['TXD2'], 'groups': ['TXD2']}, 'txd3_default': {'function': ['TXD3'], 'groups': ['TXD3'], 'phandle': [[11]]}, 'txd4_default': {'function': ['TXD4'], 'groups': ['TXD4'], 'phandle': [[13]]}, 'uart6_default': {'function': ['UART6'], 'groups': ['UART6']}, 'usbcki_default': {'function': ['USBCKI'], 'groups': ['USBCKI']}, 'usb2h_default': {'function': ['USB2H1'], 'groups': ['USB2H1'], 'phandle': [[5]]}, 'usb2d_default': {'fun
 ction': ['USB2D1'], 'groups': ['USB2D1'], 'phandle': [[6]]}, 'vgabios_rom_default': {'function': ['VGABIOS_ROM'], 'groups': ['VGABIOS_ROM']}, 'vgahs_default': {'function': ['VGAHS'], 'groups': ['VGAHS']}, 'vgavs_default': {'function': ['VGAVS'], 'groups': ['VGAVS']}, 'vpi18_default': {'function': ['VPI18'], 'groups': ['VPI18']}, 'vpi24_default': {'function': ['VPI24'], 'groups': ['VPI24']}, 'vpi30_default': {'function': ['VPI30'], 'groups': ['VPI30']}, 'vpo12_default': {'function': ['VPO12'], 'groups': ['VPO12']}, 'vpo24_default': {'function': ['VPO24'], 'groups': ['VPO24']}, 'wdtrst1_default': {'function': ['WDTRST1'], 'groups': ['WDTRST1']}, 'wdtrst2_default': {'function': ['WDTRST2'], 'groups': ['WDTRST2']}}}, 'hwrng at 1e6e2078': {'compatible': ['timeriomem_rng'], 'reg': [[510533752, 4]], 'period': [[1]], 'quality': [[100]]}, 'adc at 1e6e9000': {'compatible': ['aspeed,ast2400-adc'], 'reg': [[510562304, 176]], 'clocks': [[2, 26]], 'resets': [[2, 2]], '#io-channel-cells': [[1]], 'status
 ': ['okay'], 'phandle': [[29]]}, 'sram at 1e720000': {'compatible': ['mmio-sram'], 'reg': [[510787584, 32768]]}, 'video at 1e700000': {'compatible': ['aspeed,ast2400-video-engine'], 'reg': [[510656512, 4096]], 'clocks': [[2, 3], [2, 0]], 'clock-names': ['vclk', 'eclk'], 'interrupts': [[7]], 'status': ['disabled']}, 'sd-controller at 1e740000': {'compatible': ['aspeed,ast2400-sd-controller'], 'reg': [[510918656, 256]], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 510918656, 65536]], 'clocks': [[2, 22]], 'status': ['disabled'], 'sdhci at 100': {'compatible': ['aspeed,ast2400-sdhci'], 'reg': [[256, 256]], 'interrupts': [[26]], 'sdhci,auto-cmd12': True, 'clocks': [[2, 28]], 'status': ['disabled']}, 'sdhci at 200': {'compatible': ['aspeed,ast2400-sdhci'], 'reg': [[512, 256]], 'interrupts': [[26]], 'sdhci,auto-cmd12': True, 'clocks': [[2, 28]], 'status': ['disabled']}}, 'gpio at 1e780000': {'#gpio-cells': [[2]], 'gpio-controller': True, 'compatible': ['aspeed,ast2400-gpio'], 'reg': [[51118
 0800, 4096]], 'interrupts': [[20]], 'gpio-ranges': [[7, 0, 0, 220]], 'clocks': [[2, 26]], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'timer at 1e782000': {'compatible': ['aspeed,ast2400-timer'], 'reg': [[511188992, 144]], 'interrupts': [[16], [17], [18], [35], [36], [37], [38], [39]], 'clocks': [[2, 26]], 'clock-names': ['PCLK']}, 'rtc at 1e781000': {'compatible': ['aspeed,ast2400-rtc'], 'reg': [[511184896, 24]], 'status': ['disabled']}, 'serial at 1e783000': {'compatible': ['ns16550a'], 'reg': [[511193088, 32]], 'reg-shift': [[2]], 'interrupts': [[9]], 'clocks': [[2, 13]], 'resets': [[8, 4]], 'no-loopback-test': True, 'status': ['okay'], 'pinctrl-names': ['default'], 'pinctrl-0': [[9, 10]]}, 'serial at 1e784000': {'compatible': ['ns16550a'], 'reg': [[511197184, 32]], 'reg-shift': [[2]], 'interrupts': [[10]], 'clocks': [[2, 15]], 'no-loopback-test': True, 'status': ['okay']}, 'watchdog at 1e785000': {'compatible': ['aspeed,ast2400-wdt'], 'reg': [[511201280, 28]], 'clocks': [[2, 26]]
 , 'status': ['okay'], 'aspeed,reset-type': ['system']}, 'watchdog at 1e785020': {'compatible': ['aspeed,ast2400-wdt'], 'reg': [[511201312, 28]], 'clocks': [[2, 26]], 'status': ['okay'], 'aspeed,reset-type': ['system']}, 'pwm-tacho-controller at 1e786000': {'compatible': ['aspeed,ast2400-pwm-tacho'], '#address-cells': [[1]], '#size-cells': [[0]], 'reg': [[511205376, 4096]], 'clocks': [[2, 35]], 'resets': [[2, 5]], 'status': ['disabled']}, 'serial at 1e787000': {'compatible': ['aspeed,ast2400-vuart'], 'reg': [[511209472, 64]], 'reg-shift': [[2]], 'interrupts': [[8]], 'clocks': [[2, 26]], 'no-loopback-test': True, 'status': ['disabled']}, 'lpc at 1e789000': {'compatible': ['aspeed,ast2400-lpc-v2', 'simple-mfd', 'syscon'], 'reg': [[511217664, 4096]], 'reg-io-width': [[4]], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 511217664, 4096]], 'lpc-ctrl at 80': {'compatible': ['aspeed,ast2400-lpc-ctrl'], 'reg': [[128, 16]], 'clocks': [[2, 8]], 'status': ['disabled']}, 'lpc-snoop at 90': {'compat
 ible': ['aspeed,ast2400-lpc-snoop'], 'reg': [[144, 8]], 'interrupts': [[8]], 'clocks': [[2, 8]], 'status': ['disabled']}, 'lhc at a0': {'compatible': ['aspeed,ast2400-lhc'], 'reg': [[160, 36], [200, 8]]}, 'reset-controller at 98': {'compatible': ['aspeed,ast2400-lpc-reset'], 'reg': [[152, 4]], '#reset-cells': [[1]], 'phandle': [[8]]}, 'ibt at 140': {'compatible': ['aspeed,ast2400-ibt-bmc'], 'reg': [[320, 24]], 'interrupts': [[8]], 'clocks': [[2, 8]], 'status': ['disabled']}, 'uart-routing at 9c': {'compatible': ['aspeed,ast2400-uart-routing'], 'reg': [[156, 4]], 'status': ['disabled']}}, 'peci-controller at 1e78b000': {'compatible': ['aspeed,ast2400-peci'], 'reg': [[511225856, 96]], 'interrupts': [[15]], 'clocks': [[2, 6]], 'resets': [[2, 6]], 'cmd-timeout-ms': [[1000]], 'clock-frequency': [[1000000]], 'status': ['disabled']}, 'serial at 1e78d000': {'compatible': ['ns16550a'], 'reg': [[511234048, 32]], 'reg-shift': [[2]], 'interrupts': [[32]], 'clocks': [[2, 14]], 'resets': [[8, 5]], 'no-loopback-tes
 t': True, 'status': ['disabled']}, 'serial at 1e78e000': {'compatible': ['ns16550a'], 'reg': [[511238144, 32]], 'reg-shift': [[2]], 'interrupts': [[33]], 'clocks': [[2, 20]], 'resets': [[8, 6]], 'no-loopback-test': True, 'status': ['okay'], 'pinctrl-names': ['default'], 'pinctrl-0': [[11, 12]]}, 'serial at 1e78f000': {'compatible': ['ns16550a'], 'reg': [[511242240, 32]], 'reg-shift': [[2]], 'interrupts': [[34]], 'clocks': [[2, 21]], 'resets': [[8, 7]], 'no-loopback-test': True, 'status': ['okay'], 'pinctrl-names': ['default'], 'pinctrl-0': [[13, 14, 15]]}, 'bus at 1e78a000': {'compatible': ['simple-bus'], '#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 511221760, 4096]], 'interrupt-controller at 0': {'#interrupt-cells': [[1]], 'compatible': ['aspeed,ast2400-i2c-ic'], 'reg': [[0, 64]], 'interrupts': [[12]], 'interrupt-controller': True, 'phandle': [[16]]}, 'i2c-bus at 40': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[64, 64]], 'compatible': ['asp
 eed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[0]], 'interrupt-parent': [[16]], 'status': ['okay']}, 'i2c-bus at 80': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[128, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[1]], 'interrupt-parent': [[16]], 'status': ['okay']}, 'i2c-bus at c0': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[192, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[2]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[17]], 'status': ['okay']}, 'i2c-bus at 100': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[256, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-fre
 quency': [[100000]], 'interrupts': [[3]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[18]], 'status': ['okay']}, 'i2c-bus at 140': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[320, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[4]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[19]], 'status': ['okay']}, 'i2c-bus at 180': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[384, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[5]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[20]], 'status': ['okay']}, 'i2c-bus at 1c0': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[448, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26
 ]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[6]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[21]], 'status': ['okay']}, 'i2c-bus at 300': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[768, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[7]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[22]], 'status': ['okay']}, 'i2c-bus at 340': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[832, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[8]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[23]], 'status': ['okay']}, 'i2c-bus at 380': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[896, 64]], 'compatible': ['aspeed,ast2
 400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[9]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[24]], 'status': ['okay']}, 'i2c-bus at 3c0': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[960, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[10]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[25]], 'status': ['disabled']}, 'i2c-bus at 400': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[1024, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[11]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[26]], 'status': ['okay']}, 'i2c-bus at 440': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [
 [1088, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[12]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[27]], 'status': ['okay']}, 'i2c-bus at 480': {'#address-cells': [[1]], '#size-cells': [[0]], '#interrupt-cells': [[1]], 'reg': [[1152, 64]], 'compatible': ['aspeed,ast2400-i2c-bus'], 'clocks': [[2, 26]], 'resets': [[2, 7]], 'bus-frequency': [[100000]], 'interrupts': [[13]], 'interrupt-parent': [[16]], 'pinctrl-names': ['default'], 'pinctrl-0': [[28]], 'status': ['disabled']}}} should not be valid under {'type': 'object'}

Cc: Andrew Geissler <geissonator@yahoo.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Troy Lee <troy_lee@aspeedtech.com>
Link: https://github.com/devicetree-org/dt-schema/blob/c51125d571cac9596048e888a856d70650e400e0/dtschema/schemas/simple-bus.yaml#L35-L36 [1]
Link: https://github.com/openbmc/phosphor-state-manager/issues/27 [2]
Link: https://lore.kernel.org/all/20240531193115.3814887-1-robh at kernel.org/ [3]
Link: https://lore.kernel.org/all/8dabf3d1-2d23-4adc-a804-2b7aa5fe16e9 at kernel.org/ [4]
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
If there are alternative approaches then I'm interested in hearing about
them, but from what I can see we're going to have a bit of turbulence
for some OpenBMC userspace no matter what.
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi |  93 +++++++-----
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 109 ++++++++------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 249 ++++++++++++++++++--------------
 3 files changed, 251 insertions(+), 200 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 78c967812492..7b1982c116f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -179,8 +179,9 @@ vhub: usb-vhub at 1e6a0000 {
 			status = "disabled";
 		};
 
-		apb {
+		apb at 1e6e0000 {
 			compatible = "simple-bus";
+			reg = <0x1e6e0000 0x00010000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -226,52 +227,62 @@ adc: adc at 1e6e9000 {
 				#io-channel-cells = <1>;
 				status = "disabled";
 			};
+		};
 
-			sram: sram at 1e720000 {
-				compatible = "mmio-sram";
-				reg = <0x1e720000 0x8000>;	// 32K
-				ranges;
-				#address-cells = <1>;
-				#size-cells = <1>;
-			};
+		/* There's another APB mapping at 0x1e6f0000 for 0x00010000 */
+
+		sram: sram at 1e720000 {
+			compatible = "mmio-sram";
+			reg = <0x1e720000 0x8000>;	// 32K
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		video: video at 1e700000 {
+			compatible = "aspeed,ast2400-video-engine";
+			reg = <0x1e700000 0x1000>;
+			clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+				 <&syscon ASPEED_CLK_GATE_ECLK>;
+			clock-names = "vclk", "eclk";
+			interrupts = <7>;
+			status = "disabled";
+		};
+
+		sdmmc: sd-controller at 1e740000 {
+			compatible = "aspeed,ast2400-sd-controller";
+			reg = <0x1e740000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1e740000 0x10000>;
+			clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+			status = "disabled";
 
-			video: video at 1e700000 {
-				compatible = "aspeed,ast2400-video-engine";
-				reg = <0x1e700000 0x1000>;
-				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
-					 <&syscon ASPEED_CLK_GATE_ECLK>;
-				clock-names = "vclk", "eclk";
-				interrupts = <7>;
+			sdhci0: sdhci at 100 {
+				compatible = "aspeed,ast2400-sdhci";
+				reg = <0x100 0x100>;
+				interrupts = <26>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
 				status = "disabled";
 			};
 
-			sdmmc: sd-controller at 1e740000 {
-				compatible = "aspeed,ast2400-sd-controller";
-				reg = <0x1e740000 0x100>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1e740000 0x10000>;
-				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+			sdhci1: sdhci at 200 {
+				compatible = "aspeed,ast2400-sdhci";
+				reg = <0x200 0x100>;
+				interrupts = <26>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
 				status = "disabled";
-
-				sdhci0: sdhci at 100 {
-					compatible = "aspeed,ast2400-sdhci";
-					reg = <0x100 0x100>;
-					interrupts = <26>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
-
-				sdhci1: sdhci at 200 {
-					compatible = "aspeed,ast2400-sdhci";
-					reg = <0x200 0x100>;
-					interrupts = <26>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
 			};
+		};
+
+		apb at 1e780000 {
+			compatible = "simple-bus";
+			reg = <0x1e780000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
 			gpio: gpio at 1e780000 {
 				#gpio-cells = <2>;
@@ -454,6 +465,8 @@ i2c: bus at 1e78a000 {
 				ranges = <0 0x1e78a000 0x1000>;
 			};
 		};
+
+		/* There's another APB mapping at 0x1e790000 for 0x00010000 */
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 57a699a7c149..c4d7986cd357 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -207,8 +207,9 @@ vhub: usb-vhub at 1e6a0000 {
 			status = "disabled";
 		};
 
-		apb {
+		apb at 1e6e0000 {
 			compatible = "simple-bus";
+			reg = <0x1e6e0000 0x00010000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -289,53 +290,63 @@ adc: adc at 1e6e9000 {
 				#io-channel-cells = <1>;
 				status = "disabled";
 			};
+		};
 
-			video: video at 1e700000 {
-				compatible = "aspeed,ast2500-video-engine";
-				reg = <0x1e700000 0x1000>;
-				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
-					 <&syscon ASPEED_CLK_GATE_ECLK>;
-				clock-names = "vclk", "eclk";
-				interrupts = <7>;
-				status = "disabled";
-			};
+		/* There's another APB mapping at 0x1e6f0000 for 0x00010000 */
 
-			sram: sram at 1e720000 {
-				compatible = "mmio-sram";
-				reg = <0x1e720000 0x9000>;	// 36K
-				ranges;
-				#address-cells = <1>;
-				#size-cells = <1>;
-			};
+		video: video at 1e700000 {
+			compatible = "aspeed,ast2500-video-engine";
+			reg = <0x1e700000 0x1000>;
+			clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+				 <&syscon ASPEED_CLK_GATE_ECLK>;
+			clock-names = "vclk", "eclk";
+			interrupts = <7>;
+			status = "disabled";
+		};
 
-			sdmmc: sd-controller at 1e740000 {
-				compatible = "aspeed,ast2500-sd-controller";
-				reg = <0x1e740000 0x100>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1e740000 0x10000>;
-				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
-				status = "disabled";
+		sram: sram at 1e720000 {
+			compatible = "mmio-sram";
+			reg = <0x1e720000 0x9000>;	// 36K
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 
-				sdhci0: sdhci at 100 {
-					compatible = "aspeed,ast2500-sdhci";
-					reg = <0x100 0x100>;
-					interrupts = <26>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
+		sdmmc: sd-controller at 1e740000 {
+			compatible = "aspeed,ast2500-sd-controller";
+			reg = <0x1e740000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1e740000 0x10000>;
+			clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+			status = "disabled";
 
-				sdhci1: sdhci at 200 {
-					compatible = "aspeed,ast2500-sdhci";
-					reg = <0x200 0x100>;
-					interrupts = <26>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
+			sdhci0: sdhci at 100 {
+				compatible = "aspeed,ast2500-sdhci";
+				reg = <0x100 0x100>;
+				interrupts = <26>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
+				status = "disabled";
 			};
 
+			sdhci1: sdhci at 200 {
+				compatible = "aspeed,ast2500-sdhci";
+				reg = <0x200 0x100>;
+				interrupts = <26>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
+				status = "disabled";
+			};
+		};
+
+		apb at 1e780000 {
+			compatible = "simple-bus";
+			reg = <0x1e780000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
 			gpio: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
@@ -521,6 +532,13 @@ ibt: ibt at 140 {
 				};
 			};
 
+			i2c: bus at 1e78a000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e78a000 0x1000>;
+			};
+
 			peci0: peci-controller at 1e78b000 {
 				compatible = "aspeed,ast2500-peci";
 				reg = <0x1e78b000 0x60>;
@@ -564,14 +582,9 @@ uart4: serial at 1e78f000 {
 				no-loopback-test;
 				status = "disabled";
 			};
-
-			i2c: bus at 1e78a000 {
-				compatible = "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1e78a000 0x1000>;
-			};
 		};
+
+		/* There's another APB mapping at 0x1e790000 for 0x00010000 */
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..88e719cc19bb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -318,20 +318,21 @@ udc: usb at 1e6a2000 {
 			status = "disabled";
 		};
 
-		apb {
+		hace: crypto at 1e6d0000 {
+			compatible = "aspeed,ast2600-hace";
+			reg = <0x1e6d0000 0x200>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+			resets = <&syscon ASPEED_RESET_HACE>;
+		};
+
+		apb at 1e6e0000 {
 			compatible = "simple-bus";
+			reg = <0x1e6e0000 0x00010000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-			hace: crypto at 1e6d0000 {
-				compatible = "aspeed,ast2600-hace";
-				reg = <0x1e6d0000 0x200>;
-				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
-				resets = <&syscon ASPEED_RESET_HACE>;
-			};
-
 			syscon: syscon at 1e6e2000 {
 				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1000>;
@@ -409,6 +410,14 @@ adc1: adc at 1e6e9100 {
 				#io-channel-cells = <1>;
 				status = "disabled";
 			};
+		};
+
+		apb at 1e6f0000 {
+			compatible = "simple-bus";
+			reg = <0x1e6f0000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
 			sbc: secure-boot-controller at 1e6f2000 {
 				compatible = "aspeed,ast2600-sbc";
@@ -422,17 +431,73 @@ acry: crypto at 1e6fa000 {
 				clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
 				aspeed,ahbc = <&ahbc>;
 			};
+		};
+
+		video: video at 1e700000 {
+			compatible = "aspeed,ast2600-video-engine";
+			reg = <0x1e700000 0x1000>;
+			clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+				 <&syscon ASPEED_CLK_GATE_ECLK>;
+			clock-names = "vclk", "eclk";
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sdc: sdc at 1e740000 {
+			compatible = "aspeed,ast2600-sd-controller";
+			reg = <0x1e740000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1e740000 0x10000>;
+			clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+			status = "disabled";
 
-			video: video at 1e700000 {
-				compatible = "aspeed,ast2600-video-engine";
-				reg = <0x1e700000 0x1000>;
-				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
-					 <&syscon ASPEED_CLK_GATE_ECLK>;
-				clock-names = "vclk", "eclk";
-				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			sdhci0: sdhci at 1e740100 {
+				compatible = "aspeed,ast2600-sdhci", "sdhci";
+				reg = <0x100 0x100>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
 				status = "disabled";
 			};
 
+			sdhci1: sdhci at 1e740200 {
+				compatible = "aspeed,ast2600-sdhci", "sdhci";
+				reg = <0x200 0x100>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon ASPEED_CLK_SDIO>;
+				status = "disabled";
+			};
+		};
+
+		emmc_controller: sdc at 1e750000 {
+			compatible = "aspeed,ast2600-sd-controller";
+			reg = <0x1e750000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1e750000 0x10000>;
+			clocks = <&syscon ASPEED_CLK_GATE_EMMCCLK>;
+			status = "disabled";
+
+			emmc: sdhci at 1e750100 {
+				compatible = "aspeed,ast2600-sdhci";
+				reg = <0x100 0x100>;
+				sdhci,auto-cmd12;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_EMMC>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_emmc_default>;
+			};
+		};
+
+		apb at 1e780000 {
+			compatible = "simple-bus";
+			reg = <0x1e780000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
 			gpio0: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
@@ -558,14 +623,43 @@ wdt4: watchdog at 1e7850c0 {
 				status = "disabled";
 			};
 
-			peci0: peci-controller at 1e78b000 {
-				compatible = "aspeed,ast2600-peci";
-				reg = <0x1e78b000 0x100>;
-				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
-				resets = <&syscon ASPEED_RESET_PECI>;
-				cmd-timeout-ms = <1000>;
-				clock-frequency = <1000000>;
+			vuart1: serial at 1e787000 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e787000 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB1>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			vuart3: serial at 1e787800 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e787800 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			vuart2: serial at 1e788000 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e788000 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB1>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			vuart4: serial at 1e788800 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e788800 0x40>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				no-loopback-test;
 				status = "disabled";
 			};
 
@@ -652,91 +746,21 @@ ibt: ibt at 140 {
 				};
 			};
 
-			sdc: sdc at 1e740000 {
-				compatible = "aspeed,ast2600-sd-controller";
-				reg = <0x1e740000 0x100>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1e740000 0x10000>;
-				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
-				status = "disabled";
-
-				sdhci0: sdhci at 1e740100 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
-					reg = <0x100 0x100>;
-					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
-
-				sdhci1: sdhci at 1e740200 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
-					reg = <0x200 0x100>;
-					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-					sdhci,auto-cmd12;
-					clocks = <&syscon ASPEED_CLK_SDIO>;
-					status = "disabled";
-				};
-			};
-
-			emmc_controller: sdc at 1e750000 {
-				compatible = "aspeed,ast2600-sd-controller";
-				reg = <0x1e750000 0x100>;
+			i2c: bus at 1e78a000 {
+				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0x1e750000 0x10000>;
-				clocks = <&syscon ASPEED_CLK_GATE_EMMCCLK>;
-				status = "disabled";
-
-				emmc: sdhci at 1e750100 {
-					compatible = "aspeed,ast2600-sdhci";
-					reg = <0x100 0x100>;
-					sdhci,auto-cmd12;
-					interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&syscon ASPEED_CLK_EMMC>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_emmc_default>;
-				};
-			};
-
-			vuart1: serial at 1e787000 {
-				compatible = "aspeed,ast2500-vuart";
-				reg = <0x1e787000 0x40>;
-				reg-shift = <2>;
-				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_APB1>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
-			vuart3: serial at 1e787800 {
-				compatible = "aspeed,ast2500-vuart";
-				reg = <0x1e787800 0x40>;
-				reg-shift = <2>;
-				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_APB2>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
-			vuart2: serial at 1e788000 {
-				compatible = "aspeed,ast2500-vuart";
-				reg = <0x1e788000 0x40>;
-				reg-shift = <2>;
-				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_APB1>;
-				no-loopback-test;
-				status = "disabled";
+				ranges = <0 0x1e78a000 0x1000>;
 			};
 
-			vuart4: serial at 1e788800 {
-				compatible = "aspeed,ast2500-vuart";
-				reg = <0x1e788800 0x40>;
-				reg-shift = <2>;
-				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&syscon ASPEED_CLK_APB2>;
-				no-loopback-test;
+			peci0: peci-controller at 1e78b000 {
+				compatible = "aspeed,ast2600-peci";
+				reg = <0x1e78b000 0x100>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				cmd-timeout-ms = <1000>;
+				clock-frequency = <1000000>;
 				status = "disabled";
 			};
 
@@ -781,6 +805,14 @@ uart4: serial at 1e78f000 {
 				pinctrl-0 = <&pinctrl_txd4_default &pinctrl_rxd4_default>;
 				status = "disabled";
 			};
+		};
+
+		apb at 1e790000 {
+			compatible = "simple-bus";
+			reg = <0x1e790000 0x00010000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 
 			uart6: serial at 1e790000 {
 				compatible = "ns16550a";
@@ -838,13 +870,6 @@ uart9: serial at 1e790300 {
 				status = "disabled";
 			};
 
-			i2c: bus at 1e78a000 {
-				compatible = "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x1e78a000 0x1000>;
-			};
-
 			fsim0: fsi at 1e79b000 {
 				#interrupt-cells = <1>;
 				compatible = "aspeed,ast2600-fsi-master", "fsi-master";

---
base-commit: 6152cce5900f9cc70e62dabafa9c8b74db2d2e38
change-id: 20240821-dt-warnings-apb-nodes-3bd83b27c08c

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


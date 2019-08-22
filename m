From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Aug 2019 11:28:09 +0930
Subject: [PATCH 5/7] ARM: dts: aspeed: Add AST2600 and EVB
In-Reply-To: <20190821055530.8720-6-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
 <20190821055530.8720-6-joel@jms.id.au>
Message-ID: <b1527d8e-4def-4769-b85a-142aa4d99f03@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 21 Aug 2019, at 15:26, Joel Stanley wrote:
> The AST2600 is a new SoC by ASPEED. It contains a dual core Cortex A7
> CPU and shares many periperhals with the existing AST2400 and AST2500.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts |  44 ++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 266 +++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb.dts
>  create mode 100644 arch/arm/boot/dts/aspeed-g6.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 247e556de48e..2d8d29e5686d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1276,6 +1276,7 @@ dtb-$(CONFIG_ARCH_MILBEAUT) += 
> milbeaut-m10v-evb.dtb
>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>  dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2500-evb.dtb \
> +	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-arm-centriq2400-rep.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-facebook-cmm.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> new file mode 100644
> index 000000000000..7f2528e084b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 IBM Corp.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +	model = "AST2600 EVB";
> +	compatible = "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";
> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +};
> +
> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac1 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy1>;
> +};
> +
> +&emmc {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi 
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> new file mode 100644
> index 000000000000..9f9931541060
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2019 IBM Corp.
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/ast2600-clock.h>
> +
> +/ {
> +	model = "Aspeed BMC";
> +	compatible = "aspeed,ast2600";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "aspeed,ast2600-smp";
> +
> +		cpu at f00 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf00>;
> +		};
> +
> +		cpu at f01 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf01>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | 
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +		clocks = <&syscon ASPEED_CLK_HPLL>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	ahb {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges;
> +
> +		gic: interrupt-controller at 40461000 {
> +			compatible = "arm,cortex-a7-gic";
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | 
> IRQ_TYPE_LEVEL_HIGH)>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			reg = <0x40461000 0x1000>,
> +			    <0x40462000 0x1000>,
> +			    <0x40464000 0x2000>,
> +			    <0x40466000 0x2000>;
> +			};
> +
> +		mdio0: mdio at 1e650000 {
> +			compatible = "aspeed,ast2600-mdio";
> +			reg = <0x1e650000 0x8>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mdio1: mdio at 1e650008 {
> +			compatible = "aspeed,ast2600-mdio";
> +			reg = <0x1e650008 0x8>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mdio2: mdio at 1e650010 {
> +			compatible = "aspeed,ast2600-mdio";
> +			reg = <0x1e650010 0x8>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mdio3: mdio at 1e650018 {
> +			compatible = "aspeed,ast2600-mdio";
> +			reg = <0x1e650018 0x8>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mac0: ftgmac at 1e660000 {
> +			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
> +			reg = <0x1e660000 0x180>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
> +			status = "disabled";
> +		};
> +
> +		mac1: ftgmac at 1e680000 {
> +			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
> +			reg = <0x1e680000 0x180>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
> +			status = "disabled";
> +		};
> +
> +		mac2: ftgmac at 1e670000 {
> +			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
> +			reg = <0x1e670000 0x180>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
> +			status = "disabled";
> +		};
> +
> +		mac3: ftgmac at 1e690000 {
> +			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
> +			reg = <0x1e690000 0x180>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
> +			status = "disabled";
> +		};
> +
> +		apb {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon: syscon at 1e6e2000 {
> +				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
> +				reg = <0x1e6e2000 0x1000>;
> +				ranges = <0 0x1e6e2000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#clock-cells = <1>;
> +				#reset-cells = <1>;
> +
> +				pinctrl: pinctrl {
> +					compatible = "aspeed,ast2600-pinctrl";
> +				};
> +
> +				smp-memram at 180 {
> +					compatible = "aspeed,ast2600-smpmem";
> +					reg = <0x180 0x40>;
> +				};
> +			};
> +
> +			rng: hwrng at 1e6e2524 {
> +				compatible = "timeriomem_rng";
> +				reg = <0x1e6e2524 0x4>;
> +				period = <1>;
> +				quality = <100>;
> +			};
> +
> +			rtc: rtc at 1e781000 {
> +				compatible = "aspeed,ast2600-rtc";
> +				reg = <0x1e781000 0x18>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			uart5: serial at 1e784000 {
> +				compatible = "ns16550a";
> +				reg = <0x1e784000 0x1000>;
> +				reg-shift = <2>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&syscon ASPEED_CLK_GATE_UART5CLK>;
> +				no-loopback-test;
> +			};
> +
> +			wdt1: watchdog at 1e785000 {
> +				compatible = "aspeed,ast2600-wdt";
> +				reg = <0x1e785000 0x40>;
> +			};
> +
> +			wdt2: watchdog at 1e785040 {
> +				compatible = "aspeed,ast2600-wdt";
> +				reg = <0x1e785040 0x40>;
> +				status = "disabled";
> +			};
> +
> +			wdt3: watchdog at 1e785080 {
> +				compatible = "aspeed,ast2600-wdt";
> +				reg = <0x1e785080 0x40>;
> +				status = "disabled";
> +			};
> +
> +			wdt4: watchdog at 1e7850C0 {
> +				compatible = "aspeed,ast2600-wdt";
> +				reg = <0x1e7850C0 0x40>;
> +				status = "disabled";
> +			};
> +
> +			sdc: sdc at 1e740000 {
> +				compatible = "aspeed,ast2600-sd-controller";
> +				reg = <0x1e740000 0x100>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x1e740000 0x10000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +				status = "disabled";
> +
> +				sdhci0: sdhci at 1e740100 {
> +					compatible = "aspeed,ast2600-sdhci", "sdhci";
> +					reg = <0x100 0x100>;
> +					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +					sdhci,auto-cmd12;
> +					clocks = <&syscon ASPEED_CLK_SDIO>;
> +					status = "disabled";
> +				};
> +
> +				sdhci1: sdhci at 1e740200 {
> +					compatible = "aspeed,ast2600-sdhci", "sdhci";
> +					reg = <0x200 0x100>;
> +					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +					sdhci,auto-cmd12;
> +					clocks = <&syscon ASPEED_CLK_SDIO>;
> +					status = "disabled";
> +				};
> +			};
> +
> +			emmc: sdc at 1e750000 {
> +				compatible = "aspeed,ast2600-sd-controller";
> +				reg = <0x1e750000 0x100>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x1e750000 0x10000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_EMMCCLK>;
> +				status = "disabled";
> +
> +				sdhci at 1e750100 {
> +					compatible = "aspeed,ast2600-sdhci";
> +					reg = <0x100 0x100>;
> +					sdhci,auto-cmd12;
> +					interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&syscon ASPEED_CLK_EMMC>;
> +					pinctrl-names = "default";
> +					pinctrl-0 = <&pinctrl_emmc_default>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl_emmc_default: emmc_default {
> +		function = "SD3";
> +		groups = "SD3";
> +	};

I need to send some fixes for pinmux along with the dt patche, but this
will do for the moment.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

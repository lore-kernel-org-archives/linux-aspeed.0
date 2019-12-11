From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 14:18:45 +1030
Subject: [PATCH v2 09/12] ARM: dts: aspeed: ast2600: Add XDMA Engine
In-Reply-To: <1575566112-11658-10-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-10-git-send-email-eajames@linux.ibm.com>
Message-ID: <5086ee4b-bddb-40c1-9841-005b233f837b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Add a node for the XDMA engine with all the necessary information. Also
> add a simple syscon node for the SDRAM memory controller.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Add a syscon SDRAM controller
>  - Add various properties to XDMA node
> 
>  arch/arm/boot/dts/aspeed-g6.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index ead336e..514d685 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/ast2600-clock.h>
> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>  
>  / {
>  	model = "Aspeed BMC";
> @@ -265,6 +266,11 @@
>  			status = "disabled";
>  		};
>  
> +		sdmc: sdram at 1e6e0000 {
> +			compatible = "syscon";
> +			reg = <0x1e6e0000 0xb8>;
> +		};
> +

Hopefully we can drop this. We also need to figure out how whatever the solution is interacts
with the EDAC driver.

>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -311,6 +317,19 @@
>  				quality = <100>;
>  			};
>  
> +			xdma: xdma at 1e6e7000 {
> +				compatible = "aspeed,ast2600-xdma";
> +				reg = <0x1e6e7000 0x100>;
> +				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +				resets = <&syscon ASPEED_RESET_DEV_XDMA>;
> +				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
> +				pcie-device = "bmc";
> +				scu = <&syscon>;
> +				sdmc = <&sdmc>;

sdmc property should go away also.

> +				status = "disabled";
> +			};
> +
>  			gpio0: gpio at 1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 1.8.3.1
> 
>

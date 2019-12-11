From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 11:10:45 +1030
Subject: [PATCH v2 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <1575566112-11658-6-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-6-git-send-email-eajames@linux.ibm.com>
Message-ID: <6be1f1d3-8d85-4363-938d-1265e9f95d6f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v1:
>  - Add 'clocks', 'scu', 'sdmc', 'vga-mem', and 'pcie-device' property
>    documentation
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt        | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 0000000..942dc07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,43 @@
> +Aspeed AST25XX and AST26XX XDMA Engine
> +
> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform 
> automatic
> +DMA operations over PCI between the SOC (acting as a BMC) and a host 
> processor.
> +
> +Required properties:
> + - compatible		: must be "aspeed,ast2500-xdma" or
> +			  "aspeed,ast2600-xdma"
> + - reg			: contains the address and size of the memory region
> +			  associated with the XDMA engine registers
> + - clocks		: clock specifier for the clock associated with the
> +			  XDMA engine
> + - resets		: reset specifier for the syscon reset associated with
> +			  the XDMA engine
> + - interrupts-extended	: two interrupt nodes; the first specifies the 

s/nodes/cells/?

> global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - scu			: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - sdmc			: a phandle to the syscon node for the SDRAM memory
> +			  controller of the SOC

This is a driver and is unrelated to the XDMA hardware. I think we can avoid
touching the SDMC in the XDMA driver anyway (it should be up to the
platform configuration to make sure the remapping is set correctly, not a
behaviour of the XDMA driver).

> + - vga-mem		: contains the address and size of the VGA memory space
> +			  to be used by the XDMA engine

Shouldn't we generalise this to just a 'memory' property? It doesn't have to
be the VGA memory, just we tend to use the VGA memory to uphold security
properties of our platforms.

> +
> +Optional properties:
> + - pcie-device		: should be either "bmc" or "vga", corresponding to
> +			  which device should be used by the XDMA engine for
> +			  DMA operations. If this property is not set, the XDMA
> +			  engine will use the BMC PCI-E device.
> +
> +Example:
> +
> +    xdma at 1e6e7000 {
> +        compatible = "aspeed,ast2500-xdma";
> +        reg = <0x1e6e7000 0x100>;
> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +        resets = <&syscon ASPEED_RESET_XDMA>;
> +        interrupts-extended = <&vic 6>, <&scu_ic 
> ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
> +        scu = <&syscon>;
> +        sdmc = <&edac>;
> +        pcie-device = "bmc";
> +        vga-mem = <0x9f000000 0x01000000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 398861a..528a142 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2707,6 +2707,12 @@ S:	Maintained
>  F:	drivers/media/platform/aspeed-video.c
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  
> +ASPEED XDMA ENGINE DRIVER
> +M:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user at lists.sourceforge.net
> -- 
> 1.8.3.1
> 
>

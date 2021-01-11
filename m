From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Jan 2021 14:38:50 -0600
Subject: [PATCH v4 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <20201229063157.3587-2-chiawei_wang@aspeedtech.com>
References: <20201229063157.3587-1-chiawei_wang@aspeedtech.com>
 <20201229063157.3587-2-chiawei_wang@aspeedtech.com>
Message-ID: <20210111203850.GA3022469@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 29, 2020 at 02:31:53PM +0800, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 99 ++++---------------
>  1 file changed, 21 insertions(+), 78 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index d0a38ba8b9ce..90eb0ecc95d1 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -9,13 +9,7 @@ primary use case of the Aspeed LPC controller is as a slave on the bus
>  conditions it can also take the role of bus master.
>  
>  The LPC controller is represented as a multi-function device to account for the
> -mix of functionality it provides. The principle split is between the register
> -layout at the start of the I/O space which is, to quote the Aspeed datasheet,
> -"basically compatible with the [LPC registers from the] popular BMC controller
> -H8S/2168[1]", and everything else, where everything else is an eclectic
> -collection of functions with a esoteric register layout. "Everything else",
> -here labeled the "host" portion of the controller, includes, but is not limited
> -to:
> +mix of functionality, which includes, but is not limited to:
>  
>  * An IPMI Block Transfer[2] Controller
>  
> @@ -44,80 +38,29 @@ Required properties
>  ===================
>  
>  - compatible:	One of:
> -		"aspeed,ast2400-lpc", "simple-mfd"
> -		"aspeed,ast2500-lpc", "simple-mfd"
> -		"aspeed,ast2600-lpc", "simple-mfd"
> +		"aspeed,ast2400-lpc-v2", "simple-mfd", "syscon"
> +		"aspeed,ast2500-lpc-v2", "simple-mfd", "syscon"
> +		"aspeed,ast2600-lpc-v2", "simple-mfd", "syscon"
>  
>  - reg:		contains the physical address and length values of the Aspeed
>                  LPC memory region.
>  
>  - #address-cells: <1>
>  - #size-cells:	<1>
> -- ranges: 	Maps 0 to the physical address and length of the LPC memory
> -                region
> -
> -Required LPC Child nodes
> -========================
> -
> -BMC Node
> ---------
> -
> -- compatible:	One of:
> -		"aspeed,ast2400-lpc-bmc"
> -		"aspeed,ast2500-lpc-bmc"
> -		"aspeed,ast2600-lpc-bmc"
> -
> -- reg:		contains the physical address and length values of the
> -                H8S/2168-compatible LPC controller memory region
> -
> -Host Node
> ----------
> -
> -- compatible:   One of:
> -		"aspeed,ast2400-lpc-host", "simple-mfd", "syscon"
> -		"aspeed,ast2500-lpc-host", "simple-mfd", "syscon"
> -		"aspeed,ast2600-lpc-host", "simple-mfd", "syscon"
> -
> -- reg:		contains the address and length values of the host-related
> -                register space for the Aspeed LPC controller
> -
> -- #address-cells: <1>
> -- #size-cells:	<1>
> -- ranges: 	Maps 0 to the address and length of the host-related LPC memory
> +- ranges:	Maps 0 to the physical address and length of the LPC memory
>                  region
>  
>  Example:
>  
>  lpc: lpc at 1e789000 {
> -	compatible = "aspeed,ast2500-lpc", "simple-mfd";
> +	compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
>  	reg = <0x1e789000 0x1000>;
>  
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  	ranges = <0x0 0x1e789000 0x1000>;

No child nodes? Then you don't need 'ranges', '#size-cells', nor 
'#address-cells'.

> -
> -	lpc_bmc: lpc-bmc at 0 {
> -		compatible = "aspeed,ast2500-lpc-bmc";
> -		reg = <0x0 0x80>;
> -	};
> -
> -	lpc_host: lpc-host at 80 {
> -		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
> -		reg = <0x80 0x1e0>;
> -		reg-io-width = <4>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x0 0x80 0x1e0>;
> -	};
>  };
>  
> -BMC Node Children
> -==================
> -
> -
> -Host Node Children
> -==================
>  
>  LPC Host Interface Controller
>  -------------------
> @@ -149,14 +92,12 @@ Optional properties:
>  
>  Example:
>  
> -lpc-host at 80 {
> -	lpc_ctrl: lpc-ctrl at 0 {
> -		compatible = "aspeed,ast2500-lpc-ctrl";
> -		reg = <0x0 0x80>;
> -		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> -		memory-region = <&flash_memory>;
> -		flash = <&spi>;
> -	};
> +lpc_ctrl: lpc-ctrl at 80 {
> +	compatible = "aspeed,ast2500-lpc-ctrl";
> +	reg = <0x80 0x80>;
> +	clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> +	memory-region = <&flash_memory>;
> +	flash = <&spi>;
>  };
>  
>  LPC Host Controller
> @@ -179,9 +120,9 @@ Required properties:
>  
>  Example:
>  
> -lhc: lhc at 20 {
> +lhc: lhc at a0 {
>  	compatible = "aspeed,ast2500-lhc";
> -	reg = <0x20 0x24 0x48 0x8>;
> +	reg = <0xa0 0x24 0xc8 0x8>;
>  };
>  
>  LPC reset control
> @@ -192,16 +133,18 @@ state of the LPC bus. Some systems may chose to modify this configuration.
>  
>  Required properties:
>  
> - - compatible:		"aspeed,ast2600-lpc-reset" or
> -			"aspeed,ast2500-lpc-reset"
> -			"aspeed,ast2400-lpc-reset"
> + - compatible:		One of:
> +			"aspeed,ast2600-lpc-reset";
> +			"aspeed,ast2500-lpc-reset";
> +			"aspeed,ast2400-lpc-reset";
> +
>   - reg:			offset and length of the IP in the LHC memory region
>   - #reset-controller	indicates the number of reset cells expected
>  
>  Example:
>  
> -lpc_reset: reset-controller at 18 {
> +lpc_reset: reset-controller at 98 {
>          compatible = "aspeed,ast2500-lpc-reset";
> -        reg = <0x18 0x4>;
> +        reg = <0x98 0x4>;
>          #reset-cells = <1>;
>  };
> -- 
> 2.17.1
> 

From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 30 May 2019 15:00:25 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_1/8]_dt-bindings:_soc:_Add_Aspeed_XDMA_engine_bi?=
 =?UTF-8?Q?nding_documentation?=
In-Reply-To: <1559153408-31190-2-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
 <1559153408-31190-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <58b74556-cbf0-4da2-9392-4c4ac40ad760@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 30 May 2019, at 03:40, Eddie James wrote:
> Document the bindings.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/soc/aspeed/xdma.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 0000000..85e82ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,23 @@
> +* Device tree bindings for the Aspeed XDMA Engine
> +
> +The XDMA Engine embedded in the AST2500 SOC can perform automatic DMA
> +operations over PCI between the AST2500 (acting as a BMC) and a host 
> processor.
> +
> +Required properties:
> +
> + - compatible		"aspeed,ast2500-xdma"
> + - reg			contains the offset and length of the memory region
> +			assigned to the XDMA registers
> + - resets		reset specifier for the syscon reset associated with
> +			the XDMA engine
> + - interrupts		the interrupt associated with the XDMA engine on this
> +			platform

The indentation is quite distracting. If you rev the series can you fix it?

Otherwise,

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> +
> +Example:
> +
> +    xdma at 1e6e7000 {
> +        compatible = "aspeed,ast2500-xdma";
> +        reg = <0x1e6e7000 0x100>;
> +        resets = <&syscon ASPEED_RESET_XDMA>;
> +        interrupts = <6>;
> +    };
> -- 
> 1.8.3.1
> 
>

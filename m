From: Andrew Jeffery <andrew@aj.id.au>
Date: Sun, 05 Apr 2020 16:40:33 +0930
Subject: [PATCH v8 1/5] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <20200403162901.21106-2-eajames@linux.ibm.com>
References: <20200403162901.21106-1-eajames@linux.ibm.com>
 <20200403162901.21106-2-eajames@linux.ibm.com>
Message-ID: <8307d2cd-3bd2-4447-a244-89d0da1a71fe@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 4 Apr 2020, at 02:58, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Changes since v6:
>  - Add PCI-E root complex reset documentation
>  - Add reset-names documentation
>  - Switch to memory-region phandle instead of memory regs
> 
>  .../devicetree/bindings/soc/aspeed/xdma.txt   | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt 
> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 000000000000..c3d7cdeb1db6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,44 @@
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
> +			  the XDMA engine, and, for the AST2600, a second reset
> +			  associated with the PCI-E root complex
> + - reset-names		: required only for the AST2600; must be "dev, "rc"

Bit of a nit, but I find "root-complex" to not be so onerous as to shorten it to "rc".
Is there a need to be so economical? Contracting it makes it harder to read.
While we're here we might also expand "dev" to "device".

Thoughts?

Also you're missing the closing quote on "dev".

> + - interrupts-extended	: two interrupt cells; the first specifies the 
> global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - aspeed,scu		: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - memory-region	: a phandle to the reserved memory region to be used 
> by
> +			  the XDMA engine for DMA operations

Might have been worth dropping the tags for this patch given the changes. I
feel Rob will welcome the switch to describing the memory with a phandle
to a reserved region, but removing his tag makes it easier for him to protest :)

Andrew

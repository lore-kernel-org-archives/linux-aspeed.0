From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Dec 2019 07:44:05 +1030
Subject: [PATCH v3 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <45cabf88-063d-aea1-6c2b-fa8cc0d8cbd3@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-6-git-send-email-eajames@linux.ibm.com>
 <73cbffea-89f1-4212-99af-10c32968cf15@www.fastmail.com>
 <45cabf88-063d-aea1-6c2b-fa8cc0d8cbd3@linux.ibm.com>
Message-ID: <a0b5728c-4022-4cfb-bcd1-8816e4d80e4a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 20 Dec 2019, at 02:18, Eddie James wrote:
> 
> On 12/18/19 5:12 PM, Andrew Jeffery wrote:
> >
> > On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> >> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Changes since v2:
> >>   - Remove 'sdmc', rename 'vga-mem' to 'memory'
> >>
> >>   .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
> >>   MAINTAINERS                                   |  6 +++
> >>   2 files changed, 46 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> new file mode 100644
> >> index 000000000000..58253ea1587b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> @@ -0,0 +1,40 @@
> >> +Aspeed AST25XX and AST26XX XDMA Engine
> >> +
> >> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform
> >> automatic
> >> +DMA operations over PCI between the SOC (acting as a BMC) and a host
> >> processor.
> >> +
> >> +Required properties:
> >> + - compatible		: must be "aspeed,ast2500-xdma" or
> >> +			  "aspeed,ast2600-xdma"
> >> + - reg			: contains the address and size of the memory region
> >> +			  associated with the XDMA engine registers
> >> + - clocks		: clock specifier for the clock associated with the
> >> +			  XDMA engine
> >> + - resets		: reset specifier for the syscon reset associated with
> >> +			  the XDMA engine
> >> + - interrupts-extended	: two interrupt cells; the first specifies the
> >> global
> >> +			  interrupt for the XDMA engine and the second
> >> +			  specifies the PCI-E reset or PERST interrupt.
> >> + - scu			: a phandle to the syscon node for the system control
> >> +			  unit of the SOC
> > I think this should be aspeed,scu.
> 
> 
> Sure.
> 
> 
> >
> >> + - memory		: contains the address and size of the memory area to
> >> +			  be used by the XDMA engine for DMA operations
> > Hmm, I was thinking more like a phandle to a reserved memory region,
> > like we have in the aspeed-lpc-ctrl binding.
> 
> 
> I think I mentioned before, but that doesn't work with the VGA memory. 
> Linux can't reserve it. I haven't quite understood what happens in the 
> memory system but I've tried it and it didn't work.
> 

Yeah, I think you have mentioned that before, sorry for the noise.

Andrew

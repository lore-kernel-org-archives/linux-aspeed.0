From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 14 Dec 2020 02:44:22 +0000
Subject: [PATCH v2 5/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <2e2d3a02-6677-4b0e-b538-d3130a3b20d1@www.fastmail.com>
References: <20201005082806.28899-1-chiawei_wang@aspeedtech.com>
 <20201005082806.28899-6-chiawei_wang@aspeedtech.com>
 <2e2d3a02-6677-4b0e-b538-d3130a3b20d1@www.fastmail.com>
Message-ID: <HK0PR06MB3779F5B4B9629909DDF441F091C70@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew & Rob,

Do you have any suggestion on this patch?
Or should I send a v3 patch with the commits reordering for the review?
Thanks.

Chiawei

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Monday, October 26, 2020 11:12 AM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Lee Jones
> <lee.jones@linaro.org>; Corey Minyard <minyard@acm.org>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Linus
> Walleij <linus.walleij@linaro.org>; Haiyue Wang
> <haiyue.wang@linux.intel.com>; Cyril Bur <cyrilbur@gmail.com>; Robert
> Lippert <rlippert@google.com>; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> openbmc at lists.ozlabs.org; linux-gpio at vger.kernel.org
> Subject: Re: [PATCH v2 5/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
> 
> Hi Wang Chia-Wei,
> 
> On Mon, 5 Oct 2020, at 18:58, Chia-Wei, Wang wrote:
> > The LPC controller has no concept of the BMC and the Host partitions.
> > This patch fixes the documentation by removing the description on LPC
> > partitions. The register offsets illustrated in the DTS node examples
> > are also fixed to adapt to the LPC DTS change.
> >
> > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> 
> The documentation at [1] suggests this should probably be patch 1/5 rather
> than 5/5, so if you send the series again I'd probably rearrange it. Following the
> steps outlined in [1] helps catch Rob's attention in the right way :)
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume
> ntation/devicetree/bindings/submitting-patches.rst?h=v5.9
> 
> Rob:
> 
> The changes here go some way towards cleaning up mistakes I made in the
> Aspeed LPC controller binding. The proposed change is very much not
> backwards compatible, but Joel and I don't want to live with the resulting mess
> in the drivers of catering to both layouts. Another way we could avoid the
> driver mess is to rev all the bindings and immediately drop support for the old
> compatibles in the drivers. This creates a bit more churn in the bindings. What
> are you willing to accommodate?
> 
> All consumers I'm aware of ship the Aspeed BMC dtb in FIT images alongside
> the kernel, so while backwards-incompatible changes are rightly frowned upon
> I feel we probably wouldn't cause too much damage if we went that path.
> 
> Andrew
> 
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 85 +++----------------
> >  1 file changed, 14 insertions(+), 71 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > index a92acf1dd491..866f54a09e09 100644
> > --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > @@ -9,13 +9,7 @@ primary use case of the Aspeed LPC controller is as a
> > slave on the bus  conditions it can also take the role of bus master.
> >
> >  The LPC controller is represented as a multi-function device to
> > account for the -mix of functionality it provides. The principle split
> > is between the register -layout at the start of the I/O space which
> > is, to quote the Aspeed datasheet, -"basically compatible with the
> > [LPC registers from the] popular BMC controller -H8S/2168[1]", and
> > everything else, where everything else is an eclectic -collection of
> > functions with a esoteric register layout. "Everything else", -here
> > labeled the "host" portion of the controller, includes, but is not
> > limited
> > -to:
> > +mix of functionality, which includes, but is not limited to:
> >
> >  * An IPMI Block Transfer[2] Controller
> >
> > @@ -44,8 +38,8 @@ Required properties
> >  ===================
> >
> >  - compatible:	One of:
> > -		"aspeed,ast2400-lpc", "simple-mfd"
> > -		"aspeed,ast2500-lpc", "simple-mfd"
> > +		"aspeed,ast2400-lpc", "simple-mfd", "syscon"
> > +		"aspeed,ast2500-lpc", "simple-mfd", "syscon"
> >
> >  - reg:		contains the physical address and length values of the Aspeed
> >                  LPC memory region.
> > @@ -55,66 +49,17 @@ Required properties
> >  - ranges: 	Maps 0 to the physical address and length of the LPC memory
> >                  region
> >
> > -Required LPC Child nodes
> > -========================
> > -
> > -BMC Node
> > ---------
> > -
> > -- compatible:	One of:
> > -		"aspeed,ast2400-lpc-bmc"
> > -		"aspeed,ast2500-lpc-bmc"
> > -
> > -- reg:		contains the physical address and length values of the
> > -                H8S/2168-compatible LPC controller memory region
> > -
> > -Host Node
> > ----------
> > -
> > -- compatible:   One of:
> > -		"aspeed,ast2400-lpc-host", "simple-mfd", "syscon"
> > -		"aspeed,ast2500-lpc-host", "simple-mfd", "syscon"
> > -
> > -- reg:		contains the address and length values of the host-related
> > -                register space for the Aspeed LPC controller
> > -
> > -- #address-cells: <1>
> > -- #size-cells:	<1>
> > -- ranges: 	Maps 0 to the address and length of the host-related LPC
> memory
> > -                region
> > -
> >  Example:
> >
> >  lpc: lpc at 1e789000 {
> > -	compatible = "aspeed,ast2500-lpc", "simple-mfd";
> > +	compatible = "aspeed,ast2500-lpc", "simple-mfd", "syscon";
> >  	reg = <0x1e789000 0x1000>;
> >
> >  	#address-cells = <1>;
> >  	#size-cells = <1>;
> >  	ranges = <0x0 0x1e789000 0x1000>;
> > -
> > -	lpc_bmc: lpc-bmc at 0 {
> > -		compatible = "aspeed,ast2500-lpc-bmc";
> > -		reg = <0x0 0x80>;
> > -	};
> > -
> > -	lpc_host: lpc-host at 80 {
> > -		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
> > -		reg = <0x80 0x1e0>;
> > -		reg-io-width = <4>;
> > -
> > -		#address-cells = <1>;
> > -		#size-cells = <1>;
> > -		ranges = <0x0 0x80 0x1e0>;
> > -	};
> >  };
> >
> > -BMC Node Children
> > -==================
> > -
> > -
> > -Host Node Children
> > -==================
> >
> >  LPC Host Interface Controller
> >  -------------------
> > @@ -145,14 +90,12 @@ Optional properties:
> >
> >  Example:
> >
> > -lpc-host at 80 {
> > -	lpc_ctrl: lpc-ctrl at 0 {
> > -		compatible = "aspeed,ast2500-lpc-ctrl";
> > -		reg = <0x0 0x80>;
> > -		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> > -		memory-region = <&flash_memory>;
> > -		flash = <&spi>;
> > -	};
> > +lpc_ctrl: lpc-ctrl at 80 {
> > +	compatible = "aspeed,ast2500-lpc-ctrl";
> > +	reg = <0x80 0x80>;
> > +	clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> > +	memory-region = <&flash_memory>;
> > +	flash = <&spi>;
> >  };
> >
> >  LPC Host Controller
> > @@ -174,9 +117,9 @@ Required properties:
> >
> >  Example:
> >
> > -lhc: lhc at 20 {
> > +lhc: lhc at a0 {
> >  	compatible = "aspeed,ast2500-lhc";
> > -	reg = <0x20 0x24 0x48 0x8>;
> > +	reg = <0xa0 0x24 0xc8 0x8>;
> >  };
> >
> >  LPC reset control
> > @@ -194,8 +137,8 @@ Required properties:
> >
> >  Example:
> >
> > -lpc_reset: reset-controller at 18 {
> > +lpc_reset: reset-controller at 98 {
> >          compatible = "aspeed,ast2500-lpc-reset";
> > -        reg = <0x18 0x4>;
> > +        reg = <0x98 0x4>;
> >          #reset-cells = <1>;
> >  };
> > --
> > 2.17.1
> >
> >

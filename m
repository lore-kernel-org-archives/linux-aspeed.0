From: schaecsn <schaecsn@gmx.net>
Date: Sat, 29 Dec 2018 10:30:35 -0800 (PST)
Subject: [PATCH 2/2] dt-bindings: edac: Aspeed AST2500
In-Reply-To: <20181227220906.GA14320@bogus> (message from Rob Herring on Thu, 
 27 Dec 2018 16:09:06 -0600)
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
 <20181227220906.GA14320@bogus>
Message-ID: <20181229183035.EA5A26E85603@corona.crabdance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Rob,

> From: Rob Herring <robh@kernel.org>
> 
> On Sun, Dec 16, 2018 at 10:01:57PM -0800, Stefan Schaeckeler wrote:
> > From: Stefan M Schaeckeler <sschaeck@cisco.com>
> > 
> > Add support for the Aspeed AST2500 SoC EDAC driver.
> > 
> > Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> > ---
> >  .../bindings/edac/aspeed-sdram-edac.txt       | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > new file mode 100644
> > index 000000000000..57ba852883c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> > @@ -0,0 +1,34 @@
> > +Aspeed AST2500 SoC EDAC device driver
> 
> Bindings are for h/w, not drivers

Changed "device driver" to "node".

I will also change the commit message to perhaps "Add support for EDAC on the
Aspeed AST2500 SoC."


> > +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
> > +correction check).
> > +
> > +The memory controller supports SECDED (single bit error correction, double bit
> > +error detection) and single bit error auto scrubbing by reserving 8 bits for
> > +every 64 bit word (effectively reducing available memory to 8/9).
> > +
> > +First, ECC must be configured in u-boot. Then, this driver will expose error
> > +counters via the edac kernel framework.
> 
> Please reword this to not be u-boot or kernel specific.

The previous paragraph is now: Note, the bootloader must configure ECC mode in
the memory controller.

 
> Maybe this node is enabled in the bootloader or the OS can just read the 
> registers to see if ECC is enabled. The latter is more future proof if 
> you need to access the DDR ctrl registers for other reasons.

The driver's probe function has a sanity check. It consults the memory
controller for enabled ECC mode:
 
        /* bail out if ECC mode is not configured */
        regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
        if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
                dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
                return -EPERM;
        }


> > +A note on memory organization in ECC mode: every 512 bytes are followed by 64
> > +bytes of ECC codes. 
> 
> That sounds strange. Normally, the memory would be 72-bits wide to hold 
> the ECC byte for each 64-bit chunk. It would be inefficient to access 
> the ECC byte in a discontiguous location.

When a word is loaded from memory, the corresponding ECC word needs to be
loaded as well (both words can and will be cached). Performance relies on
temporal and spatial locality. That can fire back, of course.


> In any case, none of this is really important for the binding.

I will move above and below paragraph into Kconfig.


> > The address remapping is done in hardware and is fully
> > +transparent to firmware and software. Because of this, ECC mode must be
> > +configured in u-boot as part of the memory initialization as one can not switch
> > +from one mode to another when executing in memory.
> > +
> > +
> > +
> > +Required properties:
> > +- compatible: should be "aspeed,ast2500-sdram-edac"
> > +- reg:        sdram controller register set should be <0x1e6e0000 0x174>
> > +- interrupts: should be AVIC interrupt #0
> > +
> > +
> > +Example:
> > +
> > +	edac: sdram at 1e6e0000 {
> > +		compatible = "aspeed,ast2500-sdram-edac";
> > +		reg = <0x1e6e0000 0x174>;
> > +		interrupts = <0>;
> > +		status = "okay";
> 
> Don't show status in examples.

Removed.

> 
> > +	};
> > -- 
> > 2.19.1


To wrap it up, for the next patchset, I will generate a diff for below text

- - - snip - - -
Aspeed AST2500 SoC EDAC node

The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
correction check).

The memory controller supports SECDED (single bit error correction, double bit
error detection) and single bit error auto scrubbing by reserving 8 bits for
every 64 bit word (effectively reducing available memory to 8/9).

Note, the bootloader must configure ECC mode in the memory controller.


Required properties:
- compatible: should be "aspeed,ast2500-sdram-edac"
- reg:        sdram controller register set should be <0x1e6e0000 0x174>
- interrupts: should be AVIC interrupt #0


Example:

        edac: sdram at 1e6e0000 {
                compatible = "aspeed,ast2500-sdram-edac";
                reg = <0x1e6e0000 0x174>;
                interrupts = <0>;
        };
- - - snip - - -

 Stefan


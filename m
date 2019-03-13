From: Patrick Venture <venture@google.com>
Date: Wed, 13 Mar 2019 13:41:56 -0700
Subject: [PATCH v7 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
In-Reply-To: <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
References: <20190312163051.155405-1-venture@google.com>
 <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
Message-ID: <CAO=notz1Wrqaj4wWw5HmfMPpp6BMacMkr++WirLEHrphaesySA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 13, 2019 at 12:54 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Mar 12, 2019 at 11:30 AM Patrick Venture <venture@google.com> wrote:
> >
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> > Changes for v7:
> > - Moved node under the syscon node it requires
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - None
> > Changes for v3:
> > - None
> > Changes for v2:
> > - Added comment about syscon required parameter.
> > ---
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 000000000000..088cc4e3dc54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,48 @@
> > +======================================================================
> > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> > +======================================================================
> > +
> > +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> > +In this case, the host has access to a 64KiB window into all of the BMC's
> > +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> > +has read access to all the regions of memory, however the host only has read
> > +and write access depending on a register controlled by the BMC.
> > +
> > +Required properties:
> > +===================
> > +
> > + - compatible: must be one of:
> > +       - "aspeed,ast2400-p2a-ctrl"
> > +       - "aspeed,ast2500-p2a-ctrl"
> > +
> > + - syscon: handle to syscon device node controlling PCI.
> > +
> > +Optional properties:
> > +===================
> > +
> > +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> > +               to AHB mapping
> > +
> > +The p2a-control node should be the child of a syscon node with the required
> > +property:
> > +
> > +- compatible : Should be one of the following:
> > +               "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +               "aspeed,g4-scu", "syscon", "simple-mfd"
> > +               "aspeed,ast2500-scu", "syscon", "simple-mfd"
> > +               "aspeed,g5-scu", "syscon", "simple-mfd"
> > +
> > +Example:
> > +
> > +g4 Example
> > +----------
> > +
> > +syscon: scu at 1e6e2000 {
> > +       compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> > +       reg = <0x1e6e2000 0x1a8>;
> > +
> > +       p2a: p2a-control {
> > +               compatible = "aspeed,ast2400-p2a-ctrl";
>
> If there's a defined register range, then you could add a reg property
> (even though Linux doesn't use it).

in this case, the device just needs access to two separate registers
controlled by the syscon to which it is now a child.

>
> Either way,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Jul 2018 11:06:51 +1000
Subject: [PATCH 1/2] dt-bindings: fsi: Add optional chip-id to CFAMs
In-Reply-To: <20180703193017.GA23230@rob-hp-laptop>
References: <20180622043756.21158-1-benh@kernel.crashing.org>
 <20180703193017.GA23230@rob-hp-laptop>
Message-ID: <23be30ebb2c661ef304c78a85cff591c515ba65b.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2018-07-03 at 13:30 -0600, Rob Herring wrote:
> On Fri, Jun 22, 2018 at 02:37:55PM +1000, Benjamin Herrenschmidt wrote:
> > This represents a physical chip in the system and allows
> > a stable numbering scheme to be passed to udev for userspace
> > to recognize which chip is which.
> 
> I'm sure you're aware, stable numbers is generally not something the 
> kernel guarantees...

This has nothing to do with any kernel guarantee. Not sure what you are
mixing up here :-)

The IDs will get exposed via sysfs in order to allow udev rules to
create appropriate symlinks such as by-id or by-path as is traditional
(we haven't completely decided some of the udev side details yet)

> In the cases where we do have them, we've used aliases.

This is necessary, though Aliases may do the job too. This is the
device-tree that represents the "host" system that the BMC is managing.

We need to be able to identify using a stable numbering scheme the
processors on the FSI topology otherwise we would do "interesting"
things such as turn the fan for CPU 1 when CPU 0 gets hot :-)

(This is just a silly example, there are plenty of other reasons why we
need to understand the HW topology of a given system, including
debuggers using FSI as a backend etc...)

Traditionally POWER has used ibm,chip-id properties for the host side,
so I just did something similar here for the BMC side, but I can look
into using aliases if you prefer.

Note: I'm not sure what you have against DT provided names or IDs, this
has been a rather standard way of doing things even before we did the
FDT. For example that's what slot-names properties are for, or location
codes etc... Yes we invented that alias trick later on but it's not
necessarily the best approach (in fact I don't really like it to be
honest).

Cheers,
Ben.


> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  Documentation/devicetree/bindings/fsi/fsi.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
> > index ab516c673a4b..afb4eccab131 100644
> > --- a/Documentation/devicetree/bindings/fsi/fsi.txt
> > +++ b/Documentation/devicetree/bindings/fsi/fsi.txt
> > @@ -83,6 +83,10 @@ addresses and sizes in the slave address space:
> >      #address-cells = <1>;
> >      #size-cells = <1>;
> >  
> > +Optionally, a slave can provide a global unique chip ID which is used to
> > +identify the physical location of the chip in a system specific way
> > +
> > +    chip-id = <0>;
> >  
> >  FSI engines (devices)
> >  ---------------------
> > @@ -125,6 +129,7 @@ device tree if no extra platform information is required.
> >              reg = <0 0>;
> >              #address-cells = <1>;
> >              #size-cells = <1>;
> > +	    chip-id = <0>;
> >  
> >              /* FSI engine at 0xc00, using a single page. In this example,
> >               * it's an I2C master controller, so subnodes describe the
> > -- 
> > 2.17.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

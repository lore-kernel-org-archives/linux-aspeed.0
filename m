From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 26 Sep 2023 10:27:45 +0930
Subject: [PATCH 1/2] dt-bindings: watchdog: aspeed-wdt: Add
 aspeed,reset-mask property
In-Reply-To: <e6b82ec9-c19b-4210-9251-2beee30c6d90@roeck-us.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
	 <20230922104231.1434-5-zev@bewilderbeest.net>
	 <6df088a6-75ab-42f2-ba39-3f155714ed2d@app.fastmail.com>
	 <6b0d4901-d543-4a06-a1e4-7f1558f5361f@hatter.bewilderbeest.net>
	 <e6b82ec9-c19b-4210-9251-2beee30c6d90@roeck-us.net>
Message-ID: <20e3bef8282b1dd412020ecb24d90cbd89f39756.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-09-25 at 17:35 -0700, Guenter Roeck wrote:
> On Mon, Sep 25, 2023 at 05:04:10PM -0700, Zev Weiss wrote:
> > On Sun, Sep 24, 2023 at 07:42:45PM PDT, Andrew Jeffery wrote:
> > > 
> > > 
> > > On Fri, 22 Sep 2023, at 20:12, Zev Weiss wrote:
> > > > This property configures the Aspeed watchdog timer's reset mask, which
> > > > controls which peripherals are reset when the watchdog timer expires.
> > > > Some platforms require that certain devices be left untouched across a
> > > > reboot; aspeed,reset-mask can now be used to express such constraints.
> > > > 
> > > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > > ---
> > > >  .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
> > > >  include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
> > > >  2 files changed, 109 insertions(+), 1 deletion(-)
> > > >  create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > > b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > > index a8197632d6d2..3208adb3e52e 100644
> > > > --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > > +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > > @@ -47,7 +47,15 @@ Optional properties for AST2500-compatible watchdogs:
> > > >  			   is configured as push-pull, then set the pulse
> > > >  			   polarity to active-high. The default is active-low.
> > > > 
> > > > -Example:
> > > > +Optional properties for AST2500- and AST2600-compatible watchdogs:
> > > > + - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
> > > > +		      the watchdog timer expires.  On AST2500 this should be a
> > > > +		      single word defined using the AST2500_WDT_RESET_* macros;
> > > > +		      on AST2600 this should be a two-word array with the first
> > > > +		      word defined using the AST2600_WDT_RESET1_* macros and the
> > > > +		      second word defined using the AST2600_WDT_RESET2_* macros.
> > > > +
> > > > +Examples:
> > > > 
> > > >  	wdt1: watchdog at 1e785000 {
> > > >  		compatible = "aspeed,ast2400-wdt";
> > > > @@ -55,3 +63,11 @@ Example:
> > > >  		aspeed,reset-type = "system";
> > > >  		aspeed,external-signal;
> > > >  	};
> > > > +
> > > > +	#include <dt-bindings/watchdog/aspeed-wdt.h>
> > > > +	wdt2: watchdog at 1e785040 {
> > > > +		compatible = "aspeed,ast2600-wdt";
> > > > +		reg = <0x1e785040 0x40>;
> > > > +		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> > > > +				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> > > > +	};
> > > 
> > > Rob has acked your current approach already, but I do wonder about an
> > > alternative that aligns more with the clock/reset/interrupt properties.
> > > Essentially, define a new generic watchdog property that is specified on
> > > the controllers to be reset by the watchdog (or even on just the
> > > watchdog node itself, emulating what you've proposed here):
> > > 
> > > watchdog-resets = <phandle index>;
> > > 
> > > The phandle links to the watchdog of interest, and the index specifies
> > > the controller associated with the configuration. It might even be
> > > useful to do:
> > > 
> > > watchdog-resets = <phandle index enable>;
> > > 
> > > "enable" could provide explicit control over whether somethings should
> > > be reset or not (as a way to prevent reset if the controller targeted by
> > > the provided index would otherwise be reset in accordance with the
> > > default reset value in the watchdog controller).
> > > 
> > > The macros from the dt-bindings header can then use macros to name the
> > > indexes rather than define a mask tied to the register layout. The index
> > > may still in some way represent the mask position. This has the benefit
> > > of hiding the issue of one vs two configuration registers between the
> > > AST2500 and AST2600 while also allowing other controllers to exploit the
> > > binding (Nuvoton BMCs? Though maybe it's generalising too early?).
> > > 
> > 
> > Sorry, I'm having a bit of a hard time picturing exactly what you're
> > suggesting here...to start with:
> > 
> > > property that is specified on the controllers to be reset by the
> > > watchdog
> > 
> > and
> > 
> > > or even on just the watchdog node itself
> > 
> > seem on the face of it like two fairly different approaches to me.  The
> > former sounds more like existing clock/reset/etc. stuff, where the
> > peripheral has a property describing its relationship to the "central"
> > subsystem, and various peripheral drivers are all individually responsible
> > for observing that property and calling in to the central subsystem to
> > configure things for that peripheral appropriately; if I'm understanding you
> > correctly, it might look something like:
> > 
> >   &spi1 {
> >     watchdog-resets = <&wdt1 WDT_INDEX_SPI1 0>;
> >   };
> > 
> > Or maybe something more like how pinctrl works, via phandles to subnodes of
> > the central device?
> > 
> >   &wdt1 {
> >     wdt1_spi1_reset: spi1_reset {
> >       reg = <0x1c>;
> >       bit = <24>;
> >     };
> >   };
> > 
> >   &spi1 {
> >     watchdog-resets = <&wdt1_spi1_reset 0>;
> >   };
> > 
> > Either way, it seems like it'd be complicated by any insufficient
> > granularity in the watchdog w.r.t. having independent control over the
> > individual devices represented by separate DT nodes (such as how the AST2500
> > watchdog has a single SPI controller reset bit instead of one per SPI
> > interface, or its "misc SOC controller" bit governing all sorts of odds and
> > ends).
> > 
> > In the latter case (property on the wdt node), would it essentially just be
> > kind of an indirection layer mapping hardware-independent device indices to
> > specific registers/bits?  It's not obvious to me what purpose a phandle to
> > the peripheral device node would serve (would the wdt driver have a good way
> > of identifying what specific peripheral it's pointing to to know what bit to
> > twiddle?), but maybe I'm misunderstanding what you're suggesting...
> > 
> > 
> > I guess my other uncertainty is the balance between generalization and
> > applicability -- how many other watchdog devices have sufficient comparable
> > configurability to make use of it?  I haven't pored over all of them, but
> > from a random sampling of 20 so of the other existing wdt drivers I don't
> > see any obvious candidates -- the closest I saw were cpwd.c, which
> > apparently can distinguish between a CPU reset and a CPU/backplane/board
> > reset, and realtek_otto_wdt.c, which can do a CPU or a SOC reset (though I
> > don't have any of the hardware docs to know what capabilities other devices
> > might provide that the drivers don't use).  Do the Nuvoton BMCs have
> > watchdogs with peripheral-granularity reset configuration?
> > 
> 
> Quite frankly, I don't like where this is going. It is getting way
> too complicated. And when something is becoming way too complicated,
> I tend to put it on my backburner list. The length of that list quickly
> approaches maxint.
> 

No worries. I figured I should at least give the idea some air-time,
even if we did end up discounting it. I feel my description and Zev's
queries make it sound more complex than it might be in practice but I
also haven't written the patch, so never mind!

Andrew

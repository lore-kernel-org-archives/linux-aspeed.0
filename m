From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Jun 2017 10:43:16 +0930
Subject: [PATCH 1/4] ARM: aspeed: g4: Add USB functions to pinctrl bindings
In-Reply-To: <1498535619.3651.29.camel@kernel.crashing.org>
References: <20170627021214.23323-1-andrew@aj.id.au>
 <20170627021214.23323-2-andrew@aj.id.au>
 <1498535619.3651.29.camel@kernel.crashing.org>
Message-ID: <1498785196.5203.9.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-06-26 at 22:53 -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2017-06-27 at 11:42 +0930, Andrew Jeffery wrote:
> > The AST2400 contains several USB controllers:
> > 
> > * USB 1.1 Host Controller
> > * USB 2.0 Host Controller
> > * Combined USB 2.0 Virtual Hub and USB 1.1 HID Controller
> 
> There's also a USB1.1 HID-only device-controller, but it's a legacy
> piece of IP that we may never support.

Yes, I'll fix that - there's a block diagram in the datasheet that
suggests they're combined, but the memory map says otherwise. I'll
separate them out in the commit message.

>  It might be worth mentioning its
> existence and Ryan might want it supported in the bindings at least no
> ?

Unless I've missed something this just amounts to a change in the
commit message, both above to split the Hub/HID description and below
in the table to say "HID" instead of just "Device". The bindings as
they stand in this patch completely describe the mux behaviour for USB
as documented in the datasheet's Multifunction Pins Mapping and Control
table.

> 
> > Pins for three ports are routed to the three controllers such that:
> > 
> > * Port 1 is a dedicated USB 1.1 host port
> > * Port 2 is shared between the USB 1.1 host and HID controllers
> > * Port 3 is shared between the USB 2.0 host and Hub controllers
> > 
> > As the pins for port 1 are fixed function there is no associated mux
> > function or group described in the bindings. Ports 2 and 3 are muxed as
> > above, and the table below describes the mapping between pinmux function
> > names and ports:
> > 
> > Port  | USB Version  | USB Mode  | Mux Function
> > ------|--------------|-----------|-------------
> > 1     | 1.1          | Host      | -
> > 2     | 1.1          | Host      | USB11H2
> > 2     | 1.1          | Device    | USB11D1

                           ^~~~~~
                           Should be "HID" for clarity

Cheers,

Andrew

> > 3     | 2.0          | Host      | USB2H1
> > 3     | 2.0          | Device    | USB2D1
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> > index ca01710ee29a..09142dab47db 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
> > @@ -69,8 +69,9 @@ PWM1 PWM2 PWM3 PWM4 PWM5 PWM6 PWM7 RGMII1 RGMII2 RMII1 RMII2 ROM16 ROM8 ROMCS1
> >  ROMCS2 ROMCS3 ROMCS4 RXD1 RXD2 RXD3 RXD4 SALT1 SALT2 SALT3 SALT4 SD1 SD2 SGPMCK
> >  SGPMI SGPMLD SGPMO SGPSCK SGPSI0 SGPSI1 SGPSLD SIOONCTRL SIOPBI SIOPBO SIOPWREQ
> >  SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1DEBUG SPI1PASSTHRU SPICS1 TIMER3 TIMER4
> > -TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2 TXD3 TXD4 UART6 USBCKI VGABIOS_ROM VGAHS
> > -VGAVS VPI18 VPI24 VPI30 VPO12 VPO24 WDTRST1 WDTRST2
> > +TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2 TXD3 TXD4 UART6 USB11D1 USB11H2 USB2D1
> > +USB2H1 USBCKI VGABIOS_ROM VGAHS VGAVS VPI18 VPI24 VPI30 VPO12 VPO24 WDTRST1
> > +WDTRST2
> >  
> >  aspeed,ast2500-pinctrl, aspeed,g5-pinctrl:
> >  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170630/4aadd7c7/attachment-0001.sig>

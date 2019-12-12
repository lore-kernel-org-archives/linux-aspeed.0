From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 12 Dec 2019 16:55:13 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <CACRpkda4PFA=99u33xsXzQND1FaP=8GXGRQULngcd5a=zFepXg@mail.gmail.com>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <CACRpkda4PFA=99u33xsXzQND1FaP=8GXGRQULngcd5a=zFepXg@mail.gmail.com>
Message-ID: <20191212155513.fevajupxi6omphzf@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 19-12-12 16:08, Linus Walleij wrote:
> On Wed, Dec 11, 2019 at 6:09 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > I discussed it with a colleague again and he mentioned that pinctrl
> > should be named pinctrl instead it should be named padctrl.
> 
> Quoting Documentation/driver-api/pinctl.rst:
> 
> (...)
> Definition of PIN:
> 
> - PINS are equal to pads, fingers, balls or whatever packaging input or
>   output line you want to control and these are denoted by unsigned integers
>   in the range 0..maxpin.
> (...)

Okay there is the definition.

> > We don't
> > reconfigure the pad to a other function it is still a device general
> > purpose input pad. The hw-signal flow goes always trough the gpio block
> > so one argument more for my solution. Also we don't configure the "pad"
> > to be a vsel/ena-pin. The hw-pad can only be a gpio or has an alternate
> > function (WDKICK for GPIO0, Seq. SYS_EN for GPIO2, Seq. PWR_EN for GPIO4).
> > Instead we tell the regulator to use _this_ GPIO e.g. for voltage
> > selection so we go the other way around. My last argument why pinctrl
> > isn't the correct place is that the GPIO1 can be used for
> > regulator-0:vsel-in and for regulator-1:enable-in. So this pad would
> > have different states which is invalid IMHO.
> 
> Yeah it is just one of these cases where the silicon designer pulled
> a line of polysilicone over to the regulator enable signal and put a
> switch on it and say "so you can also enable the regulator
> with a signal from here", it can be used in parallel with anything
> else, which is especially messy.

I didn't say that the design isn't messy ;) I just wanna make the right
abstraction and IMHO this is the correct abstraction.

Regards,
  Marco

> Special cases require special handling, since the electronic design
> of this thing is a bit Rube Goldberg.
> 
> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

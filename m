From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 11 Dec 2019 18:09:18 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Adam,

On 19-12-11 16:14, Adam Thomson wrote:
> On 10 December 2019 09:42, Marco Felsch wrote:
> 
> > Hi Mark,
> > 
> > On 19-12-04 13:46, Mark Brown wrote:
> > > On Fri, Nov 29, 2019 at 06:25:34PM +0100, Marco Felsch wrote:
> > >
> > > > +  Optional regulator device-specific properties:
> > > > +  - dlg,vsel-sense-gpios : A GPIO reference to a local general purpose input,
> > > > +    the datasheet calls it GPI. The regulator sense the input signal and select
> > > > +    the active or suspend voltage settings. If the signal is active the
> > > > +    active-settings are applied else the suspend-settings are applied.
> > > > +    Attention: Sharing the same GPI for other purposes or across multiple
> > > > +    regulators is possible but the polarity setting must equal.
> > >
> > > I'm really confused by this.  As far as I understand it it seems
> > > to be doing pinmuxing on the chip using the GPIO bindings which
> > > is itself a bit odd and I don't see anything here that configures
> > > whatever sets the state of the pins.  Don't we need another GPIO
> > > to set the vsel-sense inputs on the PMIC?
> > 
> > Yes the PMIC is very configurable and it took a while till I understand
> > it.. @Adam please correct me if I'm wrong.
> > 
> > The PMIC regulators regardless of the type: ldo or buck can be
> > simplified drawn as:
> > 
> > 
> > 
> > da9062-gpio               da9062-regulator
> > 
> >   +-------------------------------------------------------
> >   |                  PMIC
> >   |
> >   > GPIO0            +--------------------------+
> >   |                  |         REGULATOR-0      |
> >   > GPIO1 -------+   |                          |
> >   |              +-- > vsel-in    voltage-a-out <
> >   > GPIO2        |   |                          |
> >   |              |   > enable-in  voltage-b-out <
> >   |              |   |                          |
> >   |              |   +--------------------------+
> >   |              |
> >   |              |   +--------------------------+
> >   |              |   |         REGULATOR-1      |
> >   |              |   |                          |
> >   |              +-- > vsel-in    voltage-a-out <
> >   |                  |                          |
> >   |                  > enable-in  voltage-b-out <
> >   |                  |                          |
> >   |                  +--------------------------+
> >   |
> > 
> > The 'vsel-in' and 'enable-in' regulator inputs must be routed to the
> > PMIC GPIOs which must be configured as input. If this is a pinmux in
> > your opinion, then yes we need to do that. IMHO it isn't a pinmux
> > because from the regulator point of view it is just a GPIO which comes
> > from our own gpio-dev (da9062-gpio). So the abstraction is vald. Anyway
> > I'm with you that this isn't the typical use-case.
> 
> We've had this discussion before and to me it felt more like pinmux than GPIO
> although I understand we're configuring the GPIO pin as input before then
> configuring a regulator to take that specific internal GPIO as the control
> signal. We're defining a specific role to this pin in HW rather than it being a
> general software handled GPI so it feels like this would be neater under pinmux.
> There does still need to be a mapping between that pin and the regulator which I
> guess would be served by passing the pin to the regulator through generic pinmux
> bindings and then in the regulator code you're simply just enabling the
> regulator to be controlled from that pin. The HW lets you control multiple
> regulators from the same input pin so there's a flexibility there to be
> captured, as you mention.

I know that we already had this discussion but the result was to wait
for the maintainers input. Since Linus is the pinctrl/gpio maintainer
and Mark the regulator maintainer we now have some input so we can move
forward. Linus made some comments on the dt-bindings and on the code but
he didn't pointed out that this usage is wrong. So I guessed it would be
fine for him. Mark did his first comments now and I explained the
current state..

I discussed it with a colleague again and he mentioned that pinctrl
should be named pinctrl instead it should be named padctrl. We don't
reconfigure the pad to a other function it is still a device general
purpose input pad. The hw-signal flow goes always trough the gpio block
so one argument more for my solution. Also we don't configure the "pad"
to be a vsel/ena-pin. The hw-pad can only be a gpio or has an alternate
function (WDKICK for GPIO0, Seq. SYS_EN for GPIO2, Seq. PWR_EN for GPIO4).
Instead we tell the regulator to use _this_ GPIO e.g. for voltage
selection so we go the other way around. My last argument why pinctrl
isn't the correct place is that the GPIO1 can be used for
regulator-0:vsel-in and for regulator-1:enable-in. So this pad would
have different states which is invalid IMHO.

Regards,
  Marco

> > Regards,
> >   Marco
> > 
> > --
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

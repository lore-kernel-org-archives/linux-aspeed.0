From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 11 Dec 2019 16:14:09 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191210094144.mxximpuouchy3fqu@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
Message-ID: <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10 December 2019 09:42, Marco Felsch wrote:

> Hi Mark,
> 
> On 19-12-04 13:46, Mark Brown wrote:
> > On Fri, Nov 29, 2019 at 06:25:34PM +0100, Marco Felsch wrote:
> >
> > > +  Optional regulator device-specific properties:
> > > +  - dlg,vsel-sense-gpios : A GPIO reference to a local general purpose input,
> > > +    the datasheet calls it GPI. The regulator sense the input signal and select
> > > +    the active or suspend voltage settings. If the signal is active the
> > > +    active-settings are applied else the suspend-settings are applied.
> > > +    Attention: Sharing the same GPI for other purposes or across multiple
> > > +    regulators is possible but the polarity setting must equal.
> >
> > I'm really confused by this.  As far as I understand it it seems
> > to be doing pinmuxing on the chip using the GPIO bindings which
> > is itself a bit odd and I don't see anything here that configures
> > whatever sets the state of the pins.  Don't we need another GPIO
> > to set the vsel-sense inputs on the PMIC?
> 
> Yes the PMIC is very configurable and it took a while till I understand
> it.. @Adam please correct me if I'm wrong.
> 
> The PMIC regulators regardless of the type: ldo or buck can be
> simplified drawn as:
> 
> 
> 
> da9062-gpio               da9062-regulator
> 
>   +-------------------------------------------------------
>   |                  PMIC
>   |
>   > GPIO0            +--------------------------+
>   |                  |         REGULATOR-0      |
>   > GPIO1 -------+   |                          |
>   |              +-- > vsel-in    voltage-a-out <
>   > GPIO2        |   |                          |
>   |              |   > enable-in  voltage-b-out <
>   |              |   |                          |
>   |              |   +--------------------------+
>   |              |
>   |              |   +--------------------------+
>   |              |   |         REGULATOR-1      |
>   |              |   |                          |
>   |              +-- > vsel-in    voltage-a-out <
>   |                  |                          |
>   |                  > enable-in  voltage-b-out <
>   |                  |                          |
>   |                  +--------------------------+
>   |
> 
> The 'vsel-in' and 'enable-in' regulator inputs must be routed to the
> PMIC GPIOs which must be configured as input. If this is a pinmux in
> your opinion, then yes we need to do that. IMHO it isn't a pinmux
> because from the regulator point of view it is just a GPIO which comes
> from our own gpio-dev (da9062-gpio). So the abstraction is vald. Anyway
> I'm with you that this isn't the typical use-case.

We've had this discussion before and to me it felt more like pinmux than GPIO
although I understand we're configuring the GPIO pin as input before then
configuring a regulator to take that specific internal GPIO as the control
signal. We're defining a specific role to this pin in HW rather than it being a
general software handled GPI so it feels like this would be neater under pinmux.
There does still need to be a mapping between that pin and the regulator which I
guess would be served by passing the pin to the regulator through generic pinmux
bindings and then in the regulator code you're simply just enabling the
regulator to be controlled from that pin. The HW lets you control multiple
regulators from the same input pin so there's a flexibility there to be
captured, as you mention.

> 
> Regards,
>   Marco
> 
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

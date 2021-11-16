From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 Nov 2021 02:44:00 +0000
Subject: [PATCH 1/2] leds: pca955x: Make the gpiochip always expose all
 pins
In-Reply-To: <CACRpkdZRWzq_j_UsU+eZurv1wT7muB1V4ktui1-Q0mHV3xw58A@mail.gmail.com>
References: <20210921043936.468001-1-andrew@aj.id.au>
 <20210921043936.468001-2-andrew@aj.id.au>
 <CACRpkdZRWzq_j_UsU+eZurv1wT7muB1V4ktui1-Q0mHV3xw58A@mail.gmail.com>
Message-ID: <CACPK8Xef1hVFFAJS-tHa+fjR0SgNZ7d5W04KwOYi-CvQdpnJww@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Pavel and Arnd,

This one has slipped through the cracks. Andrew asked for a follow up
and Linus sent a review, but we haven't heard from Pavel at all.

We've merged device tree changes through the soc tree in v5.16 that
depend on this patch. Ideally I would like to see it applied to fix
those device trees, instead of sending reverts for the device trees.

Additionally, I'm now reviewing changes for v5.17 and want to decide
which direction we should take.

Pavel, are you happy with the change?

If so, would you consider merging it as a fix for v5.16?

Cheers,

Joel

On Tue, 9 Nov 2021 at 11:03, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Sep 21, 2021 at 6:40 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> > The devicetree binding allows specifying which pins are GPIO vs LED.
> > Limiting the instantiated gpiochip to just these pins as the driver
> > currently does requires an arbitrary mapping between pins and GPIOs, but
> > such a mapping is not implemented by the driver. As a result,
> > specifying GPIOs in such a way that they don't map 1-to-1 to pin indexes
> > does not function as expected.
> >
> > Establishing such a mapping is more complex than not and even if we did,
> > doing so leads to a slightly hairy userspace experience as the behaviour
> > of the PCA955x gpiochip would depend on how the pins are assigned in the
> > devicetree. Instead, always expose all pins via the gpiochip to provide
> > a stable interface and track which pins are in use.
> >
> > Specifying a pin as `type = <PCA955X_TYPE_GPIO>;` in the devicetree
> > becomes a no-op.
> >
> > I've assessed the impact of this change by looking through all of the
> > affected devicetrees as of the tag leds-5.15-rc1:
> >
> > ```
> > $ git grep -l 'pca955[0123]' $(find . -name dts -type d)
> > arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> > arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> > arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> > arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
> > arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> > arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> > arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> > ```
> >
> > These are all IBM-associated platforms. I've analysed both the
> > devicetrees and schematics where necessary to determine whether any
> > systems hit the hazard of the current broken behaviour. For the most
> > part, the systems specify the pins as either all LEDs or all GPIOs, or
> > at least do so in a way such that the broken behaviour isn't exposed.
> >
> > The main counter-point to this observation is the Everest system whose
> > devicetree describes a large number of PCA955x devices and in some cases
> > has pin assignments that hit the hazard. However, there does not seem to
> > be any use of the affected GPIOs in the userspace associated with
> > Everest.
> >
> > Regardless, any use of the hazardous GPIOs in Everest is already broken,
> > so let's fix the interface and then fix any already broken userspace
> > with it.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Nov 2021 12:03:30 +0100
Subject: [PATCH 1/2] leds: pca955x: Make the gpiochip always expose all
 pins
In-Reply-To: <20210921043936.468001-2-andrew@aj.id.au>
References: <20210921043936.468001-1-andrew@aj.id.au>
 <20210921043936.468001-2-andrew@aj.id.au>
Message-ID: <CACRpkdZRWzq_j_UsU+eZurv1wT7muB1V4ktui1-Q0mHV3xw58A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 21, 2021 at 6:40 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The devicetree binding allows specifying which pins are GPIO vs LED.
> Limiting the instantiated gpiochip to just these pins as the driver
> currently does requires an arbitrary mapping between pins and GPIOs, but
> such a mapping is not implemented by the driver. As a result,
> specifying GPIOs in such a way that they don't map 1-to-1 to pin indexes
> does not function as expected.
>
> Establishing such a mapping is more complex than not and even if we did,
> doing so leads to a slightly hairy userspace experience as the behaviour
> of the PCA955x gpiochip would depend on how the pins are assigned in the
> devicetree. Instead, always expose all pins via the gpiochip to provide
> a stable interface and track which pins are in use.
>
> Specifying a pin as `type = <PCA955X_TYPE_GPIO>;` in the devicetree
> becomes a no-op.
>
> I've assessed the impact of this change by looking through all of the
> affected devicetrees as of the tag leds-5.15-rc1:
>
> ```
> $ git grep -l 'pca955[0123]' $(find . -name dts -type d)
> arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
> arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> ```
>
> These are all IBM-associated platforms. I've analysed both the
> devicetrees and schematics where necessary to determine whether any
> systems hit the hazard of the current broken behaviour. For the most
> part, the systems specify the pins as either all LEDs or all GPIOs, or
> at least do so in a way such that the broken behaviour isn't exposed.
>
> The main counter-point to this observation is the Everest system whose
> devicetree describes a large number of PCA955x devices and in some cases
> has pin assignments that hit the hazard. However, there does not seem to
> be any use of the affected GPIOs in the userspace associated with
> Everest.
>
> Regardless, any use of the hazardous GPIOs in Everest is already broken,
> so let's fix the interface and then fix any already broken userspace
> with it.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

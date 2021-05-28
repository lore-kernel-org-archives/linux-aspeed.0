From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 May 2021 10:35:37 +0200
Subject: [PATCH v2 1/4] dt-bindings: aspeed-sgpio: Convert txt bindings to
 yaml.
In-Reply-To: <20210528040934.GA28403@aspeedtech.com>
References: <20210527005455.25758-1-steven_lee@aspeedtech.com>
 <20210527005455.25758-2-steven_lee@aspeedtech.com>
 <CACRpkdZFcFuT9rdrc8BfEBmhy0--9uLMSJWfr=A+nU117_BT8A@mail.gmail.com>
 <20210528040934.GA28403@aspeedtech.com>
Message-ID: <CACRpkdYnvzOW_86QgLAsNpNXWZXpaMiE7g9_jHZ0ZsFyhOjjAg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 28, 2021 at 6:10 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> The 05/28/2021 07:51, Linus Walleij wrote:
> > On Thu, May 27, 2021 at 2:55 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > > +  max-ngpios:
> > > +    description:
> > > +      represents the number of actual hardware-supported GPIOs (ie,
> > > +      slots within the clocked serial GPIO data). Since each HW GPIO is both an
> > > +      input and an output, we provide max_ngpios * 2 lines on our gpiochip
> > > +      device. We also use it to define the split between the inputs and
> > > +      outputs; the inputs start at line 0, the outputs start at max_ngpios.
> > > +    minimum: 0
> > > +    maximum: 128
> >
> > Why can this not be derived from the compatible value?
> >
> > Normally there should be one compatible per hardware variant
> > of the block. And this should be aligned with that, should it not?
> >
> > If this is not the case, maybe more detailed compatible strings
> > are needed, maybe double compatibles with compatible per
> > family and SoC?
> >
>
> Thanks for your suggestion.
> I add max-ngpios in dt-bindings as there is ngpios defined in
> dt-bindings, users can get the both max-ngpios and ngpios information
> from dtsi without digging sgpio driver.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-g5.dtsi#n354
>
> If adding more detailed compatibles is better, I will add them to sgpio driver
> in V3 patch and remove max-ngpios from dt-bindings.
>
> Since AST2600 has 2 sgpio controller one with 128 pins and another one with 80 pins.
> For supporting max-ngpios in compatibles, 2 platform data for each
> ast2600 sgpio controller as follows are necessary.
>
> ```
> static const struct aspeed_sgpio_pdata ast2600_sgpiom1_pdata = {
>         .max_ngpios = 128;
> };
> static const struct aspeed_sgpio_pdata ast2600_sgpiom2_pdata = {
>         .max_ngpios = 80;
> };
>
> { .compatible = "aspeed,ast2500-sgpio" , .data = &ast2400_sgpio_pdata, },
> { .compatible = "aspeed,ast2600-sgpiom1", .data = &ast2600_sgpiom1_pdata, },
> { .compatible = "aspeed,ast2600-sgpiom2", .data = &ast2600_sgpiom2_pdata, },

There is a soft border between two IP blocks being "compatible"
and parameterized and two IP blocks being different and having
unique compatibles.

For example we know for sure we don't use different compatibles
because of how interrupt lines or DMA channels are connected.

So if this is an external thing, outside of the IP itself, I might back
off on this and say it shall be a parameter.

But max-ngpios? It is confusingly similar to ngpios.

So we need to think about this name.

Something like gpio-hardware-slots or something else that
really describe what this is.

Does this always strictly follow ngpios so that the number
of gpio slots == ngpios * 2? In that case only put ngpios into
the device tree and multiply by 2 in the driver, because ngpios
is exactly for this: parameterizing hardware limitations.

Yours,
Linus Walleij

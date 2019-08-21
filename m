From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 21 Aug 2019 10:25:21 -0400
Subject: [v7 2/2] gpio: aspeed: Add SGPIO driver
In-Reply-To: <1564603297-1391-3-git-send-email-hongweiz@ami.com>
References: <1564603297-1391-1-git-send-email-hongweiz@ami.com>
Message-ID: <1566397521-987-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Linus,

Thanks for your review! I just submitted v8 to the list, please help to review it again.

Since you have already merged the dt-binding document [v7 1/2], and I don't have your
update to this file, so to avoid confusion, I only include the driver code in v8.

Regards,
--Hongwei 

P.S. sorry previous response used wrong In-Reply-To ID, so resent it again.

> From:	Linus Walleij <linus.walleij@linaro.org>
> Sent:	Wednesday, August 14, 2019 4:09 AM
> To:	Hongwei Zhang
> Cc:	Andrew Jeffery; open list:GPIO SUBSYSTEM; Joel Stanley; linux-aspeed; Bartosz Golaszewski; 
> linux-kernel at vger.kernel.org; Linux ARM
> Subject:	Re: [v7 2/2] gpio: aspeed: Add SGPIO driver
> 
> Hi Hongwei,
> 
> thanks for your patch!
> 
> I have now merged the bindings so you only need to respin this patch.
> 
> On Wed, Jul 31, 2019 at 10:02 PM Hongwei Zhang <hongweiz@ami.com> wrote:
> 
> > Add SGPIO driver support for Aspeed AST2500 SoC.
> >
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > Reviewed-by:   Andrew Jeffery <andrew@aj.id.au>
> 
> I guess I need to go with this, there are some minor things I still want to be fixed:
> 
> > +static void __aspeed_sgpio_set(struct gpio_chip *gc, unsigned int 
> > +offset, int val)
> 
> I don't like __underscore_functions because their semantic is ambiguous.
> 

done, please see v8.

> Rename this something like aspeed_sgpio_commit() or whatever best fits the actual use.
> 
> > +static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
> > +                                  struct platform_device *pdev) {
> (...)
> > +       rc = gpiochip_irqchip_add(&gpio->chip, &aspeed_sgpio_irqchip,
> > +                                 0, handle_bad_irq, IRQ_TYPE_NONE);
> (...)
> > +       gpiochip_set_chained_irqchip(&gpio->chip, &aspeed_sgpio_irqchip,
> > +                                    gpio->irq, 
> > + aspeed_sgpio_irq_handler);
> 
> We do not set up chained irqchips like this anymore, sorry.
> 
> I am currently rewriting all existing chained drivers to pass an initialized irqchip when registering the 
> whole gpio chip.
> See drivers/gpio/TODO.
> 
> Here are examples:
> https://lore.kernel.org/linux-gpio/20190811080539.15647-1-linus.walleij at linaro.org/
> https://lore.kernel.org/linux-gpio/20190812132554.18313-1-linus.walleij at linaro.org/
> 

done, please see v8.

> > +       /* set all SGPIO pins as input (1). */
> > +       memset(gpio->dir_in, 0xff, sizeof(gpio->dir_in));
> 
> Do the irqchip set-up here, before adding the gpio_chip.
> 
> > +       rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> > +       if (rc < 0)
> > +               return rc;
> > +
> > +       return aspeed_sgpio_setup_irqs(gpio, pdev);
> 
> Yours,
> Linus Walleij

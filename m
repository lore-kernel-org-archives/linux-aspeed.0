From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 12 Jun 2018 17:17:13 +1000
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <CACPK8XcPdf-=Xr0LRDR9=VjUHgOmTujG1TYsNEoAS31ZUP4+EQ@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
 <CACPK8XcPdf-=Xr0LRDR9=VjUHgOmTujG1TYsNEoAS31ZUP4+EQ@mail.gmail.com>
Message-ID: <6b482e79dab3053c8b7f283aeb1955c095cdc3dd.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2018-06-12 at 15:07 +0930, Joel Stanley wrote:
> On 12 June 2018 at 09:40, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On the Aspeed chip, the GPIOs can be under control of the ARM
> > chip or of the ColdFire coprocessor. (There's a third command
> > source, the LPC bus, which we don't use or support yet).
> > 
> > The control of which master is allowed to modify a given
> > GPIO is per-bank (8 GPIOs).
> > 
> > Unfortunately, systems already exist for which we want to
> > use GPIOs of both sources in the same bank.
> > 
> > This provides an API exported by the gpio-aspeed driver
> > that an aspeed coprocessor driver can use to "grab" some
> > GPIOs for use by the coprocessor, and allow the coprocessor
> > driver to provide callbacks for arbitrating access.
> > 
> > Once at least one GPIO of a given bank has been "grabbed"
> > by the coprocessor, the entire bank is marked as being
> > under coprocessor control. It's command source is switched
> > to the coprocessor.
> > 
> > If the ARM then tries to write to a GPIO in such a marked bank,
> > the provided callbacks are used to request access from the
> > coprocessor driver, which is responsible to doing whatever
> > is necessary to "pause" the coprocessor or prevent it from
> > trying to use the GPIOs while the ARM is doing its accesses.
> > 
> > During that time, the command source for the bank is temporarily
> > switched back to the ARM.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Looks okay to me. Just need to deal with the memory allocated.
> 
> > +
> > +/**
> > + * aspeed_gpio_copro_grab_gpio - Mark a GPIO used by the coprocessor. The entire
> > + *                               bank gets marked and any access from the ARM will
> > + *                               result in handshaking via callbacks.
> > + * @desc: The GPIO to be marked
> > + */
> > +int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc)
> > +{
> > +       struct gpio_chip *chip = gpiod_to_chip(desc);
> > +       struct aspeed_gpio *gpio = gpiochip_get_data(chip);
> > +       int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
> > +       const struct aspeed_gpio_bank *bank = to_bank(offset);
> > +       unsigned long flags;
> > +
> > +       if (!gpio->cf_copro_bankmap)
> > +               gpio->cf_copro_bankmap = kzalloc(gpio->config->nr_gpios >> 3, GFP_KERNEL);
> 
> Someone should free this.

Right, I'll probably just make it a devm_kzalloc

> > +       if (!gpio->cf_copro_bankmap)
> > +               return -ENOMEM;
> > +       if (offset < 0 || offset > gpio->config->nr_gpios)
> > +               return -EINVAL;
> > +       bindex = offset >> 3;
> > +
> > +       spin_lock_irqsave(&gpio->lock, flags);
> > +
> > +       /* Sanity check, this shouldn't happen */
> > +       if (gpio->cf_copro_bankmap[bindex] == 0xff) {
> > +               rc = -EIO;
> > +               goto bail;
> > +       }
> > +       gpio->cf_copro_bankmap[bindex]++;
> > +
> > +       /* Switch command source */
> > +       if (gpio->cf_copro_bankmap[bindex] == 1)
> > +               aspeed_gpio_change_cmd_source(gpio, bank, bindex,
> > +                                             GPIO_CMDSRC_COLDFIRE);
> > +
> > + bail:
> > +       spin_unlock_irqrestore(&gpio->lock, flags);
> > +       return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(aspeed_gpio_copro_grab_gpio);

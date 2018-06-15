From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 15 Jun 2018 16:04:14 +1000
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <CACPK8XcPdf-=Xr0LRDR9=VjUHgOmTujG1TYsNEoAS31ZUP4+EQ@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
 <CACPK8XcPdf-=Xr0LRDR9=VjUHgOmTujG1TYsNEoAS31ZUP4+EQ@mail.gmail.com>
Message-ID: <ac48488f1e92b7dabffa38977151b6c457565f0e.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


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

Actually no. The driver doesn't have a remove(), so it doesn't.

Cheers,
Ben.

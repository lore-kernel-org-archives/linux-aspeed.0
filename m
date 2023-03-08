From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Mar 2023 13:13:25 +0100
Subject: [PATCH v2 03/16] gpio: aspeed: Convert to immutable irq_chip
In-Reply-To: <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
 <20230215-immutable-chips-v2-3-d6b0e3f2d991@linaro.org> <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
Message-ID: <CACRpkdZmemtVHkdo7f8G4wTHEayk1moHSMHEyvomebPV_h8AHA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 8, 2023 at 2:22 AM Joel Stanley <joel@jms.id.au> wrote:
> On Tue, 7 Mar 2023 at 13:04, Linus Walleij <linus.walleij@linaro.org> wrote:

> > +static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
> > +{
> > +       const struct aspeed_gpio_bank *bank;
> > +       struct aspeed_gpio *gpio;
> > +       u32 bit;
> > +       int rc, offset;
> > +
> > +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
>
> Why do we call this instead of using irq_data_get_irq_chip_data?

Because this is what the other irqchip callbacks do and I do not
dare to do anything inventive or different as I can't really test
the patches.

> Actually, the callback appears to do the same as the default
> implementation, so we could just drop it?

So is chip->name always set to dev_name(dev) if we don't define
it? I had no idea.

I can respon with this change, the optional IRQ should be a separate
patch I think?

Yours,
Linus Walleij

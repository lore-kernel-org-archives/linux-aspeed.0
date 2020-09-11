From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 11 Sep 2020 09:10:29 +0800
Subject: [PATCH 1/2] gpio/aspeed-sgpio: enable access to all 80 input &
 output sgpios
In-Reply-To: <CACPK8XcT02qv+1H=DDv8BRAdUmrBoweZ+Qb3aG34bQ9-UC08Xg@mail.gmail.com>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
 <CACPK8XcT02qv+1H=DDv8BRAdUmrBoweZ+Qb3aG34bQ9-UC08Xg@mail.gmail.com>
Message-ID: <788526c84deb4763d874be1748fcc5a583f8f79d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Thanks for the review!

> A Fixes: might be a good idea.

OK, given this isn't strictly (just) a fix, should I split that out?

> > -#define MAX_NR_SGPIO                   80
> > +#define MAX_NR_HW_SGPIO                        80
> > +#define SGPIO_OUTPUT_OFFSET            MAX_NR_HW_SGPIO
> 
> A short comment explaining what's going on with these defines (as you
> did in your commit message) will help future reviewers.

Sounds good, I'll add one.

> 
> > +static void aspeed_sgpio_irq_init_valid_mask(struct gpio_chip *gc,
> > +               unsigned long *valid_mask, unsigned int ngpios)
> > +{
> > +       struct aspeed_sgpio *sgpio = gpiochip_get_data(gc);
> > +       int n = sgpio->n_sgpio;
> > +
> > +       WARN_ON(ngpios < MAX_NR_HW_SGPIO * 2);
> > +
> > +       /* input GPIOs in the lower range */
> > +       bitmap_set(valid_mask, 0, n);
> > +       bitmap_clear(valid_mask, n, ngpios - n);
> > +}
> > +
> > +static const bool aspeed_sgpio_is_input(unsigned int offset)
> 
> The 0day bot complained about the 'const' here.

ack, will remove.

> > +{
> > +       return offset < SGPIO_OUTPUT_OFFSET;
> > +}
> >  static int aspeed_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
> >  {
> >         struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
> >         unsigned long flags;
> > +       int rc;
> > 
> > -       spin_lock_irqsave(&gpio->lock, flags);
> > -
> > -       gpio->dir_in[GPIO_BANK(offset)] &= ~GPIO_BIT(offset);
> > -       sgpio_set_value(gc, offset, val);
> > +       /* No special action is required for setting the direction; we'll
> > +        * error-out in sgpio_set_value if this isn't an output GPIO */
> > 
> > +       spin_lock_irqsave(&gpio->lock, flags);
> > +       rc = sgpio_set_value(gc, offset, val);
> >         spin_unlock_irqrestore(&gpio->lock, flags);
> > 
> >         return 0;
> 
> I think this should be 'return rc'

Yup. I'll send a v2 with these changes.

Cheers,


Jeremy


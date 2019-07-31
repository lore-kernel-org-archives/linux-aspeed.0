From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 31 Jul 2019 16:25:45 -0400
Subject: [v6 2/2] gpio: aspeed: Add SGPIO driver
In-Reply-To: <1564500268-2627-3-git-send-email-hongweiz@ami.com>
References: <1564500268-2627-3-git-send-email-hongweiz@ami.com>
Message-ID: <1564604745-1639-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andrew,
Thanks so much for your help.

> From:	Andrew Jeffery <andrew@aj.id.au>
> Sent:	Tuesday, July 30, 2019 8:19 PM
> To:	Hongwei Zhang; Linus Walleij; linux-gpio at vger.kernel.org
> Cc:	Joel Stanley; linux-aspeed at lists.ozlabs.org; Bartosz Golaszewski; linux-kernel at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject:	Re: [v6 2/2] gpio: aspeed: Add SGPIO driver
> 
> 
> 
> On Wed, 31 Jul 2019, at 00:55, Hongwei Zhang wrote:
> > Add SGPIO driver support for Aspeed AST2500 SoC.
> > 
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > ---
> >  drivers/gpio/sgpio-aspeed.c | 521 
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 521 insertions(+)
> >  create mode 100644 drivers/gpio/sgpio-aspeed.c
> > 
> > diff --git a/drivers/gpio/sgpio-aspeed.c b/drivers/gpio/sgpio-aspeed.c 
> > new file mode 100644 index 0000000..9a17b1a
> > --- /dev/null
> > +++ b/drivers/gpio/sgpio-aspeed.c
> > @@ -0,0 +1,521 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright 2019 American Megatrends International LLC.
> > + *
> > + * Author: Karthikeyan Mani <karthikeyanm@amiindia.co.in>  */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/init.h>
> > +
> > +static void aspeed_sgpio_set(struct gpio_chip *gc, unsigned int
> > offset, int val)
> > +{
> > +	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
> > +	const struct aspeed_sgpio_bank *bank = to_bank(offset);
> > +	unsigned long flags;
> > +	void __iomem *addr;
> > +	u32 reg = 0;
> > +
> > +	spin_lock_irqsave(&gpio->lock, flags);
> > +
> > +	addr = bank_reg(gpio, bank, reg_val);
> > +
> > +	if (val)
> > +		reg |= GPIO_BIT(offset);
> > +	else
> > +		reg &= ~GPIO_BIT(offset);
> 
> reg is zero-initialised above and you haven't read from addr to assign to reg, so the else branch is 
> redundant (reg is already zeroed). This path has a bug - you're clearing the state of all GPIOs associated 
> with addr rather than just the GPIO associated with offset.
> 

you're correct, this is fixed in v7.

> > +
> > +	iowrite32(reg, addr);
> > +
> > +	spin_unlock_irqrestore(&gpio->lock, flags); }
> > +
> > +
> > +static int aspeed_sgpio_dir_out(struct gpio_chip *gc, unsigned int
> > offset, int val)
> > +{
> > +	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&gpio->lock, flags);
> > +	gpio->dir_in[GPIO_BANK(offset)] &= ~GPIO_BIT(offset);
> > +	spin_unlock_irqrestore(&gpio->lock, flags);
> > +
> > +	aspeed_sgpio_set(gc, offset, val);
> 
> In this case you should probably have an unlocked variant of aspeed_sgpio_set() so you can call it inside 
> the the critical section above instead of needing to acquire/release the lock twice (once above and again 
> in aspeed_sgpio_set() as it stands).
> 

moved _sgpio_set() so only one pair of acquire/release lock used.

> Cheers,
> 
> Andrew
> 

Thanks,
--Hongwei

> > +
> > +	return 0;
> > +}
> > +
> > --
> > 2.7.4
> > 
> >

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Dec 2020 16:14:33 +0200
Subject: [PATCH] gpio: aspeed: Lock GPIO pin used as IRQ
In-Reply-To: <20201210065013.29348-1-troy_lee@aspeedtech.com>
References: <20201210065013.29348-1-troy_lee@aspeedtech.com>
Message-ID: <CAHp75VcMuHiUFgSas26DA-Bh1gGA_G5FT+9cetK=En9Q_oMZtg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 10, 2020 at 9:36 AM Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> GPIO pins can be used as IRQ indicators. When they do,
> those pins should be flaged with locks to avoid kernel

flagged

> warning message.

...

> @@ -651,6 +651,13 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)

> +       rc = gpiochip_lock_as_irq(&gpio->chip, d->hwirq);
> +       if (rc) {
> +               dev_err(gpio->chip.parent, "unable to lock GPIO %lu as IRQ\n",
> +                       d->hwirq);
> +               return rc;
> +       }

It's a copy'n'paste of generic code. Why do you need it in an unusual
place, i.e. ->irq_set_type() IIUC?
Can you elaborate about an issue, because this seems to be a hack?

-- 
With Best Regards,
Andy Shevchenko

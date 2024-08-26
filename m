From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 26 Aug 2024 12:56:19 +0200
Subject: [PATCH 2/2] gpio: Add G7 Aspeed gpio controller driver
In-Reply-To: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
References: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
Message-ID: <42c569f4-9171-46e0-9df3-72c583106cc4@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

?
> +++ b/drivers/gpio/gpio-aspeed-g7.c
> @@ -0,0 +1,831 @@
?
> +static void aspeed_gpio_g7_set(struct gpio_chip *gc, unsigned int offset, int val)
> +{
?
> +	raw_spin_lock_irqsave(&gpio->lock, flags);
> +
> +	__aspeed_gpio_g7_set(gc, offset, val);
> +
> +	raw_spin_unlock_irqrestore(&gpio->lock, flags);
> +}
?

Under which circumstances would you become interested to apply a statement
like ?guard(raw_spinlock_irqsave)(&gpio->lock);??
https://elixir.bootlin.com/linux/v6.11-rc5/source/include/linux/spinlock.h#L551

Regards,
Markus

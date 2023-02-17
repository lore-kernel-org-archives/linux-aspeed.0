From: Tony Lindgren <tony@atomide.com>
Date: Fri, 17 Feb 2023 09:49:37 +0200
Subject: [PATCH 15/17] gpio: omap: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
Message-ID: <Y+8xkV5aUrAajLNP@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

* Linus Walleij <linus.walleij@linaro.org> [230216 09:38]:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
> 
> This driver require some special care: .irq_ack() was copied
> from dummy_irq_chip where it was defined as noop. This only
> makes sense if using handle_edge_irq() that will unconditionally
> call .irq_ack() to avoid a crash, but this driver is not ever
> using handle_edge_irq() so just avoid assigning .irq_ack().
> 
> A separate chip had to be created for the non-wakeup instance.

Nice, works for me.

BTW, I still see these warnings remaining on boot:

gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.

Seems like we might be able to get rid of those too now or are
there still some dependencies with /sys/class/gpio for example?

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

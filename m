From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 17 Feb 2023 17:31:08 +0100
Subject: [PATCH 15/17] gpio: omap: Convert to immutable irq_chip
In-Reply-To: <Y+8xkV5aUrAajLNP@atomide.com>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
	<20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
	<Y+8xkV5aUrAajLNP@atomide.com>
Message-ID: <20230217173108.1448ce92@aktux>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 17 Feb 2023 09:49:37 +0200
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Linus Walleij <linus.walleij@linaro.org> [230216 09:38]:
> > Convert the driver to immutable irq-chip with a bit of
> > intuition.
> > 
> > This driver require some special care: .irq_ack() was copied
> > from dummy_irq_chip where it was defined as noop. This only
> > makes sense if using handle_edge_irq() that will unconditionally
> > call .irq_ack() to avoid a crash, but this driver is not ever
> > using handle_edge_irq() so just avoid assigning .irq_ack().
> > 
> > A separate chip had to be created for the non-wakeup instance.  
> 
> Nice, works for me.
> 
> BTW, I still see these warnings remaining on boot:
> 
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> 
> Seems like we might be able to get rid of those too now or are
> there still some dependencies with /sys/class/gpio for example?
> 
on what are you testing? on -next? I thought I have fixed theese warning with
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=92bf78b33b0b463b00c6b0203b49aea845daecc8

Regards,
Andreas

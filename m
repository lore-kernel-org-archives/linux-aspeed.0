From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 19 May 2021 15:57:47 +0930
Subject: [PATCH v2 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
In-Reply-To: <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-3-andrew@aj.id.au>
 <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
Message-ID: <2bb7dfc4-a20e-4e3e-8fa5-74ff264c4e44@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 19 May 2021, at 15:44, Jiri Slaby wrote:
> On 19. 05. 21, 2:07, Andrew Jeffery wrote:
> > BIT(x) improves readability and safety with respect to shifts.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >   drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
> >   1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 34aa2714f3c9..4fbf1088fad8 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -7,6 +7,7 @@
> >    *  Copyright (C) 2001 Russell King.
> >    */
> >   
> > +#include <linux/bitops.h>
> >   #include <linux/serial_8250.h>
> >   #include <linux/serial_reg.h>
> >   #include <linux/dmaengine.h>
> > @@ -70,25 +71,25 @@ struct serial8250_config {
> >   	unsigned int	flags;
> >   };
> >   
> > -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
> > -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
> > -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> > -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
> > -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
> > -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> > -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
> > -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
> > -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
> > -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> > +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
> > +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
> > +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
> 
> 
> Perfect, except the include: BIT is not defined in bitops.h, but in 
> bits.h (which includes vdso/bits.h). In fact, bitops.h includes bits.h 
> too, but it's superfluous to include all those bitops.

Maybe the recommendation in the checkpatch documentation should be 
fixed then?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/checkpatch.rst?h=v5.13-rc2#n473

I didn't dig through the include maze to optimise my choice.

That said, I will switch to bits.h based on your feedback above.

Thanks,

Andrew

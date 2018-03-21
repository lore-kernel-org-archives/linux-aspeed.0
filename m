From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Mar 2018 13:56:57 +1030
Subject: [PATCH 5/5] serial/aspeed-vuart: Implement quick throttle
 mechanism
In-Reply-To: <20180321025241.19785-6-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-6-jk@ozlabs.org>
Message-ID: <CACPK8Xc+BhX+8o3-z1tVWCc81rCnf5EBaFA8VqU64ywvJg6aZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On Wed, Mar 21, 2018 at 1:22 PM, Jeremy Kerr <jk@ozlabs.org> wrote:
> Although we populate the ->throttle and ->unthrottle UART operations,
> these may not be called until the ldisc has had a chance to schedule and
> check buffer space. This means that we may overflow the flip buffers
> without ever hitting the ldisc's throttle threshold.
>
> This change implements an interrupt-based throttle, where we check for
> space in the flip buffers before reading characters from the UART's
> FIFO. If there's no space available, we disable the RX interrupt and
> schedule a timer to check for space later.
>
> This prevents a case where we drop characters under heavy RX load.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 103 ++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 50c082b4a1ac..bc2b63578e58 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -14,6 +14,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
>  #include <linux/clk.h>
>
>  #include "8250.h"
> @@ -32,8 +34,16 @@ struct aspeed_vuart {
>         void __iomem            *regs;
>         struct clk              *clk;
>         int                     line;
> +       struct timer_list       unthrottle_timer;
>  };
>
> +/*
> + * If we fill the tty flip buffers, we throttle the data ready interrupt
> + * to prevent dropped characters. This timeout defines how long we wait
> + * to (conditionally, depending on buffer state) unthrottle.
> + */
> +static const int unthrottle_timeout = HZ/10;
> +
>  /*
>   * The VUART is basically two UART 'front ends' connected by their FIFO
>   * (no actual serial line in between). One is on the BMC side (management
> @@ -183,17 +193,23 @@ static void aspeed_vuart_shutdown(struct uart_port *uart_port)
>         serial8250_do_shutdown(uart_port);
>  }
>
> -static void aspeed_vuart_set_throttle(struct uart_port *port, bool throttle)
> +static void __aspeed_vuart_set_throttle(struct uart_8250_port *up,
> +               bool throttle)
>  {
>         unsigned char irqs = UART_IER_RLSI | UART_IER_RDI;
> -       struct uart_8250_port *up = up_to_u8250p(port);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&port->lock, flags);

The diff is a bit confusing, considering you just added these
functions. Can you explain why you did it that way?

Cheers,

Joel

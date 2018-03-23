From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Mar 2018 16:33:50 +0100
Subject: [PATCH 1/5] serial: Introduce UPSTAT_SYNC_FIFO for synchronised
 FIFOs
In-Reply-To: <20180321025241.19785-2-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-2-jk@ozlabs.org>
Message-ID: <20180323153350.GC25972@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 21, 2018 at 10:52:37AM +0800, Jeremy Kerr wrote:
> This change adds a flag to indicate that a UART is has an external means
> of synchronising its FIFO, without needing CTSRTS or XON/XOFF.
> 
> This allows us to use the throttle/unthrottle callbacks, without having
> to claim other methods of flow control.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
>  drivers/tty/serial/serial_core.c | 4 ++--
>  include/linux/serial_core.h      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f534a40aebde..8f3dfc8b5307 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -678,7 +678,7 @@ static void uart_throttle(struct tty_struct *tty)
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
>  
> -	if (port->status & mask) {
> +	if (port->status & (mask | UPSTAT_SYNC_FIFO)) {
>  		port->ops->throttle(port);
>  		mask &= ~port->status;
>  	}

Why not just set mask to UPSTAT_SYNC_FIFO at the top of this function?

> @@ -707,7 +707,7 @@ static void uart_unthrottle(struct tty_struct *tty)
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
>  
> -	if (port->status & mask) {
> +	if (port->status & (mask | UPSTAT_SYNC_FIFO)) {
>  		port->ops->unthrottle(port);
>  		mask &= ~port->status;
>  	}

Same here.  Would make it a bit more obvious (at least to me...)

thanks,

greg k-h

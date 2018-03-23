From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 10:50:26 -0500
Subject: [PATCH 1/5] serial: Introduce UPSTAT_SYNC_FIFO for synchronised
 FIFOs
In-Reply-To: <20180321025241.19785-2-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-2-jk@ozlabs.org>
Message-ID: <2708b9bf-cf8b-a98e-d64b-abb1c90a927f@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 03/20/2018 09:52 PM, Jeremy Kerr wrote:
> This change adds a flag to indicate that a UART is has an external means
> of synchronising its FIFO, without needing CTSRTS or XON/XOFF.
>
> This allows us to use the throttle/unthrottle callbacks, without having
> to claim other methods of flow control.

This series fixed extremely heavy cpu usage we were getting with a lot 
of traffic coming in on the console. System is usable again with console 
getting hammered.

Tested-by: Eddie James <eajames@linux.vnet.ibm.com>

>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
>   drivers/tty/serial/serial_core.c | 4 ++--
>   include/linux/serial_core.h      | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f534a40aebde..8f3dfc8b5307 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -678,7 +678,7 @@ static void uart_throttle(struct tty_struct *tty)
>   	if (C_CRTSCTS(tty))
>   		mask |= UPSTAT_AUTORTS;
>
> -	if (port->status & mask) {
> +	if (port->status & (mask | UPSTAT_SYNC_FIFO)) {
>   		port->ops->throttle(port);
>   		mask &= ~port->status;
>   	}
> @@ -707,7 +707,7 @@ static void uart_unthrottle(struct tty_struct *tty)
>   	if (C_CRTSCTS(tty))
>   		mask |= UPSTAT_AUTORTS;
>
> -	if (port->status & mask) {
> +	if (port->status & (mask | UPSTAT_SYNC_FIFO)) {
>   		port->ops->unthrottle(port);
>   		mask &= ~port->status;
>   	}
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 1775500294bb..bf600ae0290d 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -232,6 +232,7 @@ struct uart_port {
>   #define UPSTAT_AUTORTS		((__force upstat_t) (1 << 2))
>   #define UPSTAT_AUTOCTS		((__force upstat_t) (1 << 3))
>   #define UPSTAT_AUTOXOFF		((__force upstat_t) (1 << 4))
> +#define UPSTAT_SYNC_FIFO	((__force upstat_t) (1 << 5))
>
>   	int			hw_stopped;		/* sw-assisted CTS flow state */
>   	unsigned int		mctrl;			/* current modem ctrl settings */


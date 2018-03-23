From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 10:51:27 -0500
Subject: [PATCH 4/5] serial/aspeed-vuart: Implement rx throttling
In-Reply-To: <20180321025241.19785-5-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-5-jk@ozlabs.org>
Message-ID: <8eb7d8e4-92ef-766c-9c8b-6725ef121085@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 03/20/2018 09:52 PM, Jeremy Kerr wrote:
> The aspeed VUART runs at LPC bus frequency, rather than being restricted
> to a typical UART baud rate. This means that the VUART can receive a lot
> of data, which can overrun tty flip buffers, and/or cause a large amount
> of interrupt traffic.
>
> This change implements the uart_port->throttle & unthrottle callbacks,
> implemented by disabling the receiver line status & received data
> available IRQs.

Tested-by: Eddie James <eajames@linux.vnet.ibm.com>

>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
>   drivers/tty/serial/8250/8250_aspeed_vuart.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 33a801353114..50c082b4a1ac 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -183,6 +183,30 @@ static void aspeed_vuart_shutdown(struct uart_port *uart_port)
>   	serial8250_do_shutdown(uart_port);
>   }
>
> +static void aspeed_vuart_set_throttle(struct uart_port *port, bool throttle)
> +{
> +	unsigned char irqs = UART_IER_RLSI | UART_IER_RDI;
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	up->ier &= ~irqs;
> +	if (!throttle)
> +		up->ier |= irqs;
> +	serial_out(up, UART_IER, up->ier);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void aspeed_vuart_throttle(struct uart_port *port)
> +{
> +	aspeed_vuart_set_throttle(port, true);
> +}
> +
> +static void aspeed_vuart_unthrottle(struct uart_port *port)
> +{
> +	aspeed_vuart_set_throttle(port, false);
> +}
> +
>   static int aspeed_vuart_probe(struct platform_device *pdev)
>   {
>   	struct uart_8250_port port;
> @@ -212,6 +236,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>   	port.port.mapsize = resource_size(res);
>   	port.port.startup = aspeed_vuart_startup;
>   	port.port.shutdown = aspeed_vuart_shutdown;
> +	port.port.throttle = aspeed_vuart_throttle;
> +	port.port.unthrottle = aspeed_vuart_unthrottle;
> +	port.port.status = UPSTAT_SYNC_FIFO;
>   	port.port.dev = &pdev->dev;
>
>   	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);


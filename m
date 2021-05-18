From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 18 May 2021 11:00:39 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_tty:_8250:_Add_UART=5FBUG=5FTXRACE_workaround_for_?=
 =?UTF-8?Q?Aspeed_VUART?=
In-Reply-To: <YKJ6aP/xqAe1hW6A@kroah.com>
References: <20210517124105.3565860-1-andrew@aj.id.au>
 <YKJ6aP/xqAe1hW6A@kroah.com>
Message-ID: <d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 17 May 2021, at 23:45, Greg KH wrote:
> On Mon, May 17, 2021 at 10:11:05PM +0930, Andrew Jeffery wrote:
> > Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
> > LPC bus to the UART interface on the BMC's internal APB. As such there's
> > no RS-232 signalling involved - the UART interfaces on each bus are
> > directly connected as the producers and consumers of the one set of
> > FIFOs.
> > 
> > The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
> > at 33MHz. The difference in clock speeds exposes a race in the VUART
> > design where a Tx data burst on the APB interface can result in a byte
> > lost on the LPC interface. The symptom is LSR[DR] remains clear on the
> > LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
> > remains clear on the APB interface as the host has not consumed the data
> > the BMC has transmitted. In this state, the UART has stalled and no
> > further data can be transmitted without manual intervention (e.g.
> > resetting the FIFOs, resulting in loss of data).
> > 
> > The recommended work-around is to insert a read cycle on the APB
> > interface between writes to THR.
> > 
> > Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/tty/serial/8250/8250.h              | 1 +
> >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
> >  drivers/tty/serial/8250/8250_port.c         | 2 ++
> >  3 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 52bb21205bb6..4d6f5e0ecd4c 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -88,6 +88,7 @@ struct serial8250_config {
> >  #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
> >  #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
> >  #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> > +#define UART_BUG_TXRACE (1 << 5)	/* UART Tx fails to set remote DR */
> 
> BUG()?

Can you please expand on what you mean here? I don't follow.

At least, I think there might be a formatting issue (spaces vs tabs).

> 
> >  #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > index a28a394ba32a..4caab8714e2c 100644
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
> >  	port.port.status = UPSTAT_SYNC_FIFO;
> >  	port.port.dev = &pdev->dev;
> >  	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> > +	port.bugs |= UART_BUG_TXRACE;
> >  
> >  	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
> >  	if (rc < 0)
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index d45dab1ab316..6c032abfc321 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1809,6 +1809,8 @@ void serial8250_tx_chars(struct uart_8250_port *up)
> >  	count = up->tx_loadsz;
> >  	do {
> >  		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> > +		if (up->bugs & UART_BUG_TXRACE)
> > +			serial_in(up, UART_SCR);
> 
> Can you document why you are doing a call here to serial_in(), otherwise
> someone running "automated checking scripts" will remove it later as it
> seems to be doing nothing.

Good point, I'll add a comment.

Thanks,

Andrew

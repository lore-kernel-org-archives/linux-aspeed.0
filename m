From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 18 May 2021 08:38:06 +0200
Subject: [PATCH] tty: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
In-Reply-To: <d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com>
References: <20210517124105.3565860-1-andrew@aj.id.au>
 <YKJ6aP/xqAe1hW6A@kroah.com>
 <d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com>
Message-ID: <YKNgziMXms4zWRoY@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 18, 2021 at 11:00:39AM +0930, Andrew Jeffery wrote:
> 
> 
> On Mon, 17 May 2021, at 23:45, Greg KH wrote:
> > On Mon, May 17, 2021 at 10:11:05PM +0930, Andrew Jeffery wrote:
> > > Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
> > > LPC bus to the UART interface on the BMC's internal APB. As such there's
> > > no RS-232 signalling involved - the UART interfaces on each bus are
> > > directly connected as the producers and consumers of the one set of
> > > FIFOs.
> > > 
> > > The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
> > > at 33MHz. The difference in clock speeds exposes a race in the VUART
> > > design where a Tx data burst on the APB interface can result in a byte
> > > lost on the LPC interface. The symptom is LSR[DR] remains clear on the
> > > LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
> > > remains clear on the APB interface as the host has not consumed the data
> > > the BMC has transmitted. In this state, the UART has stalled and no
> > > further data can be transmitted without manual intervention (e.g.
> > > resetting the FIFOs, resulting in loss of data).
> > > 
> > > The recommended work-around is to insert a read cycle on the APB
> > > interface between writes to THR.
> > > 
> > > Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/tty/serial/8250/8250.h              | 1 +
> > >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
> > >  drivers/tty/serial/8250/8250_port.c         | 2 ++
> > >  3 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > > index 52bb21205bb6..4d6f5e0ecd4c 100644
> > > --- a/drivers/tty/serial/8250/8250.h
> > > +++ b/drivers/tty/serial/8250/8250.h
> > > @@ -88,6 +88,7 @@ struct serial8250_config {
> > >  #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
> > >  #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
> > >  #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
> > > +#define UART_BUG_TXRACE (1 << 5)	/* UART Tx fails to set remote DR */
> > 
> > BUG()?
> 
> Can you please expand on what you mean here? I don't follow.
> 
> At least, I think there might be a formatting issue (spaces vs tabs).

Ick, my fault, I meant "BIT()"?  To perhaps use that macro instead of the <<
symbol.

And yes, tabs would be good as well :)

thanks,

greg k-h



From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 19 May 2021 14:28:18 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/2]_serial:_8250:_Add_UART=5FBUG=5FTXRACE_worka?=
 =?UTF-8?Q?round_for_Aspeed_VUART?=
In-Reply-To: <CACPK8XdqeS+rE0Jz9SF+sSMUaxmg7vFtghhiZNbDpKRNbBZK=Q@mail.gmail.com>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-2-andrew@aj.id.au>
 <CACPK8XdqeS+rE0Jz9SF+sSMUaxmg7vFtghhiZNbDpKRNbBZK=Q@mail.gmail.com>
Message-ID: <66904cc2-a4ef-42db-a1c9-b12ceecb52c1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 19 May 2021, at 10:28, Joel Stanley wrote:
> On Wed, 19 May 2021 at 00:07, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
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
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> > ---
> >  drivers/tty/serial/8250/8250.h              |  1 +
> >  drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
> >  drivers/tty/serial/8250/8250_port.c         | 10 ++++++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 52bb21205bb6..34aa2714f3c9 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -88,6 +88,7 @@ struct serial8250_config {
> >  #define UART_BUG_NOMSR (1 << 2)        /* UART has buggy MSR status bits (Au1x00) */
> >  #define UART_BUG_THRE  (1 << 3)        /* UART has buggy THRE reassertion */
> >  #define UART_BUG_PARITY        (1 << 4)        /* UART mishandles parity if FIFO enabled */
> > +#define UART_BUG_TXRACE        (1 << 5)        /* UART Tx fails to set remote DR */
> >
> >
> >  #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > index a28a394ba32a..4caab8714e2c 100644
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
> >         port.port.status = UPSTAT_SYNC_FIFO;
> >         port.port.dev = &pdev->dev;
> >         port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> > +       port.bugs |= UART_BUG_TXRACE;
> 
> A future enhancement would be to have this depend on the ast2600
> compatible string, so we don't enable the feature for ast2400/ast2500.
> 
> That would also mean adding a compatible string for the ast2600.

Yep, I'll sort out some cleanups in that regard in a separate series.

Andrew

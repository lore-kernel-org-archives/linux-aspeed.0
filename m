From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 22 Mar 2023 08:34:36 +0000
Subject: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
In-Reply-To: <a5b0d7d8-d78a-a12f-783-419713742d5@linux.intel.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
 <20230320081133.23655-5-chiawei_wang@aspeedtech.com>
 <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
 <KL1PR0601MB37819E400753132F11F0202D91809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
 <a5b0d7d8-d78a-a12f-783-419713742d5@linux.intel.com>
Message-ID: <KL1PR0601MB3781185930057DB03293660B91869@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Ilpo J?rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Monday, March 20, 2023 6:49 PM
> 
> On Mon, 20 Mar 2023, ChiaWei Wang wrote:
> 
> > > From: Ilpo J?rvinen <ilpo.jarvinen@linux.intel.com>
> > > Sent: Monday, March 20, 2023 5:43 PM
> > >
> > > On Mon, 20 Mar 2023, Chia-Wei Wang wrote:
> > >
> > > > Add new UART driver with DMA support for Aspeed AST2600 SoCs.
> > > > The drivers mainly prepare the dma instance based on the 8250_dma
> > > > implementation to leverage the AST2600 UART DMA (UDMA) engine.
> > > >
> > > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_aspeed.c | 224
> > > ++++++++++++++++++++++++++
> > > >  drivers/tty/serial/8250/Kconfig       |   8 +
> > > >  drivers/tty/serial/8250/Makefile      |   1 +
> > > >  3 files changed, 233 insertions(+)  create mode 100644
> > > > drivers/tty/serial/8250/8250_aspeed.c
> > > >
> > > > diff --git a/drivers/tty/serial/8250/8250_aspeed.c
> > > > b/drivers/tty/serial/8250/8250_aspeed.c
> > > > new file mode 100644
> > > > index 000000000000..04d0bf6fba28
> > > > --- /dev/null
> > > > +++ b/drivers/tty/serial/8250/8250_aspeed.c
> > > > @@ -0,0 +1,224 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) ASPEED Technology Inc.
> > > > + */
> > > > +#include <linux/device.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/serial_8250.h>
> > > > +#include <linux/serial_reg.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_irq.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/platform_device.h> #include <linux/clk.h>
> > > > +#include <linux/reset.h> #include <linux/dma-mapping.h> #include
> > > > +<linux/circ_buf.h> #include <linux/tty_flip.h> #include
> > > > +<linux/pm_runtime.h>
> > > > +
> > > > +#include "8250.h"
> > > > +
> > > > +#define DEVICE_NAME "aspeed-uart"
> > > > +
> > > > +struct ast8250_data {
> > > > +	int line;
> > > > +	int irq;
> > > > +	u8 __iomem *regs;
> > > > +	struct reset_control *rst;
> > > > +	struct clk *clk;
> > > > +#ifdef CONFIG_SERIAL_8250_DMA
> > > > +	struct uart_8250_dma dma;
> > > > +#endif
> > > > +};
> > > > +
> > > > +#ifdef CONFIG_SERIAL_8250_DMA
> > > > +static int ast8250_rx_dma(struct uart_8250_port *p);
> > > > +
> > > > +static void ast8250_rx_dma_complete(void *param) {
> > > > +	struct uart_8250_port *p = param;
> > > > +	struct uart_8250_dma *dma = p->dma;
> > > > +	struct tty_port *tty_port = &p->port.state->port;
> > > > +	struct dma_tx_state	state;
> > > > +	int	count;
> > > > +
> > > > +	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> > > > +
> > > > +	count = dma->rx_size - state.residue;
> > > > +
> > > > +	tty_insert_flip_string(tty_port, dma->rx_buf, count);
> > > > +	p->port.icount.rx += count;
> > > > +
> > > > +	tty_flip_buffer_push(tty_port);
> > > > +
> > > > +	ast8250_rx_dma(p);
> > > > +}
> > > > +
> > > > +static int ast8250_rx_dma(struct uart_8250_port *p) {
> > > > +	struct uart_8250_dma *dma = p->dma;
> > > > +	struct dma_async_tx_descriptor *tx;
> > > > +
> > > > +	tx = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
> > > > +					 dma->rx_size, DMA_DEV_TO_MEM,
> > > > +					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > > > +	if (!tx)
> > > > +		return -EBUSY;
> > >
> > > How does the DMA Rx "loop" restart when this is taken?
> >
> > The loop re-starts from ast8250_startup.
> 
> Why would startup get called again?

Sorry for misleading, it relies on handle_rx_dma that restarts the loop

If UDMA suddenly shutdown, RX data stays in UART FIFO and thus triggers an interrupt.
The ISR call chain, serial8250_handle_irq -> handle_rx_dma, will restarts the UDMA loop.

However, before UDMA is restarted, there is a window suffering the same overrun issue as mentioned before.
I think make the default code support "RX DMA AO (Always On)" is certain to avoid producing more duplicated code with little customizations.

> 
> > > > +	tx->callback = ast8250_rx_dma_complete;
> > > > +	tx->callback_param = p;
> > > > +
> > > > +	dma->rx_cookie = dmaengine_submit(tx);
> > > > +
> > > > +	dma_async_issue_pending(dma->rxchan);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > >
> > > These 2 functions look very similar to what 8250_dma offers for you.
> > > The only difference I could see is that always start DMA Rx thing
> > > which could be handled by adding some capability flag into
> > > uart_8250_dma for those UARTs that can launch DMA Rx while Rx queue is
> empty.
> > >
> > > So, just use the standard 8250_dma functions and make the small
> > > capabilities flag tweak there.
> > >
> > > By using the stock functions you also avoid 8250_dma Rx and your DMA
> > > Rx racing like they currently would (8250_port assigns the functions
> > > from 8250_dma when you don't specify the rx handler and the default
> > > 8250 irq handler will call into those standard 8250 DMA functions).
> >
> > Yes for the difference described.
> >
> > Our customers usually use UDMA for file-transmissions over UART.
> > And I found the preceding bytes will get lost easily due to the late
> > start of DMA engine.
> >
> > In fact, I was seeking the default implementation to always start RX
> > DMA instead of enabling it upon DR bit rising. But no luck and thus
> > add ast8250_rx_dma. (The default 8250 ISR also called into
> > up->dma->rx_dma)
> >
> > If adding a new capability flag is the better way to go, I will try to
> > implement in that way for further review.
> 
> Yes it would be much better.
> 
> Add unsigned int capabilities into uart_8250_dma and put the necessary
> checks + code into general code. Don't add any #ifdef
> CONFIG_SERIAL_8250_DMA into 8250_port.c nor 8250_dma.c. Instead, if you
> feel a need for one, use the #ifdef ... #else ... #endif in 8250.h to provide an
> empty static inline function for the #else case.
> 

Got it. I will get the patch prepared for your review in v4 revision.

> > > I'm curious about this HW and how it behaves under these two scenarios:
> > > - When Rx is empty, does UART/DMA just sit there waiting forever?
> >
> > Yes.
> 
> Okay.
> 
> > > - When a stream of incoming Rx characters suddenly ends, how does
> > > UART/DMA
> > >   react? ...On 8250 UARTs I'm familiar with this triggers
> UART_IIR_TIMEOUT
> > >   which you don't seem to handle.
> >
> > UDMA also has a timeout control.
> > If the data suddenly ends and timeout occurs, UDMA will trigger an
> interrupt.
> > UDMA ISR then check if there is data available using DMA read/write
> > pointers and invokes callback if any.
> 
> Okay. And the UART side won't trigger any interrupts?

UART side still triggers interrupts.

However, for RX data, UDMA keep polling DR bit and read the data out from UART FIFO.
Thus when serial8250_handle_irq ISR checks IIR, it gets no interrupt pending as data has been taken.
The ISR will return if no other events.

> 
> > > When you provide answer to those two questions, I can try to help
> > > you further on how to integrate into the standard 8250 DMA code.
> >
> > Thanks!
> > It would be great using the default one to avoid mostly duplicated code.
> 
> You need to take a look into handle_rx_dma() what to do there. Probably just
> call to ->rx_dma() unconditionally to prevent UART interrupts from messing up
> with DMA Rx. This restart for DMA Rx is just for backup if the DMA Rx "loop"
> stopped due to an error.

Yes. A new if-condition to support "RX DMA AO" should be needed.

Thanks for the review and feedback.
I will move on to v4 revision with default code modification.

Regards,
Chiawei

From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 28 Nov 2023 09:30:01 +1030
Subject: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
In-Reply-To: <854762fb-1767-4208-a7fc-10580730c1f3@os.amperecomputing.com>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
	 <fdd884426497486c6b17795b4edc66243bdc7350.camel@codeconstruct.com.au>
	 <CAOeEDyumVdi-3O3apMUFJ695V3YcZqZQ7wvzYL2YfU88XJ3Dxw@mail.gmail.com>
	 <854762fb-1767-4208-a7fc-10580730c1f3@os.amperecomputing.com>
Message-ID: <d0773df55a6fe8a5c9b1a3d7c8dd2e1343643272.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-11-27 at 15:08 +0700, Quan Nguyen wrote:
> 
> On 27/11/2023 14:04, Cosmo Chou wrote:
> > Andrew Jeffery <andrew@codeconstruct.com.au> wrote on Mon, 2023-11-27
> > at 11:23 AM:
> > > 
> > > On Mon, 2023-11-20 at 17:17 +0800, Cosmo Chou wrote:
> > > > commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
> > > > in interrupt handler") moved most interrupt acknowledgments to the
> > > > start of the interrupt handler to avoid race conditions. However,
> > > > slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
> > > > is handled.
> > > > 
> > > > Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
> > > > the problem that the next byte is not sent correctly.
> > > 
> > > What does this mean in practice? Can you provide more details? It
> > > sounds like you've seen concrete problems and it would be nice to
> > > capture what it was that occurred.
> > > 
> > > Andrew
> > 
> > For a normal slave transaction, a master attempts to read out N bytes
> > from BMC: (BMC addr: 0x20)
> > [S] [21] [A] [1st_B] [1_ack] [2nd_B] [2_ack] ... [Nth_B] [N] [P]
> > 
> > T1: when [21] [A]: Both INTR_SLAVE_MATCH and INTR_RX_DONE rise,
> > INTR_RX_DONE is not cleared until BMC is ready to send the 1st_B:
> > https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-aspeed.c#L294
> > That is, BMC stretches the SCL until ready to send the 1st_B.
> > 
> > T2: when [1_ack]: INTR_TX_ACK rises, but it's cleared at the start of
> > the ISR, so that BMC does not stretch the SCL, the master continues
> > to read 2nd_B before BMC is ready to send the 2nd_B.
> > 
> > To fix this, do not clear INTR_TX_ACK until BMC is ready to send data:
> > https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-aspeed.c#L302
> > 
> 
> This looks like the same issue, but we chose to ack them late. Same with 
> INTR_RX_DONE.
> 
> https://lore.kernel.org/all/20210616031046.2317-3-quan at os.amperecomputing.com/

From a brief inspection I prefer the descriptions in your series Quan.
Looks like we dropped the ball a bit there though on the review - can
you resend your series based on 6.7-rc1 or so and Cc Cosmo?

Cheers,

Andrew

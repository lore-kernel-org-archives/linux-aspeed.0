From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 27 Nov 2023 13:53:02 +1030
Subject: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
In-Reply-To: <20231120091746.2866232-1-chou.cosmo@gmail.com>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
Message-ID: <fdd884426497486c6b17795b4edc66243bdc7350.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-11-20 at 17:17 +0800, Cosmo Chou wrote:
> commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
> in interrupt handler") moved most interrupt acknowledgments to the
> start of the interrupt handler to avoid race conditions. However,
> slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
> is handled.
> 
> Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
> the problem that the next byte is not sent correctly.

What does this mean in practice? Can you provide more details? It
sounds like you've seen concrete problems and it would be nice to
capture what it was that occurred.

Andrew

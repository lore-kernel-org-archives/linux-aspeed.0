From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 12 Dec 2023 09:33:17 +1030
Subject: [PATCH v4 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
In-Reply-To: <20231211102217.2436294-3-quan@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
	 <20231211102217.2436294-3-quan@os.amperecomputing.com>
Message-ID: <2eab42cde34723a195e7a0287db08b25f8388a3b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-12-11 at 17:22 +0700, Quan Nguyen wrote:
> Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
> interrupt handler") acknowledges most interrupts early before the slave
> irq handler is executed, except for the "Receive Done Interrupt status"
> which is acknowledged late in the interrupt.
> However, it has been observed that the early acknowledgment of "Transmit
> Done Interrupt Status" (with ACK or NACK) often causes the interrupt to
> be raised in READ REQUEST state, that shows the
> "Unexpected ACK on read request." complaint messages.
> 
> Assuming that the "Transmit Done" interrupt should only be acknowledged
> once it is truly processed, this commit fixes that issue by acknowledging
> interrupts for both ACK and NACK cases late in the interrupt handler.
> 
> Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Quan!

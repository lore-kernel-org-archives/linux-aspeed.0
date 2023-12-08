From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 08 Dec 2023 14:30:18 +1030
Subject: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
In-Reply-To: <20231208033142.1673232-3-quan@os.amperecomputing.com>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
	 <20231208033142.1673232-3-quan@os.amperecomputing.com>
Message-ID: <dc36d61aedd2b2389eb366b27436f19d934fc93b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2023-12-08 at 10:31 +0700, Quan Nguyen wrote:
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
> ---
> v3:
>   + Fix the unconditinal write when ack the irqs               [Andrew]
>   + Refactor the code to enhance code readability                [Quan]
>   + Fix grammar in commit message                                [Quan]
> 
> v2:
>   + Split to separate series                                     [Joel]
>   + Added the Fixes line                                         [Joel]
>   + Fixed multiline comment                                      [Joel]
>   + Refactor irq clearing code                          [Joel, Guenter]
>   + Revised commit message                                       [Joel]
>   + Revised commit message                                       [Quan]
>   + About a note to remind why the readl() should immediately follow the
> writel() to fix the race condition when clearing irq status from commit
> c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
> condition"), I think it looks straight forward in this patch and decided
> not to add that note.                                            [Joel]
> 
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 1c2a4f4c4e1b..967a26dd4ffa 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -617,13 +617,19 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>  	struct aspeed_i2c_bus *bus = dev_id;
> -	u32 irq_received, irq_remaining, irq_handled;
> +	u32 irq_received, irq_remaining, irq_handled, irq_ack_last;

`irq_ack_last` might be better as a macro, but you're probably saved by
the optimiser anyway. If there's another reason to do a v4 or others
are unhappy with it then consider fixing it, otherwise:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks.

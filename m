From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 20 May 2021 21:03:33 +0700
Subject: [PATCH v3 4/7] i2c: aspeed: Acknowledge Tx done w/wo ACK irq late
In-Reply-To: <414a51e8-0973-0007-9ffc-2949f3c7b0f8@roeck-us.net>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-5-quan@os.amperecomputing.com>
 <CACPK8XdyQT=cuSr9KBqC0PBkOLgBUBpyz3kZEA3JuOuZsQN_Rw@mail.gmail.com>
 <414a51e8-0973-0007-9ffc-2949f3c7b0f8@roeck-us.net>
Message-ID: <f7b8ee1d-61dc-68a8-f60e-25f99e104c04@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/05/2021 08:19, Guenter Roeck wrote:
> On 5/19/21 4:43 PM, Joel Stanley wrote:
>> On Wed, 19 May 2021 at 07:50, Quan Nguyen 
>> <quan@os.amperecomputing.com> wrote:
>>>
>>> With Tx done w/wo ACK are ack'ed early at beginning of irq handler,
>>
>> Is w/wo a typo? If not, please write the full words ("with and without")
>>
>>> it is observed that, usually, the Tx done with Ack irq raises in the
>>> READ REQUESTED state. This is unexpected and complaint as below appear:
>>> "Unexpected Ack on read request"
>>>
>>> Assumed that Tx done should only be ack'ed once it was truly processed,
>>> switch to late ack'ed this two irqs and seen this issue go away through
>>> test with AST2500..
>>
>> Please read Guneter's commit message
>> 2be6b47211e17e6c90ead40d24d2a5cc815f2d5c to confirm that your changes
>> do not invalidate the fix that they made.? Add them to CC for review.
>>
> 
> This might re-introduce a race condition if the code that is handling
> Tx done sends another byte without acknowledging the original interrupt,
> and another Tx done (or Tx nack) interrupt is received before the interrupt
> handler returns. If that happens, the second Tx done interrupt would be
> acknowledged but not be handled, and transmit would stall. That may well be
> what I had observed at the time but it is too long ago to remember, sorry.
> 
My assumption is that HW will start sending another byte as soon as the 
Tx done of the previous byte is ack'ed. So if it was ack'ed early before 
the slave irq handler to actually prepare the next byte to send, garbage 
value might be sent out instead.
I'm not sure if my assumption is correct but this patch do help in this 
case.
Please help with your comment.

>> Again, this is a fix that is independent of the ssif work. Please send
>> it separately with a Fixes line.
>>
>>>
>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>> ---
>>> v3:
>>> ?? + First introduce in v3 [Quan]
>>>
>>> ? drivers/i2c/busses/i2c-aspeed.c | 26 ++++++++++++++++++--------
>>> ? 1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c 
>>> b/drivers/i2c/busses/i2c-aspeed.c
>>> index 3fb37c3f23d4..b2e9c8f0ddf7 100644
>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>> @@ -606,8 +606,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, 
>>> void *dev_id)
>>>
>>> ???????? spin_lock(&bus->lock);
>>> ???????? irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>> -?????? /* Ack all interrupts except for Rx done */
>>> -?????? writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>>> +?????? /*
>>> +??????? * Ack all interrupts except for Rx done and
>>> +??????? * Tx done with/without ACK
>>
>> Nit: this comment can be on one line.
>>
>>
>>> +??????? */
>>> +?????? writel(irq_received &
>>> +????????????? ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | 
>>> ASPEED_I2CD_INTR_TX_NAK),
>>> ??????????????? bus->base + ASPEED_I2C_INTR_STS_REG);
>>> ???????? readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>> ???????? irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
>>> @@ -652,12 +656,18 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, 
>>> void *dev_id)
>>> ???????????????????????? "irq handled != irq. expected 0x%08x, but 
>>> was 0x%08x\n",
>>> ???????????????????????? irq_received, irq_handled);
>>>
>>> -?????? /* Ack Rx done */
>>> -?????? if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
>>> -?????????????? writel(ASPEED_I2CD_INTR_RX_DONE,
>>> -????????????????????? bus->base + ASPEED_I2C_INTR_STS_REG);
>>> -?????????????? readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>> -?????? }
>>> +?????? /* Ack Rx done and Tx done with/without ACK */
>>> +?????? /* Note: Re-use irq_handled variable */
>>
>> I'm not sure what this note means.
>>
>>> +?????? irq_handled = 0;
>>> +?????? if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
>>> +?????????????? irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
>>> +?????? if (irq_received & ASPEED_I2CD_INTR_TX_ACK)
>>> +?????????????? irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
>>> +?????? if (irq_received & ASPEED_I2CD_INTR_TX_NAK)
>>> +?????????????? irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>>> +?????? writel(irq_handled, bus->base + ASPEED_I2C_INTR_STS_REG);
>>
>> Are you intentionally only acking the bits that are set when we read
>> from STS_REG at the start of the handler? If not, we could write this
>> instead:
>>
>> writel(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK |
>> ASPEED_I2CD_INTR_TX_NAK,
>> ???????? bus->base + ASPEED_I2C_INTR_STS_REG);
>>
> 
> This would clear those bits unconditionally even if they were not handled.
> 
>> If you only want to ack the bits that are set, then do this:
>>
>> ?? writel(irq_received &
>> ???????????? (ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK |
>> ASPEED_I2CD_INTR_TX_NAK),
>> ????????? bus->base + ASPEED_I2C_INTR_STS_REG);
>>
>> That way, you can avoid all of the tests.
>>
> Or
>  ????irq_handled = irq_received &
>  ??????? (ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | 
> ASPEED_I2CD_INTR_TX_NAK);
>  ????writel(irq_handled, bus->base + ASPEED_I2C_INTR_STS_REG);
> 
> if the idea was to avoid the long statement.
> 
> Guenter
> 
Thanks Guenter,
Will apply in next version.

>>> +?????? readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>>
>> When you move this, please add a comment that reminds us why we do a
>> write-then-read (see commit c926c87b8e36dcc0ea5c2a0a0227ed4f32d0516a).
>>
>>> +
>>> ???????? spin_unlock(&bus->lock);
>>> ???????? return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>>> ? }
>>> -- 
>>> 2.28.0
>>>
> 


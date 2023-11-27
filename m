From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 27 Nov 2023 15:08:02 +0700
Subject: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
In-Reply-To: <CAOeEDyumVdi-3O3apMUFJ695V3YcZqZQ7wvzYL2YfU88XJ3Dxw@mail.gmail.com>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
 <fdd884426497486c6b17795b4edc66243bdc7350.camel@codeconstruct.com.au>
 <CAOeEDyumVdi-3O3apMUFJ695V3YcZqZQ7wvzYL2YfU88XJ3Dxw@mail.gmail.com>
Message-ID: <854762fb-1767-4208-a7fc-10580730c1f3@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 27/11/2023 14:04, Cosmo Chou wrote:
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote on Mon, 2023-11-27
> at 11:23 AM:
>>
>> On Mon, 2023-11-20 at 17:17 +0800, Cosmo Chou wrote:
>>> commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
>>> in interrupt handler") moved most interrupt acknowledgments to the
>>> start of the interrupt handler to avoid race conditions. However,
>>> slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
>>> is handled.
>>>
>>> Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
>>> the problem that the next byte is not sent correctly.
>>
>> What does this mean in practice? Can you provide more details? It
>> sounds like you've seen concrete problems and it would be nice to
>> capture what it was that occurred.
>>
>> Andrew
> 
> For a normal slave transaction, a master attempts to read out N bytes
> from BMC: (BMC addr: 0x20)
> [S] [21] [A] [1st_B] [1_ack] [2nd_B] [2_ack] ... [Nth_B] [N] [P]
> 
> T1: when [21] [A]: Both INTR_SLAVE_MATCH and INTR_RX_DONE rise,
> INTR_RX_DONE is not cleared until BMC is ready to send the 1st_B:
> https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-aspeed.c#L294
> That is, BMC stretches the SCL until ready to send the 1st_B.
> 
> T2: when [1_ack]: INTR_TX_ACK rises, but it's cleared at the start of
> the ISR, so that BMC does not stretch the SCL, the master continues
> to read 2nd_B before BMC is ready to send the 2nd_B.
> 
> To fix this, do not clear INTR_TX_ACK until BMC is ready to send data:
> https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-aspeed.c#L302
> 

This looks like the same issue, but we chose to ack them late. Same with 
INTR_RX_DONE.

https://lore.kernel.org/all/20210616031046.2317-3-quan at os.amperecomputing.com/


- Quan

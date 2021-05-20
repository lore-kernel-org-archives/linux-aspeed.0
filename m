From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 20 May 2021 20:48:08 +0700
Subject: [PATCH v3 3/7] i2c: aspeed: Fix unhandled Tx done with NAK
In-Reply-To: <CACPK8XeFsuEXeCvG9DC0z+tiri6ptjOFOXe3x+COEZTVqUbVFg@mail.gmail.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-4-quan@os.amperecomputing.com>
 <CACPK8XeFsuEXeCvG9DC0z+tiri6ptjOFOXe3x+COEZTVqUbVFg@mail.gmail.com>
Message-ID: <211c8380-8909-4acd-5b7e-9ba2a0f20834@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/05/2021 06:28, Joel Stanley wrote:
> Ryan, can you please review this change?
> 
> On Wed, 19 May 2021 at 07:50, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>> It is observed that in normal condition, when the last byte sent by
>> slave, the Tx Done with NAK irq will raise.
>> But it is also observed that sometimes master issues next transaction
>> too quick while the slave irq handler is not yet invoked and Tx Done
>> with NAK irq of last byte of previous READ PROCESSED was not ack'ed.
>> This Tx Done with NAK irq is raised together with the Slave Match and
>> Rx Done irq of the next coming transaction from master.
>> Unfortunately, the current slave irq handler handles the Slave Match and
>> Rx Done only in higher priority and ignore the Tx Done with NAK, causing
>> the complain as below:
>> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. expected
>> 0x00000086, but was 0x00000084"
>>
>> This commit handles this case by emitting a Slave Stop event for the
>> Tx Done with NAK before processing Slave Match and Rx Done for the
>> coming transaction from master.
> 
> It sounds like this patch is independent of the rest of the series,
> and can go in on it's own. Please send it separately to the i2c
> maintainers and add a suitable Fixes line, such as:
> 
>    Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> 
Will separate this patch into independent series in next version.

>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> v3:
>>    + First introduce in v3 [Quan]
>>
>>   drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 724bf30600d6..3fb37c3f23d4 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -254,6 +254,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>>
>>          /* Slave was requested, restart state machine. */
>>          if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> 
> Can you explain why you need to do this handing inside the SLAVE_MATCH case?

> Could you instead move the TX_NAK handling to be above the SLAVE_MATCH case?
>
>> +               if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
>> +                   bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> 
> Either way, this needs a comment to explain what we're working around.
>
Let me explain with the two examples below in normal case and the case 
where this patch is for:

In normal case:
The first transaction is Slave send (Master read):
    20(addr) 03(singlepart read) 03 1c 2e d5

Then the second Master write follow as below:
    20(addr) 02(singlepart write) 02 18 08 59

The irq will raise in sequence below:

  irq      data  from-state      to-state
00000084  20    INACTIVE        WRITE_RECEIVED
00000004  03    WRITE_RECEIVED  WRITE_RECEIVED <= RX_DONE
00000084  03    WRITE_RECEIVED  READ_PROCESSED
00000001  1c    READ_PROCESSED  READ_PROCESSED <= TX_ACK
00000001  2e    READ_PROCESSED  READ_PROCESSED
00000001  d5    READ_PROCESSED  READ_PROCESSED
00000002  xx    READ_PROCESSED  INACTIVE       <= TX_NAK

00000084  20    INACTIVE        WRITE_RECEIVED <= SLAVE_MATCH & RX_DONE
00000004  02    WRITE_RECEIVED  WRITE_RECEIVED
00000084  02    WRITE_RECEIVED  WRITE_RECEIVED
00000004  18    WRITE_RECEIVED  WRITE_RECEIVED
00000004  08    WRITE_RECEIVED  WRITE_RECEIVED
00000004  59    WRITE_RECEIVED  WRITE_RECEIVED
00000010  xx    WRITE_RECEIVED  INACTIVE

But sometimes:
The first transaction is Slave send (Master read):
    20(addr) 03(singlepart read) 03 1c 42 cc a5

Then the second Master write follow as below:
    20(addr) 02(singlepart write) 03 18 42 0c 63

The irq will raise in sequence below:

  irq      data  from-state      to-state
00000084  20    INACTIVE        WRITE_RECEIVED
00000004  03    WRITE_RECEIVED  WRITE_RECEIVED
00000084  03    WRITE_RECEIVED  READ_PROCESSED
00000001  1c    READ_PROCESSED  READ_PROCESSED
00000001  42    READ_PROCESSED  READ_PROCESSED
00000001  0c    READ_PROCESSED  READ_PROCESSED
00000001  63    READ_PROCESSED  READ_PROCESSED

00000086  20    READ_PROCESSED  WRITE_RECEIVED <= both 3 irqs raised
00000004  02    WRITE_RECEIVED  WRITE_RECEIVED
00000084  03    WRITE_RECEIVED  WRITE_RECEIVED
00000004  18    WRITE_RECEIVED  WRITE_RECEIVED
00000004  42    WRITE_RECEIVED  WRITE_RECEIVED
00000004  0c    WRITE_RECEIVED  WRITE_RECEIVED
00000004  63    WRITE_RECEIVED  WRITE_RECEIVED
00000010  xx    WRITE_RECEIVED  INACTIVE

This patch is to address this case where TX_NAK, SLAVE_MATCH and RX_DONE 
are raised together.

>> +                       irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>> +                       i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
>> +               }
>>                  irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
>>                  bus->slave_state = ASPEED_I2C_SLAVE_START;
>>          }
>> --
>> 2.28.0
>>


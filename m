From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 16 Jun 2022 14:16:14 +0700
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <YqpB8A2uBi+4epHM@shikoro>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
 <Yn+9QBoPdH8fMm/m@shikoro>
 <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
 <YqpB8A2uBi+4epHM@shikoro>
Message-ID: <bf001ece-e981-3a06-53fe-6a8b637d69fe@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/06/2022 03:32, Wolfram Sang wrote:
> Hi Quan,
> 
>> When tested with ast2500, it is observed that there's always a
>> I2C_SLAVE_WRITE_REQUESTED comes first then other I2C_SLAVE_WRITE_RECEIVED's
>> follow for all transactions.
> 
> Yes, that's the design of the interface :)
> 
>> In case slave is busy, the NAK will be asserted on the first occurrence of
>> I2C_SLAVE_WRITE_REQUESTED make host to stop the current transaction (host
>> later will retry with other transaction) until slave ready.
>>
>> This behavior is expected as we want host to drop all transactions while
>> slave is busy on working on the response. That is why we choose to assert
>> NAK on the first I2C_SLAVE_WRITE_REQUESTED of the transaction instead of
>> I2C_SLAVE_WRITE_RECEIVED.
> 
>  From Documentation/i2c/slave-interface.rst:
> 
> ===
> 
> About ACK/NACK
> --------------
> 
> It is good behaviour to always ACK the address phase, so the master knows if a
> device is basically present or if it mysteriously disappeared. Using NACK to
> state being busy is troublesome. SMBus demands to always ACK the address phase,
> while the I2C specification is more loose on that. Most I2C controllers also
> automatically ACK when detecting their slave addresses, so there is no option
> to NACK them. For those reasons, this API does not support NACK in the address
> phase.
> 
> ===
> 
> So, the proper design is to NACK on the first received byte. All EEPROMs
> do it this way when they are busy because of erasing a page.
> 

Thanks Wolfram for the review.

On the first occurrence of I2C_SLAVE_WRITE_REQUESTED, the address is 
already received with ACK. So if slave return -EBUSY, the NAK will occur 
on the next Rx byte (on I2C_SLAVE_WRITE_RECEIVED event).

Tested this patch and capture using Saleae tool, it always shows ACK on 
the address and NAK on the first byte follow when slave return -EBUSY, 
ie: the byte follow the address, which is single part read command 
(0x03) in my case.

+ When slave return -EBUSY:
   S-> Aw(ACK)-> RxD(NAK)-> P
       0x10      0x03 (Singlepart read)

+ When slave ready:
   S-> Aw(ACK)-> RxD(ACK)-> Sr-> Ar-> TxD(ACK)-> ... -> TxD(NAK)-> P
       0x10      0x03                 0x07       ...    0xDE

Using the Logic 2 (with Saleae tool) to capture, we could see the log as 
below:

write to 0x10 ack data: 0x03    <= when slave return -EBUSY
write to 0x10 ack data: 0x03    <= when slave return -EBUSY
write to 0x10 ack data: 0x03    <= when slave return -EBUSY
...
write to 0x10 ack data: 0x03    <= when slave return -EBUSY
write to 0x10 ack data: 0x03    <= when slave is ready
read to 0x10 ack data: 0x07 0xF4 0x1D 0x00 0x01 0x00 0x00 0x00 0xDE

Thanks,
- Quan

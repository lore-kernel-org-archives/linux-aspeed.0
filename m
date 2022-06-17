From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 17 Jun 2022 14:08:55 +0700
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <YqsiRW78NAL9rX9S@shikoro>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
 <Yn+9QBoPdH8fMm/m@shikoro>
 <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
 <YqpB8A2uBi+4epHM@shikoro>
 <bf001ece-e981-3a06-53fe-6a8b637d69fe@os.amperecomputing.com>
 <YqsiRW78NAL9rX9S@shikoro>
Message-ID: <27f5999e-40a6-311f-20f1-331a0f4447da@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/06/2022 19:29, Wolfram Sang wrote:
> Hi Quan,
> 
>> On the first occurrence of I2C_SLAVE_WRITE_REQUESTED, the address is already
>> received with ACK. So if slave return -EBUSY, the NAK will occur on the next
>> Rx byte (on I2C_SLAVE_WRITE_RECEIVED event).
> 
> This is exactly why I2C_SLAVE_WRITE_RECEIVED allows for an error code.
>  From the docs:
> 
> ===
> 
> * I2C_SLAVE_WRITE_RECEIVED (mandatory)
> 
>    'val': bus driver delivers received byte
> 
>    'ret': 0 if the byte should be acked, some errno if the byte should be nacked
> 
> Another I2C master has sent a byte to us which needs to be set in 'val'. If 'ret'
> is zero, the bus driver should ack this byte. If 'ret' is an errno, then the byte
> should be nacked.
> 
> ===
> 
> 'ret' is used to ACK/NACK the current byte in 'val'. That's exactly what
> you need, or? Does the aspeed driver not support acking the current
> byte?
>

It is true that aspeed driver does not support acking the current byte. 
Setting ASPEED_I2CD_M_S_RX_CMD_LAST will take effect on the next Rx byte 
as per my observation.

S-> Aw(ACK)-> RxD(ACK)-> Sr-> Ar-> TxD(ACK)-> ... -> TxD(NAK)-> P
      (1)        (2)

Currently, setting ASPEED_I2CD_M_S_RX_CMD_LAST in (1), on 
I2C_SLAVE_WRITE_REQUESTED event, will make the NAK happen in (2) and 
make the read stop.

If setting ASPEED_I2CD_M_S_RX_CMD_LAST on (2), ie: on 
I2C_SLAVE_WRITE_RECEIVED event, the read from Master is never NAK 
because there is no next Rx byte and Master is already switch to read 
from Slave.

I understands that the return of
i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value) is always 0 as 
in Documentation/i2c/slave-interface.rst. But with this case, this is 
the way to NAK on the first byte and I'm wonder if this particular case 
would be supported somehow.

Thanks,
-- Quan

From: Wolfram Sang <wsa@kernel.org>
Date: Wed, 15 Jun 2022 22:32:48 +0200
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
 <Yn+9QBoPdH8fMm/m@shikoro>
 <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
Message-ID: <YqpB8A2uBi+4epHM@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

> When tested with ast2500, it is observed that there's always a
> I2C_SLAVE_WRITE_REQUESTED comes first then other I2C_SLAVE_WRITE_RECEIVED's
> follow for all transactions.

Yes, that's the design of the interface :)

> In case slave is busy, the NAK will be asserted on the first occurrence of
> I2C_SLAVE_WRITE_REQUESTED make host to stop the current transaction (host
> later will retry with other transaction) until slave ready.
> 
> This behavior is expected as we want host to drop all transactions while
> slave is busy on working on the response. That is why we choose to assert
> NAK on the first I2C_SLAVE_WRITE_REQUESTED of the transaction instead of
> I2C_SLAVE_WRITE_RECEIVED.

From Documentation/i2c/slave-interface.rst:

===

About ACK/NACK
--------------

It is good behaviour to always ACK the address phase, so the master knows if a
device is basically present or if it mysteriously disappeared. Using NACK to
state being busy is troublesome. SMBus demands to always ACK the address phase,
while the I2C specification is more loose on that. Most I2C controllers also
automatically ACK when detecting their slave addresses, so there is no option
to NACK them. For those reasons, this API does not support NACK in the address
phase.

===

So, the proper design is to NACK on the first received byte. All EEPROMs
do it this way when they are busy because of erasing a page.

All the best,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220615/1d72cf30/attachment.sig>

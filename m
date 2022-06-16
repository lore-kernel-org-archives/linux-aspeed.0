From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 16 Jun 2022 14:29:57 +0200
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <bf001ece-e981-3a06-53fe-6a8b637d69fe@os.amperecomputing.com>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
 <Yn+9QBoPdH8fMm/m@shikoro>
 <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
 <YqpB8A2uBi+4epHM@shikoro>
 <bf001ece-e981-3a06-53fe-6a8b637d69fe@os.amperecomputing.com>
Message-ID: <YqsiRW78NAL9rX9S@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

> On the first occurrence of I2C_SLAVE_WRITE_REQUESTED, the address is already
> received with ACK. So if slave return -EBUSY, the NAK will occur on the next
> Rx byte (on I2C_SLAVE_WRITE_RECEIVED event).

This is exactly why I2C_SLAVE_WRITE_RECEIVED allows for an error code.
From the docs:

===

* I2C_SLAVE_WRITE_RECEIVED (mandatory)

  'val': bus driver delivers received byte

  'ret': 0 if the byte should be acked, some errno if the byte should be nacked

Another I2C master has sent a byte to us which needs to be set in 'val'. If 'ret'
is zero, the bus driver should ack this byte. If 'ret' is an errno, then the byte
should be nacked.

===

'ret' is used to ACK/NACK the current byte in 'val'. That's exactly what
you need, or? Does the aspeed driver not support acking the current
byte?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220616/10331f96/attachment.sig>

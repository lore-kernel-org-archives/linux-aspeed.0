From: Wolfram Sang <wsa@kernel.org>
Date: Sat, 14 May 2022 16:31:28 +0200
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <20220422040803.2524940-4-quan@os.amperecomputing.com>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
Message-ID: <Yn+9QBoPdH8fMm/m@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 22, 2022 at 11:08:03AM +0700, Quan Nguyen wrote:
> When processing I2C_SLAVE_WRITE_REQUESTED event, if slave returns
> -EBUSY, i2c controller should issue RxCmdLast command to assert NAK
> on the bus.

That should be I2C_SLAVE_WRITE_RECEIVED and it should be NAKed on all
errnos. Have you tested it?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220514/72da26af/attachment.sig>

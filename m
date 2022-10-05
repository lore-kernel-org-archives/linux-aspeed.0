From: Wolfram Sang <wsa@kernel.org>
Date: Wed, 5 Oct 2022 21:06:01 +0200
Subject: [PATCH v10 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <20221004093106.1653317-4-quan@os.amperecomputing.com>
References: <20221004093106.1653317-1-quan@os.amperecomputing.com>
 <20221004093106.1653317-4-quan@os.amperecomputing.com>
Message-ID: <Yz3VmWCqdolKg5sm@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 04, 2022 at 04:31:06PM +0700, Quan Nguyen wrote:
> On I2C_SLAVE_WRITE_REQUESTED event, Slave already ACK'ed on the address
> phase. But as the backend driver is busy and unable to process any
> request from Master, issue RxCmdLast for Slave to auto send NACK on
> next incoming byte.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221005/d53d6409/attachment.sig>

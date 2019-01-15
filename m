From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 15 Jan 2019 23:47:13 +0100
Subject: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190115224713.duoha332mjlrmwji@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver. To prevent state corruption in the
> case, this patch adds checking code if any slave operation is
> ongoing and it waits up to the bus timeout duration before starting
> a master_xfer operation.
> 
> To support this change, it introduces changes on i2c-core-base to
> make that able to read the bus timeout and master transfer retries
> count values from device tree properties.
> 
> Please review this patch set.

Marking this as "Changes requested". I think if the mutex approach
works, these patches become obsolete then.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190115/7fd71a22/attachment.sig>

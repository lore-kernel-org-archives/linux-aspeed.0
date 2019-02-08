From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 8 Feb 2019 22:48:49 +0100
Subject: [PATCH] i2c: aspeed: Add multi-master use case support
In-Reply-To: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190208214849.GH12451@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 16, 2019 at 11:39:58AM -0800, Jae Hyun Yoo wrote:
> In multi-master environment, this driver's master cannot know
> exactly when a peer master sends data to this driver's slave so
> cases can be happened that this master tries sending data through
> the master_xfer function but slave data from a peer master is still
> being processed or slave xfer is started by a peer immediately
> after it queues a master command. To support multi-master use cases
> properly, this H/W provides arbitration in physical level and it
> provides priority based command handling too to avoid conflicts in
> multi-master environment, means that if a master and a slave events
> happen at the same time, H/W will handle a higher priority event
> first and a pending event will be handled when bus comes back to
> the idle state.
> 
> To support this H/W feature properly, this patch adds the 'pending'
> state of master and its handling code so that the pending master
> xfer can be continued after slave operation properly.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Hmmm, the #ifdeffery quite increases with this patch. Maybe it is easier
to select I2C_SLAVE in Kconfig? I'll let you decide.

My code checkers found this:

    CPPCHECK
drivers/i2c/busses/i2c-aspeed.c:694:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190208/a4140498/attachment.sig>

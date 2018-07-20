From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 21 Jul 2018 00:29:21 +0200
Subject: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
In-Reply-To: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180720222921.hvpk2zgr4rxnwoom@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 02, 2018 at 02:40:11PM -0700, Jae Hyun Yoo wrote:
> This patch adjusts spinlock scope to make it wrap the whole irq
> handler using a single lock/unlock which covers both master and
> slave handlers.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!

Not related to these patches, but there is an issue found with sparse:

drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data

Maybe someone wants to have a go at this...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180721/21136550/attachment.sig>

From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 9 Oct 2019 17:32:34 -0700
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20191010003234.GA12710@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 09, 2019 at 02:20:34PM -0700, Jae Hyun Yoo wrote:
> In case of master pending state, it should not trigger a master
> command, otherwise data could be corrupted because this H/W shares
> the same data buffer for slave and master operations. It also means
> that H/W command queue handling is unreliable because of the buffer
> sharing issue. To fix this issue, it clears command queue if a
> master command is queued in pending state to use S/W solution
> instead of H/W command queue handling. Also, it refines restarting
> mechanism of the pending master command.
> 
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

We don't have any multi-master setups, can we get a Tested-by?

Wolfram, since this is a bugfix, can we get this in 5.4?

Thanks!

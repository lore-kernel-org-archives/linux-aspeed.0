From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 24 Sep 2018 23:51:18 +0200
Subject: [PATCH v4] i2c: aspeed: fix invalid clock parameters for very
 large divisors
In-Reply-To: <20180921233050.121570-1-brendanhiggins@google.com>
References: <20180921233050.121570-1-brendanhiggins@google.com>
Message-ID: <20180924215118.GC18592@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 21, 2018 at 04:30:50PM -0700, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
> 
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180924/12f6a14f/attachment.sig>

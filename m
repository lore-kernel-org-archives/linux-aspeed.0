From: Tao Ren <taoren@fb.com>
Date: Thu, 10 Oct 2019 23:29:04 +0000
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <49244d71-cbc3-f2ae-97ac-74b5f68a4816@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
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

Tested-by: Tao Ren <taoren@fb.com>

Tested the patch on Facebook Minipack BMC (multi-master i2c-0 environment) and
everything looks good to me.


Cheers,

Tao

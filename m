From: Wolfram Sang <wsa@kernel.org>
Date: Wed, 13 Sep 2023 11:05:25 +0200
Subject: [PATCH v3] i2c: aspeed: Reset the i2c controller when timeout
 occurs
In-Reply-To: <20230906004910.4157305-1-tommy_huang@aspeedtech.com>
References: <20230906004910.4157305-1-tommy_huang@aspeedtech.com>
Message-ID: <ZQF7VeckiRciWMRI@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 06, 2023 at 08:49:10AM +0800, Tommy Huang wrote:
> Reset the i2c controller when an i2c transfer timeout occurs.
> The remaining interrupts and device should be reset to avoid
> unpredictable controller behavior.
> 
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.1+
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230913/72017358/attachment.sig>

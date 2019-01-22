From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Jan 2019 00:18:54 +0100
Subject: [PATCH] i2c: aspeed: Remove hard-coded bus timeout value setting
In-Reply-To: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
References: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190122231854.g75ijhg6halhzdvh@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 16, 2019 at 11:39:43AM -0800, Jae Hyun Yoo wrote:
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190123/f5021458/attachment.sig>

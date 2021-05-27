From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 27 May 2021 21:46:59 +0200
Subject: [PATCH v2] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
In-Reply-To: <20210506205419.26294-1-zev@bewilderbeest.net>
References: <20210506205419.26294-1-zev@bewilderbeest.net>
Message-ID: <YK/3M94uwuLQNwbz@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 06, 2021 at 03:54:19PM -0500, Zev Weiss wrote:
> The ast25xx and ast26xx have, respectively, two and three configurable
> slave device addresses to the ast24xx's one.  We only support using
> one at a time, but the others may come up in an indeterminate state
> depending on hardware/bootloader behavior, so we need to make sure we
> disable them so as to avoid ending up with phantom devices on the bus.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210527/b851c372/attachment.sig>

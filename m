From: Wolfram Sang <wsa@kernel.org>
Date: Fri, 29 Sep 2023 09:39:37 +0200
Subject: [PATCH v2] i2c: aspeed: Fix i2c bus hang in slave read
In-Reply-To: <20230927154244.3774670-1-zhangjian.3032@bytedance.com>
References: <20230927154244.3774670-1-zhangjian.3032@bytedance.com>
Message-ID: <ZRZ/ObZmntMLw2r+@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 27, 2023 at 11:42:43PM +0800, Jian Zhang wrote:
> When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
> as a slave, a situation arises where the master sends a START signal
> without the accompanying STOP signal. This action results in a
> persistent I2C bus timeout. The core issue stems from the fact that
> the i2c controller remains in a slave read state without a timeout
> mechanism. As a consequence, the bus perpetually experiences timeouts.
> 
> In this case, the i2c bus will be reset, but the slave_state reset is
> missing.
> 
> Fixes: fee465150b45 ("i2c: aspeed: Reset the i2c controller when timeout occurs")
> Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>

Somebody wants to add tags here? I think it should go to my pull request
this week.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230929/43314aa0/attachment.sig>

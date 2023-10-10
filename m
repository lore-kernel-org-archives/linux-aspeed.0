From: Wolfram Sang <wsa@kernel.org>
Date: Tue, 10 Oct 2023 21:34:20 +0200
Subject: [PATCH v3] i2c: aspeed: Fix i2c bus hang in slave read
In-Reply-To: <20231006022233.3963590-1-zhangjian.3032@bytedance.com>
References: <20231006022233.3963590-1-zhangjian.3032@bytedance.com>
Message-ID: <ZSWnPG6oIxrVFmbg@shikoro>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 06, 2023 at 10:22:33AM +0800, Jian Zhang wrote:
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
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231010/be28e26c/attachment.sig>

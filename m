From: Wolfram Sang <wsa@kernel.org>
Date: Fri, 20 Jan 2023 10:29:12 +0100
Subject: [PATCH] i2c: aspeed: Use devm_platform_get_and_ioremap_resource()
In-Reply-To: <202301191715319948743@zte.com.cn>
References: <202301191715319948743@zte.com.cn>
Message-ID: <Y8pe6PWZQ4TVHlqi@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 19, 2023 at 05:15:31PM +0800, ye.xingchen at zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230120/e553d661/attachment.sig>

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Nov 2019 06:16:06 -0800
Subject: [PATCH -next] fsi: aspeed: Use devm_kfree in
 aspeed_master_release()
In-Reply-To: <20191109033209.45244-1-yuehaibing@huawei.com>
References: <20191109033209.45244-1-yuehaibing@huawei.com>
Message-ID: <62eacd00-300c-bc3e-b680-605bd0b7a983@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/8/19 7:32 PM, YueHaibing wrote:
> 'aspeed' is allocted by devm_kfree(), it should not be
> freed bt kfree().
> 
> Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/fsi/fsi-master-aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 3dd82dd..0f63eec 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -361,7 +361,7 @@ static void aspeed_master_release(struct device *dev)
>   	struct fsi_master_aspeed *aspeed =
>   		to_fsi_master_aspeed(dev_to_fsi_master(dev));
>   
> -	kfree(aspeed);
> +	devm_kfree(dev, aspeed);
>   }
>   
>   /* mmode encoders */
> 
The memory is attached to the device, and will thus be freed once the device
is released. Why is the release function needed in the first place ?

Guenter

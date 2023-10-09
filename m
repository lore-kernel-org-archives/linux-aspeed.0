From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 9 Oct 2023 08:50:22 -0500
Subject: [PATCH v2] media: aspeed: Drop unnecessary error check for
 debugfs_create_file()
In-Reply-To: <20231007084339.3160130-1-ruanjinjie@huawei.com>
References: <20231007084339.3160130-1-ruanjinjie@huawei.com>
Message-ID: <a606fd9a-5cc0-1158-e72e-f675f19c9dd8@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/7/23 03:43, Jinjie Ruan wrote:
> debugfs_create_file() return ERR_PTR and never return NULL.
>
> When calling debugfs functions, there is no need to ever check the
> return value. The function can work or not, but the code logic should
> never do something different based on this.


Thanks!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> v2:
> - Remove the err check instead of using IS_ERR to replace NULL check.
> - Add suggested-by.
> - Update the commit title and message.
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index a9c2c69b2ed9..d08aa7f73d4f 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1970,22 +1970,15 @@ static void aspeed_video_debugfs_remove(struct aspeed_video *video)
>   	debugfs_entry = NULL;
>   }
>   
> -static int aspeed_video_debugfs_create(struct aspeed_video *video)
> +static void aspeed_video_debugfs_create(struct aspeed_video *video)
>   {
>   	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
>   					    video,
>   					    &aspeed_video_debugfs_fops);
> -	if (!debugfs_entry)
> -		aspeed_video_debugfs_remove(video);
> -
> -	return !debugfs_entry ? -EIO : 0;
>   }
>   #else
>   static void aspeed_video_debugfs_remove(struct aspeed_video *video) { }
> -static int aspeed_video_debugfs_create(struct aspeed_video *video)
> -{
> -	return 0;
> -}
> +static void aspeed_video_debugfs_create(struct aspeed_video *video) { }
>   #endif /* CONFIG_DEBUG_FS */
>   
>   static int aspeed_video_setup_video(struct aspeed_video *video)
> @@ -2198,9 +2191,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
>   		return rc;
>   	}
>   
> -	rc = aspeed_video_debugfs_create(video);
> -	if (rc)
> -		dev_err(video->dev, "debugfs create failed\n");
> +	aspeed_video_debugfs_create(video);
>   
>   	return 0;
>   }

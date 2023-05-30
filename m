From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 30 May 2023 09:18:06 -0500
Subject: [PATCH] aspeed-video.c: Fix error checking for debugfs_create_dir
In-Reply-To: <20230524171137.22128-1-osmtendev@gmail.com>
References: <20230524171137.22128-1-osmtendev@gmail.com>
Message-ID: <e123f9a1-e316-a80d-1431-1d3528c25ba5@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/24/23 12:11, Osama Muhammad wrote:
> This patch fixes the error checking in aspeed-video.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is using 'IS_ERR' inline function.


Thanks.

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index 374eb7781936..97847f44964a 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1976,7 +1976,7 @@ static int aspeed_video_debugfs_create(struct aspeed_video *video)
>   	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
>   					    video,
>   					    &aspeed_video_debugfs_fops);
> -	if (!debugfs_entry)
> +	if (IS_ERR(debugfs_entry))
>   		aspeed_video_debugfs_remove(video);
>   
>   	return !debugfs_entry ? -EIO : 0;

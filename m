From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 26 Aug 2019 11:02:19 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_media:_aspeed:_fix_an_incorrect_return_code_on_buf?=
 =?UTF-8?Q?fer_allocation_failure?=
In-Reply-To: <20190823212957.26043-1-jae.hyun.yoo@linux.intel.com>
References: <20190823212957.26043-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <588f6cbd-b6ca-4f43-8034-80956ee56bb8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 24 Aug 2019, at 07:00, Jae Hyun Yoo wrote:
> It returns '0' even when a failure happens on jpeg buffer allocation
> so this commit fixes the issue.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/media/platform/aspeed-video.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/aspeed-video.c 
> b/drivers/media/platform/aspeed-video.c
> index f899ac3b4a61..94f97d96dabc 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1624,6 +1624,7 @@ static int aspeed_video_init(struct aspeed_video 
> *video)
>  	if (!aspeed_video_alloc_buf(video, &video->jpeg,
>  				    VE_JPEG_HEADER_SIZE)) {
>  		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
> +		rc = -ENOMEM;
>  		goto err_release_reserved_mem;
>  	}
>  
> -- 
> 2.7.4
> 
>

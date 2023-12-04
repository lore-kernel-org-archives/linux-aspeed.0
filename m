From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Mon, 4 Dec 2023 15:59:02 +0100
Subject: [PATCH v2 25/36] media: aspeed: Fix misuse of min_buffers_needed
 field
In-Reply-To: <20231204132323.22811-26-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
 <20231204132323.22811-26-benjamin.gaignard@collabora.com>
Message-ID: <e920d35c-dd2f-48f6-aad8-5c7dd4a4987d@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/12/2023 14:23, Benjamin Gaignard wrote:
> 'min_buffers_needed' is suppose to be used to indicate the number
> of buffers needed by DMA engine to start streaming.
> aspeed doesn't use DMA engine and just want to specify
> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> That 'min_reqbufs_allocation' field purpose so use it.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
> CC: Joel Stanley <joel@jms.id.au> (supporter:ARM/ASPEED MACHINE SUPPORT)
> CC: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ARM/ASPEED MACHINE SUPPORT)
> CC: openbmc at lists.ozlabs.org (moderated list:ASPEED VIDEO ENGINE DRIVER)
> CC: linux-aspeed at lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
> ---
>  drivers/media/platform/aspeed/aspeed-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index d08aa7f73d4f..c28b10808cda 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -2034,7 +2034,7 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>  	vbq->drv_priv = video;
>  	vbq->buf_struct_size = sizeof(struct aspeed_video_buffer);
>  	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	vbq->min_buffers_needed = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
> +	vbq->min_reqbufs_allocation = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;

Looking at the start_streaming code I think min_buffers_needed should be 1, since
otherwise start_streaming would return -EPROTO.

But clearly the intent is also that 3 buffers minimum are allocated.

So in this case both fields should be set.

Regards,

	Hans

>  
>  	rc = vb2_queue_init(vbq);
>  	if (rc) {


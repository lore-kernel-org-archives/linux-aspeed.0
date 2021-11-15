From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 15 Nov 2021 10:19:46 +0200
Subject: [PATCH v4 7/9] media: aspeed: Support aspeed mode to reduce
 compressed data
In-Reply-To: <20211115074437.28079-8-jammy_huang@aspeedtech.com>
References: <20211115074437.28079-1-jammy_huang@aspeedtech.com>
 <20211115074437.28079-8-jammy_huang@aspeedtech.com>
Message-ID: <YZIYIsURV0Gv1bc6@paasikivi.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

Thanks for the patch. A few comments below...

On Mon, Nov 15, 2021 at 03:44:35PM +0800, Jammy Huang wrote:
> @@ -969,35 +1045,70 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>  
>  static void aspeed_video_update_regs(struct aspeed_video *video)
>  {
> -	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
> -		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
> -		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
> +	u8 jpeg_hq_quality = clamp((int)video->jpeg_hq_quality - 1, 0,
> +				   ASPEED_VIDEO_JPEG_NUM_QUALITIES - 1);
> +	u32 comp_ctrl =	FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
> +		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10) |
> +		FIELD_PREP(VE_COMP_CTRL_EN_HQ, video->hq_mode) |
> +		FIELD_PREP(VE_COMP_CTRL_HQ_DCT_LUM, jpeg_hq_quality) |
> +		FIELD_PREP(VE_COMP_CTRL_HQ_DCT_CHR, jpeg_hq_quality |
> +			   0x10);
>  	u32 ctrl = 0;
> -	u32 seq_ctrl = VE_SEQ_CTRL_JPEG_MODE;
> +	u32 seq_ctrl = 0;
>  
> -	v4l2_dbg(1, debug, &video->v4l2_dev, "framerate(%d)\n",
> -		 video->frame_rate);
> -	v4l2_dbg(1, debug, &video->v4l2_dev, "subsample(%s)\n",
> +	v4l2_dbg(1, debug, &video->v4l2_dev, "framerate(%d)\n", video->frame_rate);
> +	v4l2_dbg(1, debug, &video->v4l2_dev, "jpeg format(%s) subsample(%s)\n",
> +		 format_str[video->format],
>  		 video->yuv420 ? "420" : "444");
> -	v4l2_dbg(1, debug, &video->v4l2_dev, "compression quality(%d)\n",
> -		 video->jpeg_quality);
> +	v4l2_dbg(1, debug, &video->v4l2_dev, "compression quality(%d) hq(%s) hq_quality(%d)\n",
> +		 video->jpeg_quality, video->hq_mode ? "on" : "off",
> +		 video->jpeg_hq_quality);
> +	v4l2_dbg(1, debug, &video->v4l2_dev, "compression mode(%s)\n",
> +		 compress_mode_str[video->compression_mode]);
> +
> +	if (video->format == VIDEO_FMT_ASPEED)
> +		aspeed_video_update(video, VE_BCD_CTRL, 0, VE_BCD_CTRL_EN_BCD);
> +	else
> +		aspeed_video_update(video, VE_BCD_CTRL, VE_BCD_CTRL_EN_BCD, 0);
>  
>  	if (video->frame_rate)
>  		ctrl |= FIELD_PREP(VE_CTRL_FRC, video->frame_rate);
>  
> +	if (video->format == VIDEO_FMT_STANDARD) {
> +		comp_ctrl &= ~FIELD_PREP(VE_COMP_CTRL_EN_HQ, video->hq_mode);
> +		seq_ctrl |= VE_SEQ_CTRL_JPEG_MODE;
> +	}
> +
>  	if (video->yuv420)
>  		seq_ctrl |= VE_SEQ_CTRL_YUV420;
>  
>  	if (video->jpeg.virt)
>  		aspeed_video_update_jpeg_table(video->jpeg.virt, video->yuv420);
>  
> +#ifdef CONFIG_MACH_ASPEED_G4

This would be better done based on the device recognised, not the selected
compile target. The same goes for the rest of the conditional pre-processor
bits.

> +	switch (video->compression_mode) {
> +	case 0:	//DCT only
> +		comp_ctrl |= VE_COMP_CTRL_VQ_DCT_ONLY;
> +		break;
> +	case 1:	//DCT VQ mix 2-color
> +		comp_ctrl &= ~(VE_COMP_CTRL_VQ_4COLOR | VE_COMP_CTRL_VQ_DCT_ONLY);
> +		break;
> +	case 2:	//DCT VQ mix 4-color
> +		comp_ctrl |= VE_COMP_CTRL_VQ_4COLOR;
> +		break;
> +	}
> +#endif
> +

-- 
Kind regards,

Sakari Ailus

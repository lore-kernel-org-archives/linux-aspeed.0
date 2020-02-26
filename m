From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 26 Feb 2020 08:50:06 -0600
Subject: [PATCH -next] media: aspeed: add AST2600 support
In-Reply-To: <20200225195853.17480-1-jae.hyun.yoo@linux.intel.com>
References: <20200225195853.17480-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <f4ffad91-9742-9b68-be51-c1ec222e24b6@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2/25/20 1:58 PM, Jae Hyun Yoo wrote:
> Video engine in AST2600 has the exactly same register set with
> AST2500 except VR084 register which provides more precise JPEG
> size read back. This commit adds support for the difference and
> adds 'aspeed,ast2600-video-engine' compatible OF string.


Thanks Jae!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>   drivers/media/platform/aspeed-video.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 47444a336ebb..7d98db1d9b52 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   // Copyright 2020 IBM Corp.
> -// Copyright (c) 2019 Intel Corporation
> +// Copyright (c) 2019-2020 Intel Corporation
>   
>   #include <linux/atomic.h>
>   #include <linux/bitfield.h>
> @@ -132,7 +132,8 @@
>   #define  VE_COMP_CTRL_HQ_DCT_CHR	GENMASK(26, 22)
>   #define  VE_COMP_CTRL_HQ_DCT_LUM	GENMASK(31, 27)
>   
> -#define VE_OFFSET_COMP_STREAM		0x078
> +#define AST2400_VE_COMP_SIZE_READ_BACK	0x078
> +#define AST2600_VE_COMP_SIZE_READ_BACK	0x084
>   
>   #define VE_SRC_LR_EDGE_DET		0x090
>   #define  VE_SRC_LR_EDGE_DET_LEFT	GENMASK(11, 0)
> @@ -252,12 +253,17 @@ struct aspeed_video_config {
>   
>   static const struct aspeed_video_config ast2400_config = {
>   	.jpeg_mode = AST2400_VE_SEQ_CTRL_JPEG_MODE,
> -	.comp_size_read = VE_OFFSET_COMP_STREAM,
> +	.comp_size_read = AST2400_VE_COMP_SIZE_READ_BACK,
>   };
>   
>   static const struct aspeed_video_config ast2500_config = {
>   	.jpeg_mode = AST2500_VE_SEQ_CTRL_JPEG_MODE,
> -	.comp_size_read = VE_OFFSET_COMP_STREAM,
> +	.comp_size_read = AST2400_VE_COMP_SIZE_READ_BACK,
> +};
> +
> +static const struct aspeed_video_config ast2600_config = {
> +	.jpeg_mode = AST2500_VE_SEQ_CTRL_JPEG_MODE,
> +	.comp_size_read = AST2600_VE_COMP_SIZE_READ_BACK,
>   };
>   
>   static const u32 aspeed_video_jpeg_header[ASPEED_VIDEO_JPEG_HEADER_SIZE] = {
> @@ -1673,6 +1679,7 @@ static int aspeed_video_init(struct aspeed_video *video)
>   static const struct of_device_id aspeed_video_of_match[] = {
>   	{ .compatible = "aspeed,ast2400-video-engine", .data = &ast2400_config },
>   	{ .compatible = "aspeed,ast2500-video-engine", .data = &ast2500_config },
> +	{ .compatible = "aspeed,ast2600-video-engine", .data = &ast2600_config },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, aspeed_video_of_match);

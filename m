From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 9 Feb 2022 07:23:21 +0100
Subject: [PATCH v1] media: aspeed: Fix incorrect color
In-Reply-To: <20220209024312.2218-1-jammy_huang@aspeedtech.com>
References: <20220209024312.2218-1-jammy_huang@aspeedtech.com>
Message-ID: <554448a9-bc65-7c0b-9878-fb2c0fe9bfe4@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Jammy,


Am 09.02.22 um 03:43 schrieb Jammy Huang:
> Current settings for rgb-2-yuv is BT.601(studio swing), but JFIF
> uses BT.601(full swing).

Could you please describe the problem in a little more detail? On an 
attached monitor to the BMC (which one) what incorrect colors are seen?

Maybe use:

> media: aspeed: Use full swing for JFIF to fix incorrect color

> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/media/platform/aspeed-video.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index eb9c17ac0e14..08b63b8297f0 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1089,7 +1089,7 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>   	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
>   		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>   		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
> -	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
> +	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR | VE_CTRL_YUV;

Excuse my ignorance, but reading [1][2] YUV can be represented by studio 
and full swing. How is the register/bit described in the datasheet, and 
can the macro name be improved?

>   	u32 seq_ctrl = video->jpeg_mode;
>   
>   	if (video->frame_rate)


Kind regards,

Paul


[1]: https://mymusing.co/bt601-yuv-to-rgb-conversion-color/
[2]: https://www.hisour.com/yuv-color-system-25916/

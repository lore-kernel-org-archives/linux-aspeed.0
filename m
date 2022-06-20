From: Lei Yu <yulei.sh@bytedance.com>
Date: Mon, 20 Jun 2022 17:28:34 +0800
Subject: [PATCH v5 2/2] media: aspeed: Fix unstable timing detection
In-Reply-To: <20220126014725.1511-3-jammy_huang@aspeedtech.com>
References: <20220126014725.1511-1-jammy_huang@aspeedtech.com> <20220126014725.1511-3-jammy_huang@aspeedtech.com>
Message-ID: <CAGm54UHobZ7f9q7vB5F8fJDeyr_PSbRxJPg45etscxxSvRtFVA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We hit an issue where the resolution is not detected correctly.
The issue could be fixed by this patch.

Tested-by: Lei YU <yulei.sh@bytedance.com>

On Wed, Jan 26, 2022 at 9:49 AM Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Using stable-signal in resolution detection, and try detection again
> if unstable.
>
> VE_MODE_DETECT_EXTSRC_ADC: 1 if video source is from ADC output.
> VE_MODE_DETECT_H_STABLE: 1 if horizontal signal detection is stable.
> VE_MODE_DETECT_V_STABLE: 1 if vertical signal detection is stable.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 5d1ec3de50ad..eb9c17ac0e14 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -153,9 +153,14 @@
>
>  #define VE_MODE_DETECT_STATUS          0x098
>  #define  VE_MODE_DETECT_H_PERIOD       GENMASK(11, 0)
> +#define  VE_MODE_DETECT_EXTSRC_ADC     BIT(12)
> +#define  VE_MODE_DETECT_H_STABLE       BIT(13)
> +#define  VE_MODE_DETECT_V_STABLE       BIT(14)
>  #define  VE_MODE_DETECT_V_LINES                GENMASK(27, 16)
>  #define  VE_MODE_DETECT_STATUS_VSYNC   BIT(28)
>  #define  VE_MODE_DETECT_STATUS_HSYNC   BIT(29)
> +#define  VE_MODE_DETECT_VSYNC_RDY      BIT(30)
> +#define  VE_MODE_DETECT_HSYNC_RDY      BIT(31)
>
>  #define VE_SYNC_STATUS                 0x09c
>  #define  VE_SYNC_STATUS_HSYNC          GENMASK(11, 0)
> @@ -909,6 +914,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>         bool invalid_resolution = true;
>         int rc;
>         int tries = 0;
> +       u32 mds;
>         u32 src_lr_edge;
>         u32 src_tb_edge;
>         struct v4l2_bt_timings *det = &video->detected_timings;
> @@ -939,6 +945,13 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                         return;
>                 }
>
> +               mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
> +               // try detection again if current signal isn't stable
> +               if (!(mds & VE_MODE_DETECT_H_STABLE) ||
> +                   !(mds & VE_MODE_DETECT_V_STABLE) ||
> +                   (mds & VE_MODE_DETECT_EXTSRC_ADC))
> +                       continue;
> +
>                 aspeed_video_check_and_set_polarity(video);
>
>                 aspeed_video_enable_mode_detect(video);
> --
> 2.25.1
>


-- 
BRs,
Lei YU

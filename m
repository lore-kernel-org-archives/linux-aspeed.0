From: Joel Stanley <joel@jms.id.au>
Date: Wed, 22 Dec 2021 01:31:02 +0000
Subject: [PATCH 3/4] media: aspeed: Correct values for detected timing
In-Reply-To: <20211217095403.2618-4-jammy_huang@aspeedtech.com>
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
 <20211217095403.2618-4-jammy_huang@aspeedtech.com>
Message-ID: <CACPK8Xf_5wZXzfDSrdLLxs_B_jX7BVHc5o2Thw1DJvYix1AA8Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 17 Dec 2021 at 09:54, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Correct timing's fp/sync/bp value based on the information below.
> It should be noticed that the calculation formula should be changed
> per sync polarity.
>
> The sequence of signal: sync - backporch - video data - frontporch
>
> The following registers start counting from sync's rising edge:
> 1. VR090: frame edge's left and right
> 2. VR094: frame edge's top and bottom
> 3. VR09C: counting from sync's rising edge to falling edge
>
>             +--+     +-------------------+     +--+
>             |  |     |    v i d e o      |     |  |
>          +--+  +-----+                   +-----+  +---+
>
>         sync+--+
>     left/top+--------+
> right/bottom+----------------------------+
>
>                   +-------------------+
>                   |    v i d e o      |
>       +--+  +-----+                   +-----+  +---+
>          |  |                               |  |
>          +--+                               +--+
>         sync+-------------------------------+
>     left/top+-----+
> right/bottom+-------------------------+

This is a good explanation. Can you add detail that relates the names
you use here to to the variable names in your patch (or change them to
match)?

>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 581a4261f9b7..5ad3a20c5bac 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -988,10 +988,20 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                                                 src_tb_edge);
>                 video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
>                                              src_tb_edge);
> -               det->vfrontporch = video->frame_top;
> -               det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> -                       video->frame_bottom;
>                 det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);


Would it be clearer if you structured the code like this?

 vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
 vlines = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);

 if (det->polarities & V4L2_DV_VSYNC_POS_POL)) {
    det->vbackporch = video->frame_top - vsync;
    det->vfrontporch = vlines - video->frame_bottom;
    det->vsync = vsync;
 } else {
    det->vbackporch = video->frame_top;
    det->vfrontporch = vlines - video->frame_bottom - vsync;
    det->vsync = vlines - vsync;

}


> +               if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
> +                       det->vbackporch = video->frame_top - det->vsync;
> +                       det->vfrontporch =
> +                               FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                               video->frame_bottom;
> +               } else {
> +                       det->vsync = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                                              det->vsync;
> +                       det->vbackporch = video->frame_top;
> +                       det->vfrontporch =
> +                               FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                               video->frame_bottom - det->vsync;
> +               }
>                 if (video->frame_top > video->frame_bottom)
>                         continue;
>
> @@ -999,9 +1009,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                                                src_lr_edge);
>                 video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
>                                               src_lr_edge);
> -               det->hfrontporch = video->frame_left;
> -               det->hbackporch = htotal - video->frame_right;
>                 det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
> +               if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
> +                       det->hbackporch = video->frame_left - det->hsync;
> +                       det->hfrontporch = htotal - video->frame_right;
> +               } else {
> +                       det->hsync = htotal - det->hsync;
> +                       det->hbackporch = video->frame_left;
> +                       det->hfrontporch = htotal - video->frame_right -
> +                                          det->hsync;
> +               }
>                 if (video->frame_left > video->frame_right)
>                         continue;
>
> --
> 2.25.1
>

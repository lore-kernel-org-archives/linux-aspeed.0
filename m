From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Fri, 23 Sep 2022 12:56:34 +0000
Subject: [PATCH v9 1/4] media: v4l: Add definition for the Aspeed JPEG
 format
In-Reply-To: <20220921025112.13150-2-jammy_huang@aspeedtech.com>
References: <20220921025112.13150-1-jammy_huang@aspeedtech.com>
 <20220921025112.13150-2-jammy_huang@aspeedtech.com>
Message-ID: <Yy2tAlGXFJS+a2Lz@paasikivi.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

Thanks for the update.

On Wed, Sep 21, 2022 at 10:51:09AM +0800, Jammy Huang wrote:
> This introduces support for the Aspeed JPEG format, where the new frame
> can refer to previous frame to reduce the amount of compressed data.
> The concept is similar to I/P frame of video compression. It will
> compare the new frame with previous one to decide which macroblock's
> data is changed, and only the changed macroblocks will be compressed.
> 
> This Aspeed JPEG format is used by the video engine on Aspeed platforms,
> which is generally adapted for remote KVM.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-reserved.rst | 17 +++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c            |  1 +
>  include/uapi/linux/videodev2.h                  |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 0ff68cd8cf62..f62bc76d606f 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -258,6 +258,23 @@ please make a proposal on the linux-media mailing list.
>          and it is used by various multimedia hardware blocks like GPU, display
>          controllers, ISP and video accelerators.
>          It contains four planes for progressive video.
> +    * .. _V4L2-PIX-FMT-AJPG:
> +
> +      - ``V4L2_PIX_FMT_AJPG``
> +      - 'AJPG'
> +      - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
> +        which is generally adapted for remote KVM.
> +        On each frame compression, I will compare the new frame with previous
> +        one to decide which macroblock's data is changed, and only the changed
> +        macroblocks will be compressed.
> +
> +        The implementation is based on AST2600 A3 datasheet, revision 0.9, which
> +        is not publicly available. Or you can reference Video stream data format
> +        ? ASPEED mode compression of SDK_User_Guide which available on
> +        AspeedTech-BMC/openbmc/releases.
> +
> +        Decoder's implementation can be found here,
> +        `https://github.com/AspeedTech-BMC/aspeed_codec/ <https://github.com/AspeedTech-BMC/aspeed_codec/>`__

This is better than the previous versions.

Can you still run

$ scripts/checkpatch.pl --strict --max-line-length=80

?

On the decoder --- which values is the user supposed to use for mode_420,
selector and advance_selector parameters? I think this needs to be
documented.

>  .. raw:: latex
>  
>      \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index a1a1b51ac599..c72bc3410bee 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
>  		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
> +		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 86cae23cc446..870a7e5ef8ca 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
>  #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
>  #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
> +#define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
>  
>  /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */

-- 
Kind regards,

Sakari Ailus

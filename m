From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Thu, 25 Nov 2021 15:31:03 +0100
Subject: [PATCH v5 00/10] add aspeed-jpeg support for aspeed-video
In-Reply-To: <20211118074030.685-1-jammy_huang@aspeedtech.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
Message-ID: <5ab806d1-e407-1fa4-83ec-93ebe8df7db4@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

I suggest posting a v3 that moves the patches that deal with the
Aspeed JPEG format to the end of the series. That way I can easily
merge the patches up to that point, and the Aspeed JPEG support can
be handled separately.

I'm not sure if it can be merged without that format being documented,
either in pixfmt-reserved.rst, by implementing support for it in
libv4lconvert from v4l-utils, or by providing a URL to some other
publicly available source code. We really don't like adding pixel
formats that cannot be interpreted by someone without access to the
datasheets.

Regards,

	Hans

On 18/11/2021 08:40, Jammy Huang wrote:
> The aim of this series is to add aspeed-jpeg support for aspeed-video
> driver.
> 
> To achieve this major goal some refactors are included.
> 
> In the last, debugfs information is also updated per this change.
> 
> Changes in v5:
>  - Use model data to tell different soc
> 
> Changes in v4:
>  - Add definition for the Aspeed JPEG format
>  - Reserve controls for ASPEED
>  - Use s_fmt to update format rather than new control
>  - Update aspeed hq quality range, 1 ~ 12
> 
> 
> Jammy Huang (10):
>   media: aspeed: move err-handling together to the bottom
>   media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg for log
>   media: aspeed: add more debug log messages
>   media: aspeed: refactor to gather format/compress settings
>   media: v4l: Add definition for the Aspeed JPEG format
>   media: v4l2-ctrls: Reserve controls for ASPEED
>   media: aspeed: use model-data
>   media: aspeed: Support aspeed mode to reduce compressed data
>   media: aspeed: add comments and macro
>   media: aspeed: Extend debug message
> 
>  .../media/uapi/v4l/pixfmt-reserved.rst        |  12 +
>  drivers/media/platform/aspeed-video.c         | 534 ++++++++++++++----
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>  include/uapi/linux/aspeed-video.h             |  15 +
>  include/uapi/linux/v4l2-controls.h            |   5 +
>  include/uapi/linux/videodev2.h                |   1 +
>  6 files changed, 467 insertions(+), 101 deletions(-)
>  create mode 100644 include/uapi/linux/aspeed-video.h
> 


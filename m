From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 28 Oct 2022 10:35:49 +0800
Subject: [PATCH v11 0/5] add aspeed-jpeg support for aspeed-video
Message-ID: <20221028023554.928-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aim of this series is to add aspeed-jpeg support for aspeed-video
driver. aspeed-jpeg is a per-frame differential jpeg format which only
compress the parts which are different from the previous frame. In this
way, it reduces both the amount of data to be transferred by network and
those to be decoded on the client side.

In the last, debugfs information is also updated per this change.

Changes in v11:
 - Update document

Changes in v10:
 - Add document, aspeed-video.rst, for new V4L2 CID
 - Fix warnings reported by kernel test robot
 
Changes in v9:
 - Rebase on new kernel

Changes in v8:
 - Add information of decoder's implementation
 
Changes in v7:
 - Separate other patches alone from aspeed-jpeg series
 - for Aspeed-jpeg, generate an I frame every 8 frames
 - rename compression_mode as compression_scheme
 - Add more reference for aspeed-jpeg
 - Update debugfs message

Changes in v6:
 - Update description for new format, aspeed-jpeg, in Documentation.

Changes in v5:
 - Use model data to tell different soc

Changes in v4:
 - Add definition for the Aspeed JPEG format
 - Reserve controls for ASPEED
 - Use s_fmt to update format rather than new control
 - Update aspeed hq quality range, 1 ~ 12


Jammy Huang (5):
  media: v4l: Add definition for the Aspeed JPEG format
  media: v4l2-ctrls: Reserve controls for ASPEED
  media: Documentation: aspeed-video: Add user documentation for the
    aspeed-video driver
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: Extend debug message

 .../media/drivers/aspeed-video.rst            |  65 ++++
 .../userspace-api/media/drivers/index.rst     |   1 +
 .../media/v4l/pixfmt-reserved.rst             |  17 +
 drivers/media/platform/aspeed/aspeed-video.c  | 317 +++++++++++++++---
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 include/uapi/linux/aspeed-video.h             |  14 +
 include/uapi/linux/v4l2-controls.h            |   6 +
 include/uapi/linux/videodev2.h                |   1 +
 8 files changed, 370 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst
 create mode 100644 include/uapi/linux/aspeed-video.h


base-commit: aae703b02f92bde9264366c545e87cec451de471
-- 
2.25.1


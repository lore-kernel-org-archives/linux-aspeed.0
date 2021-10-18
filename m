From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 18 Oct 2021 17:22:00 +0800
Subject: [PATCH v2 0/7] add aspeed-jpeg support for aspeed-video
Message-ID: <20211018092207.13336-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aim of this series is to add aspeed-jpeg support for aspeed-video
driver.

To achieve this major goal some refactors are included.

In the last, debugfs information is also updated per this change.

Jammy Huang (7):
  media: aspeed: move err-handling together to the bottom
  media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg for log
  media: aspeed: add more debug log message
  media: aspeed: refactor to gather format/compress settings
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: add comments and macro
  media: aspeed: Extend debug message

 drivers/media/platform/aspeed-video.c | 439 +++++++++++++++++++++-----
 1 file changed, 358 insertions(+), 81 deletions(-)

-- 
2.25.1


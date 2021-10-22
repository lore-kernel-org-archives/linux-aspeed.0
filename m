From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 22 Oct 2021 14:55:32 +0800
Subject: [PATCH v3 0/7] add aspeed-jpeg support for aspeed-video
Message-ID: <20211022065539.12392-1-jammy_huang@aspeedtech.com>
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
  media: aspeed: add more debug log messages
  media: aspeed: refactor to gather format/compress settings
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: add comments and macro
  media: aspeed: Extend debug message

 drivers/media/platform/aspeed-video.c | 443 +++++++++++++++++++++-----
 1 file changed, 362 insertions(+), 81 deletions(-)

-- 
2.25.1


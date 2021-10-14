From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 14 Oct 2021 11:48:13 +0800
Subject: [PATCH 0/6] add aspeed-jpeg support for aspeed-video
Message-ID: <20211014034819.2283-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aim of this series is to add aspeed-jpeg support for aspeed-video
driver.

To achieve this major goal some refactors are included. In addition,
dprintk is added to more detailedly categorize the log.

In the last, debugfs information is also updated per this change.

Jammy Huang (6):
  media: aspeed: move err-handling together to the bottom
  media: aspeed: add dprintk for more detailed log control
  media: aspeed: refine to centerize format/compress settings
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: add comments and macro
  media: aspeed: richer debugfs

 drivers/media/platform/aspeed-video.c | 443 +++++++++++++++++++++-----
 1 file changed, 366 insertions(+), 77 deletions(-)

-- 
2.25.1


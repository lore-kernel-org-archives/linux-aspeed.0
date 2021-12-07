From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 7 Dec 2021 09:41:45 +0800
Subject: [PATCH 0/2] Use v4l2_info/v4l2_warn/v4l2_dbg for log
Message-ID: <20211207014147.226-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In this seris, v4l2_xxx log macro will be adapted.
With v4l2_dbg, the debug level can be set with the module parameter
called debug. In this way, we won't have to see all debug logs together.
To many log could have bad influence on the rate to reproduce some
issues as well.

Some logs are added, and more is coming for aspeed-format.

Jammy Huang (2):
  media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg for log
  media: aspeed: add more debug log messages

 drivers/media/platform/aspeed-video.c | 64 ++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 17 deletions(-)

-- 
2.25.1


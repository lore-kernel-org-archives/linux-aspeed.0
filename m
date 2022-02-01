From: Yang Li <yang.lee@linux.alibaba.com>
Date: Tue,  1 Feb 2022 12:04:31 +0800
Subject: [PATCH -next] media: aspeed: Remove duplicated include in
 aspeed-video.c
Message-ID: <20220201040431.9881-1-yang.lee@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix following includecheck warning:
./drivers/media/platform/aspeed-video.c: linux/videodev2.h is included
more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/aspeed-video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 51fb18453b81..53409d86fe44 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -32,7 +32,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-dma-contig.h>
-#include <linux/videodev2.h>
 
 #define DEVICE_NAME			"aspeed-video"
 
-- 
2.20.1.7.g153144c


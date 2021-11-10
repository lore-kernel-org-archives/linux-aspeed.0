From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 10 Nov 2021 16:00:12 +0800
Subject: [PATCH v2 2/2] media: aspeed: Fix incorrect resolution detected
In-Reply-To: <20211110080012.20759-1-jammy_huang@aspeedtech.com>
References: <20211110080012.20759-1-jammy_huang@aspeedtech.com>
Message-ID: <20211110080012.20759-3-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

During successive timing-change, resolution detected could be incorrect,
for example. Using remote KVM to do Centos-8.2 installation, the timing
detected could be only 1920x471 for 1920x1200.

Increase min-required-count of stable signal to fix the problem.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 996afbb87ee9..625a77ddb479 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1208,8 +1208,8 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
 	aspeed_video_write(video, VE_MODE_DETECT,
 			   FIELD_PREP(VE_MODE_DT_HOR_TOLER, 2) |
 			   FIELD_PREP(VE_MODE_DT_VER_TOLER, 2) |
-			   FIELD_PREP(VE_MODE_DT_HOR_STABLE, 6) |
-			   FIELD_PREP(VE_MODE_DT_VER_STABLE, 6) |
+			   FIELD_PREP(VE_MODE_DT_HOR_STABLE, 10) |
+			   FIELD_PREP(VE_MODE_DT_VER_STABLE, 10) |
 			   FIELD_PREP(VE_MODE_DT_EDG_THROD, 0x65));
 
 	aspeed_video_write(video, VE_BCD_CTRL, 0);
-- 
2.25.1


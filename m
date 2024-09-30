From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:14 +0000
Subject: [PATCH 19/45] media: platform: ti: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-19-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/platform/ti/omap3isp/ispstat.c:771:21-27: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/ti/omap3isp/ispstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
index 359a846205b0..603439afe582 100644
--- a/drivers/media/platform/ti/omap3isp/ispstat.c
+++ b/drivers/media/platform/ti/omap3isp/ispstat.c
@@ -768,7 +768,7 @@ int omap3isp_stat_enable(struct ispstat *stat, u8 enable)
 	unsigned long irqflags;
 
 	dev_dbg(stat->isp->dev, "%s: user wants to %s module.\n",
-		stat->subdev.name, enable ? "enable" : "disable");
+		stat->subdev.name, str_enable_disable(enable));
 
 	/* Prevent enabling while configuring */
 	mutex_lock(&stat->ioctl_lock);

-- 
2.46.1.824.gd892dcdcdd-goog


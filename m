From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:18 +0000
Subject: [PATCH 23/45] media: ipu6: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-23-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c:247:51-57: opportunity for str_on_off(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
index 051898ce53f4..522dbf52c82b 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
@@ -244,7 +244,7 @@ static int ipu6_isys_csi2_set_stream(struct v4l2_subdev *sd,
 	u32 mask = 0;
 	u32 i;
 
-	dev_dbg(dev, "stream %s CSI2-%u with %u lanes\n", enable ? "on" : "off",
+	dev_dbg(dev, "stream %s CSI2-%u with %u lanes\n", str_on_off(enable),
 		csi2->port, nlanes);
 
 	cfg.port = csi2->port;

-- 
2.46.1.824.gd892dcdcdd-goog


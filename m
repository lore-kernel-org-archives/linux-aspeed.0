From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 28 Oct 2022 10:35:51 +0800
Subject: [PATCH v11 2/5] media: v4l2-ctrls: Reserve controls for ASPEED
In-Reply-To: <20221028023554.928-1-jammy_huang@aspeedtech.com>
References: <20221028023554.928-1-jammy_huang@aspeedtech.com>
Message-ID: <20221028023554.928-3-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reserve controls for ASPEED video family. Aspeed video engine contains a
few features which improve video quality, reduce amount of compressed
data, and etc. Hence, 16 controls are reserved for these aspeed
proprietary features.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v11:
  - no update
v10:
  - no update
v9:
  - Rebase on new kernel
v8:
  - no update
v7:
  - no update
v6:
  - no update
v5:
  - no update
v4:
  - new
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b5e7d082b8ad..60a6bed21c56 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -231,6 +231,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_DW100_BASE		(V4L2_CID_USER_BASE + 0x1190)
 
+/*
+ * The base for Aspeed driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11A0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.25.1


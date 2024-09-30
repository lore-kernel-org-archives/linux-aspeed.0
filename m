From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:03:58 +0000
Subject: [PATCH 03/45] media: core: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-3-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/v4l2-core/v4l2-fwnode.c:282:32-33: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-fwnode.c:290:32-33: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-fwnode.c:298:37-38: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-fwnode.c:329:31-32: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-fwnode.c:356:40-41: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-fwnode.c:364:38-39: opportunity for str_high_low(v)
drivers/media/v4l2-core/v4l2-ctrls-core.c:272:16-26: opportunity for str_true_false(* ptr . p_s32)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c |  3 ++-
 drivers/media/v4l2-core/v4l2-fwnode.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index eeab6a5eb7ba..f303c70dffae 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
@@ -269,7 +270,7 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
 		pr_cont("%d", *ptr.p_s32);
 		break;
 	case V4L2_CTRL_TYPE_BOOLEAN:
-		pr_cont("%s", *ptr.p_s32 ? "true" : "false");
+		pr_cont("%s", str_true_false(*ptr.p_s32));
 		break;
 	case V4L2_CTRL_TYPE_MENU:
 		pr_cont("%s", ctrl->qmenu[*ptr.p_s32]);
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index f19c8adf2c61..92dc17179018 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -279,7 +279,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_HSYNC_ACTIVE_LOW);
 		flags |= v ? V4L2_MBUS_HSYNC_ACTIVE_HIGH :
 			V4L2_MBUS_HSYNC_ACTIVE_LOW;
-		pr_debug("hsync-active %s\n", v ? "high" : "low");
+		pr_debug("hsync-active %s\n", str_high_low(v));
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "vsync-active", &v)) {
@@ -287,7 +287,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_VSYNC_ACTIVE_LOW);
 		flags |= v ? V4L2_MBUS_VSYNC_ACTIVE_HIGH :
 			V4L2_MBUS_VSYNC_ACTIVE_LOW;
-		pr_debug("vsync-active %s\n", v ? "high" : "low");
+		pr_debug("vsync-active %s\n", str_high_low(v));
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "field-even-active", &v)) {
@@ -295,7 +295,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_FIELD_EVEN_LOW);
 		flags |= v ? V4L2_MBUS_FIELD_EVEN_HIGH :
 			V4L2_MBUS_FIELD_EVEN_LOW;
-		pr_debug("field-even-active %s\n", v ? "high" : "low");
+		pr_debug("field-even-active %s\n", str_high_low(v));
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "pclk-sample", &v)) {
@@ -326,7 +326,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_DATA_ACTIVE_LOW);
 		flags |= v ? V4L2_MBUS_DATA_ACTIVE_HIGH :
 			V4L2_MBUS_DATA_ACTIVE_LOW;
-		pr_debug("data-active %s\n", v ? "high" : "low");
+		pr_debug("data-active %s\n", str_high_low(v));
 	}
 
 	if (fwnode_property_present(fwnode, "slave-mode")) {
@@ -353,7 +353,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW);
 		flags |= v ? V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH :
 			V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW;
-		pr_debug("sync-on-green-active %s\n", v ? "high" : "low");
+		pr_debug("sync-on-green-active %s\n", str_high_low(v));
 	}
 
 	if (!fwnode_property_read_u32(fwnode, "data-enable-active", &v)) {
@@ -361,7 +361,7 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
 			   V4L2_MBUS_DATA_ENABLE_LOW);
 		flags |= v ? V4L2_MBUS_DATA_ENABLE_HIGH :
 			V4L2_MBUS_DATA_ENABLE_LOW;
-		pr_debug("data-enable-active %s\n", v ? "high" : "low");
+		pr_debug("data-enable-active %s\n", str_high_low(v));
 	}
 
 	switch (bus_type) {

-- 
2.46.1.824.gd892dcdcdd-goog


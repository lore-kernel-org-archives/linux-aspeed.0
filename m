From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:10 +0000
Subject: [PATCH 15/45] media: amphion: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-15-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/platform/amphion/venc.c:1206:4-26: opportunity for str_enable_disable(venc -> params . rc_enable)
drivers/media/platform/amphion/vpu_dbg.c:259:3-34: opportunity for str_on_off(vpu_iface_get_power_state ( core ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/amphion/venc.c    | 2 +-
 drivers/media/platform/amphion/vpu_dbg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 351b4edc8742..789c8fca3d31 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -1203,7 +1203,7 @@ static int venc_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 		break;
 	case 8:
 		num = scnprintf(str, size, "rc: %s, mode = %d, bitrate = %d(%d), qp = %d\n",
-				venc->params.rc_enable ? "enable" : "disable",
+				str_enable_disable(venc->params.rc_enable),
 				venc->params.rc_mode,
 				venc->params.bitrate,
 				venc->params.bitrate_max,
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 940e5bda5fa3..2dbcef4e83ef 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -256,7 +256,7 @@ static int vpu_dbg_core(struct seq_file *s, void *data)
 		return 0;
 
 	num = scnprintf(str, sizeof(str), "power %s\n",
-			vpu_iface_get_power_state(core) ? "on" : "off");
+			str_on_off(vpu_iface_get_power_state(core)));
 	if (seq_write(s, str, num))
 		return 0;
 	num = scnprintf(str, sizeof(str), "state = %d\n", core->state);

-- 
2.46.1.824.gd892dcdcdd-goog


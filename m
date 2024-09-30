From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:15 +0000
Subject: [PATCH 20/45] media: st: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-20-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/platform/st/sti/hva/hva-debugfs.c:74:9-22: opportunity for str_true_false(ctrls -> dct8x8)
drivers/media/platform/st/sti/hva/hva-debugfs.c:79:9-22: opportunity for str_true_false(ctrls -> sei_fp)
drivers/media/platform/st/sti/hva/hva-debugfs.c:77:9-23: opportunity for str_true_false(ctrls -> vui_sar)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/st/sti/hva/hva-debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-debugfs.c b/drivers/media/platform/st/sti/hva/hva-debugfs.c
index a86a07b6fbc7..5e8c7dddbabf 100644
--- a/drivers/media/platform/st/sti/hva/hva-debugfs.c
+++ b/drivers/media/platform/st/sti/hva/hva-debugfs.c
@@ -71,12 +71,12 @@ static void format_ctx(struct seq_file *s, struct hva_ctx *ctx)
 			      "  | |- SEI frame packing type=%s\n",
 			      v4l2_ctrl_get_menu(entropy)[ctrls->entropy_mode],
 			      ctrls->cpb_size,
-			      ctrls->dct8x8 ? "true" : "false",
+			      str_true_false(ctrls->dct8x8),
 			      ctrls->qpmin,
 			      ctrls->qpmax,
-			      ctrls->vui_sar ? "true" : "false",
+			      str_true_false(ctrls->vui_sar),
 			      v4l2_ctrl_get_menu(vui_sar)[ctrls->vui_sar_idc],
-			      ctrls->sei_fp ? "true" : "false",
+			      str_true_false(ctrls->sei_fp),
 			      v4l2_ctrl_get_menu(sei_fp)[ctrls->sei_fp_type]);
 	}
 

-- 
2.46.1.824.gd892dcdcdd-goog


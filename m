From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:11 +0000
Subject: [PATCH 16/45] media: pci: ivtv: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-16-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/pci/ivtv/ivtvfb.c:809:3-57: opportunity for str_on_off(( var -> vmode & FB_VMODE_MASK ) == FB_VMODE_NONINTERLACED)
drivers/media/pci/ivtv/ivtvfb.c:609:3-57: opportunity for str_on_off(( var -> vmode & FB_VMODE_MASK ) == FB_VMODE_NONINTERLACED)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/ivtv/ivtvfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 90c584cf97c2..bd07afc68191 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -606,7 +606,7 @@ static int ivtvfb_set_var(struct ivtv *itv, struct fb_var_screeninfo *var)
 		      var->left_margin, var->upper_margin);
 
 	IVTVFB_DEBUG_INFO("Display filter: %s\n",
-			(var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED ? "on" : "off");
+			str_on_off((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED));
 	IVTVFB_DEBUG_INFO("Color space: %s\n", var->nonstd ? "YUV" : "RGB");
 
 	return 0;
@@ -806,7 +806,7 @@ static int _ivtvfb_check_var(struct fb_var_screeninfo *var, struct ivtv *itv)
 		      var->left_margin, var->upper_margin);
 
 	IVTVFB_DEBUG_INFO("Display filter: %s\n",
-			(var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED ? "on" : "off");
+			str_on_off((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED));
 	IVTVFB_DEBUG_INFO("Color space: %s\n", var->nonstd ? "YUV" : "RGB");
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog


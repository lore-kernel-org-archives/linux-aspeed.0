From: Joe Perches <joe@perches.com>
Date: Tue,  9 Jul 2019 22:04:16 -0700
Subject: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Message-ID: <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index a10358bb61ec..095ea03e5833 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
 /* CTRL2 */
 #define CRT_CTRL_DAC_EN			BIT(0)
 #define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
-#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
+#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(31, 20)
 
 /* CRT_HORIZ0 */
 #define CRT_H_TOTAL(x)			(x)
-- 
2.15.0


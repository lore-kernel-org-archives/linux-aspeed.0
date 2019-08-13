From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Tue, 13 Aug 2019 06:34:12 -0000
Subject: [PATCH] drm/aspeed: gfc_crtc: Make structure aspeed_gfx_funcs constant
Message-ID: <20190813063355.25549-1-nishkadg.linux@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The static structure aspeed_gfx_funcs, of type
drm_simple_display_pipe_funcs, is used only as an argument to
drm_simple_display_pipe_init(), which does not modify it. Hence make it
constant to protect it from unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index 15db9e426ec4..2184b8be6fd4 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -215,7 +215,7 @@ static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
 	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
 }
 
-static struct drm_simple_display_pipe_funcs aspeed_gfx_funcs = {
+static const struct drm_simple_display_pipe_funcs aspeed_gfx_funcs = {
 	.enable		= aspeed_gfx_pipe_enable,
 	.disable	= aspeed_gfx_pipe_disable,
 	.update		= aspeed_gfx_pipe_update,
-- 
2.19.1


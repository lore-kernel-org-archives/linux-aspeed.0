From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed, 12 Jul 2023 11:46:16 +0200
Subject: [PATCH RFC v1 06/52] drm/aspeed: Use struct drm_crtc::drm_dev instead of struct drm_crtc::dev
In-Reply-To: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230712094702.1770121-7-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Prepare dropping the alias "dev" for struct drm_crtc::drm_dev. "drm_dev"
is the better name as "dev" is usually a struct device pointer.

No semantic changes.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index 7877a57b8e26..84c4b28e7c9c 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -26,7 +26,7 @@ drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
 static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
 {
 	struct drm_crtc *crtc = &priv->pipe.crtc;
-	struct drm_device *drm = crtc->dev;
+	struct drm_device *drm = crtc->drm_dev;
 	const u32 format = crtc->primary->state->fb->format->format;
 	u32 ctrl1;
 
@@ -169,7 +169,7 @@ static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_pending_vblank_event *event;
 	struct drm_gem_dma_object *gem;
 
-	spin_lock_irq(&crtc->dev->event_lock);
+	spin_lock_irq(&crtc->drm_dev->event_lock);
 	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
@@ -179,7 +179,7 @@ static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
 		else
 			drm_crtc_send_vblank_event(crtc, event);
 	}
-	spin_unlock_irq(&crtc->dev->event_lock);
+	spin_unlock_irq(&crtc->drm_dev->event_lock);
 
 	if (!fb)
 		return;
-- 
2.39.2


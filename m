From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 24 Oct 2022 13:19:46 +0200
Subject: [PATCH v2 14/21] drm/fb-helper: Rename drm_fb_helper_unregister_fbi() to use _info postfix
In-Reply-To: <20221024111953.24307-1-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
Message-ID: <20221024111953.24307-15-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rename drm_fb_helper_unregister_fbi() to drm_fb_helper_unregister_info()
as part of unifying the naming within fbdev helpers. Adapt drivers. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/armada/armada_fbdev.c      | 2 +-
 drivers/gpu/drm/drm_fb_helper.c            | 8 ++++----
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c  | 2 +-
 drivers/gpu/drm/gma500/framebuffer.c       | 2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c | 2 +-
 drivers/gpu/drm/msm/msm_fbdev.c            | 2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c    | 2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c       | 2 +-
 drivers/gpu/drm/radeon/radeon_fb.c         | 2 +-
 drivers/gpu/drm/tegra/fb.c                 | 2 +-
 include/drm/drm_fb_helper.h                | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index eaae98d9377ae..f02f6a5ba8320 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -155,7 +155,7 @@ void armada_fbdev_fini(struct drm_device *dev)
 	struct drm_fb_helper *fbh = priv->fbdev;
 
 	if (fbh) {
-		drm_fb_helper_unregister_fbi(fbh);
+		drm_fb_helper_unregister_info(fbh);
 
 		drm_fb_helper_fini(fbh);
 
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 881e6a04fa706..bfbb2af144060 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -612,19 +612,19 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 EXPORT_SYMBOL(drm_fb_helper_alloc_info);
 
 /**
- * drm_fb_helper_unregister_fbi - unregister fb_info framebuffer device
+ * drm_fb_helper_unregister_info - unregister fb_info framebuffer device
  * @fb_helper: driver-allocated fbdev helper, can be NULL
  *
  * A wrapper around unregister_framebuffer, to release the fb_info
  * framebuffer device. This must be called before releasing all resources for
  * @fb_helper by calling drm_fb_helper_fini().
  */
-void drm_fb_helper_unregister_fbi(struct drm_fb_helper *fb_helper)
+void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
 	if (fb_helper && fb_helper->info)
 		unregister_framebuffer(fb_helper->info);
 }
-EXPORT_SYMBOL(drm_fb_helper_unregister_fbi);
+EXPORT_SYMBOL(drm_fb_helper_unregister_info);
 
 /**
  * drm_fb_helper_fini - finialize a &struct drm_fb_helper
@@ -2497,7 +2497,7 @@ static void drm_fbdev_client_unregister(struct drm_client_dev *client)
 
 	if (fb_helper->info)
 		/* drm_fbdev_fb_destroy() takes care of cleanup */
-		drm_fb_helper_unregister_fbi(fb_helper);
+		drm_fb_helper_unregister_info(fb_helper);
 	else
 		drm_fbdev_release(fb_helper);
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 8741eb0b1b604..86c489d945849 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -201,7 +201,7 @@ static void exynos_drm_fbdev_destroy(struct drm_device *dev,
 			drm_framebuffer_remove(fb);
 	}
 
-	drm_fb_helper_unregister_fbi(fb_helper);
+	drm_fb_helper_unregister_info(fb_helper);
 
 	drm_fb_helper_fini(fb_helper);
 }
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 6d0e3bf6435ee..6098d936e44b6 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -383,7 +383,7 @@ static int psb_fbdev_destroy(struct drm_device *dev,
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	drm_fb_helper_unregister_fbi(fb_helper);
+	drm_fb_helper_unregister_info(fb_helper);
 
 	drm_fb_helper_fini(fb_helper);
 	drm_framebuffer_unregister_private(fb);
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 05b841343ea3e..1b576c859837b 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -584,7 +584,7 @@ void intel_fbdev_unregister(struct drm_i915_private *dev_priv)
 	if (!current_is_async())
 		intel_fbdev_sync(ifbdev);
 
-	drm_fb_helper_unregister_fbi(&ifbdev->helper);
+	drm_fb_helper_unregister_info(&ifbdev->helper);
 }
 
 void intel_fbdev_fini(struct drm_i915_private *dev_priv)
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 4d9a0fcbf95b6..31e1e30cb52a2 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -182,7 +182,7 @@ void msm_fbdev_free(struct drm_device *dev)
 
 	DBG();
 
-	drm_fb_helper_unregister_fbi(helper);
+	drm_fb_helper_unregister_info(helper);
 
 	drm_fb_helper_fini(helper);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index fca40124fc17c..e87de7906f780 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -419,7 +419,7 @@ nouveau_fbcon_destroy(struct drm_device *dev, struct nouveau_fbdev *fbcon)
 	struct drm_framebuffer *fb = fbcon->helper.fb;
 	struct nouveau_bo *nvbo;
 
-	drm_fb_helper_unregister_fbi(&fbcon->helper);
+	drm_fb_helper_unregister_info(&fbcon->helper);
 	drm_fb_helper_fini(&fbcon->helper);
 
 	if (fb && fb->obj[0]) {
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index ab30c64e97043..98d8758048fc1 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -272,7 +272,7 @@ void omap_fbdev_fini(struct drm_device *dev)
 	if (!helper)
 		return;
 
-	drm_fb_helper_unregister_fbi(helper);
+	drm_fb_helper_unregister_info(helper);
 
 	drm_fb_helper_fini(helper);
 
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 0c6a227929db2..f06fed2030a89 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -309,7 +309,7 @@ static int radeon_fbdev_destroy(struct drm_device *dev, struct radeon_fbdev *rfb
 {
 	struct drm_framebuffer *fb = &rfbdev->fb;
 
-	drm_fb_helper_unregister_fbi(&rfbdev->helper);
+	drm_fb_helper_unregister_info(&rfbdev->helper);
 
 	if (fb->obj[0]) {
 		radeonfb_destroy_pinned_object(fb->obj[0]);
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index a09c071f35120..84b7f1dd9fb57 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -347,7 +347,7 @@ static int tegra_fbdev_init(struct tegra_fbdev *fbdev,
 
 static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
 {
-	drm_fb_helper_unregister_fbi(&fbdev->base);
+	drm_fb_helper_unregister_info(&fbdev->base);
 
 	if (fbdev->fb) {
 		struct tegra_bo *bo = tegra_fb_get_plane(fbdev->fb, 0);
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 5ec9d9c68d144..edc697a2fde24 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -223,7 +223,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper);
 
 struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper);
-void drm_fb_helper_unregister_fbi(struct drm_fb_helper *fb_helper);
+void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
 			     struct drm_fb_helper_surface_size *sizes);
@@ -325,7 +325,7 @@ drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 	return NULL;
 }
 
-static inline void drm_fb_helper_unregister_fbi(struct drm_fb_helper *fb_helper)
+static inline void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
 }
 
-- 
2.38.0


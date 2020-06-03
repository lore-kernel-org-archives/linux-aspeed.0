From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  3 Jun 2020 10:31:10 +0200
Subject: [PATCH v2 01/23] drm/cma-helper: Rework DRM_GEM_CMA_VMAP_DRIVER_OPS
 macro
In-Reply-To: <20200603083132.4610-1-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
Message-ID: <20200603083132.4610-2-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rename the macro to DRM_GEM_CMA_DRIVER_OPS to align with SHMEM
helpers. An internal version is provided for drivers that override
the default .dumb_create callback. Adapt drivers to the changes.

v2:
	* provide DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c    |  3 +--
 drivers/gpu/drm/tidss/tidss_drv.c    |  2 +-
 drivers/gpu/drm/tiny/hx8357d.c       |  2 +-
 drivers/gpu/drm/tiny/ili9225.c       |  2 +-
 drivers/gpu/drm/tiny/ili9341.c       |  2 +-
 drivers/gpu/drm/tiny/ili9486.c       |  2 +-
 drivers/gpu/drm/tiny/mi0283qt.c      |  2 +-
 drivers/gpu/drm/tiny/repaper.c       |  2 +-
 drivers/gpu/drm/tiny/st7586.c        |  2 +-
 drivers/gpu/drm/tiny/st7735r.c       |  2 +-
 include/drm/drm_gem_cma_helper.h     | 30 ++++++++++++++++++++++++----
 12 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index b3db3ca7bd7a7..322a695608607 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -620,7 +620,7 @@ EXPORT_SYMBOL(drm_cma_gem_create_object_default_funcs);
  * address set. This address is released when the object is freed.
  *
  * This function can be used as the &drm_driver.gem_prime_import_sg_table
- * callback. The DRM_GEM_CMA_VMAP_DRIVER_OPS() macro provides a shortcut to set
+ * callback. The &DRM_GEM_CMA_DRIVER_OPS macro provides a shortcut to set
  * the necessary DRM driver operations.
  *
  * Returns:
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 328272ff77d84..94a90961284ce 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -52,8 +52,7 @@ static struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
-	.dumb_create		= drm_sun4i_gem_dumb_create,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(drm_sun4i_gem_dumb_create),
 };
 
 static int sun4i_drv_bind(struct device *dev)
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 99edc66ebdef2..1753cdc74ebda 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -112,7 +112,7 @@ static struct drm_driver tidss_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &tidss_fops,
 	.release		= tidss_release,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.name			= "tidss",
 	.desc			= "TI Keystone DSS",
 	.date			= "20180215",
diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index b4bc358a3269a..592da71d7ca70 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -196,7 +196,7 @@ DEFINE_DRM_GEM_CMA_FOPS(hx8357d_fops);
 static struct drm_driver hx8357d_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &hx8357d_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "hx8357d",
 	.desc			= "HX8357D",
diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index d1a5ab6747d5c..368ff6c8a1efb 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -346,7 +346,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9225_fops);
 static struct drm_driver ili9225_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &ili9225_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.name			= "ili9225",
 	.desc			= "Ilitek ILI9225",
 	.date			= "20171106",
diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index bb819f45a5d3b..e1b9043ef7a0a 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -152,7 +152,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9341_fops);
 static struct drm_driver ili9341_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &ili9341_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "ili9341",
 	.desc			= "Ilitek ILI9341",
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 2702ea557d297..90a17f40fdf0c 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -165,7 +165,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9486_fops);
 static struct drm_driver ili9486_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &ili9486_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "ili9486",
 	.desc			= "Ilitek ILI9486",
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index 08ac549ab0f7f..6624c2098fba2 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -156,7 +156,7 @@ DEFINE_DRM_GEM_CMA_FOPS(mi0283qt_fops);
 static struct drm_driver mi0283qt_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &mi0283qt_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "mi0283qt",
 	.desc			= "Multi-Inno MI0283QT",
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 1c0e7169545b4..877dcece25828 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -946,7 +946,7 @@ DEFINE_DRM_GEM_CMA_FOPS(repaper_fops);
 static struct drm_driver repaper_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &repaper_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.name			= "repaper",
 	.desc			= "Pervasive Displays RePaper e-ink panels",
 	.date			= "20170405",
diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
index 2a1fae422f7a2..ec84bdc51f60d 100644
--- a/drivers/gpu/drm/tiny/st7586.c
+++ b/drivers/gpu/drm/tiny/st7586.c
@@ -285,7 +285,7 @@ DEFINE_DRM_GEM_CMA_FOPS(st7586_fops);
 static struct drm_driver st7586_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &st7586_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "st7586",
 	.desc			= "Sitronix ST7586",
diff --git a/drivers/gpu/drm/tiny/st7735r.c b/drivers/gpu/drm/tiny/st7735r.c
index 0af1b15efdf8a..cfd4933f3b30c 100644
--- a/drivers/gpu/drm/tiny/st7735r.c
+++ b/drivers/gpu/drm/tiny/st7735r.c
@@ -157,7 +157,7 @@ DEFINE_DRM_GEM_CMA_FOPS(st7735r_fops);
 static struct drm_driver st7735r_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &st7735r_fops,
-	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "st7735r",
 	.desc			= "Sitronix ST7735R",
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 947ac95eb24a9..75c0eebc663ca 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -110,21 +110,43 @@ struct drm_gem_object *
 drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size);
 
 /**
- * DRM_GEM_CMA_VMAP_DRIVER_OPS - CMA GEM driver operations ensuring a virtual
- *                               address on the buffer
+ * DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE - CMA GEM driver operations
+ *                                           ensuring a virtual address
+ *                                           on the buffer
+ * @dumb_create_func: callback function for .dumb_create
  *
  * This macro provides a shortcut for setting the default GEM operations in the
  * &drm_driver structure for drivers that need the virtual address also on
  * imported buffers.
+ *
+ * This macro is a variant of DRM_GEM_CMA_DRIVER_OPS for drivers that
+ * override the default implementation of &struct rm_driver.dumb_create. Use
+ * DRM_GEM_CMA_DRIVER_OPS if possible.
  */
-#define DRM_GEM_CMA_VMAP_DRIVER_OPS \
+#define DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(dumb_create_func) \
 	.gem_create_object	= drm_cma_gem_create_object_default_funcs, \
-	.dumb_create		= drm_gem_cma_dumb_create, \
+	.dumb_create		= (dumb_create_func), \
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd, \
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle, \
 	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table_vmap, \
 	.gem_prime_mmap		= drm_gem_prime_mmap
 
+/**
+ * DRM_GEM_CMA_DRIVER_OPS - CMA GEM driver operations ensuring a virtual
+ *                          address on the buffer
+ *
+ * This macro provides a shortcut for setting the default GEM operations in the
+ * &drm_driver structure for drivers that need the virtual address also on
+ * imported buffers.
+ *
+ * Drivers that come with their own implementation of
+ * &struct drm_driver.dumb_create should use
+ * DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE() instead. Use
+ * DRM_GEM_CMA_DRIVER_OPS if possible.
+ */
+#define DRM_GEM_CMA_DRIVER_OPS \
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(drm_gem_cma_dumb_create)
+
 struct drm_gem_object *
 drm_gem_cma_prime_import_sg_table_vmap(struct drm_device *drm,
 				       struct dma_buf_attachment *attach,
-- 
2.26.2


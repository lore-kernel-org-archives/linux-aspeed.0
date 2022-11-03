From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu,  3 Nov 2022 16:14:46 +0100
Subject: [PATCH v3 23/23] drm/fb-helper: Clarify use of last_close and output_poll_changed
In-Reply-To: <20221103151446.2638-1-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
Message-ID: <20221103151446.2638-24-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Clarify documentation in the use of struct drm_driver.last_close and
struct drm_mode_config_funcs.output_poll_changed. Those callbacks should
not be said for fbdev implementations on top of struct drm_client_funcs.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 5eb2f0d4bf8d4..e0384f967c0b3 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -89,11 +89,13 @@ static DEFINE_MUTEX(kernel_fb_helper_lock);
  * It will automatically set up deferred I/O if the driver requires a shadow
  * buffer.
  *
- * At runtime drivers should restore the fbdev console by using
+ * Existing fbdev implementations should restore the fbdev console by using
  * drm_fb_helper_lastclose() as their &drm_driver.lastclose callback.
  * They should also notify the fb helper code from updates to the output
  * configuration by using drm_fb_helper_output_poll_changed() as their
- * &drm_mode_config_funcs.output_poll_changed callback.
+ * &drm_mode_config_funcs.output_poll_changed callback. New implementations
+ * of fbdev should be build on top of struct &drm_client_funcs, which handles
+ * this automatically. Setting the old callbacks should be avoided.
  *
  * For suspend/resume consider using drm_mode_config_helper_suspend() and
  * drm_mode_config_helper_resume() which takes care of fbdev as well.
-- 
2.38.0


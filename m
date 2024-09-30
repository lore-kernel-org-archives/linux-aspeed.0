From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:03:57 +0000
Subject: [PATCH 02/45] media: staging: atomisp: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-2-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/staging/media/atomisp/pci/sh_css.c:1490:16-19: opportunity for str_true_false(map)
drivers/staging/media/atomisp/pci/atomisp_compat_css20.c:855:2-8: opportunity for str_enable_disable(enable)
drivers/staging/media/atomisp/pci/atomisp_v4l2.c:542:40-46: opportunity for str_on_off(enable)
drivers/staging/media/atomisp/pci/atomisp_v4l2.c:584:48-54: opportunity for str_on_off(enable)
drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c:1006:2-4: opportunity for str_on_off(on)
drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c:1019:3-5: opportunity for str_on_off(on)
drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c:394:9-19: opportunity for str_low_high(active_low)
drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c:1253:3-35: opportunity for str_true_false(xcandidate -> sp . enable . continuous)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c      | 2 +-
 drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c       | 2 +-
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c     | 4 ++--
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c              | 4 ++--
 drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c | 2 +-
 drivers/staging/media/atomisp/pci/sh_css.c                    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index a62a5c0b3c00..34e68ea1b1f4 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -852,7 +852,7 @@ int atomisp_css_irq_enable(struct atomisp_device *isp,
 {
 	dev_dbg(isp->dev, "%s: css irq info 0x%08x: %s (%d).\n",
 		__func__, info,
-		enable ? "enable" : "disable", enable);
+		str_enable_disable(enable), enable);
 	if (ia_css_irq_enable(info, enable)) {
 		dev_warn(isp->dev, "%s:Invalid irq info: 0x%08x when %s.\n",
 			 __func__, info,
diff --git a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
index 6abda358a72f..7d1905791b9a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
@@ -391,7 +391,7 @@ static int atomisp_csi2_handle_acpi_gpio_res(struct acpi_resource *ares, void *_
 	acpi_handle_info(data->adev->handle, "%s: %s crs %d %s pin %u active-%s\n",
 			 dev_name(&data->adev->dev), name,
 			 data->res_count - 1, agpio->resource_source.string_ptr,
-			 pin, active_low ? "low" : "high");
+			 pin, str_low_high(active_low));
 
 	return 1;
 }
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index e176483df301..85e7d14ef394 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1003,7 +1003,7 @@ static int gmin_acpi_pm_ctrl(struct v4l2_subdev *subdev, int on)
 		return 0;
 
 	dev_dbg(subdev->dev, "Setting power state to %s\n",
-		on ? "on" : "off");
+		str_on_off(on));
 
 	if (on)
 		ret = acpi_device_set_power(adev,
@@ -1016,7 +1016,7 @@ static int gmin_acpi_pm_ctrl(struct v4l2_subdev *subdev, int on)
 		gs->clock_on = on;
 	else
 		dev_err(subdev->dev, "Couldn't set power state to %s\n",
-			on ? "on" : "off");
+			str_on_off(on));
 
 	return ret;
 }
diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index c9984f1557b0..6fd18217df1e 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -539,7 +539,7 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
 	u32 val = enable ? MRFLD_ISPSSPM0_IUNIT_POWER_ON :
 			   MRFLD_ISPSSPM0_IUNIT_POWER_OFF;
 
-	dev_dbg(isp->dev, "IUNIT power-%s.\n", enable ? "on" : "off");
+	dev_dbg(isp->dev, "IUNIT power-%s.\n", str_on_off(enable));
 
 	/* WA for P-Unit, if DVFS enabled, ISP timeout observed */
 	if (IS_CHT && enable && !isp->pm_only) {
@@ -581,7 +581,7 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
 		usleep_range(100, 150);
 	} while (1);
 
-	dev_err(isp->dev, "IUNIT power-%s timeout.\n", enable ? "on" : "off");
+	dev_err(isp->dev, "IUNIT power-%s timeout.\n", str_on_off(enable));
 	return -EBUSY;
 }
 
diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index 7ce2b2d6da11..7e295bc83464 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -1250,7 +1250,7 @@ int ia_css_binary_find(struct ia_css_binary_descr *descr, struct ia_css_binary *
 		dev_dbg(atomisp_dev, "Using binary %s (id %d), type %d, mode %d, continuous %s\n",
 			xcandidate->blob->name, xcandidate->sp.id, xcandidate->type,
 			xcandidate->sp.pipeline.mode,
-			xcandidate->sp.enable.continuous ? "true" : "false");
+			str_true_false(xcandidate->sp.enable.continuous));
 
 	if (err)
 		dev_err(atomisp_dev, "Failed to find a firmware binary matching the pipeline parameters\n");
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index ca97ea082cf4..89a694453e6f 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -1487,7 +1487,7 @@ map_sp_threads(struct ia_css_stream *stream, bool map)
 	enum ia_css_pipe_id pipe_id;
 
 	IA_CSS_ENTER_PRIVATE("stream = %p, map = %s",
-			     stream, map ? "true" : "false");
+			     stream, str_true_false(map));
 
 	if (!stream) {
 		IA_CSS_LEAVE_ERR_PRIVATE(-EINVAL);

-- 
2.46.1.824.gd892dcdcdd-goog


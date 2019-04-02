From: Joel Stanley <joel@jms.id.au>
Date: Tue,  2 Apr 2019 12:49:32 +1030
Subject: [PATCH v2 2/3] drm: Add ASPEED GFX driver
In-Reply-To: <20190402021933.13071-1-joel@jms.id.au>
References: <20190402021933.13071-1-joel@jms.id.au>
Message-ID: <20190402021933.13071-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This driver is for the ASPEED BMC SoC's GFX display hardware. This
driver runs on the ARM based BMC systems, unlike the ast driver which
runs on a host CPU and is is for a PCI graphics device.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Noralf Tr?nnes <noralf@tronnes.org>
--
v2:
 Use drm_gem_fb_simple_display_pipe_prepare_fb
 Sort headers
 Remove drmP.h inclusion
 Replace gem callbacks with those suggested by Noralf
 Use drm_connector_cleanup
 Drop null check for embedddd crtc object
 Tweaks to spelling in kerneldoc
 Drop DRM_KMS_FB_HELPER to make fbdev emulation optional
 Remove ast2400 compatible as the ast2400 support is untested

Changes since RFC:
 drm_fbdev_cma_init -> drm_fb_cma_fbdev_init and use generic lastclose callback
 Use generic irq handling instead of drm_irq_install
 Add doc to driver
 Get rid of unncessary reads in irq enable/disable path
 Rebase on linux-next
---
 drivers/gpu/drm/Kconfig                  |   2 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/aspeed/Kconfig           |  14 ++
 drivers/gpu/drm/aspeed/Makefile          |   3 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h      | 104 +++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 239 ++++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 266 +++++++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c  |  42 ++++
 8 files changed, 671 insertions(+)
 create mode 100644 drivers/gpu/drm/aspeed/Kconfig
 create mode 100644 drivers/gpu/drm/aspeed/Makefile
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx.h
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_out.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 82bb221ec94e..b1ec8f85c2a8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -335,6 +335,8 @@ source "drivers/gpu/drm/xen/Kconfig"
 
 source "drivers/gpu/drm/vboxvideo/Kconfig"
 
+source "drivers/gpu/drm/aspeed/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 0baf148e3687..df8835045310 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -110,3 +110,4 @@ obj-$(CONFIG_DRM_PL111) += pl111/
 obj-$(CONFIG_DRM_TVE200) += tve200/
 obj-$(CONFIG_DRM_XEN) += xen/
 obj-$(CONFIG_DRM_VBOXVIDEO) += vboxvideo/
+obj-$(CONFIG_DRM_ASPEED_GFX) += aspeed/
diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
new file mode 100644
index 000000000000..42b74d18a41b
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -0,0 +1,14 @@
+config DRM_ASPEED_GFX
+	tristate "ASPEED BMC Display Controller"
+	depends on DRM && OF
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_PANEL
+	select DMA_CMA
+	select CMA
+	select MFD_SYSCON
+	help
+	  Chose this option if you have an ASPEED AST2500 SOC Display
+	  Controller (aka GFX).
+
+	  If M is selected this module will be called aspeed_gfx.
diff --git a/drivers/gpu/drm/aspeed/Makefile b/drivers/gpu/drm/aspeed/Makefile
new file mode 100644
index 000000000000..6e194cd790d8
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/Makefile
@@ -0,0 +1,3 @@
+aspeed_gfx-y := aspeed_gfx_drv.o aspeed_gfx_crtc.o aspeed_gfx_out.o
+
+obj-$(CONFIG_DRM_ASPEED_GFX) += aspeed_gfx.o
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
new file mode 100644
index 000000000000..fb56e425bd48
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corporation
+
+#include <drm/drmP.h>
+#include <drm/drm_simple_kms_helper.h>
+
+struct aspeed_gfx {
+	void __iomem			*base;
+	struct clk			*clk;
+	struct reset_control		*rst;
+	struct regmap			*scu;
+
+	struct drm_simple_display_pipe	pipe;
+	struct drm_connector		connector;
+	struct drm_fbdev_cma		*fbdev;
+};
+
+int aspeed_gfx_create_pipe(struct drm_device *drm);
+int aspeed_gfx_create_output(struct drm_device *drm);
+
+#define CRT_CTRL1		0x60 /* CRT Control I */
+#define CRT_CTRL2		0x64 /* CRT Control II */
+#define CRT_STATUS		0x68 /* CRT Status */
+#define CRT_MISC		0x6c /* CRT Misc Setting */
+#define CRT_HORIZ0		0x70 /* CRT Horizontal Total & Display Enable End */
+#define CRT_HORIZ1		0x74 /* CRT Horizontal Retrace Start & End */
+#define CRT_VERT0		0x78 /* CRT Vertical Total & Display Enable End */
+#define CRT_VERT1		0x7C /* CRT Vertical Retrace Start & End */
+#define CRT_ADDR		0x80 /* CRT Display Starting Address */
+#define CRT_OFFSET		0x84 /* CRT Display Offset & Terminal Count */
+#define CRT_THROD		0x88 /* CRT Threshold */
+#define CRT_XSCALE		0x8C /* CRT Scaling-Up Factor */
+#define CRT_CURSOR0		0x90 /* CRT Hardware Cursor X & Y Offset */
+#define CRT_CURSOR1		0x94 /* CRT Hardware Cursor X & Y Position */
+#define CRT_CURSOR2		0x98 /* CRT Hardware Cursor Pattern Address */
+#define CRT_9C			0x9C
+#define CRT_OSD_H		0xA0 /* CRT OSD Horizontal Start/End */
+#define CRT_OSD_V		0xA4 /* CRT OSD Vertical Start/End */
+#define CRT_OSD_ADDR		0xA8 /* CRT OSD Pattern Address */
+#define CRT_OSD_DISP		0xAC /* CRT OSD Offset */
+#define CRT_OSD_THRESH		0xB0 /* CRT OSD Threshold & Alpha */
+#define CRT_B4			0xB4
+#define CRT_STS_V		0xB8 /* CRT Status V */
+#define CRT_SCRATCH		0xBC /* Scratchpad */
+#define CRT_BB0_ADDR		0xD0 /* CRT Display BB0 Starting Address */
+#define CRT_BB1_ADDR		0xD4 /* CRT Display BB1 Starting Address */
+#define CRT_BB_COUNT		0xD8 /* CRT Display BB Terminal Count */
+#define OSD_COLOR1		0xE0 /* OSD Color Palette Index 1 & 0 */
+#define OSD_COLOR2		0xE4 /* OSD Color Palette Index 3 & 2 */
+#define OSD_COLOR3		0xE8 /* OSD Color Palette Index 5 & 4 */
+#define OSD_COLOR4		0xEC /* OSD Color Palette Index 7 & 6 */
+#define OSD_COLOR5		0xF0 /* OSD Color Palette Index 9 & 8 */
+#define OSD_COLOR6		0xF4 /* OSD Color Palette Index 11 & 10 */
+#define OSD_COLOR7		0xF8 /* OSD Color Palette Index 13 & 12 */
+#define OSD_COLOR8		0xFC /* OSD Color Palette Index 15 & 14 */
+
+/* CTRL1 */
+#define CRT_CTRL_EN			BIT(0)
+#define CRT_CTRL_HW_CURSOR_EN		BIT(1)
+#define CRT_CTRL_OSD_EN			BIT(2)
+#define CRT_CTRL_INTERLACED		BIT(3)
+#define CRT_CTRL_COLOR_RGB565		(0 << 7)
+#define CRT_CTRL_COLOR_YUV444		(1 << 7)
+#define CRT_CTRL_COLOR_XRGB8888		(2 << 7)
+#define CRT_CTRL_COLOR_RGB888		(3 << 7)
+#define CRT_CTRL_COLOR_YUV444_2RGB	(5 << 7)
+#define CRT_CTRL_COLOR_YUV422		(7 << 7)
+#define CRT_CTRL_COLOR_MASK		GENMASK(9, 7)
+#define CRT_CTRL_HSYNC_NEGATIVE		BIT(16)
+#define CRT_CTRL_VSYNC_NEGATIVE		BIT(17)
+#define CRT_CTRL_VERTICAL_INTR_EN	BIT(30)
+#define CRT_CTRL_VERTICAL_INTR_STS	BIT(31)
+
+/* CTRL2 */
+#define CRT_CTRL_DAC_EN			BIT(0)
+#define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
+#define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
+
+/* CRT_HORIZ0 */
+#define CRT_H_TOTAL(x)			(x)
+#define CRT_H_DE(x)			((x) << 16)
+
+/* CRT_HORIZ1 */
+#define CRT_H_RS_START(x)		(x)
+#define CRT_H_RS_END(x)			((x) << 16)
+
+/* CRT_VIRT0 */
+#define CRT_V_TOTAL(x)			(x)
+#define CRT_V_DE(x)			((x) << 16)
+
+/* CRT_VIRT1 */
+#define CRT_V_RS_START(x)		(x)
+#define CRT_V_RS_END(x)			((x) << 16)
+
+/* CRT_OFFSET */
+#define CRT_DISP_OFFSET(x)		(x)
+#define CRT_TERM_COUNT(x)		((x) << 16)
+
+/* CRT_THROD */
+#define CRT_THROD_LOW(x)		(x)
+#define CRT_THROD_HIGH(x)		((x) << 8)
+
+/* Default Threshold Seting */
+#define G5_CRT_THROD_VAL	(CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3C))
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
new file mode 100644
index 000000000000..2d5c96334a36
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corporation
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_panel.h>
+
+#include "aspeed_gfx.h"
+
+static struct aspeed_gfx *
+drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
+{
+	return container_of(pipe, struct aspeed_gfx, pipe);
+}
+
+static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
+{
+	struct drm_crtc *crtc = &priv->pipe.crtc;
+	struct drm_device *drm = crtc->dev;
+	const u32 format = crtc->primary->state->fb->format->format;
+	u32 ctrl1;
+
+	ctrl1 = readl(priv->base + CRT_CTRL1);
+	ctrl1 &= ~CRT_CTRL_COLOR_MASK;
+
+	switch (format) {
+	case DRM_FORMAT_RGB565:
+		dev_dbg(drm->dev, "Setting up RGB565 mode\n");
+		ctrl1 |= CRT_CTRL_COLOR_RGB565;
+		*bpp = 16;
+		break;
+	case DRM_FORMAT_XRGB8888:
+		dev_dbg(drm->dev, "Setting up XRGB8888 mode\n");
+		ctrl1 |= CRT_CTRL_COLOR_XRGB8888;
+		*bpp = 32;
+		break;
+	default:
+		dev_err(drm->dev, "Unhandled pixel format %08x\n", format);
+		return -EINVAL;
+	}
+
+	writel(ctrl1, priv->base + CRT_CTRL1);
+
+	return 0;
+}
+
+static void aspeed_gfx_enable_controller(struct aspeed_gfx *priv)
+{
+	u32 ctrl1 = readl(priv->base + CRT_CTRL1);
+	u32 ctrl2 = readl(priv->base + CRT_CTRL2);
+
+	/* SCU2C: set DAC source for display output to Graphics CRT (GFX) */
+	regmap_update_bits(priv->scu, 0x2c, BIT(16), BIT(16));
+
+	writel(ctrl1 | CRT_CTRL_EN, priv->base + CRT_CTRL1);
+	writel(ctrl2 | CRT_CTRL_DAC_EN, priv->base + CRT_CTRL2);
+}
+
+static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
+{
+	u32 ctrl1 = readl(priv->base + CRT_CTRL1);
+	u32 ctrl2 = readl(priv->base + CRT_CTRL2);
+
+	writel(ctrl1 & ~CRT_CTRL_EN, priv->base + CRT_CTRL1);
+	writel(ctrl2 & ~CRT_CTRL_DAC_EN, priv->base + CRT_CTRL2);
+
+	regmap_update_bits(priv->scu, 0x2c, BIT(16), 0);
+}
+
+static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
+{
+	struct drm_display_mode *m = &priv->pipe.crtc.state->adjusted_mode;
+	u32 ctrl1, d_offset, t_count, bpp;
+	int err;
+
+	err = aspeed_gfx_set_pixel_fmt(priv, &bpp);
+	if (err)
+		return;
+
+#if 0
+	/* TODO: we have only been able to test with the 40MHz USB clock. The
+	 * clock is fixed, so we cannot adjust it here. */
+	clk_set_rate(priv->pixel_clk, m->crtc_clock * 1000);
+#endif
+
+	ctrl1 = readl(priv->base + CRT_CTRL1);
+	ctrl1 &= ~(CRT_CTRL_INTERLACED |
+			CRT_CTRL_HSYNC_NEGATIVE |
+			CRT_CTRL_VSYNC_NEGATIVE);
+
+	if (m->flags & DRM_MODE_FLAG_INTERLACE)
+		ctrl1 |= CRT_CTRL_INTERLACED;
+
+	if (!(m->flags & DRM_MODE_FLAG_PHSYNC))
+		ctrl1 |= CRT_CTRL_HSYNC_NEGATIVE;
+
+	if (!(m->flags & DRM_MODE_FLAG_PVSYNC))
+		ctrl1 |= CRT_CTRL_VSYNC_NEGATIVE;
+
+	writel(ctrl1, priv->base + CRT_CTRL1);
+
+	/* Horizontal timing */
+	writel(CRT_H_TOTAL(m->htotal - 1) | CRT_H_DE(m->hdisplay - 1),
+			priv->base + CRT_HORIZ0);
+	writel(CRT_H_RS_START(m->hsync_start - 1) | CRT_H_RS_END(m->hsync_end),
+			priv->base + CRT_HORIZ1);
+
+
+	/* Vertical timing */
+	writel(CRT_V_TOTAL(m->vtotal - 1) | CRT_V_DE(m->vdisplay - 1),
+			priv->base + CRT_VERT0);
+	writel(CRT_V_RS_START(m->vsync_start) | CRT_V_RS_END(m->vsync_end),
+			priv->base + CRT_VERT1);
+
+	/*
+	 * Display Offset: address difference between consecutive scan lines
+	 * Terminal Count: memory size of one scan line
+	 */
+	d_offset = m->hdisplay * bpp / 8;
+	t_count = (m->hdisplay * bpp + 127) / 128;
+	writel(CRT_DISP_OFFSET(d_offset) | CRT_TERM_COUNT(t_count),
+			priv->base + CRT_OFFSET);
+
+	/*
+	 * Threshold: FIFO thresholds of refill and stop (16 byte chunks
+	 * per line, rounded up)
+	 */
+	writel(G5_CRT_THROD_VAL, priv->base + CRT_THROD);
+}
+
+static void aspeed_gfx_pipe_enable(struct drm_simple_display_pipe *pipe,
+			      struct drm_crtc_state *crtc_state,
+			      struct drm_plane_state *plane_state)
+{
+	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	struct drm_crtc *crtc = &pipe->crtc;
+
+	aspeed_gfx_crtc_mode_set_nofb(priv);
+	aspeed_gfx_enable_controller(priv);
+	drm_crtc_vblank_on(crtc);
+}
+
+static void aspeed_gfx_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	struct drm_crtc *crtc = &pipe->crtc;
+
+	drm_crtc_vblank_off(crtc);
+	aspeed_gfx_disable_controller(priv);
+}
+
+static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
+				   struct drm_plane_state *plane_state)
+{
+	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_framebuffer *fb = pipe->plane.state->fb;
+	struct drm_pending_vblank_event *event;
+	struct drm_gem_cma_object *gem;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	event = crtc->state->event;
+	if (event) {
+		crtc->state->event = NULL;
+
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
+	if (!fb)
+		return;
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	if (!gem)
+		return;
+	writel(gem->paddr, priv->base + CRT_ADDR);
+}
+
+static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pipe)
+{
+	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	u32 reg = readl(priv->base + CRT_CTRL1);
+
+	/* Clear pending VBLANK IRQ */
+	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
+
+	reg |= CRT_CTRL_VERTICAL_INTR_EN;
+	writel(reg, priv->base + CRT_CTRL1);
+
+	return 0;
+}
+
+static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
+{
+	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	u32 reg = readl(priv->base + CRT_CTRL1);
+
+	reg &= ~CRT_CTRL_VERTICAL_INTR_EN;
+	writel(reg, priv->base + CRT_CTRL1);
+
+	/* Clear pending VBLANK IRQ */
+	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
+}
+
+static struct drm_simple_display_pipe_funcs aspeed_gfx_funcs = {
+	.enable		= aspeed_gfx_pipe_enable,
+	.disable	= aspeed_gfx_pipe_disable,
+	.update		= aspeed_gfx_pipe_update,
+	.prepare_fb	= drm_gem_fb_simple_display_pipe_prepare_fb,
+	.enable_vblank	= aspeed_gfx_enable_vblank,
+	.disable_vblank	= aspeed_gfx_disable_vblank,
+};
+
+static const uint32_t aspeed_gfx_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB565,
+};
+
+int aspeed_gfx_create_pipe(struct drm_device *drm)
+{
+	struct aspeed_gfx *priv = drm->dev_private;
+
+	return drm_simple_display_pipe_init(drm, &priv->pipe, &aspeed_gfx_funcs,
+					    aspeed_gfx_formats,
+					    ARRAY_SIZE(aspeed_gfx_formats),
+					    NULL,
+					    &priv->connector);
+}
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
new file mode 100644
index 000000000000..d1f4c0d62f38
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corporation
+
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
+#include "aspeed_gfx.h"
+
+/**
+ * DOC: ASPEED GFX Driver
+ *
+ * This driver is for the ASPEED BMC SoC's 'GFX' display hardware, also called
+ * the 'SOC Display Controller' in the datasheet. This driver runs on the ARM
+ * based BMC systems, unlike the ast driver which runs on a host CPU and is for
+ * a PCIe graphics device.
+ *
+ * The AST2500 supports a total of 3 output paths:
+ *
+ *   1. VGA output, the output target can choose either or both to the DAC
+ *   or DVO interface.
+ *
+ *   2. Graphics CRT output, the output target can choose either or both to
+ *   the DAC or DVO interface.
+ *
+ *   3. Video input from DVO, the video input can be used for video engine
+ *   capture or DAC display output.
+ *
+ * Output options are selected in SCU2C.
+ *
+ * The "VGA mode" device is the PCI attached controller. The "Graphics CRT"
+ * is the ARM's internal display controller.
+ *
+ * The driver only supports a simple configuration consisting of a 40MHz
+ * pixel clock, fixed by hardware limitations, and the VGA output path.
+ *
+ * The driver was written with the 'AST2500 Software Programming Guide' v17,
+ * which is available under NDA from ASPEED.
+ */
+
+static const struct drm_mode_config_funcs aspeed_gfx_mode_config_funcs = {
+	.fb_create		= drm_gem_fb_create,
+	.atomic_check		= drm_atomic_helper_check,
+	.atomic_commit		= drm_atomic_helper_commit,
+};
+
+static void aspeed_gfx_setup_mode_config(struct drm_device *drm)
+{
+	drm_mode_config_init(drm);
+
+	drm->mode_config.min_width = 0;
+	drm->mode_config.min_height = 0;
+	drm->mode_config.max_width = 800;
+	drm->mode_config.max_height = 600;
+	drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
+}
+
+static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
+{
+	struct drm_device *drm = data;
+	struct aspeed_gfx *priv = drm->dev_private;
+	u32 reg;
+
+	reg = readl(priv->base + CRT_CTRL1);
+
+	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
+		drm_crtc_handle_vblank(&priv->pipe.crtc);
+		writel(reg, priv->base + CRT_CTRL1);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+
+
+static int aspeed_gfx_load(struct drm_device *drm)
+{
+	struct platform_device *pdev = to_platform_device(drm->dev);
+	struct aspeed_gfx *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	drm->dev_private = priv;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(drm->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
+	if (IS_ERR(priv->scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(priv->scu);
+	}
+
+	ret = of_reserved_mem_device_init(drm->dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to initialize reserved mem: %d\n", ret);
+		return ret;
+	}
+
+	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set DMA mask: %d\n", ret);
+		return ret;
+	}
+
+	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rst)) {
+		dev_err(&pdev->dev,
+			"missing or invalid reset controller device tree entry");
+		return PTR_ERR(priv->rst);
+	}
+	reset_control_deassert(priv->rst);
+
+	priv->clk = devm_clk_get(drm->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev,
+			"missing or invalid clk device tree entry");
+		return PTR_ERR(priv->clk);
+	}
+	clk_prepare_enable(priv->clk);
+
+	/* Sanitize control registers */
+	writel(0, priv->base + CRT_CTRL1);
+	writel(0, priv->base + CRT_CTRL2);
+
+	aspeed_gfx_setup_mode_config(drm);
+
+	ret = drm_vblank_init(drm, 1);
+	if (ret < 0) {
+		dev_err(drm->dev, "Failed to initialise vblank\n");
+		return ret;
+	}
+
+	ret = aspeed_gfx_create_output(drm);
+	if (ret < 0) {
+		dev_err(drm->dev, "Failed to create outputs\n");
+		return ret;
+	}
+
+	ret = aspeed_gfx_create_pipe(drm);
+	if (ret < 0) {
+		dev_err(drm->dev, "Cannot setup simple display pipe\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(drm->dev, platform_get_irq(pdev, 0),
+			       aspeed_gfx_irq_handler, 0, "aspeed gfx", drm);
+	if (ret < 0) {
+		dev_err(drm->dev, "Failed to install IRQ handler\n");
+		return ret;
+	}
+
+	drm_mode_config_reset(drm);
+
+	drm_fbdev_generic_setup(drm, 32);
+
+	return 0;
+}
+
+static void aspeed_gfx_unload(struct drm_device *drm)
+{
+	drm_kms_helper_poll_fini(drm);
+	drm_mode_config_cleanup(drm);
+
+	drm->dev_private = NULL;
+}
+
+DEFINE_DRM_GEM_CMA_FOPS(fops);
+
+static struct drm_driver aspeed_gfx_driver = {
+	.driver_features        = DRIVER_GEM | DRIVER_MODESET |
+				DRIVER_PRIME | DRIVER_ATOMIC |
+				DRIVER_HAVE_IRQ,
+	.gem_create_object	= drm_cma_gem_create_object_default_funcs,
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_mmap		= drm_gem_prime_mmap,
+	.fops = &fops,
+	.name = "aspeed-gfx-drm",
+	.desc = "ASPEED GFX DRM",
+	.date = "20180319",
+	.major = 1,
+	.minor = 0,
+};
+
+static const struct of_device_id aspeed_gfx_match[] = {
+	{ .compatible = "aspeed,ast2500-gfx" },
+	{ }
+};
+
+static int aspeed_gfx_probe(struct platform_device *pdev)
+{
+	struct drm_device *drm;
+	int ret;
+
+	drm = drm_dev_alloc(&aspeed_gfx_driver, &pdev->dev);
+	if (IS_ERR(drm))
+		return PTR_ERR(drm);
+
+	ret = aspeed_gfx_load(drm);
+	if (ret)
+		goto err_free;
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		goto err_unload;
+
+	return 0;
+
+err_unload:
+	aspeed_gfx_unload(drm);
+err_free:
+	drm_dev_put(drm);
+
+	return ret;
+}
+
+static int aspeed_gfx_remove(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	drm_dev_unregister(drm);
+	aspeed_gfx_unload(drm);
+	drm_dev_put(drm);
+
+	return 0;
+}
+
+static struct platform_driver aspeed_gfx_platform_driver = {
+	.probe		= aspeed_gfx_probe,
+	.remove		= aspeed_gfx_remove,
+	.driver = {
+		.name = "aspeed_gfx",
+		.of_match_table = aspeed_gfx_match,
+	},
+};
+
+module_platform_driver(aspeed_gfx_platform_driver);
+
+MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_DESCRIPTION("ASPEED BMC DRM/KMS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
new file mode 100644
index 000000000000..67ee5fa10055
--- /dev/null
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corporation
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
+
+#include "aspeed_gfx.h"
+
+static int aspeed_gfx_get_modes(struct drm_connector *connector)
+{
+	return drm_add_modes_noedid(connector, 800, 600);
+}
+
+static const struct
+drm_connector_helper_funcs aspeed_gfx_connector_helper_funcs = {
+	.get_modes = aspeed_gfx_get_modes,
+};
+
+static const struct drm_connector_funcs aspeed_gfx_connector_funcs = {
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= drm_connector_cleanup,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+int aspeed_gfx_create_output(struct drm_device *drm)
+{
+	struct aspeed_gfx *priv = drm->dev_private;
+	int ret;
+
+	priv->connector.dpms = DRM_MODE_DPMS_OFF;
+	priv->connector.polled = 0;
+	drm_connector_helper_add(&priv->connector,
+				 &aspeed_gfx_connector_helper_funcs);
+	ret = drm_connector_init(drm, &priv->connector,
+				 &aspeed_gfx_connector_funcs,
+				 DRM_MODE_CONNECTOR_Unknown);
+	return ret;
+}
-- 
2.20.1


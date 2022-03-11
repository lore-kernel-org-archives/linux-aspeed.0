From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Fri, 11 Mar 2022 15:07:19 +0100
Subject: [PATCH v2 06/38] media: platform: place Aspeed driver on a separate
 dir
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
Message-ID: <97fe1a5a4183c04ac8bed0cee7583fcda96a3dd6.1647006877.git.mchehab@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In order to cleanup the main platform media directory, move Aspeed
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab at kernel.org/

 MAINTAINERS                                        |  2 +-
 drivers/media/platform/Kconfig                     | 10 +---------
 drivers/media/platform/Makefile                    |  2 +-
 drivers/media/platform/aspeed/Kconfig              | 10 ++++++++++
 drivers/media/platform/aspeed/Makefile             |  1 +
 drivers/media/platform/{ => aspeed}/aspeed-video.c |  0
 6 files changed, 14 insertions(+), 11 deletions(-)
 create mode 100644 drivers/media/platform/aspeed/Kconfig
 create mode 100644 drivers/media/platform/aspeed/Makefile
 rename drivers/media/platform/{ => aspeed}/aspeed-video.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a9fb0615925..1b6f48a660de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3026,7 +3026,7 @@ L:	linux-media at vger.kernel.org
 L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
-F:	drivers/media/platform/aspeed-video.c
+F:	drivers/media/platform/aspeed/
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 1cb73f09d0b5..ad95a25ae2fc 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -57,15 +57,7 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
 
-config VIDEO_ASPEED
-	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2
-	select VIDEOBUF2_DMA_CONTIG
-	help
-	  Support for the Aspeed Video Engine (VE) embedded in the Aspeed
-	  AST2400 and AST2500 SOCs. The VE can capture and compress video data
-	  from digital or analog sources.
+source "drivers/media/platform/aspeed/Kconfig"
 
 config VIDEO_SH_VOU
 	tristate "SuperH VOU video output driver"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index c7ee7dafe6b3..1a52a1a784b5 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -5,6 +5,7 @@
 
 # Place here, alphabetically sorted, all directories
 obj-y += allegro-dvt/
+obj-y += aspeed/
 obj-y += am437x/
 obj-y += amphion/
 obj-y += atmel/
@@ -44,7 +45,6 @@ obj-y += vsp1/
 obj-y += xilinx/
 
 # Please place here only ancillary drivers that aren't SoC-specific
-obj-$(CONFIG_VIDEO_ASPEED)		+= aspeed-video.o
 obj-$(CONFIG_VIDEO_IMX_PXP)		+= imx-pxp.o
 obj-$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
 obj-$(CONFIG_VIDEO_MUX)			+= video-mux.o
diff --git a/drivers/media/platform/aspeed/Kconfig b/drivers/media/platform/aspeed/Kconfig
new file mode 100644
index 000000000000..5025e892844c
--- /dev/null
+++ b/drivers/media/platform/aspeed/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_ASPEED
+	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	  Support for the Aspeed Video Engine (VE) embedded in the Aspeed
+	  AST2400 and AST2500 SOCs. The VE can capture and compress video data
+	  from digital or analog sources.
diff --git a/drivers/media/platform/aspeed/Makefile b/drivers/media/platform/aspeed/Makefile
new file mode 100644
index 000000000000..4ee15b3ddd90
--- /dev/null
+++ b/drivers/media/platform/aspeed/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_VIDEO_ASPEED)		+= aspeed-video.o
diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
similarity index 100%
rename from drivers/media/platform/aspeed-video.c
rename to drivers/media/platform/aspeed/aspeed-video.c
-- 
2.35.1


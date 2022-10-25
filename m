From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 25 Oct 2022 17:02:01 +0800
Subject: [PATCH v10 3/5] media: Documentation: aspeed-video: Add user documentation for the aspeed-video driver
In-Reply-To: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
References: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
Message-ID: <20221025090203.5623-4-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add user documentation for the aspeed-video driver.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v10:
  - new
---
 .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
 .../userspace-api/media/drivers/index.rst     |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst

diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
new file mode 100644
index 000000000000..798a2588b175
--- /dev/null
+++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+ASPEED video driver
+===================
+
+ASPEED Video Engine found on AST2400/2500/2600 SoC supports high performance
+video compressions with a wide range of video quality and compression ratio
+options. The adopted compressing algorithm is a modified JPEG algorithm.
+
+There are 2 types of compressions in this IP.
+
+* JPEG JFIF standard mode: for single frame and management compression
+* ASPEED proprietary mode: for multi-frame and differential compression.
+  Support 2-pass (high quality) video compression scheme (Patent pending by
+  ASPEED). Provide visually lossless video compression quality or to reduce
+  the network average loading under intranet KVM applications.
+
+More details on the ASPEED video hardware operations can be found in
+*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
+AspeedTech-BMC/openbmc/releases.
+
+The ASPEED video driver implements the following driver-specific control:
+
+``V4L2_CID_ASPEED_HQ_MODE``
+-------------------------------
+    Enable/Disable ASPEED's High quality mode. This is a private control
+    that can be used to enable high quality for aspeed proprietary mode.
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 4
+
+    * - ``(0)``
+      - ASPEED HQ mode is disabled.
+    * - ``(1)``
+      - ASPEED HQ mode is enabled.
+
+``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
+-------------------------------
+    Define the quality of ASPEED's High quality mode. This is a private control
+    that can be used to decide compression quality if High quality mode enabled
+    . Higher the value, better the quality and bigger the size.
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 4
+
+    * - ``(1)``
+      - minimum
+    * - ``(12)``
+      - maximum
+    * - ``(1)``
+      - step
+    * - ``(1)``
+      - default
+
+**Copyright** |copy| 2022 ASPEED Technology Inc.
diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 32f82aed47d9..46a494e00b72 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	:maxdepth: 5
 	:numbered:
 
+	aspeed-video
 	ccs
 	cx2341x-uapi
 	dw100
-- 
2.25.1


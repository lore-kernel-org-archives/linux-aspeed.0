From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  5 May 2020 11:58:24 -0500
Subject: [PATCH v11 7/8] ARM: dts: Aspeed: Witherspoon: Enable XDMA engine
In-Reply-To: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
References: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1588697905-23444-8-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a reserved memory node for the VGA memory. Add the XDMA engine node,
enable it, and point it's memory region to the VGA memory.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index a0f99e3..85d58a6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -27,6 +27,12 @@
 			reg = <0x98000000 0x04000000>; /* 64M */
 		};
 
+		vga_memory: region at 9f000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
 		gfx_memory: framebuffer {
 			size = <0x01000000>;
 			alignment = <0x01000000>;
@@ -690,4 +696,9 @@
 	memory-region = <&video_engine_memory>;
 };
 
+&xdma {
+	status = "okay";
+	memory-region = <&vga_memory>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
1.8.3.1


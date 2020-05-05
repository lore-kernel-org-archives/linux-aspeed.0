From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  5 May 2020 11:58:25 -0500
Subject: [PATCH v11 8/8] ARM: dts: Aspeed: Tacoma: Enable XDMA engine
In-Reply-To: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
References: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1588697905-23444-9-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a reserved memory node for the VGA memory. Add the XDMA engine node,
enable it, and point it's memory region to the VGA memory.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 47293a5..d336dd4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -29,6 +29,12 @@
 			no-map;
 			reg = <0xb8000000 0x4000000>; /* 64M */
 		};
+
+		vga_memory: region at bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;	/* 16M */
+		};
 	};
 
 	gpio-keys {
@@ -804,3 +810,8 @@
 	pinctrl-0 = <&pinctrl_lpc_default>,
 		    <&pinctrl_lsirq_default>;
 };
+
+&xdma {
+	status = "okay";
+	memory-region = <&vga_memory>;
+};
-- 
1.8.3.1


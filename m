From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  5 Dec 2019 11:15:11 -0600
Subject: [PATCH v2 11/12] ARM: dts: aspeed: rainier: Enable XDMA engine
In-Reply-To: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1575566112-11658-12-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index c1c9cd3..7c1a155 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -970,3 +970,8 @@
 		spi-max-frequency = <100000000>;
 	};
 };
+
+&xdma {
+	status = "okay";
+	vga-mem = <0xbf800000 0x00800000>;
+};
-- 
1.8.3.1


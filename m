From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  5 Dec 2019 11:15:10 -0600
Subject: [PATCH v2 10/12] ARM: dts: aspeed: witherspoon: Enable XDMA Engine
In-Reply-To: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1575566112-11658-11-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 569dad9..2676a28 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -658,4 +658,9 @@
 	memory-region = <&video_engine_memory>;
 };
 
+&xdma {
+	status = "okay";
+	vga-mem = <0x9f000000 0x01000000>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
1.8.3.1


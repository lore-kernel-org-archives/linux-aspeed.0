From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Fri, 31 May 2019 15:31:40 -0500
Subject: [PATCH dev-5.1] ARM: dts: aspeed: swift: Add VDD (IR35219) devices
Message-ID: <1559334700-51970-1-git-send-email-anoo@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Adriana Kobylak <anoo@us.ibm.com>

Add the VDD (IR35219) devices to the Swift device tree.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 270c923..8590e6b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -723,6 +723,11 @@
 		reg = <0x4c>;
 	};
 
+	ir35219 at 70 {
+		compatible = "infineon,ir35219";
+		reg = <0x70>;
+	};
+
 	ir35221 at 71 {
 		compatible = "infineon,ir35221";
 		reg = <0x71>;
@@ -820,6 +825,11 @@
 		reg = <0x4c>;
 	};
 
+	ir35219 at 70 {
+		compatible = "infineon,ir35219";
+		reg = <0x70>;
+	};
+
 	ir35221 at 71 {
 		compatible = "infineon,ir35221";
 		reg = <0x71>;
-- 
1.8.3.1


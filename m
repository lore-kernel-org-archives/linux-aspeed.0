From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 18 Nov 2022 13:51:09 +0700
Subject: [PATCH] ARM: dts: aspeed: mtjade: Add SMPro nodes
Message-ID: <20221118065109.2339066-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add SMPro nodes to Mt. Jade BMC.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 353359822d7b..0a51d2e32fab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -354,6 +354,14 @@ &i2c1 {
 
 &i2c2 {
 	status = "okay";
+	smpro at 4f {
+		compatible = "ampere,smpro";
+		reg = <0x4f>;
+	};
+	smpro at 4e {
+		compatible = "ampere,smpro";
+		reg = <0x4e>;
+	};
 };
 
 &i2c3 {
-- 
2.35.1


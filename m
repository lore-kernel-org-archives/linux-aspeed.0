From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue,  1 Oct 2024 14:17:49 -0500
Subject: [PATCH v1 2/3] ARM: dts: aspeed: system1: Enable serial gpio0
In-Reply-To: <20241001191756.234096-1-ninad@linux.ibm.com>
References: <20241001191756.234096-1-ninad@linux.ibm.com>
Message-ID: <20241001191756.234096-3-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable serial GPIO0. Set number of GPIO lines to 128 and bus frequency
to 1MHz.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 1cbf257fb0a0b..c0219167a337a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -398,6 +398,12 @@ &emmc {
 	clk-phase-mmc-hs200 = <180>, <180>;
 };
 
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <1000000>;
+};
+
 &ibt {
 	status = "okay";
 };
-- 
2.43.0


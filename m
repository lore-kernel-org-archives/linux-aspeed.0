From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 14:26:55 +0930
Subject: [PATCH] ARM: dts: aspeed: swift: Add eMMC device
Message-ID: <20190821045655.21752-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Swift contains an eMMC device attached to the second SDHCI controller.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index f14f745b34ca..25bc0e1bbced 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -963,4 +963,15 @@
 	status = "okay";
 };
 
+&sdmmc {
+       status = "okay";
+};
+
+&sdhci1 {
+       status = "okay";
+
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_sd2_default>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
2.23.0.rc1


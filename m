From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 14:19:45 -0700
Subject: [PATCH 2/5] ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Message-ID: <20200824211948.12852-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set 32MB FMC flash layout in CMM device tree explicitly because the flash
layout settings were removed from "ast2500-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
index 7bc7df7ed428..2fb8b147f489 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -1571,3 +1571,20 @@
 &sdhci1 {
 	status = "disabled";
 };
+
+&fmc_flash0 {
+#include "facebook-bmc-flash-layout.dtsi"
+};
+
+&fmc_flash1 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		flash1 at 0 {
+			reg = <0x0 0x2000000>;
+			label = "flash1";
+		};
+	};
+};
-- 
2.17.1


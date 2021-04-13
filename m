From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 14:43:05 -0500
Subject: [PATCH 1/4] ARM: dts: aspeed: Rainier: Fix PCA9552 on bus 8
In-Reply-To: <20210413194308.36930-1-eajames@linux.ibm.com>
References: <20210413194308.36930-1-eajames@linux.ibm.com>
Message-ID: <20210413194308.36930-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The second presence detection PCA9552 was incorrectly added to bus 9.

Fixes: 8be44de6f209 ("ARM: dts: aspeed: Rainier: Add presence GPIOs")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 109 ++-----------------
 1 file changed, 10 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 4dbb030f3ebb..49419cd7f853 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -1399,7 +1399,7 @@ eeprom at 51 {
 		reg = <0x51>;
 	};
 
-	pca1: pca9552 at 61 {
+	pca_pres2: pca9552 at 61 {
 		compatible = "nxp,pca9552";
 		reg = <0x61>;
 		#address-cells = <1>;
@@ -1407,6 +1407,15 @@ pca1: pca9552 at 61 {
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		gpio-line-names =
+			"SLOT6_PRSNT_EN_RSVD", "SLOT7_PRSNT_EN_RSVD",
+			"SLOT8_PRSNT_EN_RSVD", "SLOT9_PRSNT_EN_RSVD",
+			"SLOT10_PRSNT_EN_RSVD", "SLOT11_PRSNT_EN_RSVD",
+			"SLOT6_EXPANDER_PRSNT_N", "SLOT7_EXPANDER_PRSNT_N",
+			"SLOT8_EXPANDER_PRSNT_N", "SLOT9_EXPANDER_PRSNT_N",
+			"SLOT10_EXPANDER_PRSNT_N", "SLOT11_EXPANDER_PRSNT_N",
+			"", "", "", "";
+
 		gpio at 0 {
 			reg = <0>;
 			type = <PCA955X_TYPE_GPIO>;
@@ -1507,104 +1516,6 @@ eeprom at 50 {
 		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
-
-	pca_pres3: pca9552 at 61 {
-		compatible = "nxp,pca9552";
-		reg = <0x61>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		gpio-line-names =
-			"SLOT6_PRSNT_EN_RSVD", "SLOT7_PRSNT_EN_RSVD",
-			"SLOT8_PRSNT_EN_RSVD", "SLOT9_PRSNT_EN_RSVD",
-			"SLOT10_PRSNT_EN_RSVD", "SLOT11_PRSNT_EN_RSVD",
-			"SLOT6_EXPANDER_PRSNT_N", "SLOT7_EXPANDER_PRSNT_N",
-			"SLOT8_EXPANDER_PRSNT_N", "SLOT9_EXPANDER_PRSNT_N",
-			"SLOT10_EXPANDER_PRSNT_N", "SLOT11_EXPANDER_PRSNT_N",
-			"", "", "", "";
-
-		gpio at 0 {
-			reg = <0>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 1 {
-			reg = <1>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 2 {
-			reg = <2>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 3 {
-			reg = <3>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 4 {
-			reg = <4>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 5 {
-			reg = <5>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 6 {
-			reg = <6>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 7 {
-			reg = <7>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 8 {
-			reg = <8>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 9 {
-			reg = <9>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 10 {
-			reg = <10>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 11 {
-			reg = <11>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 12 {
-			reg = <12>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 13 {
-			reg = <13>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 14 {
-			reg = <14>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-
-		gpio at 15 {
-			reg = <15>;
-			type = <PCA955X_TYPE_GPIO>;
-		};
-	};
 };
 
 &i2c10 {
-- 
2.27.0


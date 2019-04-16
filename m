From: Patrick Venture <venture@google.com>
Date: Tue, 16 Apr 2019 09:21:50 -0700
Subject: [PATCH 2/3] ARM: dts: aspeed: zaius: update 12V brick I2C address
In-Reply-To: <20190416162150.150154-1-venture@google.com>
References: <20190416162150.150154-1-venture@google.com>
Message-ID: <20190416162150.150154-3-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Robert Lippert <rlippert@google.com>

The I2C address of the brick is different depending on the board SKU.

Update the values to instantiate addresses which work for most boards.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 63e892f16d050..51265af622574 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -328,10 +328,21 @@
 	 *   LM5066I PMBUS @10h
 	 */
 
-	/* 12V Quarter Brick DC/DC Converter Q54SJ12050 @61h */
-	power-brick at 61 {
+	/*
+	 * Brick will be one of these types/addresses.  Depending
+	 * on the board SKU only one is actually present and will successfully
+	 * instantiate while the others will fail the probe operation.
+	 * These are the PVT (and presumably beyond) addresses:
+	 *    12V Quarter Brick DC/DC Converter Q54SJ12050 @6Ah
+	 *    12V Quarter Brick DC/DC Converter Q54SH12050 @30h
+	 */
+	power-brick at 6a {
+		compatible = "delta,dps800";
+		reg = <0x6a>;
+	};
+	power-brick at 30 {
 		compatible = "delta,dps800";
-		reg = <0x61>;
+		reg = <0x30>;
 	};
 
 	/* CPU0 VR ISL68137 0.7V, 0.96V PMBUS @64h */
@@ -342,7 +353,6 @@
 	/* Master selector PCA9541A @70h (other master: CPU0)
 	 *   LM5066I PMBUS @10h
 	 */
-	/* 12V SMPS Q54SH12050NNDH @61h */
 };
 
 &i2c8 {
-- 
2.21.0.392.gf8f6787159e-goog


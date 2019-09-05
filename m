From: Joel Stanley <joel@jms.id.au>
Date: Wed,  4 Sep 2019 17:02:20 -0700
Subject: [PATCH] ARM: dts: aspeed-g4: Add all flash chips
Message-ID: <20190905000221.31445-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The FMC supports five chip selects, so describe the five possible flash
chips.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index e465cda40fe7..dffb595d30e4 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -67,6 +67,26 @@
 				compatible = "jedec,spi-nor";
 				status = "disabled";
 			};
+			flash at 1 {
+				reg = < 1 >;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+			flash at 2 {
+				reg = < 2 >;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+			flash at 3 {
+				reg = < 3 >;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+			flash at 4 {
+				reg = < 4 >;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
 		};
 
 		spi: spi at 1e630000 {
-- 
2.23.0.rc1


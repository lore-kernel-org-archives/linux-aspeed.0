From: Potin Lai <potin.lai@quantatw.com>
Date: Mon, 14 Feb 2022 12:25:38 +0800
Subject: [PATCH v2 10/10] arch: arm: dts: bletchley: cleanup redundant nodes
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Message-ID: <20220214042538.12132-11-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

cleanup following nodes

1. Remove redundant i2c1 node.
2. Disable in-chip rtc, use battery-backed external rtc (pcf85263)
   instead.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 946107bd8bc7..52201c6a69bc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -205,10 +205,6 @@
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 	flash at 0 {
@@ -387,10 +383,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	ina230 at 45 {
@@ -680,6 +672,7 @@
 	};
 
 	rtc at 51 {
+		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.17.1


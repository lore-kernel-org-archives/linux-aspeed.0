From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 16 Feb 2022 00:31:51 +0800
Subject: [PATCH v3 10/10] ARM: dts: aspeed: bletchley: cleanup redundant nodes
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Message-ID: <20220215163151.32252-11-potin.lai@quantatw.com>
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
index 494654338542..eaf1bc261ee3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -225,10 +225,6 @@
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 	flash at 0 {
@@ -386,10 +382,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	ina230 at 45 {
@@ -679,6 +671,7 @@
 	};
 
 	rtc at 51 {
+		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.17.1


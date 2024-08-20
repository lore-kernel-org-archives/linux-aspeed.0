From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 20 Aug 2024 18:29:02 +0800
Subject: [PATCH v1 1/2] ARM: dts: aspeed: Harma: add rtc device
In-Reply-To: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
References: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
Message-ID: <20240820102904.1756785-2-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add "nxp,pcf8563" device and the slave address is 0x51.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index cf3f807a38fe..92068c65eae4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -135,10 +135,6 @@ &mac3 {
 	use-ncsi;
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 
@@ -506,6 +502,11 @@ imux31: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			rtc at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
 		};
 	};
 };
-- 
2.25.1


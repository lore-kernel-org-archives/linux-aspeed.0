From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:23 +0800
Subject: [PATCH 05/17] ARM: dts: aspeed: minerva: change RTC reference
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-6-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Change the RTC reference from on-chip to externel on i2c bus 9 and address
is 0x51.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 19f609cfd026..32400284479e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -116,10 +116,6 @@ flash at 1 {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -329,6 +325,11 @@ eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
 };
 
 &i2c10 {
-- 
2.34.1


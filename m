From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:54 +0800
Subject: [PATCH 05/11] ARM: dts: aspeed: minerva: Add temperature sensor
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-6-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add one temperature sensor on i2c bus 1

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ee9691647e4a..783d4d5a8f3d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -115,7 +115,12 @@ &i2c1 {
 
 	temperature-sensor at 4b {
 		compatible = "ti,tmp75";
-		reg = <0x4B>;
+		reg = <0x4b>;
+	};
+
+	temperature-sensor at 48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
 	};
 
 	eeprom at 51 {
-- 
2.34.1


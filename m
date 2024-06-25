From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:19 +0800
Subject: [PATCH 01/17] ARM: dts: aspeed: minerva: change the address of tmp75
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-2-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Revise the address of tmp75 on I2C bus 1 from 0x48 to 0x4f due to design
change.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 942e53d5c714..e20e31917d6c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -145,9 +145,9 @@ temperature-sensor at 4b {
 		reg = <0x4b>;
 	};
 
-	temperature-sensor at 48 {
+	temperature-sensor at 4f {
 		compatible = "ti,tmp75";
-		reg = <0x48>;
+		reg = <0x4f>;
 	};
 
 	eeprom at 54 {
-- 
2.34.1


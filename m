From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 13 Jun 2024 23:24:19 +0800
Subject: [PATCH v1 1/7] ARM: dts: aspeed: Harma: revise hsc chip
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Message-ID: <20240613152425.1582059-2-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise HSC chip name and address to match LTC4287.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index e7f4823ca4b3..0d349ce1f3e6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -276,11 +276,10 @@ temperature-sensor at 49 {
 		reg = <0x49>;
 	};
 
-	power-monitor at 22 {
-		compatible = "lltc,ltc4286";
-		reg = <0x22>;
-		adi,vrange-low-enable;
-		shunt-resistor-micro-ohms = <500>;
+	power-monitor at 44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <250>;
 	};
 };
 
-- 
2.25.1


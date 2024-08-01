From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Fri,  2 Aug 2024 00:01:32 +0800
Subject: [PATCH v3 08/11] ARM: dts: aspeed: Harma: add temperature device
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Message-ID: <20240801160136.1281291-9-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add temperature deivce in i2c0 and i2c2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index f55ffe9c4d89..0455475fbcff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -221,6 +221,11 @@ power-sensor at 45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor at 4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c1 {
@@ -271,6 +276,11 @@ power-sensor at 45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor at 4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 27 Feb 2024 09:47:15 +0800
Subject: [PATCH v4 06/10] ARM: dts: aspeed: Harma: Add PDB temperature
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Message-ID: <20240227014719.3037588-7-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add PDB temperature sensor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ca3052cce0e0..5c3fa8bbaced 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -203,7 +203,7 @@ max31790 at 30{
 &i2c1 {
 	status = "okay";
 
-	tmp75 at 4b {
+	temperature-sensor at 4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
@@ -260,6 +260,11 @@ delta_brick at 69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
+
+	temperature-sensor at 49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


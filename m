From: Paul Fertser <fercerpav@gmail.com>
Date: Thu, 15 Apr 2021 17:05:00 +0300
Subject: [PATCH] arm: dts: aspeed: tiogapass: add hotplug controller
Message-ID: <20210415140521.11352-1-fercerpav@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ADM1278 IC is accessible on I2C bus and on both Wiwynn and Quanta
Tioga Pass implementations a pair of parallel 0.5 mOhm resistors is used
for current measurement.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 3cc2004fa2f2..500661956dea 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -591,6 +591,11 @@
 &i2c7 {
 	status = "okay";
 	//HSC, AirMax Conn A
+	adm1278 at 0x45 {
+		compatible = "adm1275";
+		reg = <0x45>;
+		shunt-resistor-micro-ohms = <250>;
+	};
 };
 
 &i2c8 {
-- 
2.17.1


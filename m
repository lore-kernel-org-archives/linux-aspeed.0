From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Wed, 29 Mar 2023 16:32:35 +0800
Subject: [PATCH v1 2/2] ARM: dts: aspeed: greatlakes: add mctp device
In-Reply-To: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <20230329083235.24123-3-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add mctp node on I2C bus

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
index 59819115c39d..2f83693e4f85 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -156,6 +156,7 @@
 
 &i2c8 {
 	status = "okay";
+	mctp-controller;
 	temperature-sensor at 1f {
 		compatible = "ti,tmp421";
 		reg = <0x1f>;
@@ -165,6 +166,10 @@
 		compatible = "st,24c32";
 		reg = <0x50>;
 	};
+	mctp at 10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 };
 
 &i2c9 {
-- 
2.17.1


From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:14 -0500
Subject: [PATCH 16/22] ARM: dts: aspeed: everest: Add power supply i2c devices
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-17-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Brandon Wyman <bjwyman@gmail.com>

Add the i2c/pmbus power supply devices to the everest device tree.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index d7f23b74dd4b..04c96a3fe506 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -228,6 +228,26 @@ eeprom at 54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
+
+	power-supply at 68 {
+		compatible = "ibm,cffps";
+		reg = <0x68>;
+	};
+
+	power-supply at 69 {
+		compatible = "ibm,cffps";
+		reg = <0x69>;
+	};
+
+	power-supply at 6a {
+		compatible = "ibm,cffps";
+		reg = <0x6a>;
+	};
+
+	power-supply at 6b {
+		compatible = "ibm,cffps";
+		reg = <0x6b>;
+	};
 };
 
 &i2c4 {
-- 
2.27.0


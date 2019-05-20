From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Mon, 20 May 2019 15:17:15 -0500
Subject: [PATCH dev-5.1] ARM: dts: aspeed: swift: Add pca9539 devices
Message-ID: <1558383435-38811-1-git-send-email-anoo@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Adriana Kobylak <anoo@us.ibm.com>

Add the pca9539 devices to the Swift device tree.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 146 +++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 9610637..270c923 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -732,6 +732,79 @@
 		compatible = "infineon,ir35221";
 		reg = <0x72>;
 	};
+
+	pca2: pca9539 at 74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+		};
+	};
 };
 
 &i2c10 {
@@ -756,6 +829,79 @@
 		compatible = "infineon,ir35221";
 		reg = <0x72>;
 	};
+
+	pca3: pca9539 at 74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+		};
+	};
 };
 
 &i2c11 {
-- 
1.8.3.1


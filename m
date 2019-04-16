From: Patrick Venture <venture@google.com>
Date: Tue, 16 Apr 2019 09:21:51 -0700
Subject: [PATCH 3/3] ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie
 slots
In-Reply-To: <20190416162150.150154-1-venture@google.com>
References: <20190416162150.150154-1-venture@google.com>
Message-ID: <20190416162150.150154-4-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Robert Lippert <rlippert@google.com>

The change to include ibm-power9-cfam.dtsi resulted in a renumbering
of all of the I2C bus numbers behind the on-board muxes.  This breaks
some tools which have hardcoded the bus numbers.

Add device tree aliases for the I2C buses routed through the PCIe slots
so that they return to their former numbers before the cfam change.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 51265af622574..c12f89e042efc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -7,6 +7,14 @@
 	model = "Zaius BMC";
 	compatible = "ingrasys,zaius-bmc", "aspeed,ast2500";
 
+	aliases {
+		i2c15 = &i2cpcie0;
+		i2c16 = &i2cpcie1;
+		i2c17 = &i2cpcie2;
+		i2c19 = &i2cpcie3;
+		i2c20 = &i2cpcie4;
+	};
+
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200 earlyprintk";
@@ -223,6 +231,27 @@
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		i2cpcie0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2cpcie1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2cpcie2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2ctpm: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 
 	/* MUX1 PCA9546A @71h
@@ -253,6 +282,17 @@
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		i2cpcie3: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2cpcie4: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
 	};
 
 	/* MUX1 PCA9546A @71h
-- 
2.21.0.392.gf8f6787159e-goog


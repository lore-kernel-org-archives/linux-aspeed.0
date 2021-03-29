From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:13 -0500
Subject: [PATCH 15/22] ARM: dts: Aspeed: Everest: Add pca9552 fan presence
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-16-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Matthew Barth <msbarth@us.ibm.com>

Add the pca9552 at address 0x61 on i2c14 behind mux0 channel 3 with the
4 GPIO fan presence inputs.

Signed-off-by: Matthew Barth <msbarth@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 128 +++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index de2606b416e6..d7f23b74dd4b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -171,6 +171,37 @@ vga_memory: region at bf000000 {
 			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
 	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <1000>;
+
+		fan0-presence {
+			label = "fan0-presence";
+			gpios = <&pca0 15 GPIO_ACTIVE_LOW>;
+			linux,code = <15>;
+		};
+
+		fan1-presence {
+			label = "fan1-presence";
+			gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
+			linux,code = <14>;
+		};
+
+		fan2-presence {
+			label = "fan2-presence";
+			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
+			linux,code = <13>;
+		};
+
+		fan3-presence {
+			label = "fan3-presence";
+			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
+			linux,code = <12>;
+		};
+	};
 };
 
 &i2c0 {
@@ -567,6 +598,103 @@ fan at 3 {
 					maxim,fan-fault-pin-mon;
 				};
 			};
+
+			pca0: pca9552 at 61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"","","","",
+					"","","","",
+					"","","","",
+					"presence-fan3",
+					"presence-fan2",
+					"presence-fan1",
+					"presence-fan0";
+
+				gpio at 0 {
+					reg = <0>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 1 {
+					reg = <1>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 8 {
+					reg = <8>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 9 {
+					reg = <9>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 10 {
+					reg = <10>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 11 {
+					reg = <11>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 12 {
+					reg = <12>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 13 {
+					reg = <13>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 14 {
+					reg = <14>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 15 {
+					reg = <15>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 	};
 
-- 
2.27.0


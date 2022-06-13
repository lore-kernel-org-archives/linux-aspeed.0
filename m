From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jun 2022 17:51:49 +0800
Subject: [PATCH 3/4] ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
Message-ID: <20220613095150.21917-4-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Bind presence-sledX pins via gpio-keys driver to monitor and export
GPIO pin values on DBUS using phosphor-gpio-presence service.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index ee33cc3efae4..7b6de9b51547 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -190,6 +190,41 @@
 			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		presence-sled1 {
+			label = "presence-sled1";
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 2)>;
+		};
+		presence-sled2 {
+			label = "presence-sled2";
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 3)>;
+		};
+		presence-sled3 {
+			label = "presence-sled3";
+			gpios = <&gpio0 ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 4)>;
+		};
+		presence-sled4 {
+			label = "presence-sled4";
+			gpios = <&gpio0 ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 5)>;
+		};
+		presence-sled5 {
+			label = "presence-sled5";
+			gpios = <&gpio0 ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 6)>;
+		};
+		presence-sled6 {
+			label = "presence-sled6";
+			gpios = <&gpio0 ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 7)>;
+		};
+	};
 };
 
 &mac2 {
-- 
2.17.1


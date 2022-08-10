From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 10 Aug 2022 00:43:37 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: add USB debug card IPMB node
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
Message-ID: <20220810004338.329832-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an IPMB node for USB debug card (13-0010) to support IPMI comnunication

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 9fdb3d17596b9..54c9f182f6a5c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i2c/i2c.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -946,6 +947,13 @@ &i2c13 {
 	multi-master;
 	aspeed,hw-timeout-ms = <1000>;
 	status = "okay";
+
+	//USB Debug Connector
+	ipmb13 at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &gpio0 {
-- 
2.31.1


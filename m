From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:35 +0800
Subject: [PATCH 17/17] ARM: dts: aspeed: minerva: add ltc4287 device
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-18-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable LTC4287 device on i2c-0.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 288d4ba06b99..896e84cd03de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -165,6 +165,12 @@ power-monitor at 41 {
 		shunt-resistor = <1000>;
 	};
 
+	power-monitor at 44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <2000>;
+	};
+
 	power-monitor at 43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1


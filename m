From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 26 Jun 2024 21:03:27 +0800
Subject: [PATCH v1 12/17] ARM: dts: aspeed: minerva: add power monitor xdp710
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Message-ID: <20240626130332.929534-13-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Add HSC xdp710 on i2c bus0.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 3d80993885b7..0c305ddf7011 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -154,6 +154,11 @@ power-monitor at 68 {
 		reg = <0x68>;
 	};
 
+	power-monitor at 43 {
+		compatible = "infineon,xdp710";
+		reg = <0x43>;
+	};
+
 	leds_gpio: gpio at 19 {
 		compatible = "nxp,pca9555";
 		reg = <0x19>;
-- 
2.34.1


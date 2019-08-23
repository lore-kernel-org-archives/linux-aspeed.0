From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Fri, 23 Aug 2019 12:33:27 +0300
Subject: [PATCH v1 2/3] vesnin: add secondary SPI flash chip
Message-ID: <e67b04b6f322c1abc8153a3d23a18452f74497e5.camel@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adds secondary SPI flash chip into dts for vesnin.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index 2ee26c86a32e..db4cc3df61ce 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -81,6 +81,14 @@
         label = "bmc";
 #include "openbmc-flash-layout.dtsi"
 	};
+
+	flash at 1 {
+		status = "okay";
+		reg = < 1 >;
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		label = "alt";
+	};
 };
 
 &spi {
-- 
2.20.1



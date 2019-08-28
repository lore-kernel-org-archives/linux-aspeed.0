From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Wed, 28 Aug 2019 13:24:00 +0300
Subject: [PATCH v4 2/4] vesnin: add secondary SPI flash chip
In-Reply-To: <20190828102402.13155-1-i.mikhaylov@yadro.com>
References: <20190828102402.13155-1-i.mikhaylov@yadro.com>
Message-ID: <20190828102402.13155-3-i.mikhaylov@yadro.com>
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


From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:38 +0700
Subject: [PATCH v1 1/5] ARM: dts: aspeed: mtjade: Enable secondary flash
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Message-ID: <20220228000242.1884-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the secondary flash of the Ampere's Mt. Jade's BMC.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 4c3c3f1a12ea..934bb54b193a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -362,6 +362,13 @@ flash at 0 {
 		/* spi-max-frequency = <50000000>; */
 #include "openbmc-flash-layout-64.dtsi"
 	};
+
+	flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+#include "openbmc-flash-layout-64-alt.dtsi"
+	};
 };
 
 &spi1 {
-- 
2.28.0


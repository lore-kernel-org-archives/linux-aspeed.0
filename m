From: Lei YU <yulei.sh@bytedance.com>
Date: Fri, 10 Dec 2021 17:36:23 +0800
Subject: [PATCH] ARM: dts: aspeed: g220a: Enable secondary flash
Message-ID: <20211210093623.2140640-1-yulei.sh@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the secondary flash of the g220a's BMC and the wdt2.

Signed-off-by: Lei YU <yulei.sh@bytedance.com>
---
 arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
index 01dace8f5e5f..05f392f42960 100644
--- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
@@ -260,6 +260,13 @@ flash at 0 {
 		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
+	flash at 1 {
+		status = "okay";
+		label = "alt-bmc";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64-alt.dtsi"
+	};
 };
 
 &spi1 {
@@ -278,6 +285,10 @@ &adc {
 	status = "okay";
 };
 
+&wdt2 {
+	aspeed,alt-boot;
+};
+
 &gpio {
 	status = "okay";
 	gpio-line-names =
-- 
2.25.1


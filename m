From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Wed, 11 Jan 2023 14:39:34 +0300
Subject: [PATCH] ARM: dts: ethanolx: Add BIOS flash chip
Message-ID: <20230111113934.1176-1-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a BIOS flash chip to the DTS to open a possibility to reflash the
main CPU BIOS from the BMC.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 8d84dcc06221..5f9093c58e8c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -63,6 +63,17 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <100000000>;
+	};
+};
 
 &mac0 {
 	status = "okay";
-- 
2.25.1


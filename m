From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Fri, 19 May 2023 15:51:58 +0700
Subject: [PATCH v2 1/3] ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
In-Reply-To: <20230519085200.22020-1-chanh@os.amperecomputing.com>
References: <20230519085200.22020-1-chanh@os.amperecomputing.com>
Message-ID: <20230519085200.22020-2-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The BMC UART8 and UART9 were connected to the Secpro and Mpro console
of socket S1 on the Mt.Mitchell system.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - None
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index 1e0e88465254..e79f56208b89 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -9,6 +9,10 @@
 / {
 	model = "Ampere Mt.Mitchell BMC";
 	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
+	aliases {
+		serial7 = &uart8;
+		serial8 = &uart9;
+	};
 
 	chosen {
 		stdout-path = &uart5;
@@ -307,6 +311,14 @@
 	status = "okay";
 };
 
+&uart8 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.17.1


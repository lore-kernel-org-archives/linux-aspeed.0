From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 27 Jun 2024 15:00:11 +0800
Subject: [PATCH v2 09/10] ARM: dts: aspeed: Harma: enable mctp controller
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Message-ID: <20240627070013.2509150-10-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the mctp controller in i2c9.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0455475fbcff..0dd0566bbf27 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -382,6 +382,14 @@ &i2c8 {
 &i2c9 {
 	status = "okay";
 
+	mctp-controller;
+	multi-master;
+
+	mctp at 10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	gpio at 30 {
 		compatible = "nxp,pca9555";
 		reg = <0x30>;
-- 
2.25.1


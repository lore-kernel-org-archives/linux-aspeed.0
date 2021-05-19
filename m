From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Wed, 19 May 2021 16:04:28 +0800
Subject: [PATCH 2/3] ARM: dts: aspeed: Add node for AST2600 I2C
In-Reply-To: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
References: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
Message-ID: <20210519080436.18975-3-jamin_lin@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add node to get the global register of i2c for AST2600.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..998d55a16c5c 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -674,6 +674,14 @@
 #include "aspeed-g6-pinctrl.dtsi"
 
 &i2c {
+
+	i2c_gr: i2c-global-regs at 0 {
+		compatible = "aspeed,ast2600-i2c-global", "syscon";
+		reg = <0x0 0x20>;
+		clocks = <&syscon ASPEED_CLK_APB2>;
+		resets = <&syscon ASPEED_RESET_I2C>;
+	};
+
 	i2c0: i2c-bus at 80 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1


From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 29 Aug 2020 11:40:21 +0200
Subject: [PATCH 3/6] ARM: dts: am335x: lxm: Fix PCA9539 GPIO expander
 properties
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Message-ID: <20200829094024.31842-3-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PCA9539 GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/am335x-lxm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index cd55f11260ea..0f078465297a 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -160,11 +160,15 @@
 	serial_config1: serial_config1 at 20 {
 		compatible = "nxp,pca9539";
 		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	serial_config2: serial_config2 at 21 {
 		compatible = "nxp,pca9539";
 		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	tps: tps at 2d {
-- 
2.17.1


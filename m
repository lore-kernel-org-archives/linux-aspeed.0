From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 29 Aug 2020 11:40:24 +0200
Subject: [PATCH 6/6] ARM: dts: vf: Fix PCA95xx GPIO expander properties on ZII
 CFU1
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Message-ID: <20200829094024.31842-6-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PCA95xx GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 64e0e9509226..e76a7ebd5dc9 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -226,6 +226,7 @@
 		compatible = "nxp,pca9554";
 		reg = <0x22>;
 		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	lm75 at 48 {
-- 
2.17.1


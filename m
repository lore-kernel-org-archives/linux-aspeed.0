From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 29 Aug 2020 11:40:23 +0200
Subject: [PATCH 5/6] ARM: dts: dove: Fix PCA95xx GPIO expander properties on
 A510
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Message-ID: <20200829094024.31842-5-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PCA95xx GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/dove-sbc-a510.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts b/arch/arm/boot/dts/dove-sbc-a510.dts
index 2bb85a9b7614..df021f9b0117 100644
--- a/arch/arm/boot/dts/dove-sbc-a510.dts
+++ b/arch/arm/boot/dts/dove-sbc-a510.dts
@@ -143,6 +143,7 @@
 	gpio_ext: gpio at 20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;
+		gpio-controller;
 		#gpio-cells = <2>;
 	};
 };
-- 
2.17.1


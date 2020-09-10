From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:31 +0200
Subject: [PATCH v2 13/15] ARM: dts: dove: fix PCA95xx GPIO expander properties
 on A510
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-14-krzk@kernel.org>
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


From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 29 Aug 2020 11:40:22 +0200
Subject: [PATCH 4/6] ARM: dts: aspeed: Fix PCA95xx GPIO expander properties on
 Portwell
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Message-ID: <20200829094024.31842-4-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PCA95xx GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
index 4a1ca8f5b6a7..03c161493ffc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
@@ -121,6 +121,8 @@
 	pca9555 at 27 {
 		compatible = "nxp,pca9555";
 		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 };
 
-- 
2.17.1


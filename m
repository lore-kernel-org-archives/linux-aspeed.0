From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:24 +0200
Subject: [PATCH v2 06/15] arm64: dts: ti: align GPIO hog names with dtschema
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-7-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx requires GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 648267284582..456e7818b521 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -407,7 +407,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		p09 {
+		p09-hog {
 			/* P11 - MCASP/TRACE_MUX_S0 */
 			gpio-hog;
 			gpios = <9 GPIO_ACTIVE_HIGH>;
@@ -415,7 +415,7 @@
 			line-name = "MCASP/TRACE_MUX_S0";
 		};
 
-		p10 {
+		p10-hog {
 			/* P12 - MCASP/TRACE_MUX_S1 */
 			gpio-hog;
 			gpios = <10 GPIO_ACTIVE_HIGH>;
-- 
2.17.1


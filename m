From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:44 +0930
Subject: [PATCH 02/17] ARM: dts: aspeed-g5: Use recommended generic node name
 for SDMC
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <20190726053959.2003-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
node to the appropriate generic node name.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7723afc7c249..6e5b0c493f16 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -199,7 +199,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			edac: sdram at 1e6e0000 {
+			edac: memory-controller at 1e6e0000 {
 				compatible = "aspeed,ast2500-sdram-edac";
 				reg = <0x1e6e0000 0x174>;
 				interrupts = <0>;
-- 
2.20.1


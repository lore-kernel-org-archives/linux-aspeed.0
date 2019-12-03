From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  3 Dec 2019 22:34:05 +1030
Subject: [PATCH 04/14] ARM: dts: aspeed-g5: Use recommended generic node name
 for SDMC
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
Message-ID: <f6963e3de99508b1053e7d96e4dbb05cb4bef3be.1575369656.git-series.andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
node to the appropriate generic node name.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index edad1fd78925..d8d358e23d78 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -206,7 +206,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			edac: sdram at 1e6e0000 {
+			edac: memory-controller at 1e6e0000 {
 				compatible = "aspeed,ast2500-sdram-edac";
 				reg = <0x1e6e0000 0x174>;
 				interrupts = <0>;
-- 
git-series 0.9.1

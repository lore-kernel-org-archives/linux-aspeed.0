From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  3 Dec 2019 22:34:14 +1030
Subject: [PATCH 13/14] ARM: dts: aspeed-g6: Cleanup watchdog unit address
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
Message-ID: <eaf3a37fefaa6f05ef7e4b6bb2c41be84c27316f.1575369656.git-series.andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

arch/arm/boot/dts/aspeed-g6.dtsi:204.28-208.6: Warning (simple_bus_reg): /ahb/apb/watchdog at 1e7850C0: simple-bus unit address format error, expected "1e7850c0"

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 5f6142d99eeb..ffe0d76c5ac0 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -385,7 +385,7 @@
 				status = "disabled";
 			};
 
-			wdt4: watchdog at 1e7850C0 {
+			wdt4: watchdog at 1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e7850C0 0x40>;
 				status = "disabled";
-- 
git-series 0.9.1

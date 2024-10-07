From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Mon, 7 Oct 2024 14:34:06 +0800
Subject: [PATCH 2/4] ARM: dts: aspeed: Add WDT controller into alias field
In-Reply-To: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
References: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20241007063408.2360874-3-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add WDT controller into alias field. After that, WDT index,
used to distinguish different WDT controllers in the driver,
can be gotten by using of_alias_get_id dts API.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 78c967812492..d8b4136d0ca0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -29,6 +29,8 @@ aliases {
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 57a699a7c149..4dd220bca617 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -30,6 +30,9 @@ aliases {
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
+		watchdog2 = &wdt3;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..c0a47c795fff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
+		watchdog2 = &wdt3;
+		watchdog3 = &wdt4;
 	};
 
 
-- 
2.34.1


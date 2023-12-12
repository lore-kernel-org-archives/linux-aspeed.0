From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:50 +0800
Subject: [PATCH 01/11] ARM: dts: aspeed: minerva: Revise the name of DTS
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-2-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The project Minerva which is the platform used by Meta has two boards: the
Chassis Management Module (Minerva) and the Motherboard (Harma), so change
the DTS name to minerva here for CMM use.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                               | 2 +-
 ...facebook-minerva-cmc.dts => aspeed-bmc-facebook-minerva.dts} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/aspeed/{aspeed-bmc-facebook-minerva-cmc.dts => aspeed-bmc-facebook-minerva.dts} (99%)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e316d0..b1da302dbcd6 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -19,7 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
-	aspeed-bmc-facebook-minerva-cmc.dtb \
+	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
similarity index 99%
rename from arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
rename to arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f04ef9063520..c755fb3258a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -7,7 +7,7 @@
 #include <dt-bindings/i2c/i2c.h>
 
 / {
-	model = "Facebook Minerva CMC";
+	model = "Facebook Minerva CMM";
 	compatible = "facebook,minerva-cmc", "aspeed,ast2600";
 
 	aliases {
-- 
2.34.1


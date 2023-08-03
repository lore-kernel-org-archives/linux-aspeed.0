From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  3 Aug 2023 16:03:24 -0700
Subject: [PATCH 3/3] ARM: dts: aspeed: wedge400: Set eMMC max frequency
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
Message-ID: <20230803230324.731268-4-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set eMMC max frequency to 25MHz to prevent intermittent eMMC access
failures.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 5c55afed946f..d17b977fee9b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -367,6 +367,7 @@ &uhci {
 };
 
 &sdhci1 {
+	max-frequency = <25000000>;
 	/*
 	 * DMA mode needs to be disabled to avoid conflicts with UHCI
 	 * Controller in AST2500 SoC.
-- 
2.40.1


From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 25 Jun 2021 15:40:17 +0930
Subject: [PATCH] ARM: dts: tacoma: Add phase corrections for eMMC
Message-ID: <20210625061017.1149942-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The degree values were reversed out from the magic tap values of 7 (in)
and 15 + inversion (out) initially suggested by Aspeed.

With the patch tacoma survives several gigabytes of reads and writes
using dd while without it locks up randomly during the boot process.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index c1478d2db602..670080bb80eb 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -189,6 +189,7 @@ &emmc_controller {
 
 &emmc {
 	status = "okay";
+	clk-phase-mmc-hs200 = <36>, <270>;
 };
 
 &fsim0 {
-- 
2.30.2


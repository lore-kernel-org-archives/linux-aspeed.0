From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 28 Jun 2021 11:06:05 +0930
Subject: [PATCH] ARM: dts: everest: Add phase corrections for eMMC
Message-ID: <20210628013605.1257346-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The values were determined experimentally via boot tests, not by
measuring the bus behaviour with a scope. We plan to do scope
measurements to confirm or refine the values and will update the
devicetree if necessary once these have been obtained.

However, with the patch we can write and read data without issue, where
as booting the system without the patch failed at the point of mounting
the rootfs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 3295c8c7c05c..3274a1f9047f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -1070,6 +1070,7 @@ &pinctrl_emmc_default {
 
 &emmc {
 	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
 };
 
 &fsim0 {
-- 
2.30.2


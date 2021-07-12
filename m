From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 13 Jul 2021 09:06:42 +0930
Subject: [PATCH v2] ARM: dts: everest: Add phase corrections for eMMC
Message-ID: <20210712233642.3119722-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The values were determined via scope measurements.

With the patch we can write and read data without issue where as booting
the system without the patch failed at the point of mounting the rootfs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index d26a9e16ff7c..5f141c3d9c3f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -2832,6 +2832,7 @@ &pinctrl_emmc_default {
 
 &emmc {
 	status = "okay";
+	clk-phase-mmc-hs200 = <210>, <228>;
 };
 
 &fsim0 {
-- 
2.30.2


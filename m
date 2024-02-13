From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 19:35:16 -0000
Subject: [PATCH 1/6] arm64: dts: freescale: Disable interrupt_map check
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <20240213-arm-dt-cleanups-v1-1-f2dee1292525@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several Freescale Layerscape platforms extirq binding use a malformed
interrupt-map property missing parent address cells. These are
documented in of_irq_imap_abusers list in drivers/of/irq.c. In order to
enable dtc interrupt_map check tree wide, we need to disable it for
these platforms which will not be fixed (as that would break
compatibility).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2e027675d7bb..2cb0212b63c6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -20,23 +20,41 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-tqmls1046a-mbls10xxa.dtb
+DTC_FLAGS_fsl-ls1088a-qds := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
+DTC_FLAGS_fsl-ls1088a-rdb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
+DTC_FLAGS_fsl-ls1088a-ten64 := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
+DTC_FLAGS_fsl-ls1088a-tqmls1088a-mbls10xxa := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-tqmls1088a-mbls10xxa.dtb
+DTC_FLAGS_fsl-ls2080a-qds := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
+DTC_FLAGS_fsl-ls2080a-rdb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
+DTC_FLAGS_fsl-ls2081a-rdb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
+DTC_FLAGS_fsl-ls2080a-simu := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
+DTC_FLAGS_fsl-ls2088a-qds := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
+DTC_FLAGS_fsl-ls2088a-rdb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
+DTC_FLAGS_fsl-lx2160a-bluebox3 := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-bluebox3.dtb
+DTC_FLAGS_fsl-lx2160a-bluebox3-rev-a := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-bluebox3-rev-a.dtb
+DTC_FLAGS_fsl-lx2160a-clearfog-cx := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-clearfog-cx.dtb
+DTC_FLAGS_fsl-lx2160a-honeycomb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
+DTC_FLAGS_fsl-lx2160a-qds := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
+DTC_FLAGS_fsl-lx2160a-rdb := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
+DTC_FLAGS_fsl-lx2162a-clearfog := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
+DTC_FLAGS_fsl-lx2162a-qds := -Wno-interrupt_map
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 fsl-ls1028a-qds-13bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-13bb.dtbo
@@ -53,6 +71,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-85bb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 
+DTC_FLAGS_fsl-lx2160a-tqmlx2160a-mblx2160a := -Wno-interrupt_map
 fsl-lx2160a-tqmlx2160a-mblx2160a-12-11-x-dtbs := fsl-lx2160a-tqmlx2160a-mblx2160a.dtb \
 	fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtbo \
 	fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtbo

-- 
2.43.0


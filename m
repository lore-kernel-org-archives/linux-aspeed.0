From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:29 +1030
Subject: [PATCH v2 4/6] ARM: dts: rainier,
 tacoma: Comment reserved memory regions
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
Message-ID: <20201022014731.2035438-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are some nuances to their address and size, so lets try document
that a bit better to reveal the hole between the reserved memory for the
LPC FW cycle bridge and the reserved memory for the VGA device.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 136ff156a512..802027a3c43c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -47,11 +47,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		/* LPC FW cycle bridge region requires natural alignment */
 		flash_memory: region at B8000000 {
 			no-map;
 			reg = <0xB8000000 0x04000000>; /* 64M */
 		};
 
+		/* 48MB region from the end of flash to start of vga memory */
+
+		/* VGA region is dictated by hardware strapping */
 		vga_memory: region at bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 52f5876c08cf..09b561429579 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -26,11 +26,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		/* LPC FW cycle bridge region requires natural alignment */
 		flash_memory: region at b8000000 {
 			no-map;
 			reg = <0xb8000000 0x04000000>; /* 64M */
 		};
 
+		/* 48MB region from the end of flash to start of vga memory */
+
+		/* VGA region is dictated by hardware strapping */
 		vga_memory: region at bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-- 
2.25.1


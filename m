From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:28 +1030
Subject: [PATCH v2 3/6] ARM: dts: rainier,tacoma: Fix size comment whitespace
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
Message-ID: <20201022014731.2035438-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rainier had multiple spaces, Tacoma used a tab. Let's go with a single
space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 21ae880c7530..136ff156a512 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -55,7 +55,7 @@ flash_memory: region at B8000000 {
 		vga_memory: region at bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-			reg = <0xbf000000 0x01000000>;  /* 16M */
+			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 67ab57ad4d8d..52f5876c08cf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -34,7 +34,7 @@ flash_memory: region at b8000000 {
 		vga_memory: region at bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-			reg = <0xbf000000 0x01000000>;	/* 16M */
+			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
 	};
 
-- 
2.25.1


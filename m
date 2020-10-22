From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:26 +1030
Subject: [PATCH v2 1/6] ARM: dts: tacoma: Fix node vs reg mismatch for flash
 memory
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
Message-ID: <20201022014731.2035438-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The mismatch lead to a miscalculation of regions in another patch, and
shouldn't be mismatched anyway, so make them consistent.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 4d070d6ba09f..e86c22ce6d12 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -26,7 +26,7 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		flash_memory: region at ba000000 {
+		flash_memory: region at b8000000 {
 			no-map;
 			reg = <0xb8000000 0x4000000>; /* 64M */
 		};
-- 
2.25.1


From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Oct 2020 12:17:27 +1030
Subject: [PATCH v2 2/6] ARM: dts: tacoma: Zero-pad flash memory region length
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
Message-ID: <20201022014731.2035438-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Makes it easier to understand the magnitude at a glance.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index e86c22ce6d12..67ab57ad4d8d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -28,7 +28,7 @@ reserved-memory {
 
 		flash_memory: region at b8000000 {
 			no-map;
-			reg = <0xb8000000 0x4000000>; /* 64M */
+			reg = <0xb8000000 0x04000000>; /* 64M */
 		};
 
 		vga_memory: region at bf000000 {
-- 
2.25.1


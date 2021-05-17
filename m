From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 17 May 2021 11:00:36 +0700
Subject: [PATCH 3/3] ARM: dts: aspeed: mtjade: switch to 64MB flash layout
In-Reply-To: <20210517040036.13667-1-quan@os.amperecomputing.com>
References: <20210517040036.13667-1-quan@os.amperecomputing.com>
Message-ID: <20210517040036.13667-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As the 32MB flash layout will soon be exhausted, switch to 64MB layout.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 364293e6ca76..0879f3917178 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -304,7 +304,7 @@ flash at 0 {
 		m25p,fast-read;
 		label = "bmc";
 		/* spi-max-frequency = <50000000>; */
-#include "openbmc-flash-layout.dtsi"
+#include "openbmc-flash-layout-64.dtsi"
 	};
 };
 
-- 
2.28.0


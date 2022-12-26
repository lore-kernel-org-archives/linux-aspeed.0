From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 26 Dec 2022 13:45:34 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: rename flash1 label
In-Reply-To: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
Message-ID: <20221226054535.2836110-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In OpenBMC, phosphor-software-manager use "alt-bmc" for secondary falsh
label.
Rename flash1 label to "alt-bmc" to support dual image feature inOpenBMC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index a619eec70633..791f83aaac50 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -307,7 +307,7 @@ flash at 0 {
 	flash at 1 {
 		status = "okay";
 		m25p,fast-read;
-		label = "flash1";
+		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.31.1


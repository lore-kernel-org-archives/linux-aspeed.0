From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 10 Aug 2022 00:43:38 +0000
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: remove hdc1080 node
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
Message-ID: <20220810004338.329832-3-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Because of incompatible 2nd source si7021, removing hdc1080 node from
devicetree, and move node probe to user-space layer.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 54c9f182f6a5c..1f72017c1e2d9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -882,11 +882,6 @@ tmp421 at 4f {
 		reg = <0x4f>;
 	};
 
-	hdc1080 at 40 {
-		compatible = "ti,hdc1080";
-		reg = <0x40>;
-	};
-
 	front_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
-- 
2.31.1


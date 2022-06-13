From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jun 2022 17:51:47 +0800
Subject: [PATCH 1/4] ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
Message-ID: <20220613095150.21917-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

change LED sys_log_id to active low base on DVT schematic.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 41d2b1535d9a..d34bfa50620e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -59,7 +59,7 @@
 		compatible = "gpio-leds";
 		sys_log_id {
 			default-state = "off";
-			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
+			gpios = <&front_leds 0 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.17.1


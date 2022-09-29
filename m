From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 29 Sep 2022 09:31:29 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: update and fix gpio-line-names
In-Reply-To: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
References: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
Message-ID: <20220929013130.1916525-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update new GPIOM7 line name, and fixed typo of GPION6 line name

New GPIO:
- GPIOM7: USB_DEBUG_PWR_BTN_N

Fixed GPIO:
- GPION6: LED_POSTCODE_5 --> LED_POSTCODE_6

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 1f72017c1e2d9..f5986f5909cd0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -984,11 +984,11 @@ &gpio0 {
 	/*M0-M7*/	"ALERT_SLED1_N","ALERT_SLED2_N",
 			"ALERT_SLED3_N","ALERT_SLED4_N",
 			"ALERT_SLED5_N","ALERT_SLED6_N",
-			"","",
+			"","USB_DEBUG_PWR_BTN_N",
 	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
 			"LED_POSTCODE_2","LED_POSTCODE_3",
 			"LED_POSTCODE_4","LED_POSTCODE_5",
-			"LED_POSTCODE_5","LED_POSTCODE_7",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
 	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
-- 
2.31.1


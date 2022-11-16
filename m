From: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Date: Wed, 16 Nov 2022 16:44:35 +0530
Subject: [PATCH v1] ARM: dts: aspeed: Yosemite V2: Add GPIO line names
Message-ID: <20221116111435.GA27359@hcl-ThinkPad-T495>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Name the GPIOs to help userspace work with them. The names describe
the functionality the lines provide, it makes easier to share
userspace code across different system.

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>

---
--- v1 - Initial draft
---
---
 .../dts/aspeed-bmc-facebook-yosemitev2.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..f84e2eeb9fd1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -119,6 +119,47 @@
 			&pinctrl_adc15_default>;
 };
 
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"POWER_BUTTON","POWER_OUT1","","POWER_OUT2","","POWER_OUT3","",
+			"POWER_OUT4",
+	/*E0-E7*/	"DEBUG_UART_SEL0","DEBUG_UART_SEL1","DEBUG_UART_SEL2",
+			"DEBUG_UART_RX_SEL_N","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"LED_POST_CODE_0","LED_POST_CODE_1","LED_POST_CODE_2",
+			"LED_POST_CODE_3","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"SLOT1_POWER_OK","SLOT2_POWER_OK","SLOT3_POWER_OK","SLOT4_POWER_OK",
+			"","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","I2C_SLOT1","I2C_SLOT2","I2C_SLOT3","I2C_SLOT4","","",
+	/*O0-O7*/	"","","","SELECTOR_BUTTON","SLOT1_POWER","SLOT2_POWER","SLOT3_POWER",
+			"SLOT4_POWER",
+	/*P0-P7*/	"","","","","LED_POST_CODE_4","LED_POST_CODE_5","LED_POST_CODE_6",
+			"LED_POST_CODE_7",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","GPIO_DBG_CARD_PRSNT","","","","",
+	/*S0-S7*/	"RESET_OUT1","RESET_OUT2","RESET_OUT3","RESET_OUT4","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"POST_COMPLETE","POST_COMPLETE2","POST_COMPLETE3","POST_COMPLETE4",
+			"","","","",
+	/*AA0-AA7*/	"","","","","HAND_SW1","HAND_SW2","HAND_SW3","HAND_SW4",
+	/*AB0-AB7*/	"RESET_BUTTON","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
 &i2c1 {
 	//Host1 IPMB bus
 	status = "okay";
-- 
2.17.1


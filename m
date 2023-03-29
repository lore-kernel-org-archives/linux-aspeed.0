From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Wed, 29 Mar 2023 16:32:34 +0800
Subject: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
In-Reply-To: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Add GPIO names for SOC lines.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
index 8c05bd56ce1e..59819115c39d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -238,4 +238,53 @@
 &gpio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/ "","","","","","","","",
+	/*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
+		  "power-bmc-slot1","power-bmc-slot2",
+		  "power-bmc-slot3","power-bmc-slot4","","",
+	/*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
+		  "reset-cause-nic-secondary","","","",
+	/*D0-D7*/ "","","","","","","","",
+	/*E0-E7*/ "","","","","","","","",
+	/*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
+		  "slot3-bmc-reset-button","slot4-bmc-reset-button",
+		  "","","","presence-emmc",
+	/*G0-G7*/ "","","","","","","","",
+	/*H0-H7*/ "","","","",
+		  "presence-mb-slot1","presence-mb-slot2",
+		  "presence-mb-slot3","presence-mb-slot4",
+	/*I0-I7*/ "","","","","","","bb-bmc-button","",
+	/*J0-J7*/ "","","","","","","","",
+	/*K0-K7*/ "","","","","","","","",
+	/*L0-L7*/ "","","","","","","","",
+	/*M0-M7*/ "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub","","",
+	/*N0-N7*/ "","","","","bmc-ready","","","",
+	/*O0-O7*/ "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
+	/*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
+		  "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
+		  "reset-cause-pcie-slot3","reset-cause-pcie-slot4","","",
+	/*Q0-Q7*/ "","","","","","","","",
+	/*R0-R7*/ "","","","","","","","",
+	/*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
+	/*T0-T7*/ "","","","","","","","",
+	/*U0-U7*/ "","","","","","","","GND",
+	/*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
+		  "bmc-slot3-ac-button","bmc-slot4-ac-button",
+		  "","","","",
+	/*W0-W7*/ "","","","","","","","",
+	/*X0-X7*/ "","","","","","","","",
+	/*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
+	/*Z0-Z7*/ "","","","","","","","";
+};
+
+&gpio1 {
+	status = "okay";
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","","","","","";
 };
-- 
2.17.1


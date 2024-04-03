From: Renze Nicolai <renze@rnplus.nl>
Date: Wed,  3 Apr 2024 15:28:51 +0200
Subject: [PATCH v2 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U BMC
In-Reply-To: <20240403133037.37782-1-renze@rnplus.nl>
References: <20240403133037.37782-1-renze@rnplus.nl>
Message-ID: <20240403133037.37782-2-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Restructure GPIO table to fit maximum line length.

Fix mistakes found while working on OpenBMC
userland configuration and based on probing
the board.

Schematic for this board is not available.
Because of this the choice was made to
use a descriptive method for naming the
GPIOs.

 - Push-pull outputs start with output-*
 - Open-drain outputs start with control-*
 - LED outputs start with led-*
 - Inputs start with input-*
 - Button inputs start with button-*
 - Active low signals end with *-n

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 95 ++++++++-----------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 3c975bc41ae7..dff69d6ff146 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -79,64 +79,43 @@ iio-hwmon {
 &gpio {
 	status = "okay";
 	gpio-line-names =
-	/*A0-A3*/       "status-locatorled-n",                    "",                      "button-nmi-n",          "",
-	/*A4-A7*/       "",                                       "",                      "",                      "",
-	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                      "",
-	/*B4-B7*/       "",                                       "",                      "",                      "",
-	/*C0-C3*/       "",                                       "",                      "",                      "",
-	/*C4-C7*/       "",                                       "",                      "control-locatorbutton", "",
-	/*D0-D3*/       "button-power",                           "control-power",         "button-reset",          "control-reset",
-	/*D4-D7*/       "",                                       "",                      "",                      "",
-	/*E0-E3*/       "",                                       "",                      "",                      "",
-	/*E4-E7*/       "",                                       "",                      "",                      "",
-	/*F0-F3*/       "",                                       "",                      "",                      "",
-	/*F4-F7*/       "",                                       "",                      "",                      "",
-	/*G0-G3*/       "output-rtc-battery-voltage-read-enable", "input-id0",             "input-id1",             "input-id2",
-	/*G4-G7*/       "input-alert1-n",                         "input-alert2-n",        "input-alert3-n",        "",
-	/*H0-H3*/       "",                                       "",                      "",                      "",
-	/*H4-H7*/       "input-mfg",                              "",                      "led-heartbeat-n",       "input-caseopen",
-	/*I0-I3*/       "",                                       "",                      "",                      "",
-	/*I4-I7*/       "",                                       "",                      "",                      "",
-	/*J0-J3*/       "output-bmc-ready",                       "",                      "",                      "",
-	/*J4-J7*/       "",                                       "",                      "",                      "",
-	/*K0-K3*/       "",                                       "",                      "",                      "",
-	/*K4-K7*/       "",                                       "",                      "",                      "",
-	/*L0-L3*/       "",                                       "",                      "",                      "",
-	/*L4-L7*/       "",                                       "",                      "",                      "",
-	/*M0-M3*/       "",                                       "",                      "",                      "",
-	/*M4-M7*/       "",                                       "",                      "",                      "",
-	/*N0-N3*/       "",                                       "",                      "",                      "",
-	/*N4-N7*/       "",                                       "",                      "",                      "",
-	/*O0-O3*/       "",                                       "",                      "",                      "",
-	/*O4-O7*/       "",                                       "",                      "",                      "",
-	/*P0-P3*/       "",                                       "",                      "",                      "",
-	/*P4-P7*/       "",                                       "",                      "",                      "",
-	/*Q0-Q3*/       "",                                       "",                      "",                      "",
-	/*Q4-Q7*/       "",                                       "",                      "",                      "",
-	/*R0-R3*/       "",                                       "",                      "",                      "",
-	/*R4-R7*/       "",                                       "",                      "",                      "",
-	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                      "",
-	/*S4-S7*/       "",                                       "",                      "",                      "",
-	/*T0-T3*/       "",                                       "",                      "",                      "",
-	/*T4-T7*/       "",                                       "",                      "",                      "",
-	/*U0-U3*/       "",                                       "",                      "",                      "",
-	/*U4-U7*/       "",                                       "",                      "",                      "",
-	/*V0-V3*/       "",                                       "",                      "",                      "",
-	/*V4-V7*/       "",                                       "",                      "",                      "",
-	/*W0-W3*/       "",                                       "",                      "",                      "",
-	/*W4-W7*/       "",                                       "",                      "",                      "",
-	/*X0-X3*/       "",                                       "",                      "",                      "",
-	/*X4-X7*/       "",                                       "",                      "",                      "",
-	/*Y0-Y3*/       "",                                       "",                      "",                      "",
-	/*Y4-Y7*/       "",                                       "",                      "",                      "",
-	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",           "output-bmc-throttle-n",
-	/*Z4-Z7*/       "",                                       "",                      "",                      "",
-	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",  "",
-	/*AA4-AC7*/     "",                                       "",                      "",                      "",
-	/*AB0-AB3*/     "",                                       "",                      "",                      "",
-	/*AB4-AC7*/     "",                                       "",                      "",                      "",
-	/*AC0-AC3*/     "",                                       "",                      "",                      "",
-	/*AC4-AC7*/     "",                                       "",                      "",                      "";
+	/*  A */ "input-locatorled-n", "", "", "", "", "", "", "",
+	/*  B */ "input-bios-post-cmplt-n", "", "", "", "", "", "", "",
+	/*  C */ "", "", "", "", "", "", "control-locatorbutton-n", "",
+	/*  D */ "button-power-n", "control-power-n", "button-reset-n",
+		 "control-reset-n", "", "", "", "",
+	/*  E */ "", "", "", "", "", "", "", "",
+	/*  F */ "", "", "", "", "", "", "", "",
+	/*  G */ "output-hwm-vbat-enable", "input-id0-n", "input-id1-n",
+		 "input-id2-n", "input-aux-smb-alert-n", "",
+		 "input-psu-smb-alert-n", "",
+	/*  H */ "", "", "", "", "input-mfg-mode-n", "",
+		 "led-heartbeat-n", "input-case-open-n",
+	/*  I */ "", "", "", "", "", "", "", "",
+	/*  J */ "output-bmc-ready-n", "", "", "", "", "", "", "",
+	/*  K */ "", "", "", "", "", "", "", "",
+	/*  L */ "", "", "", "", "", "", "", "",
+	/*  M */ "", "", "", "", "", "", "", "",
+	/*  N */ "", "", "", "", "", "", "", "",
+	/*  O */ "", "", "", "", "", "", "", "",
+	/*  P */ "", "", "", "", "", "", "", "",
+	/*  Q */ "", "", "", "", "input-bmc-smb-present-n", "", "",
+		 "input-pcie-wake-n",
+	/*  R */ "", "", "", "", "", "", "", "",
+	/*  S */ "input-bmc-pchhot-n", "", "", "", "", "", "", "",
+	/*  T */ "", "", "", "", "", "", "", "",
+	/*  U */ "", "", "", "", "", "", "", "",
+	/*  V */ "", "", "", "", "", "", "", "",
+	/*  W */ "", "", "", "", "", "", "", "",
+	/*  X */ "", "", "", "", "", "", "", "",
+	/*  Y */ "input-sleep-s3-n", "input-sleep-s5-n", "", "", "", "",
+		 "", "",
+	/*  Z */ "", "", "led-fault-n", "output-bmc-throttle-n", "", "",
+		 "", "",
+	/* AA */ "input-cpu1-thermtrip-latch-n", "",
+		 "input-cpu1-prochot-n", "", "", "", "", "",
+	/* AB */ "", "input-power-good", "", "", "", "", "", "",
+	/* AC */ "", "", "", "", "", "", "", "";
 };
 
 &fmc {
-- 
2.44.0


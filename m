From: Andrew Geissler <geissonator@gmail.com>
Date: Fri,  6 Mar 2020 11:02:17 -0600
Subject: [PATCH 1/2] ARM: dts: aspeed: romulus: Add gpio line names
Message-ID: <20200306170218.79698-1-geissonator@yahoo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Name the GPIOs to help userspace work with them. The names describe the
functionality the lines provide, not the net or ball name. This makes it
easier to share userspace code across different systems and makes the
use of the lines more obvious.

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 35 ++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index edfa44fe1f75..fd2e014dae75 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -231,23 +231,52 @@
 };
 
 &gpio {
+	gpio-line-names =
+	/*A0-A7*/	"","cfam-reset","","","","","fsi-mux","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"fsi-enable","","","nic_func_mode0","nic_func_mode1","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","power-button","","","","",
+	/*J0-J7*/	"","","checkstop","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","led-fault","",
+				"led-identify","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","id-button",
+	/*R0-R7*/	"","","fsi-trans","","","led-power","","",
+	/*S0-S7*/	"","","","","","","","seq_cont",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"fsi-clock","","fsi-data","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+
 	nic_func_mode0 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
 		output-low;
-		line-name = "nic_func_mode0";
 	};
 	nic_func_mode1 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
 		output-low;
-		line-name = "nic_func_mode1";
 	};
 	seq_cont {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
 		output-low;
-		line-name = "seq_cont";
 	};
 };
 
-- 
2.21.0 (Apple Git-122)


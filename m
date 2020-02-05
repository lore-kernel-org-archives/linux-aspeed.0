From: Andrew Geissler <geissonator@gmail.com>
Date: Wed, 05 Feb 2020 21:55:44 -0000
Subject: [PATCH linux dev-5.4 v2] ARM: dts: aspeed: witherspoon: Add gpio line
 names
In-Reply-To: <FMfcgxwGDDpcbrVbWGfkMRbZCLSZqpMM>
References: <FMfcgxwGDDpcbrVbWGfkMRbZCLSZqpMM>
Message-ID: <20200205215511.80333-1-geissonator@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Geissler <geissonator@yahoo.com>

Name the gpios so libgiod will work with them

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
v2: added upstream to patch
    prepended fsi- on fsi related gpios
    prepended led- on led related gpios
    prepended presence on presence related gpios
    dropped pin_gpio_a1 definition
---
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 515f0f208ee6..2519722928a4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -193,6 +193,42 @@
 
 };
 
+&gpio {
+    status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","cfam-reset","","","","","fsi-mux","",
+	/*B0-B7*/	"","","","","","air-water","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"fsi-enable","","","","","","","",
+	/*E0-E7*/	"fsi-data","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","checkstop","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"presence-ps1","","led-rear-fault","led-rear-power",
+		        "led-rear-id","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","presence-ps0",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","fsi-trans","","","power-button","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"fsi-clock","","","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+
+};
+
 &fmc {
 	status = "okay";
 
-- 
2.21.0 (Apple Git-122)


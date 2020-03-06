From: Andrew Geissler <geissonator@gmail.com>
Date: Fri,  6 Mar 2020 11:02:18 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: zaius: Add gpio line names
In-Reply-To: <20200306170218.79698-1-geissonator@yahoo.com>
References: <20200306170218.79698-1-geissonator@yahoo.com>
Message-ID: <20200306170218.79698-2-geissonator@yahoo.com>
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
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 37 +++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index bc60ec291681..4bcc82046362 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -478,32 +478,61 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpioh_unbiased>;
 
+	gpio-line-names =
+	/*A0-A7*/	"","cfam-reset","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"fsi-enable","","","","","led-sys-boot-status","led-attention",
+				"led-fault",
+	/*E0-E7*/	"","","","","","","","presence-pcie-e2b",
+	/*F0-F7*/	"","","","","","","","checkstop",
+	/*G0-G7*/	"fsi-clock","fsi-data","","","","","","",
+	/*H0-H7*/	"onewire0","onewire1","onewire2","onewire3","","","","",
+	/*I0-I7*/	"","","","power-button","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","iso_u164_en","","fsi-trans","",
+	/*P0-P7*/	"ncsi_mux_en_n","bmc_i2c2_sw_rst_n","","bmc_i2c5_sw_rst_n","",
+				"","fsi-mux","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"","","led-hdd-fault","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+
 	line_iso_u146_en {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(O, 4) GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "iso_u164_en";
 	};
 
 	ncsi_mux_en_n {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 		output-low;
-		line-name = "ncsi_mux_en_n";
 	};
 
 	line_bmc_i2c2_sw_rst_n {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "bmc_i2c2_sw_rst_n";
 	};
 
 	line_bmc_i2c5_sw_rst_n {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "bmc_i2c5_sw_rst_n";
 	};
 };
 
-- 
2.21.0 (Apple Git-122)


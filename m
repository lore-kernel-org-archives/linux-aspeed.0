From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:45:03 +0930
Subject: [PATCH 3/3] ARM: dts: aspeed: Enable both MMC slots on Swift
In-Reply-To: <20190710141503.21026-1-andrew@aj.id.au>
References: <20190710141503.21026-1-andrew@aj.id.au>
Message-ID: <20190710141503.21026-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>

Swift will provide at least its rootfs on eMMC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index f1356ca794d8..fcaeae2dd0a8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -640,3 +640,21 @@
 &vhub {
 	status = "okay";
 };
+
+&sdc {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd1_default>;
+};
+
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+};
-- 
2.20.1


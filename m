From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Sep 2020 12:41:43 +0930
Subject: [PATCH] ARM: dts: rainier: Disable internal pull-downs on eMMC pins
Message-ID: <20200910031143.2997298-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There's a veritable tug-of-war going on in the design, so disable one of
the warring parties.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 1fa233d2da26..21ae880c7530 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -180,6 +180,10 @@ &emmc_controller {
 	status = "okay";
 };
 
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
 &emmc {
 	status = "okay";
 };
-- 
2.25.1


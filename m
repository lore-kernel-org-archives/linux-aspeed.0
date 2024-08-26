From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 26 Aug 2024 14:24:05 +0800
Subject: [PATCH v14 31/31] ARM: dts: aspeed: yosemite4: add GPIO I6
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240826062408.2885174-32-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add BMC GPIO I6 for ALT_SMB_BMC_CPLD2_N.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 04aa428f94b7..0341b61aa1f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -2011,6 +2011,10 @@ pin_gpio_f7 {
 		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_i6 {
+		gpios = <ASPEED_GPIO(I, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_l6 {
 		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
 		input;
-- 
2.25.1


From: George Liu <liuxiwei1013@gmail.com>
Date: Fri, 25 Jun 2021 15:40:31 +0800
Subject: [PATCH v1] ARM: dts: fp5280g2: Add KCS node for LPC MCTP
Message-ID: <20210625074031.32576-1-liuxiwei@inspur.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: George Liu <liuxiwei@inspur.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 1752f3250e44..66c0542b2694 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -300,6 +300,11 @@ &lpc_ctrl {
 	flash = <&spi1>;
 };
 
+&kcs4 {
+	compatible = "openbmc,mctp-lpc";
+	status = "okay";
+};
+
 &mac0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.30.2


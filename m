From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 18 Jul 2021 17:17:21 -0700
Subject: [PATCH 1/4] ARM: dts: aspeed: Enable ADC in Facebook AST2400 common
 dtsi
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Message-ID: <20210719001724.6410-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable ADC controller in "ast2400-facebook-netbmc-common.dtsi" because
the device is used on all the Facebook AST2400 BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
index 73a5503be78c..4e5e786e18b7 100644
--- a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
@@ -115,3 +115,7 @@
 &vhub {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1


From: Tao Ren <taoren@fb.com>
Date: Wed, 8 May 2019 20:43:34 -0700
Subject: [PATCH] ARM: dts: aspeed: cmm: enable ehci host controllers
Message-ID: <20190509034334.2165789-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable ehci0 and ehci1 USB host controllers on Facebook Backpack CMM BMC.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
index 43aba4071a5c..d519d307aa2a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -372,3 +372,11 @@
 &adc {
 	status = "okay";
 };
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
-- 
2.17.1


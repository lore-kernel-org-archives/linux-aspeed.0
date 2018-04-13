From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 13 Apr 2018 14:40:39 +1000
Subject: [PATCH 2/2] ARM: dts: Aspeed: Enable USB ports on eval board.
In-Reply-To: <20180413044039.11345-1-benh@kernel.crashing.org>
References: <20180413044039.11345-1-benh@kernel.crashing.org>
Message-ID: <20180413044039.11345-2-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This enables both USB ports as host with EHCI and UHCI
attached to them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 6946c8610c4c..0c3f14d05046 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -80,3 +80,21 @@
 		reg = <0x4d>;
 	};
 };
+
+&ehci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2ah_default>;
+};
+
+&ehci1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2bh_default>;
+};
+
+&uhci {
+	status = "okay";
+
+	/* No pinctrl, this follows the above EHCI settings */
+};
-- 
2.14.3


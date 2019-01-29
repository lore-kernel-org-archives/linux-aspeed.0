From: Patrick Venture <venture@google.com>
Date: Tue, 29 Jan 2019 13:47:02 -0800
Subject: [PATCH] ARM: dts: aspeed: quanta-q71l: enable uart1
Message-ID: <20190129214703.119694-1-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the uart1 node such that the clock will be enabled.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 999679b5ef55..0d7c6339da46 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -138,6 +138,10 @@
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
 
+&uart1 {
+	status = "okay";
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.20.1.495.gaa96b0ce6b-goog


From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 14:55:32 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: enable mac2
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
Message-ID: <20240926-catalina-evt-dvt-system-modify-v1-2-84a27b47040b@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable mac2 in advance for DVT HW schematic.

- EVT system:
  - eth0 (mac2): no NCSI
  - eth1 (mac3): with NCSI

- DVT system:
  - eth0 (mac2): with NCSI
  - eth1 (mac3): with NCSI

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index eac6e33e98f4..9502d483e738 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -153,6 +153,13 @@ &uart5 {
 	status = "okay";
 };
 
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	use-ncsi;
+};
+
 &mac3 {
 	status = "okay";
 	pinctrl-names = "default";

-- 
2.31.1


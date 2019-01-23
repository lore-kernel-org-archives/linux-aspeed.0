From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 23 Jan 2019 15:07:33 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Add uarts for SoL in Facebook
In-Reply-To: <20190123230733.1821501-1-vijaykhemka@fb.com>
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
Message-ID: <20190123230733.1821501-2-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added uart2 and uart3 in Facebook Tiogapass for routing serial input
from Host to BMC for SoL via LPC.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index d60dbb019f82..42e0d7a8e8d0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -72,6 +72,16 @@
 		     &pinctrl_rxd1_default>;
 };
 
+&uart2 {
+	// SoL Host Console
+	status = "okay";
+};
+
+&uart3 {
+	// SoL BMC Console
+	status = "okay";
+};
+
 &uart5 {
 	// BMC Console
 	status = "okay";
-- 
2.17.1


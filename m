From: Patrick Venture <venture@google.com>
Date: Tue, 29 Jan 2019 13:46:24 -0800
Subject: [PATCH] ARM: dts: aspeed: quanta-q71l: enable lpc_ctrl node
Message-ID: <20190129214624.119330-1-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the lpc_ctrl node in the quanta-q71l dts such that the LPC_CLK is
enabled.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 385c0f4b69ee..999679b5ef55 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -116,6 +116,10 @@
 	status = "okay";
 };
 
+&lpc_ctrl {
+	status = "okay";
+};
+
 &lpc_snoop {
 	status = "okay";
 	snoop-ports = <0x80>;
-- 
2.20.1.495.gaa96b0ce6b-goog


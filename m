From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  5 Dec 2019 11:15:12 -0600
Subject: [PATCH v2 12/12] ARM: dts: aspeed: tacoma: Enable XDMA engine
In-Reply-To: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1575566112-11658-13-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index f02de4a..cf54708 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -1193,3 +1193,8 @@
 	pinctrl-0 = <&pinctrl_lpc_default>,
 		    <&pinctrl_lsirq_default>;
 };
+
+&xdma {
+	status = "okay";
+	vga-mem = <0xbf800000 0x00800000>;
+};
-- 
1.8.3.1


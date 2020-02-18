From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 18 Feb 2020 22:00:52 +1030
Subject: [PATCH] ARM: dts: rainier: Enable VUART2
Message-ID: <20200218113052.28392-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The second VUART is used to expose multiplexed, non-hypervisor consoles.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 6232cd726a7f..61d4140a2601 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -540,6 +540,10 @@
 	status = "okay";
 };
 
+&vuart2 {
+	status = "okay";
+};
+
 &lpc_ctrl {
 	status = "okay";
 	memory-region = <&flash_memory>;
-- 
2.20.1


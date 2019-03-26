From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Tue, 26 Mar 2019 09:33:23 -0500
Subject: [PATCH] witherspoon.dts: Enable the USB vhub (device)
Message-ID: <1553610803-65797-1-git-send-email-anoo@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed vhub device driver is already enabled in
the defconfig, make use of it in the witherspoon platform.

Signed-off-by: Adriana Kobylak <anoo@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index b933ced..8ebe35e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -634,6 +634,10 @@
 	memory-region = <&gfx_memory>;
 };
 
+&vhub {
+	status = "okay";
+};
+
 &pinctrl {
 	aspeed,external-nodes = <&gfx &lhc>;
 };
-- 
1.8.3.1


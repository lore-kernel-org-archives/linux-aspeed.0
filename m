From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  1 Jul 2019 14:53:59 -0500
Subject: [PATCH v4 8/8] ARM: dts: aspeed: witherspoon: Enable XDMA Engine
In-Reply-To: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
References: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1562010839-1113-9-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 31ea34e..1d247cd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -653,4 +653,8 @@
 	memory-region = <&video_engine_memory>;
 };
 
+&xdma {
+	status = "okay";
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
1.8.3.1


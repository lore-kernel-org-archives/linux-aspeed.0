From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 29 May 2019 13:10:08 -0500
Subject: [PATCH v3 8/8] ARM: dts: aspeed: witherspoon: Enable XDMA Engine
In-Reply-To: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1559153408-31190-9-git-send-email-eajames@linux.ibm.com>
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
index 85b9e40..ad7ccf1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -641,4 +641,8 @@
 	status = "okay";
 };
 
+&xdma {
+	status = "okay";
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
1.8.3.1


From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  9 Jan 2020 14:59:02 -0600
Subject: [PATCH v5 11/12] ARM: dts: aspeed: witherspoon: Enable XDMA Engine
In-Reply-To: <20200109205903.27036-1-eajames@linux.ibm.com>
References: <20200109205903.27036-1-eajames@linux.ibm.com>
Message-ID: <20200109205903.27036-12-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 421aa600148b..5351d6a8395c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -656,4 +656,10 @@ &video {
 	memory-region = <&video_engine_memory>;
 };
 
+&xdma {
+	status = "okay";
+	/* 512M DRAM with 16M VRAM which is reserved at the top. */
+	memory = <0x9f000000 0x01000000>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
2.24.0


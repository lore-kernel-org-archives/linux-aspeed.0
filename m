From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 18 Dec 2019 09:09:37 -0600
Subject: [PATCH v3 11/12] ARM: dts: aspeed: witherspoon: Enable XDMA Engine
In-Reply-To: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1576681778-18737-12-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the XDMA engine node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 569dad93e162..1a28b86f00ea 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -658,4 +658,9 @@ &video {
 	memory-region = <&video_engine_memory>;
 };
 
+&xdma {
+	status = "okay";
+	memory = <0x9f000000 0x01000000>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
2.24.0


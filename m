From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Thu, 16 Aug 2018 14:43:20 -0500
Subject: [RFC 1/2] dt-bindings: media: Add Aspeed Video Engine binding
 documentation
In-Reply-To: <1534448601-74120-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1534448601-74120-1-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <1534448601-74120-2-git-send-email-eajames@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the bindings.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 .../devicetree/bindings/media/aspeed-video.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
new file mode 100644
index 0000000..91a494e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
@@ -0,0 +1,25 @@
+* Device tree bindings for Aspeed Video Engine
+
+The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
+capture and compress video data from digital or analog sources.
+
+Required properties:
+ - compatible:		"aspeed,ast2400-video" or "aspeed,ast2500-video"
+ - reg:			contains the offset and length of the VE memory region
+ - clocks:		pointers to the the "vclk" and "eclk" of the syscon
+ - clock-names:		"vclk-gate", "eclk-gate"
+ - resets:		pointer to the VE reset of the syscon
+ - interrupts:		the interrupt associated with the VE on this platform
+ - reg-scu:		pointer to the syscon itself
+
+Example:
+
+video: video at 1e700000 {
+        compatible = "aspeed,ast2500-video";
+        reg = <0x1e700000 0x20000>;
+        clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
+        clock-names = "vclk-gate", "eclk-gate";
+        resets = <&syscon ASPEED_RESET_VIDEO>;
+        interrupts = <7>;
+        reg-scu = <&syscon>;
+};
-- 
1.8.3.1


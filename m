From: Patrick Venture <venture@google.com>
Date: Thu, 25 Apr 2019 12:48:53 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
Message-ID: <20190425194853.140617-1-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
disable the PCI-to-AHB bridge and then allow control of this bridge via
ioctls, and access via mmap.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 9549f867aa1ef..0b7bc6072aed0 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -165,6 +165,10 @@
 					compatible = "aspeed,g4-pinctrl";
 				};
 
+				p2a: p2a-control {
+					compatible = "aspeed,ast2400-p2a-ctrl";
+					status = "disabled";
+				};
 			};
 
 			rng: hwrng at 1e6e2078 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 3e4ed081505cc..5f01befcca1e2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -212,6 +212,11 @@
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
+
+				p2a: p2a-control {
+					compatible = "aspeed,ast2500-p2a-ctrl";
+					status = "disabled";
+				};
 			};
 
 			rng: hwrng at 1e6e2078 {
-- 
2.21.0.593.g511ec345e18-goog


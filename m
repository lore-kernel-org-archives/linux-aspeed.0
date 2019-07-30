From: Oskar Senft <osk@google.com>
Date: Mon, 29 Jul 2019 21:49:55 -0400
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Add uart-routing node
In-Reply-To: <20190730014955.34059-1-osk@google.com>
References: <20190730014955.34059-1-osk@google.com>
Message-ID: <20190730014955.34059-3-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the aspeed-uart-routing module. This node, when enabled
will provide control of the Aspeed UART routing via sysfs.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes since v1:
 Added AST2400.

 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index dd4b0b15afcf..d855bc19d677 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -326,6 +326,12 @@
 						status = "disabled";
 					};
 				};
+
+				uart_routing: uart_routing at 9c {
+					compatible = "aspeed,ast2400-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial at 1e78d000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7149ff3b6fb3..9e561504042a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -440,6 +440,12 @@
 						status = "disabled";
 					};
 				};
+
+				uart_routing: uart_routing at 9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
 			};
 
 			uart2: serial at 1e78d000 {
-- 
2.22.0.709.g102302147b-goog


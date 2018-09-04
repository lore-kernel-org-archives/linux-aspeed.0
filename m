From: Oskar Senft <osk@google.com>
Date: Tue,  4 Sep 2018 16:20:18 -0400
Subject: [PATCH 2/2] arch: arm: boot: dts: aspeed: Add UART routing driver to
 Aspeed G5 DTS.
In-Reply-To: <20180904202018.198707-1-osk@google.com>
References: <20180904202018.198707-1-osk@google.com>
Message-ID: <20180904202018.198707-3-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Oskar Senft <osk@google.com>
---
 .../bindings/misc/aspeed,uart-routing.txt     | 22 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              |  6 +++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,uart-routing.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed,uart-routing.txt b/Documentation/devicetree/bindings/misc/aspeed,uart-routing.txt
new file mode 100644
index 000000000000..d0a93173593c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,uart-routing.txt
@@ -0,0 +1,22 @@
+* ASPEED AST2500 UART routing
+
+This file describes the bindings for the UART routing selector present
+in the AST2500 BMC SoC.
+
+The Aspeed AST2500 allows to dynamically route the inputs for the built-in
+UARTS and physical serial I/O ports.
+
+This allows, for example, to connect the output of UART to another UART.
+This can be used to enable host<->BMC communication via UARTs, e.g. to allow
+access to the host's serial console.
+
+Required properties:
+- reg: address and length of the register for the device.
+- compatible: "aspeed,ast2500-cvic"
+
+Example:
+
+	uart_routing: uart_routing at 1e78909c {
+		compatible = "aspeed,ast2500-uart-routing";
+		reg = <0x1e78909c 0x4>;
+	};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 87fdc146ff52..03094e8878eb 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -375,6 +375,12 @@
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
2.19.0.rc1.350.ge57e33dbd1-goog


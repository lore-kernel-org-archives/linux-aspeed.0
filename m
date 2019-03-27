From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Mar 2019 11:32:14 +1030
Subject: [PATCH v3 1/2] dt-bindings: rtc: Add on-chip ASPEED RTC documentation
In-Reply-To: <20190327010215.10231-1-joel@jms.id.au>
References: <20190327010215.10231-1-joel@jms.id.au>
Message-ID: <20190327010215.10231-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Describe the RTC as used in the ASPEED BMC SoCs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add interrupts property
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
new file mode 100644
index 000000000000..2e956b3dc276
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
@@ -0,0 +1,22 @@
+ASPEED BMC RTC
+==============
+
+Required properties:
+ - compatible: should be one of the following
+   * aspeed,ast2400-rtc for the ast2400
+   * aspeed,ast2500-rtc for the ast2500
+   * aspeed,ast2600-rtc for the ast2600
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+ - interrupts: The interrupt number
+
+Example:
+
+   rtc at 1e781000 {
+           compatible = "aspeed,ast2400-rtc";
+           reg = <0x1e781000 0x18>;
+           interrupts = <22>;
+           status = "disabled";
+   };
-- 
2.20.1


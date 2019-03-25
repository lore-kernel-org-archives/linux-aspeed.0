From: Joel Stanley <joel@jms.id.au>
Date: Tue, 26 Mar 2019 00:01:58 +1030
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add on-chip ASPEED RTC documentation
In-Reply-To: <20190325133159.10653-1-joel@jms.id.au>
References: <20190325133159.10653-1-joel@jms.id.au>
Message-ID: <20190325133159.10653-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Describe the RTC as used in the ASPEED BMC SoCs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/rtc/rtc-aspeed.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
new file mode 100644
index 000000000000..f9f7defd557e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
@@ -0,0 +1,19 @@
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
+Example:
+
+   rtc at 1e781000 {
+           compatible = "aspeed,ast2400-rtc";
+           reg = <0x1e781000 0x18>;
+           status = "disabled";
+   };
-- 
2.20.1


From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Tue,  2 Nov 2021 13:37:13 -0700
Subject: [PATCH -next v2 2/6] dt-bindings: ipmi: bt-bmc: add 'clocks' as a
 required property
In-Reply-To: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
Message-ID: <20211102203717.96794-3-jae.hyun.yoo@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Add 'clocks' as a required property.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v1 - v2:
 - Added 'clocks' property into ibt bindings using
   'aspeed,ast2400-ibt-bmc.txt' because it's not merged into
   'aspeed-lpc.yaml' yet. The bindings merging could be done using a
   separate patch later.

 .../devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
index c9902fd4b38b..25f86da804b7 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
@@ -11,6 +11,7 @@ Required properties:
 	"aspeed,ast2500-ibt-bmc"
 	"aspeed,ast2600-ibt-bmc"
 - reg: physical address and size of the registers
+- clocks: clock for the device
 
 Optional properties:
 
@@ -23,4 +24,5 @@ Example:
 		compatible = "aspeed,ast2400-ibt-bmc";
 		reg = <0x1e789140 0x18>;
 		interrupts = <8>;
+		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 	};
-- 
2.25.1


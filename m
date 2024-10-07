From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Mon, 7 Oct 2024 14:34:05 +0800
Subject: [PATCH 1/4] dt-bindings: watchdog: aspeed: Add property for WDT SW reset
In-Reply-To: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
References: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20241007063408.2360874-2-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add "aspeed,restart-sw" property to distinguish normal WDT
reset from system restart triggered by SW consciously.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 .../bindings/watchdog/aspeed,ast2400-wdt.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
index be78a9865584..6cc3604c295a 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
@@ -95,6 +95,17 @@ properties:
       array with the first word defined using the AST2600_WDT_RESET1_* macros,
       and the second word defined using the AST2600_WDT_RESET2_* macros.
 
+  aspeed,restart-sw:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: >
+      Normally, ASPEED WDT reset may occur when system hangs or reboot
+      triggered by SW consciously. However, system doesn't know whether the
+      restart is triggered by SW consciously since the reset event flag is
+      the same as normal WDT timeout reset. With this property, SW can
+      restart the system immediately and directly without wait for WDT
+      timeout occurs. The reset event flag is also different from the normal
+      WDT reset. This property is only supported since AST2600 platform.
+
 required:
   - compatible
   - reg
-- 
2.34.1


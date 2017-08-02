From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed,  2 Aug 2017 14:15:28 +0930
Subject: [PATCH 1/2] dt-bindings: watchdog: aspeed: External reset signal
 properties
In-Reply-To: <20170802044529.30032-1-andrew@aj.id.au>
References: <20170802044529.30032-1-andrew@aj.id.au>
Message-ID: <20170802044529.30032-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For the AST2500 and compatible watchdog controllers the external reset
signal can be configured for push-pull or open-drain drive types, and in
the case of push-pull driving, active low or high.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index 2b34ce9b60b9..c5077a1f5cb3 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -33,10 +33,18 @@ Optional properties:
         - none: No reset is performed on timeout. Assumes another watchdog
                 engine is responsible for this.
 
+ - aspeed,alt-boot:    If property is present then boot from alternate block.
  - aspeed,external-signal: If property is present then signal is sent to
 			external reset counter (only WDT1 and WDT2). If not
 			specified no external signal is sent.
- - aspeed,alt-boot:    If property is present then boot from alternate block.
+ - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
+
+Optional properties for AST2500-compatible watchdogs:
+ - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
+			 drive type to push-pull. The default is open-drain.
+ - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
+			   is configured as push-pull, then set the pulse
+			   polarity to active-high. The default is active-low.
 
 Example:
 
-- 
2.11.0


From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 21 Oct 2022 10:15:59 -0500
Subject: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document aspeed,pre-timeout-irq-us
In-Reply-To: <20221021151559.781983-1-eajames@linux.ibm.com>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
Message-ID: <20221021151559.781983-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document this new property for the pre-timeout interrupt.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index a8197632d6d2..81d2c35ca7e3 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -40,12 +40,17 @@ Optional properties:
 			specified no external signal is sent.
  - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
 
-Optional properties for AST2500-compatible watchdogs:
+Optional properties for AST2500 and AST2600 compatible watchdogs:
  - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
 			 drive type to push-pull. The default is open-drain.
  - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
 			   is configured as push-pull, then set the pulse
 			   polarity to active-high. The default is active-low.
+ - aspeed,pre-timeout-irq-us: If aspeed,pre-timeout-irq-us is non-zero, the
+			      pre-timeout interrupt will be enabled for the
+			      watchdog. The interrupt will fire the specified
+			      number of microseconds before the watchdog expires
+			      and trigger a kernel panic.
 
 Example:
 
-- 
2.31.1


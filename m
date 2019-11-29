From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 29 Nov 2019 18:25:34 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191129172537.31410-1-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
Message-ID: <20191129172537.31410-4-m.felsch@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the documentation which describe the voltage selection gpio support.
This property can be applied to each subnode within the 'regulators'
node so each regulator can be configured differently.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v3:
- adapt binding description

 Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index edca653a5777..b9cccd4c3f76 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -66,6 +66,14 @@ Sub-nodes:
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
+  Optional regulator device-specific properties:
+  - dlg,vsel-sense-gpios : A GPIO reference to a local general purpose input,
+    the datasheet calls it GPI. The regulator sense the input signal and select
+    the active or suspend voltage settings. If the signal is active the
+    active-settings are applied else the suspend-settings are applied.
+    Attention: Sharing the same GPI for other purposes or across multiple
+    regulators is possible but the polarity setting must equal.
+
 - rtc : This node defines settings required for the Real-Time Clock associated
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
-- 
2.20.1


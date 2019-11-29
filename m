From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 29 Nov 2019 18:25:36 +0100
Subject: [PATCH v3 5/6] dt-bindings: mfd: da9062: add regulator gpio
 enable/disable documentation
In-Reply-To: <20191129172537.31410-1-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
Message-ID: <20191129172537.31410-6-m.felsch@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At the gpio-based regulator enable/disable documentation. This property
can be applied to each subnode within the 'regulators' node so each
regulator can be configured differently.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v3:
- adapt binding description

 Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index b9cccd4c3f76..863b1199d875 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -74,6 +74,13 @@ Sub-nodes:
     Attention: Sharing the same GPI for other purposes or across multiple
     regulators is possible but the polarity setting must equal.
 
+  - dlg,ena-sense-gpios : A GPIO reference to a local general purpose input,
+    the datasheet calls it GPI. The regulator sense the input signal and enable
+    or disable the regulator output. The regulator output is enabled if the
+    the signal is active else the output is disabled.
+    Attention: Sharing the same GPI for other purposes or across multiple
+    regulators is possible but the polarity setting must equal.
+
 - rtc : This node defines settings required for the Real-Time Clock associated
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
@@ -111,6 +118,7 @@ Example:
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
 				regulator-boot-on;
+				dlg,ena-sense-gpios = <&pmic0 2 GPIO_ACTIVE_LOW>;
 			};
 		};
 	};
-- 
2.20.1


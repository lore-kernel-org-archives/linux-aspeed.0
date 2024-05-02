From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  1 May 2024 17:28:31 -0700
Subject: [PATCH v3 1/3] dt-bindings: trivial-devices: add isil,isl69269
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Message-ID: <20240502002836.17862-6-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ISL69269 is a PMBus voltage regulator with no configurable
parameters.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..98ad7f3a7853 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -160,6 +160,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Intersil ISL69269 PMBus Voltage Regulator
+          - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
           - isil,isl76682
             # Linear Technology LTC2488
-- 
2.44.0


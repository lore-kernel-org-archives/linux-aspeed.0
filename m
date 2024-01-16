From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 16 Jan 2024 12:37:33 -0600
Subject: [PATCH v4 2/3] dt-bindings: Add DPS310 as trivial device
In-Reply-To: <20240116183734.3944028-1-ninad@linux.ibm.com>
References: <20240116183734.3944028-1-ninad@linux.ibm.com>
Message-ID: <20240116183734.3944028-3-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Infineon DPS310 is a barometric pressure and temperature sensor.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 430a814f64a5..22b7a29876d3 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -133,6 +133,8 @@ properties:
           - ibm,cffps1
             # IBM Common Form Factor Power Supply Versions 2
           - ibm,cffps2
+            # Infineon barometric pressure and temperature sensor
+          - infineon,dps310
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IR38060 Voltage Regulator
-- 
2.39.2


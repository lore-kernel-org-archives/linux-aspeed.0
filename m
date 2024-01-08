From: Ninad Palsule <ninad@linux.ibm.com>
Date: Mon,  8 Jan 2024 14:41:13 -0600
Subject: [PATCH v2 2/3] dt-bindings: Add DPS310 as trivial device
In-Reply-To: <20240108204114.1041390-1-ninad@linux.ibm.com>
References: <20240108204114.1041390-1-ninad@linux.ibm.com>
Message-ID: <20240108204114.1041390-3-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Infineon DPS310 is a barometric pressure and temperature sensor.

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


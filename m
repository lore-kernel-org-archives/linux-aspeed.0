From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 22 Jul 2019 17:20:46 -0700
Subject: [PATCH] dt-bindings: Add pxe1610 as a trivial device
Message-ID: <20190723002052.2878847-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pxe1610 is a voltage regulator from Infineon. It also supports
other VRs pxe1110 and pxm1310 from Infineon.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2e742d399e87..1be648828a31 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -99,6 +99,8 @@ properties:
             # Infineon IR38064 Voltage Regulator
           - infineon,ir38064
             # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
+          - infineon,pxe1610
+            # Infineon PXE1610, PXE1110 and PXM1310 Voltage Regulators
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
           - infineon,slb9645tt
-- 
2.17.1


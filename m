From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 23 Jul 2019 10:19:16 -0700
Subject: [PATCH v2] dt-bindings: Add pxe1610 as a trivial device
Message-ID: <20190723171922.1435859-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pxe1610 is a voltage regulator from Infineon. It also supports
other VRs pxe1110 and pxm1310 from Infineon.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
In V2: comment was put wrongly after device so corrected.

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2e742d399e87..a3dd83d4f429 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -98,6 +98,8 @@ properties:
           - gmt,g751
             # Infineon IR38064 Voltage Regulator
           - infineon,ir38064
+            # Infineon PXE1610, PXE1110 and PXM1310 Voltage Regulators
+          - infineon,pxe1610
             # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-- 
2.17.1


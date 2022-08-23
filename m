From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Aug 2022 09:56:40 -0500
Subject: [PATCH] dt-bindings: usb: Add missing (unevaluated|additional)Properties on child nodes
Message-ID: <20220823145649.3118479-9-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/analogix,anx7411.yaml    |  2 ++
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml     |  2 ++
 .../devicetree/bindings/usb/st,stusb160x.yaml        | 12 +++++++++---
 .../devicetree/bindings/usb/willsemi,wusb3801.yaml   |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
index ee436308e5dc..0e72c08e6566 100644
--- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -23,6 +23,8 @@ properties:
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml
+    unevaluatedProperties: false
+
     description:
       Properties for usb c connector.
 
diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
index 8b019ac05bbe..a86bcd95100e 100644
--- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -67,6 +67,7 @@ properties:
 
   vhub-strings:
     type: object
+    additionalProperties: false
 
     properties:
       '#address-cells':
@@ -78,6 +79,7 @@ properties:
     patternProperties:
       '^string@[0-9a-f]+$':
         type: object
+        additionalProperties: false
         description: string descriptors of the specific language
 
         properties:
diff --git a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
index b5a8c9814dd3..b8974807b666 100644
--- a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
+++ b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
@@ -33,6 +33,7 @@ properties:
   connector:
     type: object
     $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
 
     properties:
       compatible:
@@ -74,9 +75,14 @@ examples:
                 data-role = "dual";
                 typec-power-opmode = "default";
 
-                port {
-                    typec_con_ep: endpoint {
-                        remote-endpoint = <&usbotg_hs_ep>;
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    port at 0 {
+                        reg = <0>;
+                        typec_con_ep: endpoint {
+                            remote-endpoint = <&usbotg_hs_ep>;
+                        };
                     };
                 };
             };
diff --git a/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
index c2b2243c7892..5aa4ffd67119 100644
--- a/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
+++ b/Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
@@ -28,6 +28,7 @@ properties:
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml#
+    unevaluatedProperties: false
     description:
       The managed USB Type-C connector. Since WUSB3801 does not support
       Power Delivery, the node should have the "pd-disable" property.
-- 
2.34.1


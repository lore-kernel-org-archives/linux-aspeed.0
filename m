From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 12:49:22 +0200
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: document several vendors for Aspeed BMC boards
Message-ID: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add vendor prefixes for manufacturers of Aspeed SoC based BMC boards:
ASrock, ByteDance, Ingrasys, Inventec and Quanta.  Move also bticino to
proper alphabetical place.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/vendor-prefixes.yaml     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 495a01ced97e..169f11ce4cc5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -141,6 +141,8 @@ patternProperties:
     description: ASIX Electronics Corporation
   "^aspeed,.*":
     description: ASPEED Technology Inc.
+  "^asrock,.*":
+    description: ASRock Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
   "^atlas,.*":
@@ -195,12 +197,14 @@ patternProperties:
     description: Broadcom Corporation
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
+  "^bticino,.*":
+    description: Bticino International
   "^buffalo,.*":
     description: Buffalo, Inc.
   "^bur,.*":
     description: B&R Industrial Automation GmbH
-  "^bticino,.*":
-    description: Bticino International
+  "^bytedance,.*":
+    description: ByteDance Ltd.
   "^calamp,.*":
     description: CalAmp Corp.
   "^calaosystems,.*":
@@ -544,6 +548,8 @@ patternProperties:
     description: Shenzhen Hugsun Technology Co. Ltd.
   "^hwacom,.*":
     description: HwaCom Systems Inc.
+  "^hxt,.*":
+    description: HXT Semiconductor
   "^hycon,.*":
     description: Hycon Technology Corp.
   "^hydis,.*":
@@ -578,6 +584,8 @@ patternProperties:
     description: Infineon Technologies
   "^inforce,.*":
     description: Inforce Computing
+  "^ingrasys,.*":
+    description: Ingrasys Technology Inc.
   "^ivo,.*":
     description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
@@ -598,6 +606,8 @@ patternProperties:
     description: Inter Control Group
   "^invensense,.*":
     description: InvenSense Inc.
+  "^inventec,.*":
+    description: Inventec
   "^inversepath,.*":
     description: Inverse Path
   "^iom,.*":
@@ -1010,6 +1020,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^quanta,.*":
+    description: Quanta Computer Inc.
   "^radxa,.*":
     description: Radxa
   "^raidsonic,.*":
-- 
2.34.1


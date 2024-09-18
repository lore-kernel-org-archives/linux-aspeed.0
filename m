From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 18 Sep 2024 17:54:34 +0800
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: support pmbus compatible string
In-Reply-To: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240918095438.1345886-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add pmbus compatibale string for the Generic PMbus devices that could
be monitor by pmbus driver.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8a9a00705b23..cbb9b94e5b3b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -320,6 +320,8 @@ properties:
           - oki,ml86v7667
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
+            # Generic PMBus devices
+          - pmbus
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
-- 
2.25.1


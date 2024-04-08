From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 15:53:21 -0000
Subject: [PATCH 4/9] dt-bindings: rtc: maxim,ds1742: move to trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
Message-ID: <20240408-rtc_dtschema-v1-4-c447542fc362@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This RTC only requires the compatible a reg and properties,
which makes it suitable for a direct conversion into trivial-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/rtc/maxim,ds1742.txt | 12 ------------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt b/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
deleted file mode 100644
index d0f937c355b5..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,ds1742.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* Maxim (Dallas) DS1742/DS1743 Real Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,ds1742".
-- reg: Physical base address of the RTC and length of memory
-  mapped region.
-
-Example:
-	rtc: rtc at 10000000 {
-		compatible = "maxim,ds1742";
-		reg = <0x10000000 0x800>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d6ce7ac29033..710b096fe6f7 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -49,6 +49,8 @@ properties:
       - isil,isl1218
       # Mvebu Real-time Clock
       - marvell,orion-rtc
+      # Maxim DS1742/DS1743 Real-time Clock
+      - maxim,ds1742
       # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
       - maxim,mcp795
       # Real Time Clock Module with I2C-Bus

-- 
2.40.1


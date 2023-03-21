From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 21 Mar 2023 10:16:40 -0500
Subject: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
Message-ID: <20230321151642.461618-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
as a trivial I2C device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..43e26c73a95f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,6 +47,8 @@ properties:
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
           - at,24c08
+            # i2c serial eeprom (EE1004 standard)
+          - atmel,at30tse
             # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
             # ATSHA204 - i2c h/w symmetric crypto module
-- 
2.31.1


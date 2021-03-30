From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 30 Mar 2021 21:10:29 +0700
Subject: [PATCH v2 3/3] bindings: ipmi: Add binding for Aspeed SSIF BMC driver
In-Reply-To: <20210330141029.20412-1-quan@os.amperecomputing.com>
References: <20210330141029.20412-1-quan@os.amperecomputing.com>
Message-ID: <20210330141029.20412-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add device tree binding document for the Aspeed SSIF BMC driver.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 .../bindings/ipmi/aspeed-ssif-bmc.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
new file mode 100644
index 000000000000..1616f0188db9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
@@ -0,0 +1,18 @@
+# Aspeed SSIF (SMBus system interface) IPMI BMC interface
+
+The Aspeed AST2500 are commonly used as BMCs (Baseboard Management Controllers)
+and the SSIF slave interface can be used to perform in-band IPMI communication
+with their host.
+
+Required properties:
+
+- compatible : should be
+       "aspeed,ast2500-ssif-bmc"
+- reg: I2C address the registers
+
+Example:
+
+       ssif-bmc at 10 {
+               compatible = "aspeed,ast2500-ssif-bmc";
+               reg = <0x10>;
+       };
-- 
2.28.0


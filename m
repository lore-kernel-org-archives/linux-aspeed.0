From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:19 -0500
Subject: [PATCH v6 15/20] ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-16-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 4U Blueridge is identical to the Blueridge system but has two extra
power supplies.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
new file mode 100644
index 0000000000000..839aad4ddd917
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-blueridge.dts"
+
+/ {
+	model = "Blueridge 4U";
+};
+
+&i2c3 {
+	power-supply at 6a {
+		compatible = "ibm,cffps";
+		reg = <0x6a>;
+	};
+
+	power-supply at 6b {
+		compatible = "ibm,cffps";
+		reg = <0x6b>;
+	};
+};
-- 
2.39.3


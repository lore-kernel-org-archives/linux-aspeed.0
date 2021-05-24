From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 24 May 2021 15:32:55 +0800
Subject: [PATCH v5 3/4] ARM: dts: aspeed: ast2600evb: Add dts file for A1 and
 A0.
In-Reply-To: <20210524073308.9328-1-steven_lee@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
Message-ID: <20210524073308.9328-4-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

aspeed-ast2600-evb.dts was modified for supporting A2 evb.
Since A1/A0 evbs don't have GPIO regulators and SD clock frequency(SCU210)
is different to A2 as well. Adding a new dts that removes new nodes
created in aspeed-ast2600-evb.dts is necessary.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
new file mode 100644
index 000000000000..dd7148060c4a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2021 IBM Corp.
+
+#include "aspeed-ast2600-evb.dts"
+
+/ {
+	model = "AST2600 A1 EVB";
+
+	/delete-node/regulator-vcc-sdhci0;
+	/delete-node/regulator-vcc-sdhci1;
+	/delete-node/regulator-vccq-sdhci0;
+	/delete-node/regulator-vccq-sdhci1;
+};
+
+/delete-node/ &sdc;
-- 
2.17.1


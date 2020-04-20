From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 20 Apr 2020 15:26:11 -0500
Subject: [PATCH v10 7/7] ARM: dts: Aspeed: AST2600: Add missing SCU interrupt
 controller include
In-Reply-To: <20200420202611.17776-1-eajames@linux.ibm.com>
References: <20200420202611.17776-1-eajames@linux.ibm.com>
Message-ID: <20200420202611.17776-8-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The XDMA node references the SCU interrupt controller interrupts which
should be included.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 19f3287b7320..6cd772009313 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -2,6 +2,7 @@
 // Copyright 2019 IBM Corp.
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
 #include <dt-bindings/clock/ast2600-clock.h>
 
 / {
-- 
2.24.0


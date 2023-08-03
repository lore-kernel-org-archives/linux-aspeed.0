From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:46 -0600
Subject: [PATCH v2 06/23] ARM: hpe: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-6-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

of_platform.h is not needed, so drop it.

Acked-by: Nick Hawkins <nick.hawkins@hpe.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-hpe/gxp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
index ef3341373006..581c8da517b8 100644
--- a/arch/arm/mach-hpe/gxp.c
+++ b/arch/arm/mach-hpe/gxp.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
 
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 
 static const char * const gxp_board_dt_compat[] = {

-- 
2.40.1


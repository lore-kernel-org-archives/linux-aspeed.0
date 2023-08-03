From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:43 -0600
Subject: [PATCH v2 03/23] ARM: alpine: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-3-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

of_platform.h is not needed, drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-alpine/alpine_machine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-alpine/alpine_machine.c b/arch/arm/mach-alpine/alpine_machine.c
index d256a99e9b99..bc491bbbabf8 100644
--- a/arch/arm/mach-alpine/alpine_machine.c
+++ b/arch/arm/mach-alpine/alpine_machine.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2015 Annapurna Labs Ltd.
  */
 
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 
 static const char * const al_match[] __initconst = {

-- 
2.40.1


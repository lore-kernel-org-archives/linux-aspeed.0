From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Wed, 8 Dec 2021 09:33:37 +0800
Subject: [PATCH v5 7/7] dt-bindings:ast2600-clock Add CRT reset define
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
Message-ID: <20211208013337.13806-8-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add new CRT reset define for ast2600.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 62b9520a00fd..f8bee338a00f 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -110,6 +110,7 @@
 #define ASPEED_RESET_PCIE_DEV_OEN	20
 #define ASPEED_RESET_PCIE_RC_O		19
 #define ASPEED_RESET_PCIE_RC_OEN	18
+#define ASPEED_RESET_CRT		13
 #define ASPEED_RESET_PCI_DP		5
 #define ASPEED_RESET_AHB		1
 #define ASPEED_RESET_SDRAM		0
-- 
2.17.1


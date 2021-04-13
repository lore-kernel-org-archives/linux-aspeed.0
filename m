From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 14:43:07 -0500
Subject: [PATCH 3/4] ARM: dts: aspeed: Rainier 1S4U: Fix fan nodes
In-Reply-To: <20210413194308.36930-1-eajames@linux.ibm.com>
References: <20210413194308.36930-1-eajames@linux.ibm.com>
Message-ID: <20210413194308.36930-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 1S4U system populates fans 0, 1, 2, and 4. Update the dts to
reflect this.

Fixes: 7f03894a6555 ("ARM: dts: aspeed: Add Rainier 1S4U machine")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
index d1d31a59e502..f5f5b18c113a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
@@ -9,6 +9,6 @@ / {
 };
 
 &max {
-	/delete-node/ fan4;
+	/delete-node/ fan3;
 	/delete-node/ fan5;
 };
-- 
2.27.0


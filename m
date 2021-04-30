From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Apr 2021 13:59:57 -0500
Subject: [PATCH 1/4] ARM: dts: aspeed: Rainier 1S4U: Fix fan channels
In-Reply-To: <20210430190000.31646-1-eajames@linux.ibm.com>
References: <20210430190000.31646-1-eajames@linux.ibm.com>
Message-ID: <20210430190000.31646-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Geissler <geissonator@yahoo.com>

The 1S4U chassis populates fan channels 0, 1, 2, and 4. Update the DTS
to reflect this.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
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


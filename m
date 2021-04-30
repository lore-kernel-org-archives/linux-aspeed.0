From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Apr 2021 13:59:59 -0500
Subject: [PATCH 3/4] ARM: dts: aspeed: Rainier 4U: Remove fan updates
In-Reply-To: <20210430190000.31646-1-eajames@linux.ibm.com>
References: <20210430190000.31646-1-eajames@linux.ibm.com>
Message-ID: <20210430190000.31646-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 4U fans do not need a different "tach-pulses" property than the 2U
machine. In addition, the "maxim,fan-dual-tach" property does not exist
upstream yet, so it should also be removed.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../boot/dts/aspeed-bmc-ibm-rainier-4u.dts    | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
index f7fd3b3c90d0..342546a3c0f5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
@@ -19,33 +19,3 @@ power-supply at 6b {
 		reg = <0x6b>;
 	};
 };
-
-&fan0 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-
-&fan1 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-
-&fan2 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-
-&fan3 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-
-&fan4 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-
-&fan5 {
-	tach-pulses = <4>;
-	/delete-property/ maxim,fan-dual-tach;
-};
-- 
2.27.0


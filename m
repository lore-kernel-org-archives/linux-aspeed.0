From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:09 -0500
Subject: [PATCH 11/22] ARM: dts: aspeed: rainier 4U: Fix fan configuration
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-12-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 4U fans didn't have the correct properties since the fan nodes
were redefined. Fix this by referencing each fan individually and
adding the differences to the 4U fans.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
index 291f7d6c9979..f7fd3b3c90d0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts
@@ -22,16 +22,30 @@ power-supply at 6b {
 
 &fan0 {
 	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
 };
 
 &fan1 {
 	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
 };
 
 &fan2 {
 	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
 };
 
 &fan3 {
 	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
+};
+
+&fan4 {
+	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
+};
+
+&fan5 {
+	tach-pulses = <4>;
+	/delete-property/ maxim,fan-dual-tach;
 };
-- 
2.27.0


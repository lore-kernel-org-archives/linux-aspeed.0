From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 23 Aug 2024 14:41:11 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: update io_expander7 &
 io_expander8 line name
In-Reply-To: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
References: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
Message-ID: <20240823-catalina-ioexp-update-v1-2-4bfd8dad819c@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

io_expander7
- P1-5: MCU_GPIO
- P1-6: MCU_RST_N
- P1-7: MCU_RECOVERY_N

io_expander8
- P1-5: SEC_MCU_GPIO
- P1-6: SEC_MCU_RST_N
- P1-7: SEC_MCU_RECOVERY_N

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3a00182084a5..82835e96317d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -1024,7 +1024,7 @@ &io_expander7 {
 		"CX_TWARN_CX0_L","CX_TWARN_CX1_L",
 		"CX_OVT_SHDN_CX0","CX_OVT_SHDN_CX1",
 		"FNP_L_CX0","FNP_L_CX1",
-		"","","","";
+		"","MCU_GPIO","MCU_RST_N","MCU_RECOVERY_N";
 };
 
 &io_expander8 {
@@ -1035,7 +1035,7 @@ &io_expander8 {
 		"SEC_CX_TWARN_CX0_L","SEC_CX_TWARN_CX1_L",
 		"SEC_CX_OVT_SHDN_CX0","SEC_CX_OVT_SHDN_CX1",
 		"SEC_FNP_L_CX0","SEC_FNP_L_CX1",
-		"","","","";
+		"","SEC_MCU_GPIO","SEC_MCU_RST_N","SEC_MCU_RECOVERY_N";
 };
 
 &io_expander9 {

-- 
2.31.1


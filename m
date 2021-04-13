From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 14:43:06 -0500
Subject: [PATCH 2/4] ARM: dts: aspeed: Rainier: Fix humidity sensor bus address
In-Reply-To: <20210413194308.36930-1-eajames@linux.ibm.com>
References: <20210413194308.36930-1-eajames@linux.ibm.com>
Message-ID: <20210413194308.36930-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The si7021 was incorrectly placed at 0x20 on i2c bus 7. It is at 0x40.

Fixes: 9c44db7096e0 ("ARM: dts: aspeed: rainier: Add i2c devices")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 49419cd7f853..b13bd7ed18d1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -1201,9 +1201,9 @@ &i2c7 {
 	multi-master;
 	status = "okay";
 
-	si7021-a20 at 20 {
+	si7021-a20 at 40 {
 		compatible = "silabs,si7020";
-		reg = <0x20>;
+		reg = <0x40>;
 	};
 
 	tmp275 at 48 {
-- 
2.27.0


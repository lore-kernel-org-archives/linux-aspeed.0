From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 23 Feb 2023 09:48:26 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: bonnell: Update eeprom size
In-Reply-To: <20230223154826.4087138-1-eajames@linux.ibm.com>
References: <20230223154826.4087138-1-eajames@linux.ibm.com>
Message-ID: <20230223154826.4087138-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

An eeprom had an incorrect size.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
index a5be0ee048ec..a96feb42cbc2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -686,7 +686,7 @@ tmp275 at 48 {
 	};
 
 	eeprom at 50 {
-		compatible = "atmel,24c64";
+		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
 
-- 
2.31.1


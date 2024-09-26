From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:46 +0800
Subject: [PATCH v2 3/3] ARM: dts: aspeed: catalina: update NIC1 fru address
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
Message-ID: <20240926-catalina-evt-dvt-system-modify-v2-3-a861daeba059@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update NIC1 FRU EEPROM address to 0x52 based on EVT changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 9502d483e738..ac3e57e9c99e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -849,9 +849,9 @@ temperature-sensor at 1f {
 	};
 
 	// OCP NIC1 FRU EEPROM
-	eeprom at 50 {
+	eeprom at 52 {
 		compatible = "atmel,24c64";
-		reg = <0x50>;
+		reg = <0x52>;
 	};
 };
 

-- 
2.31.1


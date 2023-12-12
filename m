From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:51 +0800
Subject: [PATCH 02/11] ARM: dts: aspeed: minerva: Modify mac3 setting
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-3-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the unuse setting and fix the link to 100 M

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index c755fb3258a4..9979dba1ef0e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -48,10 +48,13 @@ &wdt1 {
 
 &mac3 {
 	status = "okay";
+	phy-mode = "rmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
-	use-ncsi;
-	mlx,multi-host;
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
 };
 
 &fmc {
-- 
2.34.1


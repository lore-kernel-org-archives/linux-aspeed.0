From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:52 +0800
Subject: [PATCH 03/11] ARM: dts: aspeed: minerva: Change sgpio use
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-4-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correct the sgpio use from sgpiom1 to sgpiom0

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 9979dba1ef0e..ad77057f921c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -78,7 +78,7 @@ &rtc {
 	status = "okay";
 };
 
-&sgpiom1 {
+&sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
 	bus-frequency = <2000000>;
-- 
2.34.1


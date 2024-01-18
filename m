From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 18 Jan 2024 14:00:41 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add mac config for Yosemite 4
Message-ID: <20240118060041.1923700-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add start-redo-probe and no-channel-monitor property in mac config
to fix Mellanox cx7 nic card cannot't get mac address after nic card
re-plug.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..33c01d79e5e0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -89,6 +89,8 @@ &mac2 {
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
 	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &mac3 {
@@ -97,6 +99,8 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
 	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &fmc {
-- 
2.25.1


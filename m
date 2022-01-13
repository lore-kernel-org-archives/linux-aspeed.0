From: Andrew Geissler <geissonator@gmail.com>
Date: Thu, 13 Jan 2022 15:17:34 -0600
Subject: [PATCH 1/2] ARM: dts: aspeed: rainier: add reset-cause-pinhole
Message-ID: <20220113211735.37861-1-geissonator@yahoo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This GPIO is used on the rainier system to indicate the BMC was reset
due to a physical pinhole reset.

See the following doc for more information:
https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index cfaa606666e2..7ea70c7d698f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -247,7 +247,8 @@ &gpio0 {
 	/*C0-C7*/	"","","","","","","","",
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
-	/*F0-F7*/	"","","battery-voltage-read-enable","","","","factory-reset-toggle","",
+	/*F0-F7*/	"","","battery-voltage-read-enable","reset-cause-pinhole","","",
+				"factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
 	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
 	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
-- 
2.25.1


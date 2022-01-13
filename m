From: Andrew Geissler <geissonator@gmail.com>
Date: Thu, 13 Jan 2022 15:17:35 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: everest: add reset-cause-pinhole
In-Reply-To: <20220113211735.37861-1-geissonator@yahoo.com>
References: <20220113211735.37861-1-geissonator@yahoo.com>
Message-ID: <20220113211735.37861-2-geissonator@yahoo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This GPIO is used on the everest system to indicate the BMC was reset
due to a physical pinhole reset.

It has been verified that the previous name for this pin has not been
utilized by userspace so the name change is ok.

See the following doc for more information:
https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index f48b33b0c606..6b5d5c56951f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -271,7 +271,7 @@ &gpio0 {
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"PIN_HOLE_RESET_IN_N","","battery-voltage-read-enable",
-				"PIN_HOLE_RESET_OUT_N","","",
+				"reset-cause-pinhole","","",
 				"factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
 	/*H0-H7*/	"led-rtc-battery","led-bmc","led-rear-enc-id0","led-rear-enc-fault0","","","","",
-- 
2.25.1


From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Wed, 27 Jan 2021 21:23:26 +0300
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Enable secondary LPC snooping
 address
Message-ID: <20210127182326.424-1-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AMD EthanolX CRB uses 2-byte POST codes which are sent to ports 0x80/0x81.
Currently ASPEED controller snoops only 0x80 port and therefore captures
only the lower byte of each POST code.
Enable secondary LPC snooping address to capture the higher byte of POST
codes.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 96ff0aea64e5..ac2d04cfaf2f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -218,7 +218,7 @@
 
 &lpc_snoop {
 	status = "okay";
-	snoop-ports = <0x80>;
+	snoop-ports = <0x80>, <0x81>;
 };
 
 &lpc_ctrl {
-- 
2.17.1


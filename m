From: Potin Lai <potin.lai@quantatw.com>
Date: Fri,  4 Mar 2022 08:35:06 +0800
Subject: [PATCH 1/1] ARM: dts: aspeed: bletchley: add sample averaging for
 ADM1278
Message-ID: <20220304003506.4243-1-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

set number of sample averaging to 128 for both PWR_AVG and VI_AVG

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index eaf1bc261ee3..be76cd955129 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -732,6 +732,8 @@
 		compatible = "adi,adm1278";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <300>;
+		adi,volt-curr-sample-average = <128>;
+		adi,power-sample-average = <128>;
 	};
 
 	tmp421 at 4c {
-- 
2.17.1


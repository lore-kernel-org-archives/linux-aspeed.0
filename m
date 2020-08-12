From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Aug 2020 20:54:00 +0930
Subject: [PATCH] ARM: aspeed: g5: Do not set sirq polarity
Message-ID: <20200812112400.2406734-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A feature was added to the aspeed vuart driver to configure the vuart
interrupt (sirq) polarity according to the LPC/eSPI strapping register.

Systems that depend on a active low behaviour (sirq_polarity set to 0)
such as OpenPower boxes also use LPC, so this relationship does not
hold.

The property was added for a Tyan S7106 system which is not supported
in the kernel tree. Should this or other systems wish to use this
feature of the driver they should add it to the machine specific device
tree.

Fixes: c791fc76bc72 ("arm: dts: aspeed: Add vuart aspeed,sirq-polarity-sense...")
Cc: stable at vger.kernel.org
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 27e5c5cf7712..664630a0e084 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -410,7 +410,6 @@ vuart: serial at 1e787000 {
 				interrupts = <8>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				no-loopback-test;
-				aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
 				status = "disabled";
 			};
 
-- 
2.28.0


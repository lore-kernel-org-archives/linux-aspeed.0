From: Oskar Senft <osk@google.com>
Date: Tue, 30 Jul 2019 21:34:04 -0400
Subject: [PATCH v2 3/3] arm: dts: aspeed: Add vuart espi-enabled to
 aspeed-g5.dtsi
In-Reply-To: <20190731013404.243755-1-osk@google.com>
References: <20190731013404.243755-1-osk@google.com>
Message-ID: <20190731013404.243755-3-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable auto-configuration of VUART SIRQ polarity on AST2500.

Signed-off-by: Oskar Senft <osk@google.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 01ffe70f64d5..9e561504042a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -351,6 +351,7 @@
 				interrupts = <8>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				no-loopback-test;
+				espi-enabled = <&syscon 0x70 25>;
 				status = "disabled";
 			};
 
-- 
2.22.0.709.g102302147b-goog


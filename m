From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 6 May 2021 18:03:10 +0800
Subject: [PATCH v3 3/5] ARM: dts: aspeed: ast2600evb: Add phase correction for
 emmc controller.
In-Reply-To: <20210506100312.1638-1-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
Message-ID: <20210506100312.1638-4-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set MMC timing-phase register by adding the phase correction binding in the
device tree.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 1ae0facc3d5f..fa63cb033c57 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -122,7 +122,8 @@
 &emmc {
 	non-removable;
 	bus-width = <4>;
-	max-frequency = <52000000>;
+	max-frequency = <100000000>;
+	clk-phase-mmc-hs200 = <9>, <225>;
 };
 
 &rtc {
-- 
2.17.1


From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 3 May 2021 09:43:35 +0800
Subject: [PATCH v2 2/3] ARM: dts: aspeed: ast2600evb: Add timing-phase
 property for eMMC controller
In-Reply-To: <20210503014336.20256-1-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
Message-ID: <20210503014336.20256-3-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set eMMC input clock phase to 3, which is more stable on AST2600 EVBs.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 2772796e215e..7a93317e27dc 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -102,6 +102,7 @@
 
 &emmc_controller {
 	status = "okay";
+	timing-phase = <0x300FF>;
 };
 
 &emmc {
-- 
2.17.1


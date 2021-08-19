From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 19 Aug 2021 16:00:38 +0800
Subject: [PATCH v2 3/5] clk: aspeed: Add eSPI reset bit
In-Reply-To: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210819080040.31242-4-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add bit field definition for the eSPI reset control

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 62b9520a00fd..964934b1caef 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -89,6 +89,7 @@
 #define ASPEED_CLK_MAC4RCLK		70
 
 /* Only list resets here that are not part of a gate */
+#define ASPEED_RESET_ESPI		57
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
 #define ASPEED_RESET_I3C_DMA		39
-- 
2.17.1


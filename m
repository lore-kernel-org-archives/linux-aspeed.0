From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu,  2 Mar 2023 08:58:34 +0800
Subject: [PATCH v5 6/6] dt-bindings: clock: ast2600: Expand comment on reset definitions
In-Reply-To: <20230302005834.13171-1-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au>
Message-ID: <20230302005834.13171-7-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current "not part of a gate" is a little ambiguous. Expand this a
little to clarify the reference to the paired clock + reset control.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/dt-bindings/clock/ast2600-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index b4d69103d722..e149eee61588 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -87,7 +87,7 @@
 #define ASPEED_CLK_MAC4RCLK		70
 #define ASPEED_CLK_I3C			71
 
-/* Only list resets here that are not part of a gate */
+/* Only list resets here that are not part of a clock gate + reset pair */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
 #define ASPEED_RESET_I3C_DMA		39
-- 
2.39.1


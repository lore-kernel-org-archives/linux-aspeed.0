From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 11:48:33 +0800
Subject: [PATCH 2/2] dts: ast2600: Add reset config for I3C
In-Reply-To: <cover.1676259904.git.jk@codeconstruct.com.au>
References: <cover.1676259904.git.jk@codeconstruct.com.au>
Message-ID: <ee5f26309453d6957b7908fd0db36728b20ea822.1676259904.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change adds the reset line definitions for the AST2600 I3C block's
reset inputs.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/dt-bindings/clock/ast2600-clock.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 98dc82702755..b3cc8c6fdcef 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -91,6 +91,12 @@
 /* Only list resets here that are not part of a gate */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
+#define ASPEED_RESET_I3C5		45
+#define ASPEED_RESET_I3C4		44
+#define ASPEED_RESET_I3C3		43
+#define ASPEED_RESET_I3C2		42
+#define ASPEED_RESET_I3C1		41
+#define ASPEED_RESET_I3C0		40
 #define ASPEED_RESET_I3C_DMA		39
 #define ASPEED_RESET_PWM		37
 #define ASPEED_RESET_PECI		36
-- 
2.39.1


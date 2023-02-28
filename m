From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 28 Feb 2023 17:16:37 +0800
Subject: [PATCH v4 4/5] dt-bindings: clock: ast2600: remove IC36 & I3C7 clock definitions
In-Reply-To: <20230228091638.206569-1-jk@codeconstruct.com.au>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
Message-ID: <20230228091638.206569-5-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current ast2600 clock definitions include entries for i3c6 and i3c7
devices, which don't exist: there are no clock control lines documented
for these, and only i3c devices 0 through 5 are present.

So, remove the definitions for I3C6 and I3C7. Although this is a
potential ABI-breaking change, there are no in-tree users of these, and
any references would be broken anyway, as the hardware doesn't exist.

This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
from Aspeed's own tree, originally by Dylan Hung
<dylan_hung@aspeedtech.com>.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v3:
 - split dt-bindings and clk changes
v2:
 - reword commit message
---
 include/dt-bindings/clock/ast2600-clock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index dd1581bfdf58..b4d69103d722 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -57,8 +57,6 @@
 #define ASPEED_CLK_GATE_I3C3CLK		40
 #define ASPEED_CLK_GATE_I3C4CLK		41
 #define ASPEED_CLK_GATE_I3C5CLK		42
-#define ASPEED_CLK_GATE_I3C6CLK		43
-#define ASPEED_CLK_GATE_I3C7CLK		44
 
 #define ASPEED_CLK_GATE_FSICLK		45
 
-- 
2.39.1


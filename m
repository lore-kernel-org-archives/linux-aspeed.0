From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 15:11:51 +1030
Subject: [PATCH 5/7] pinctrl: aspeed-g6: Make SIG_DESC_CLEAR() behave
 intuitively
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <20191008044153.12734-6-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signal descriptors can represent multi-bit bitfields and so have
explicit "enable" and "disable" states. However many descriptor
instances only describe a single bit, and so the SIG_DESC_SET() macro is
provides an abstraction for the single-bit cases: Its expansion
configures the "enable" state to set the bit and "disable" to clear.

SIG_DESC_CLEAR() was introduced to provide a similar single-bit
abstraction for for descriptors to clear the bit of interest. However
its behaviour was defined as the literal inverse of SIG_DESC_SET() - the
impact is the bit of interest is set in the disable path. This behaviour
isn't intuitive and doesn't align with how we want to use the macro in
practice, so make it clear the bit for both the enable and disable
paths.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index a2c0d52e4f7b..d5202241f411 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -508,7 +508,7 @@ struct aspeed_pin_desc {
  * @idx: The bit index in the register
  */
 #define SIG_DESC_SET(reg, idx) SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, 1)
-#define SIG_DESC_CLEAR(reg, idx) SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, 0)
+#define SIG_DESC_CLEAR(reg, idx) { ASPEED_IP_SCU, reg, BIT_MASK(idx), 0, 0 }
 
 #define SIG_DESC_LIST_SYM(sig, group) sig_descs_ ## sig ## _ ## group
 #define SIG_DESC_LIST_DECL(sig, group, ...) \
-- 
2.20.1


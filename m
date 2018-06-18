From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Jun 2018 22:15:06 +0930
Subject: [PATCH] pinctrl: aspeed: Fix documentation
Message-ID: <20180618124506.12961-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixes these warnings:

  pinctrl-aspeed.c:112: warning: Function parameter or member 'map' not
  described in 'aspeed_sig_desc_eval'
  pinctrl-aspeed.c:112: warning: Excess function parameter 'regmap'
  description in 'aspeed_sig_desc_eval'

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 7f13ce8450a3..aefe3c33dffd 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -95,7 +95,7 @@ static inline void aspeed_sig_desc_print_val(
  *
  * @desc: The signal descriptor of interest
  * @enabled: True to query the enabled state, false to query disabled state
- * @regmap: The IP block's regmap instance
+ * @map: The IP block's regmap instance
  *
  * Return: 1 if the descriptor's bitfield is configured to the state
  * selected by @enabled, 0 if not, and less than zero if an unrecoverable
@@ -594,7 +594,7 @@ static inline const struct aspeed_pin_config *find_pinconf_config(
 /**
  * @param: pinconf configuration parameter
  * @arg: The supported argument for @param, or -1 if any value is supported
- * @value: The register value to write to configure @arg for @param
+ * @val: The register value to write to configure @arg for @param
  *
  * The map is to be used in conjunction with the configuration array supplied
  * by the driver implementation.
-- 
2.17.1


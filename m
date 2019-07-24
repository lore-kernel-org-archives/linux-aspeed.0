From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 24 Jul 2019 17:43:12 +0930
Subject: [PATCH 2/3] pinctrl: aspeed: Document existence of deprecated
 compatibles
In-Reply-To: <20190724081313.12934-1-andrew@aj.id.au>
References: <20190724081313.12934-1-andrew@aj.id.au>
Message-ID: <20190724081313.12934-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Otherwise they look odd in the face of not being listed in the bindings
documents.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 4 ++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index 384396cbb22d..0e087fe759d2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2531,6 +2531,10 @@ static int aspeed_g4_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_g4_pinctrl_of_match[] = {
 	{ .compatible = "aspeed,ast2400-pinctrl", },
+	/*
+	 * The aspeed,g4-pinctrl compatible has been removed the from the
+	 * bindings, but keep the match in case of old devicetrees.
+	 */
 	{ .compatible = "aspeed,g4-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 053101f795a2..49255802735b 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2676,6 +2676,10 @@ static int aspeed_g5_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_g5_pinctrl_of_match[] = {
 	{ .compatible = "aspeed,ast2500-pinctrl", },
+	/*
+	 * The aspeed,g5-pinctrl compatible has been removed the from the
+	 * bindings, but keep the match in case of old devicetrees.
+	 */
 	{ .compatible = "aspeed,g5-pinctrl", },
 	{ },
 };
-- 
2.20.1


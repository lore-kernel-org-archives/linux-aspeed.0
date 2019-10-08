From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 15:11:48 +1030
Subject: [PATCH 2/7] pinctrl: aspeed-g6: Sort pins for sanity
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <20191008044153.12734-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some pins crept in that weren't ordered in the list.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 648ddb7f038a..ff208b7c75a8 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -1574,6 +1574,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(A3),
 	ASPEED_PINCTRL_PIN(AA11),
 	ASPEED_PINCTRL_PIN(AA12),
+	ASPEED_PINCTRL_PIN(AA16),
+	ASPEED_PINCTRL_PIN(AA17),
 	ASPEED_PINCTRL_PIN(AA23),
 	ASPEED_PINCTRL_PIN(AA24),
 	ASPEED_PINCTRL_PIN(AA25),
@@ -1585,6 +1587,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AB11),
 	ASPEED_PINCTRL_PIN(AB12),
 	ASPEED_PINCTRL_PIN(AB15),
+	ASPEED_PINCTRL_PIN(AB16),
+	ASPEED_PINCTRL_PIN(AB17),
 	ASPEED_PINCTRL_PIN(AB18),
 	ASPEED_PINCTRL_PIN(AB19),
 	ASPEED_PINCTRL_PIN(AB22),
@@ -1602,6 +1606,7 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AC11),
 	ASPEED_PINCTRL_PIN(AC12),
 	ASPEED_PINCTRL_PIN(AC15),
+	ASPEED_PINCTRL_PIN(AC16),
 	ASPEED_PINCTRL_PIN(AC17),
 	ASPEED_PINCTRL_PIN(AC18),
 	ASPEED_PINCTRL_PIN(AC19),
@@ -1619,6 +1624,7 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AD12),
 	ASPEED_PINCTRL_PIN(AD14),
 	ASPEED_PINCTRL_PIN(AD15),
+	ASPEED_PINCTRL_PIN(AD16),
 	ASPEED_PINCTRL_PIN(AD19),
 	ASPEED_PINCTRL_PIN(AD20),
 	ASPEED_PINCTRL_PIN(AD22),
@@ -1634,8 +1640,11 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AE12),
 	ASPEED_PINCTRL_PIN(AE14),
 	ASPEED_PINCTRL_PIN(AE15),
+	ASPEED_PINCTRL_PIN(AE16),
 	ASPEED_PINCTRL_PIN(AE18),
 	ASPEED_PINCTRL_PIN(AE19),
+	ASPEED_PINCTRL_PIN(AE25),
+	ASPEED_PINCTRL_PIN(AE26),
 	ASPEED_PINCTRL_PIN(AE7),
 	ASPEED_PINCTRL_PIN(AE8),
 	ASPEED_PINCTRL_PIN(AF10),
@@ -1643,6 +1652,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AF12),
 	ASPEED_PINCTRL_PIN(AF14),
 	ASPEED_PINCTRL_PIN(AF15),
+	ASPEED_PINCTRL_PIN(AF24),
+	ASPEED_PINCTRL_PIN(AF25),
 	ASPEED_PINCTRL_PIN(AF7),
 	ASPEED_PINCTRL_PIN(AF8),
 	ASPEED_PINCTRL_PIN(AF9),
@@ -1792,17 +1803,6 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(Y3),
 	ASPEED_PINCTRL_PIN(Y4),
 	ASPEED_PINCTRL_PIN(Y5),
-	ASPEED_PINCTRL_PIN(AB16),
-	ASPEED_PINCTRL_PIN(AA17),
-	ASPEED_PINCTRL_PIN(AB17),
-	ASPEED_PINCTRL_PIN(AE16),
-	ASPEED_PINCTRL_PIN(AC16),
-	ASPEED_PINCTRL_PIN(AA16),
-	ASPEED_PINCTRL_PIN(AD16),
-	ASPEED_PINCTRL_PIN(AF25),
-	ASPEED_PINCTRL_PIN(AE26),
-	ASPEED_PINCTRL_PIN(AE25),
-	ASPEED_PINCTRL_PIN(AF24),
 };
 
 static const struct aspeed_pin_group aspeed_g6_groups[] = {
-- 
2.20.1


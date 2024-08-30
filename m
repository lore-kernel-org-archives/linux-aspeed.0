From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 30 Aug 2024 11:40:45 +0800
Subject: [PATCH v2 2/4] gpio: aspeed: Remove the name for bank array
In-Reply-To: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
Message-ID: <20240830034047.2251482-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bank array name is only used to determine if the GPIO offset is valid,
and this condition can be replaced by checking if the offset exceeds the
ngpio property.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 04c03402db6d..24f50a0ea4ab 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -77,7 +77,6 @@ struct aspeed_gpio_bank {
 	uint16_t	debounce_regs;
 	uint16_t	tolerance_regs;
 	uint16_t	cmdsrc_regs;
-	const char	names[4][3];
 };
 
 /*
@@ -104,7 +103,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0040,
 		.tolerance_regs = 0x001c,
 		.cmdsrc_regs = 0x0060,
-		.names = { "A", "B", "C", "D" },
 	},
 	{
 		.val_regs = 0x0020,
@@ -113,7 +111,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0048,
 		.tolerance_regs = 0x003c,
 		.cmdsrc_regs = 0x0068,
-		.names = { "E", "F", "G", "H" },
 	},
 	{
 		.val_regs = 0x0070,
@@ -122,7 +119,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x00b0,
 		.tolerance_regs = 0x00ac,
 		.cmdsrc_regs = 0x0090,
-		.names = { "I", "J", "K", "L" },
 	},
 	{
 		.val_regs = 0x0078,
@@ -131,7 +127,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0100,
 		.tolerance_regs = 0x00fc,
 		.cmdsrc_regs = 0x00e0,
-		.names = { "M", "N", "O", "P" },
 	},
 	{
 		.val_regs = 0x0080,
@@ -140,7 +135,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0130,
 		.tolerance_regs = 0x012c,
 		.cmdsrc_regs = 0x0110,
-		.names = { "Q", "R", "S", "T" },
 	},
 	{
 		.val_regs = 0x0088,
@@ -149,7 +143,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0160,
 		.tolerance_regs = 0x015c,
 		.cmdsrc_regs = 0x0140,
-		.names = { "U", "V", "W", "X" },
 	},
 	{
 		.val_regs = 0x01E0,
@@ -158,7 +151,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x0190,
 		.tolerance_regs = 0x018c,
 		.cmdsrc_regs = 0x0170,
-		.names = { "Y", "Z", "AA", "AB" },
 	},
 	{
 		.val_regs = 0x01e8,
@@ -167,7 +159,6 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.debounce_regs = 0x01c0,
 		.tolerance_regs = 0x01bc,
 		.cmdsrc_regs = 0x01a0,
-		.names = { "AC", "", "", "" },
 	},
 };
 
@@ -280,11 +271,11 @@ static inline const struct aspeed_bank_props *find_bank_props(
 static inline bool have_gpio(struct aspeed_gpio *gpio, unsigned int offset)
 {
 	const struct aspeed_bank_props *props = find_bank_props(gpio, offset);
-	const struct aspeed_gpio_bank *bank = to_bank(offset);
-	unsigned int group = GPIO_OFFSET(offset) / 8;
 
-	return bank->names[group][0] != '\0' &&
-		(!props || ((props->input | props->output) & GPIO_BIT(offset)));
+	if (offset > gpio->chip.ngpio)
+		return false;
+
+	return (!props || ((props->input | props->output) & GPIO_BIT(offset)));
 }
 
 static inline bool have_input(struct aspeed_gpio *gpio, unsigned int offset)
-- 
2.25.1


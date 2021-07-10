From: Sasha Levin <sashal@kernel.org>
Date: Fri,  9 Jul 2021 22:23:42 -0400
Subject: [PATCH AUTOSEL 5.10 48/93] fsi: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
Message-ID: <20210710022428.3169839-48-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit 19a52178125c1e8b84444d85f2ce34c0964b4a91 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Link: https://lore.kernel.org/r/1620896249-52769-1-git-send-email-zou_wei at huawei.com
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fsi/fsi-master-aspeed.c | 1 +
 drivers/fsi/fsi-master-ast-cf.c | 1 +
 drivers/fsi/fsi-master-gpio.c   | 1 +
 drivers/fsi/fsi-occ.c           | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 90dbe58ca1ed..dbad73162c83 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -645,6 +645,7 @@ static const struct of_device_id fsi_master_aspeed_match[] = {
 	{ .compatible = "aspeed,ast2600-fsi-master" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, fsi_master_aspeed_match);
 
 static struct platform_driver fsi_master_aspeed_driver = {
 	.driver = {
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 57a779a89b07..70c03e304d6c 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1427,6 +1427,7 @@ static const struct of_device_id fsi_master_acf_match[] = {
 	{ .compatible = "aspeed,ast2500-cf-fsi-master" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, fsi_master_acf_match);
 
 static struct platform_driver fsi_master_acf = {
 	.driver = {
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index aa97c4a250cb..7d5f29b4b595 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -882,6 +882,7 @@ static const struct of_device_id fsi_master_gpio_match[] = {
 	{ .compatible = "fsi-master-gpio" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, fsi_master_gpio_match);
 
 static struct platform_driver fsi_master_gpio_driver = {
 	.driver = {
diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 9eeb856c8905..01eb04d52bf0 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -578,6 +578,7 @@ static const struct of_device_id occ_match[] = {
 	{ .compatible = "ibm,p9-occ" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, occ_match);
 
 static struct platform_driver occ_driver = {
 	.driver = {
-- 
2.30.2


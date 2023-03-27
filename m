From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 27 Mar 2023 15:43:15 -0700
Subject: [PATCH] peci: Constify struct peci_controller_ops
Message-ID: <20230327224315.11135-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As with most ops structs, we never modify it at runtime, and keeping
function pointers in read-only memory is generally a good thing
security-wise.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/peci/controller/peci-aspeed.c | 2 +-
 drivers/peci/core.c                   | 4 ++--
 include/linux/peci.h                  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 731c5d8f75c6..7fdc25afcf2f 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -468,7 +468,7 @@ static void aspeed_peci_property_setup(struct aspeed_peci *priv)
 				      ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT, &priv->cmd_timeout_ms);
 }
 
-static struct peci_controller_ops aspeed_ops = {
+static const struct peci_controller_ops aspeed_ops = {
 	.xfer = aspeed_peci_xfer,
 };
 
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 9c8cf07e51c7..0f83a9c6093b 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -44,7 +44,7 @@ int peci_controller_scan_devices(struct peci_controller *controller)
 }
 
 static struct peci_controller *peci_controller_alloc(struct device *dev,
-						     struct peci_controller_ops *ops)
+						     const struct peci_controller_ops *ops)
 {
 	struct peci_controller *controller;
 	int ret;
@@ -113,7 +113,7 @@ static void unregister_controller(void *_controller)
  * Return: Pointer to the newly allocated controller or ERR_PTR() in case of failure.
  */
 struct peci_controller *devm_peci_controller_add(struct device *dev,
-						 struct peci_controller_ops *ops)
+						 const struct peci_controller_ops *ops)
 {
 	struct peci_controller *controller;
 	int ret;
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 06e6ef935297..9b3d36aff431 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -42,13 +42,13 @@ struct peci_controller_ops {
  */
 struct peci_controller {
 	struct device dev;
-	struct peci_controller_ops *ops;
+	const struct peci_controller_ops *ops;
 	struct mutex bus_lock; /* held for the duration of xfer */
 	u8 id;
 };
 
 struct peci_controller *devm_peci_controller_add(struct device *parent,
-						 struct peci_controller_ops *ops);
+						 const struct peci_controller_ops *ops);
 
 static inline struct peci_controller *to_peci_controller(void *d)
 {
-- 
2.40.0.5.gf6e3b97ba6d2.dirty


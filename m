From: Juerg Haefliger <juerg.haefliger@canonical.com>
Date: Tue, 11 May 2021 08:18:12 +0200
Subject: [PATCH] watchdog: Use sysfs_emit() and sysfs_emit_at() in "show"
 functions
Message-ID: <20210511061812.480172-1-juergh@canonical.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert sprintf() in sysfs "show" functions to sysfs_emit() and
sysfs_emit_at() in order to check for buffer overruns in sysfs outputs.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/watchdog/aspeed_wdt.c          |  4 ++--
 drivers/watchdog/watchdog_dev.c        | 19 ++++++++++---------
 drivers/watchdog/watchdog_pretimeout.c |  4 ++--
 drivers/watchdog/ziirave_wdt.c         | 12 +++++++-----
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 7e00960651fa..933998e5a9de 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -175,8 +175,8 @@ static ssize_t access_cs0_show(struct device *dev,
 	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
 	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
 
-	return sprintf(buf, "%u\n",
-		      !(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
+	return sysfs_emit(buf, "%u\n",
+			  !(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
 }
 
 static ssize_t access_cs0_store(struct device *dev,
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 2946f3a63110..fe68a97973a5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -451,7 +451,8 @@ static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT, &wdd->status));
+	return sysfs_emit(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT,
+						  &wdd->status));
 }
 
 static ssize_t nowayout_store(struct device *dev, struct device_attribute *attr,
@@ -485,7 +486,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_status(wdd);
 	mutex_unlock(&wd_data->lock);
 
-	return sprintf(buf, "0x%x\n", status);
+	return sysfs_emit(buf, "0x%x\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -494,7 +495,7 @@ static ssize_t bootstatus_show(struct device *dev,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->bootstatus);
+	return sysfs_emit(buf, "%u\n", wdd->bootstatus);
 }
 static DEVICE_ATTR_RO(bootstatus);
 
@@ -510,7 +511,7 @@ static ssize_t timeleft_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_timeleft(wdd, &val);
 	mutex_unlock(&wd_data->lock);
 	if (!status)
-		status = sprintf(buf, "%u\n", val);
+		status = sysfs_emit(buf, "%u\n", val);
 
 	return status;
 }
@@ -521,7 +522,7 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->timeout);
+	return sysfs_emit(buf, "%u\n", wdd->timeout);
 }
 static DEVICE_ATTR_RO(timeout);
 
@@ -530,7 +531,7 @@ static ssize_t pretimeout_show(struct device *dev,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", wdd->pretimeout);
+	return sysfs_emit(buf, "%u\n", wdd->pretimeout);
 }
 static DEVICE_ATTR_RO(pretimeout);
 
@@ -539,7 +540,7 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", wdd->info->identity);
+	return sysfs_emit(buf, "%s\n", wdd->info->identity);
 }
 static DEVICE_ATTR_RO(identity);
 
@@ -549,9 +550,9 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
 	if (watchdog_active(wdd))
-		return sprintf(buf, "active\n");
+		return sysfs_emit(buf, "active\n");
 
-	return sprintf(buf, "inactive\n");
+	return sysfs_emit(buf, "inactive\n");
 }
 static DEVICE_ATTR_RO(state);
 
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 01ca84be240f..7f257c3485cd 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -55,7 +55,7 @@ int watchdog_pretimeout_available_governors_get(char *buf)
 	mutex_lock(&governor_lock);
 
 	list_for_each_entry(priv, &governor_list, entry)
-		count += sprintf(buf + count, "%s\n", priv->gov->name);
+		count += sysfs_emit_at(buf, count, "%s\n", priv->gov->name);
 
 	mutex_unlock(&governor_lock);
 
@@ -68,7 +68,7 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 
 	spin_lock_irq(&pretimeout_lock);
 	if (wdd->gov)
-		count = sprintf(buf, "%s\n", wdd->gov->name);
+		count = sysfs_emit(buf, "%s\n", wdd->gov->name);
 	spin_unlock_irq(&pretimeout_lock);
 
 	return count;
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 4297280807ca..6c9414d09684 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -445,8 +445,9 @@ static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, ZIIRAVE_FW_VERSION_FMT, w_priv->firmware_rev.major,
-		      w_priv->firmware_rev.minor);
+	ret = sysfs_emit(buf, ZIIRAVE_FW_VERSION_FMT,
+			 w_priv->firmware_rev.major,
+			 w_priv->firmware_rev.minor);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
@@ -468,8 +469,9 @@ static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, ZIIRAVE_BL_VERSION_FMT, w_priv->bootloader_rev.major,
-		      w_priv->bootloader_rev.minor);
+	ret = sysfs_emit(buf, ZIIRAVE_BL_VERSION_FMT,
+			 w_priv->bootloader_rev.major,
+			 w_priv->bootloader_rev.minor);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
@@ -491,7 +493,7 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
+	ret = sysfs_emit(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
 
 	mutex_unlock(&w_priv->sysfs_mutex);
 
-- 
2.27.0


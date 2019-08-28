From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Wed, 28 Aug 2019 13:24:01 +0300
Subject: [PATCH v4 3/4] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190828102402.13155-1-i.mikhaylov@yadro.com>
References: <20190828102402.13155-1-i.mikhaylov@yadro.com>
Message-ID: <20190828102402.13155-4-i.mikhaylov@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
to clear out boot code source and re-enable access to the primary SPI flash
chip while booted via wdt2 from the alternate chip.

AST2400 datasheet says:
"In the 2nd flash booting mode, all the address mapping to CS0# would be
re-directed to CS1#. And CS0# is not accessible under this mode. To access
CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
register WDT30.bit[1]."

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/watchdog/aspeed_wdt.c | 65 ++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index cc71861e033a..125dbd349b00 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -53,6 +53,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_CTRL_ENABLE		BIT(0)
 #define WDT_TIMEOUT_STATUS	0x10
 #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
+#define WDT_CLEAR_TIMEOUT_STATUS	0x14
+#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -165,6 +167,60 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+/* access_cs0 shows if cs0 is accessible, hence the reverted bit */
+static ssize_t access_cs0_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
+	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
+
+	return sprintf(buf, "%u\n",
+		      !(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
+}
+
+static ssize_t access_cs0_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t size)
+{
+	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val)
+		writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
+		       wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
+
+	return size;
+}
+
+/*
+ * This attribute exists only if the system has booted from the alternate
+ * flash with 'alt-boot' option.
+ *
+ * At alternate flash the 'access_cs0' sysfs node provides:
+ *   ast2400: a way to get access to the primary SPI flash chip at CS0
+ *            after booting from the alternate chip at CS1.
+ *   ast2500: a way to restore the normal address mapping from
+ *            (CS0->CS1, CS1->CS0) to (CS0->CS0, CS1->CS1).
+ *
+ * Clearing the boot code selection and timeout counter also resets to the
+ * initial state the chip select line mapping. When the SoC is in normal
+ * mapping state (i.e. booted from CS0), clearing those bits does nothing for
+ * both versions of the SoC. For alternate boot mode (booted from CS1 due to
+ * wdt2 expiration) the behavior differs as described above.
+ *
+ * This option can be used with wdt2 (watchdog1) only.
+ */
+static DEVICE_ATTR_RW(access_cs0);
+
+static struct attribute *bswitch_attrs[] = {
+	&dev_attr_access_cs0.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(bswitch);
+
 static const struct watchdog_ops aspeed_wdt_ops = {
 	.start		= aspeed_wdt_start,
 	.stop		= aspeed_wdt_stop,
@@ -306,9 +362,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
+	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
+		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
+		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
+			wdt->wdd.groups = bswitch_groups;
+	}
+
+	dev_set_drvdata(dev, wdt);
+
 	return devm_watchdog_register_device(dev, &wdt->wdd);
 }
 
-- 
2.20.1


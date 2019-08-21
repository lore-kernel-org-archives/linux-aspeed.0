From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Wed, 21 Aug 2019 18:57:43 +0300
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
Message-ID: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
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
re-directed to CS1#. And CS0# is not accessable under this mode. To access
CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
register WDT30.bit[1]."

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/watchdog/aspeed_wdt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index cc71861e033a..858e62f1c7ba 100644
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
@@ -165,6 +167,29 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	return 0;
 }
 
+static ssize_t access_cs0_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
+
+	if (unlikely(!wdt))
+		return -ENODEV;
+
+	writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
+			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
+	wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+
+	return size;
+}
+static DEVICE_ATTR_WO(access_cs0);
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
@@ -223,6 +248,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
 
+	if (of_property_read_bool(np, "aspeed,alt-boot"))
+		wdt->wdd.groups = bswitch_groups;
+
 	/*
 	 * Control reset on a per-device basis to ensure the
 	 * host is not affected by a BMC reboot
@@ -309,6 +337,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
+	dev_set_drvdata(dev, wdt);
+
 	return devm_watchdog_register_device(dev, &wdt->wdd);
 }
 
-- 
2.20.1



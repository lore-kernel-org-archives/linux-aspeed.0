From: Jian Zhang <zhangjian.3032@bytedance.com>
Date: Sun,  1 May 2022 18:56:44 +0800
Subject: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for flash
 toggle
Message-ID: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement the flash toggle function in soc ast2600.
Add two sysfs attrs named "access_primary" and "access_backup"

attr "access_primary": Appears only in the backup flash startup
store: Non-zero values will clear "Boot Flash source select indicator"
to '0', the next reboot will boot from primary flash. Nothing will be
done at 0.
show: 0 means the next reboot will boot from primary, 1 will boot from
backup.

attr "access_backup": Appears only in the primary flash startup
store: Non-zero values are the timeout time for abr WDT, WDT will be
turned on immediately if written. The maximum value is 0x3ff, and unit
is "0.1s". zero value will disable WDT.
show: the time left(unit is 0.1s) in WDT timer. 0 means timer is not
enabled. Thus, A non-zero value means that waiting until the WTD times
out will automatically start from the backup.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/spi/spi-aspeed.c              | 62 ++++++++++++++++++
 include/linux/soc/aspeed/aspeed-abr.h | 93 +++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 include/linux/soc/aspeed/aspeed-abr.h

diff --git a/drivers/spi/spi-aspeed.c b/drivers/spi/spi-aspeed.c
index 909b5fb175d6..abe3bfe2bd42 100644
--- a/drivers/spi/spi-aspeed.c
+++ b/drivers/spi/spi-aspeed.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/soc/aspeed/aspeed-abr.h>
 
 /* ASPEED FMC/SPI memory control register related */
 #define OFFSET_CE_TYPE_SETTING		0x00
@@ -127,6 +128,54 @@ struct aspeed_spi_controller {
 	spinlock_t lock;
 };
 
+static ssize_t access_primary_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_primary_show(ast_ctrl->regs, attr, buf);
+}
+
+static ssize_t access_primary_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_primary_store(ast_ctrl->regs, attr, buf, size);
+}
+
+static ssize_t access_backup_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_backup_show(ast_ctrl->regs, attr, buf);
+}
+
+static ssize_t access_backup_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_backup_store(ast_ctrl->regs, attr, buf, size);
+}
+
+static DEVICE_ATTR_RW(access_primary);
+static DEVICE_ATTR_RW(access_backup);
+
+static struct attribute *bswitch_primary_attrs[] = {
+	&dev_attr_access_primary.attr, NULL
+};
+
+static struct attribute *bswitch_backup_attrs[] = {
+	&dev_attr_access_backup.attr, NULL
+};
+
+ATTRIBUTE_GROUPS(bswitch_primary);
+ATTRIBUTE_GROUPS(bswitch_backup);
+
 static uint32_t
 aspeed_2600_spi_segment_start(struct aspeed_spi_controller *ast_ctrl,
 			      uint32_t reg)
@@ -1393,6 +1442,19 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto end;
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-fmc")) {
+		/* if boot from alt source, show access_primary, otherwise show access_backup */
+		if (readl(ast_ctrl->regs + OFFSET_ABR_CTRL_STATUS) &
+		    ABR_BOOT_SRC_INDICATE) {
+
+			if (devm_device_add_groups(dev, bswitch_primary_groups))
+				dev_warn(dev, "Could not add access_primary\n");
+		} else {
+			if (devm_device_add_groups(dev, bswitch_backup_groups))
+				dev_warn(dev, "Could not add access_backup\n");
+		}
+	}
+
 	ret = devm_spi_register_master(dev, spi_ctrl);
 
 end:
diff --git a/include/linux/soc/aspeed/aspeed-abr.h b/include/linux/soc/aspeed/aspeed-abr.h
new file mode 100644
index 000000000000..3542f76e0232
--- /dev/null
+++ b/include/linux/soc/aspeed/aspeed-abr.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASPEED_ABR_H__
+#define __ASPEED_ABR_H__
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/io.h>
+
+#define OFFSET_ABR_CTRL_STATUS 0x64
+#define OFFSET_ABR_TIMER_RELOAD 0x68
+#define OFFSET_ABR_TIMER_RESTART 0x6c
+
+#define ABR_WDT_ENABLE BIT(0)
+#define ABR_BOOT_SRC_INDICATE BIT(4)
+#define ABR_RESTART_MAGIC 0x4755
+#define ABR_CLEAR_BOOT_SRC_MAGIC (0xEA << 16)
+#define ABR_RELOAD_MAX_VALUE 0x3ff
+
+static inline ssize_t _access_primary_show(void __iomem *regs,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	u32 status = readl(regs + OFFSET_ABR_CTRL_STATUS);
+
+	return sysfs_emit(buf, "%u\n", !(status & ABR_BOOT_SRC_INDICATE));
+}
+
+static inline ssize_t _access_primary_store(void __iomem *regs,
+					    struct device_attribute *attr,
+					    const char *buf, size_t size)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	/* write bit[23:16] = 0xEA */
+	if (val)
+		writel(readl(regs + OFFSET_ABR_CTRL_STATUS) |
+			       ABR_CLEAR_BOOT_SRC_MAGIC,
+		       regs + OFFSET_ABR_CTRL_STATUS);
+
+	return size;
+}
+
+static inline ssize_t _access_backup_show(void __iomem *regs,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	u32 status = readl(regs + OFFSET_ABR_CTRL_STATUS);
+	u32 timer_reload = readl(regs + OFFSET_ABR_TIMER_RELOAD);
+
+	if (!(status & ABR_WDT_ENABLE))
+		return sysfs_emit(buf, "%u\n", 0);
+	/* [31:16] Counter value status */
+	return sysfs_emit(buf, "%u\n", timer_reload >> 16);
+}
+
+static inline ssize_t _access_backup_store(void __iomem *regs,
+					   struct device_attribute *attr,
+					   const char *buf, size_t size)
+{
+	unsigned long count;
+
+	if (kstrtoul(buf, 10, &count))
+		return -EINVAL;
+
+	/* disable watchdog */
+	if (count == 0) {
+		writel(0, regs + OFFSET_ABR_CTRL_STATUS);
+		return size;
+	}
+
+	/*
+	 * bit[12:0] : Reload value of expire time
+	 * The time unit is 0.1 second. Default set at 22 seconds
+	 * 0: Immediately timeout
+	 */
+	count = count < ABR_RELOAD_MAX_VALUE ? count : ABR_RELOAD_MAX_VALUE;
+
+	writel(0, regs + OFFSET_ABR_CTRL_STATUS);
+	writel(count, regs + OFFSET_ABR_TIMER_RELOAD);
+
+	/* Write 0x4755 value to load the reload value into watchdog counter */
+	writel(ABR_RESTART_MAGIC, regs + OFFSET_ABR_TIMER_RESTART);
+
+	/* Enable watchdog */
+	writel(ABR_WDT_ENABLE, regs + OFFSET_ABR_CTRL_STATUS);
+	return size;
+}
+
+#endif
-- 
2.25.1


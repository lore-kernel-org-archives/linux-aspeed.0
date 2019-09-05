From: Oskar Senft <osk@google.com>
Date: Thu,  5 Sep 2019 10:41:28 -0400
Subject: [PATCH v3 1/3] drivers/tty/serial/8250: Make Aspeed VUART SIRQ
 polarity configurable
Message-ID: <20190905144130.220713-1-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make the SIRQ polarity for Aspeed AST24xx/25xx VUART configurable via
sysfs. This setting need to be changed on specific host platforms
depending on the selected host interface (LPC / eSPI).

The setting is configurable via sysfs rather than device-tree to stay in
line with other related configurable settings.

On AST2500 the VUART SIRQ polarity can be auto-configured by reading a
bit from a configuration register, e.g. the LPC/eSPI interface
configuration bit.

Tested: Verified on TYAN S7106 mainboard.
Signed-off-by: Oskar Senft <osk@google.com>
---
 .../ABI/stable/sysfs-driver-aspeed-vuart      | 11 ++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c   | 84 +++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  1 +
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
index 8062953ce77b..950cafc9443a 100644
--- a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
+++ b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
@@ -6,10 +6,19 @@ Description:	Configures which IO port the host side of the UART
 Users:		OpenBMC.  Proposed changes should be mailed to
 		openbmc at lists.ozlabs.org
 
-What:		/sys/bus/platform/drivers/aspeed-vuart*/sirq
+What:		/sys/bus/platform/drivers/aspeed-vuart/*/sirq
 Date:		April 2017
 Contact:	Jeremy Kerr <jk@ozlabs.org>
 Description:	Configures which interrupt number the host side of
 		the UART will appear on the host <-> BMC LPC bus.
 Users:		OpenBMC.  Proposed changes should be mailed to
 		openbmc at lists.ozlabs.org
+
+What:		/sys/bus/platform/drivers/aspeed-vuart/*/sirq_polarity
+Date:		July 2019
+Contact:	Oskar Senft <osk@google.com>
+Description:	Configures the polarity of the serial interrupt to the
+		host via the BMC LPC bus.
+		Set to 0 for active-low or 1 for active-high.
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc at lists.ozlabs.org
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 0438d9a905ce..6e67fd89445a 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -14,6 +14,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/clk.h>
@@ -22,6 +24,7 @@
 
 #define ASPEED_VUART_GCRA		0x20
 #define ASPEED_VUART_GCRA_VUART_EN		BIT(0)
+#define ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY	BIT(1)
 #define ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD BIT(5)
 #define ASPEED_VUART_GCRB		0x24
 #define ASPEED_VUART_GCRB_HOST_SIRQ_MASK	GENMASK(7, 4)
@@ -131,8 +134,53 @@ static ssize_t sirq_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(sirq);
 
+static ssize_t sirq_polarity_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
+	u8 reg;
+
+	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
+}
+
+static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
+					   bool polarity)
+{
+	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+
+	if (polarity)
+		reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
+	else
+		reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
+
+	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+}
+
+static ssize_t sirq_polarity_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 0, &val);
+	if (err)
+		return err;
+
+	aspeed_vuart_set_sirq_polarity(vuart, val != 0);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(sirq_polarity);
+
 static struct attribute *aspeed_vuart_attrs[] = {
 	&dev_attr_sirq.attr,
+	&dev_attr_sirq_polarity.attr,
 	&dev_attr_lpc_address.attr,
 	NULL,
 };
@@ -302,8 +350,30 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void aspeed_vuart_auto_configure_sirq_polarity(
+	struct aspeed_vuart *vuart, struct device_node *syscon_np,
+	u32 reg_offset, u32 reg_mask)
+{
+	struct regmap *regmap;
+	u32 value;
+
+	regmap = syscon_node_to_regmap(syscon_np);
+	if (IS_ERR(regmap)) {
+		dev_warn(vuart->dev,
+			 "could not get regmap for aspeed,sirq-polarity-sense\n");
+		return;
+	}
+	if (regmap_read(regmap, reg_offset, &value)) {
+		dev_warn(vuart->dev, "could not read hw strap table\n");
+		return;
+	}
+
+	aspeed_vuart_set_sirq_polarity(vuart, (value & reg_mask) == 0);
+}
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
+	struct of_phandle_args sirq_polarity_sense_args;
 	struct uart_8250_port port;
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
@@ -402,6 +472,20 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	vuart->line = rc;
 
+	rc = of_parse_phandle_with_fixed_args(
+		np, "aspeed,sirq-polarity-sense", 2, 0,
+		&sirq_polarity_sense_args);
+	if (rc < 0) {
+		dev_dbg(&pdev->dev,
+			"aspeed,sirq-polarity-sense property not found\n");
+	} else {
+		aspeed_vuart_auto_configure_sirq_polarity(
+			vuart, sirq_polarity_sense_args.np,
+			sirq_polarity_sense_args.args[0],
+			BIT(sirq_polarity_sense_args.args[1]));
+		of_node_put(sirq_polarity_sense_args.np);
+	}
+
 	aspeed_vuart_set_enabled(vuart, true);
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 509f6a3bb9ff..98e25781a293 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -243,6 +243,7 @@ config SERIAL_8250_ASPEED_VUART
 	tristate "Aspeed Virtual UART"
 	depends on SERIAL_8250
 	depends on OF
+	depends on REGMAP && MFD_SYSCON
 	help
 	  If you want to use the virtual UART (VUART) device on Aspeed
 	  BMC platforms, enable this option. This enables the 16550A-
-- 
2.23.0.187.g17f5b7556c-goog


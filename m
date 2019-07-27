From: Oskar Senft <osk@google.com>
Date: Sat, 27 Jul 2019 09:42:42 -0400
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity
 configurable
Message-ID: <20190727134242.49847-1-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make the SIRQ polarity for Aspeed 24xx/25xx VUART configurable via
sysfs. It is required on some host platforms (e.g. TYAN S7106) to
reconfigure this setting from the default to enable the host to receive
interrupts from the VUART.

The setting is configurable via sysfs rather than device-tree to stay in
line with other related configurable settings.

Tested: Verified on TYAN S7106 mainboard.
Signed-off-by: Oskar Senft <osk@google.com>
---
 .../ABI/stable/sysfs-driver-aspeed-vuart      | 10 ++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c   | 39 +++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
index 8062953ce77b..64fad87ad964 100644
--- a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
+++ b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
@@ -6,10 +6,18 @@ Description:	Configures which IO port the host side of the UART
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
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc at lists.ozlabs.org
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 0438d9a905ce..ef0a6ff69841 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -22,6 +22,7 @@
 
 #define ASPEED_VUART_GCRA		0x20
 #define ASPEED_VUART_GCRA_VUART_EN		BIT(0)
+#define ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY	BIT(1)
 #define ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD BIT(5)
 #define ASPEED_VUART_GCRB		0x24
 #define ASPEED_VUART_GCRB_HOST_SIRQ_MASK	GENMASK(7, 4)
@@ -131,8 +132,46 @@ static ssize_t sirq_store(struct device *dev, struct device_attribute *attr,
 
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
+static ssize_t sirq_polarity_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+	u8 reg;
+
+	err = kstrtoul(buf, 0, &val);
+	if (err)
+		return err;
+
+	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	if (val != 0)
+		reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
+	else
+		reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
+	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
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
-- 
2.22.0.709.g102302147b-goog


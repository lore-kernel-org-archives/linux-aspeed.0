From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Feb 2024 16:19:19 +0200
Subject: [PATCH v2 03/14] serial: port: Introduce a common helper to read properties
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240226142514.1485246-4-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several serial drivers want to read the same or similar set of
the port properties. Make a common helper for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_port.c | 134 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |   1 +
 2 files changed, 135 insertions(+)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 88975a4df306..ecc980e9dba6 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -8,7 +8,10 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
 
@@ -82,6 +85,137 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
+/**
+ * uart_read_port_properties - read firmware properties of the given UART port
+ * @port: corresponding port
+ * @use_defaults: apply defaults (when %true) or validate the values (when %false)
+ *
+ * The following device properties are supported:
+ *   - clock-frequency (optional)
+ *   - fifo-size (optional)
+ *   - no-loopback-test (optional)
+ *   - reg-shift (defaults may apply)
+ *   - reg-offset (value may be validated)
+ *   - reg-io-width (defaults may apply or value may be validated)
+ *   - interrupts (OF only)
+ *   - serial [alias ID] (OF only)
+ *
+ * If the port->dev is of struct platform_device type the interrupt line
+ * will be retrieved via platform_get_irq() call against that device.
+ * Otherwise it will be assigned by fwnode_irq_get() call. In both cases
+ * the index 0 of the resource is used.
+ *
+ * The caller is responsible to initialize the following fields of the @port
+ *   ->dev (must be valid)
+ *   ->flags
+ *   ->mapbase
+ *   ->mapsize
+ *   ->regshift (if @use_defaults is false)
+ * before calling this function. Alternatively the above mentioned fields
+ * may be zeroed, in such case the only ones, that have associated properties
+ * found, will be set to the respective values.
+ *
+ * If no error happened, the ->irq, ->mapbase, ->mapsize will be altered.
+ * The ->iotype is always altered.
+ *
+ * When @use_defaults is true and the respective property is not found
+ * the following values will be applied:
+ *   ->regshift = 0
+ * In this case IRQ must be provided, otherwise an error will be returned.
+ *
+ * When @use_defaults is false and the respective property is found
+ * the following values will be validated:
+ *   - reg-io-width (->iotype)
+ *   - reg-offset (->mapsize against ->mapbase)
+ *
+ * Returns: 0 on success or negative errno on failure
+ */
+int uart_read_port_properties(struct uart_port *port, bool use_defaults)
+{
+	struct device *dev = port->dev;
+	u32 value;
+	int ret;
+
+	/* Read optional UART functional clock frequency */
+	device_property_read_u32(dev, "clock-frequency", &port->uartclk);
+
+	/* Read the registers alignment (default: 8-bit) */
+	ret = device_property_read_u32(dev, "reg-shift", &value);
+	if (ret)
+		port->regshift = use_defaults ? 0 : port->regshift;
+	else
+		port->regshift = value;
+
+	/* Read the registers I/O access type (default: MMIO 8-bit) */
+	ret = device_property_read_u32(dev, "reg-io-width", &value);
+	if (ret) {
+		port->iotype = UPIO_MEM;
+	} else {
+		switch (value) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 2:
+			port->iotype = UPIO_MEM16;
+			break;
+		case 4:
+			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
+			break;
+		default:
+			if (!use_defaults) {
+				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
+				return -EINVAL;
+			}
+			port->iotype = UPIO_UNKNOWN;
+			break;
+		}
+	}
+
+	/* Read the address mapping base offset (default: no offset) */
+	ret = device_property_read_u32(dev, "reg-offset", &value);
+	if (ret)
+		value = 0;
+
+	/* Check for shifted address mapping overflow */
+	if (!use_defaults && port->mapsize < value) {
+		dev_err(dev, "reg-offset %u exceeds region size %pa\n", value, &port->mapsize);
+		return -EINVAL;
+	}
+
+	port->mapbase += value;
+	port->mapsize -= value;
+
+	/* Read optional FIFO size */
+	device_property_read_u32(dev, "fifo-size", &port->fifosize);
+
+	if (device_property_read_bool(dev, "no-loopback-test"))
+		port->flags |= UPF_SKIP_TEST;
+
+	/* Get index of serial line, if found in DT aliases */
+	ret = of_alias_get_id(dev_of_node(dev), "serial");
+	if (ret >= 0)
+		port->line = ret;
+
+	if (dev_is_platform(dev))
+		ret = platform_get_irq(to_platform_device(dev), 0);
+	else
+		ret = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret > 0)
+		port->irq = ret;
+	else if (use_defaults)
+		/* By default IRQ support is mandatory */
+		return ret;
+	else
+		port->irq = 0;
+
+	port->flags |= UPF_SHARE_IRQ;
+
+	return 0;
+}
+EXPORT_SYMBOL(uart_read_port_properties);
+
 static struct device_driver serial_port_driver = {
 	.name = "port",
 	.suppress_bind_attrs = true,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c2cf9484014c..3fc8683e7b53 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -962,6 +962,7 @@ int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
+int uart_read_port_properties(struct uart_port *port, bool use_defaults);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
-- 
2.43.0.rc1.1.gbec44491f096


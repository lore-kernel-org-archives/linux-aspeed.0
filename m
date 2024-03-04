From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon,  4 Mar 2024 14:27:08 +0200
Subject: [PATCH v3 07/14] serial: 8250_dw: Switch to use uart_read_port_properties()
In-Reply-To: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
References: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240304123035.758700-8-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 67 +++++++++++++------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 062718615944..9ac4be748596 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -17,7 +17,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -449,12 +448,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 
 	if (np) {
 		unsigned int quirks = data->pdata->quirks;
-		int id;
 
-		/* get index of serial line, if found in DT aliases */
-		id = of_alias_get_id(np, "serial");
-		if (id >= 0)
-			p->line = id;
 #ifdef CONFIG_64BIT
 		if (quirks & DW_UART_QUIRK_OCTEON) {
 			p->serial_in = dw8250_serial_inq;
@@ -465,12 +459,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		}
 #endif
 
-		if (of_device_is_big_endian(np)) {
-			p->iotype = UPIO_MEM32BE;
-			p->serial_in = dw8250_serial_in32be;
-			p->serial_out = dw8250_serial_out32be;
-		}
-
 		if (quirks & DW_UART_QUIRK_ARMADA_38X)
 			p->serial_out = dw8250_serial_out38x;
 		if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
@@ -510,39 +498,21 @@ static int dw8250_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
 	struct resource *regs;
-	int irq;
 	int err;
-	u32 val;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
-	irq = platform_get_irq_optional(pdev, 0);
-	/* no interrupt -> fall back to polling */
-	if (irq == -ENXIO)
-		irq = 0;
-	if (irq < 0)
-		return irq;
-
 	spin_lock_init(&p->lock);
-	p->mapbase	= regs->start;
-	p->irq		= irq;
 	p->handle_irq	= dw8250_handle_irq;
 	p->pm		= dw8250_do_pm;
 	p->type		= PORT_8250;
-	p->flags	= UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
-	p->iotype	= UPIO_MEM;
-	p->serial_in	= dw8250_serial_in;
-	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
-	if (!p->membase)
-		return -ENOMEM;
-
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -554,15 +524,35 @@ static int dw8250_probe(struct platform_device *pdev)
 	data->uart_16550_compatible = device_property_read_bool(dev,
 						"snps,uart-16550-compatible");
 
-	err = device_property_read_u32(dev, "reg-shift", &val);
-	if (!err)
-		p->regshift = val;
+	p->mapbase = regs->start;
+	p->mapsize = resource_size(regs);
 
-	err = device_property_read_u32(dev, "reg-io-width", &val);
-	if (!err && val == 4) {
-		p->iotype = UPIO_MEM32;
+	p->membase = devm_ioremap(dev, p->mapbase, p->mapsize);
+	if (!p->membase)
+		return -ENOMEM;
+
+	err = uart_read_port_properties(p);
+	/* no interrupt -> fall back to polling */
+	if (err == -ENXIO)
+		err = 0;
+	if (err)
+		return err;
+
+	switch (p->iotype) {
+	case UPIO_MEM:
+		p->serial_in = dw8250_serial_in;
+		p->serial_out = dw8250_serial_out;
+		break;
+	case UPIO_MEM32:
 		p->serial_in = dw8250_serial_in32;
 		p->serial_out = dw8250_serial_out32;
+		break;
+	case UPIO_MEM32BE:
+		p->serial_in = dw8250_serial_in32be;
+		p->serial_out = dw8250_serial_out32be;
+		break;
+	default:
+		return -ENODEV;
 	}
 
 	if (device_property_read_bool(dev, "dcd-override")) {
@@ -589,9 +579,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		data->msr_mask_off |= UART_MSR_TERI;
 	}
 
-	/* Always ask for fixed clock rate from a property. */
-	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
-
 	/* If there is separate baudclk, get the rate from it. */
 	data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
 	if (data->clk == NULL)
-- 
2.43.0.rc1.1.gbec44491f096


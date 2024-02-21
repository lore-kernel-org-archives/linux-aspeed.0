From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 20:31:21 +0200
Subject: [PATCH v1 05/14] serial: 8250_bcm2835aux: Switch to use uart_read_port_properties()
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240221183442.4124354-6-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 92 +++++++++++------------
 1 file changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index beac6b340ace..69c3c5ca77f7 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -45,10 +45,6 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
-struct bcm2835_aux_serial_driver_data {
-	resource_size_t offset;
-};
-
 static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
@@ -85,10 +81,9 @@ static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
 
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
-	const struct bcm2835_aux_serial_driver_data *bcm_data;
+	const struct software_node *bcm2835_swnode;
 	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
-	resource_size_t offset = 0;
 	struct resource *res;
 	unsigned int uartclk;
 	int ret;
@@ -101,12 +96,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* initialize data */
 	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
 	up.port.dev = &pdev->dev;
-	up.port.regshift = 2;
 	up.port.type = PORT_16550;
-	up.port.iotype = UPIO_MEM;
-	up.port.fifosize = 8;
-	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
-			UPF_SKIP_TEST | UPF_IOREMAP;
+	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST | UPF_IOREMAP;
 	up.port.rs485_config = serial8250_em485_config;
 	up.port.rs485_supported = serial8250_em485_supported;
 	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
@@ -122,12 +113,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
 
-	/* get the interrupt */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-	up.port.irq = ret;
-
 	/* map the main registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -135,52 +120,40 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bcm_data = device_get_match_data(&pdev->dev);
+	up.port.mapbase = res->start;
+	up.port.mapsize = resource_size(res);
 
-	/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
-	 * describe the miniuart with a base address that encompasses the auxiliary
-	 * registers shared between the miniuart and spi.
-	 *
-	 * This is due to historical reasons, see discussion here :
-	 * https://edk2.groups.io/g/devel/topic/87501357#84349
-	 *
-	 * We need to add the offset between the miniuart and auxiliary
-	 * registers to get the real miniuart base address.
-	 */
-	if (bcm_data)
-		offset = bcm_data->offset;
+	bcm2835_swnode = device_get_match_data(&pdev->dev);
+	if (bcm2835_swnode) {
+		ret = device_add_software_node(&pdev->dev, bcm2835_swnode);
+		if (ret)
+			return ret;
+	}
 
-	up.port.mapbase = res->start + offset;
-	up.port.mapsize = resource_size(res) - offset;
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
+		goto rm_swnode;
 
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		up.port.line = ret;
+	up.port.regshift = 2;
+	up.port.fifosize = 8;
 
 	/* enable the clock as a last step */
 	ret = clk_prepare_enable(data->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
-			ret);
-		return ret;
+		dev_err_probe(&pdev->dev, ret, "unable to enable uart clock\n");
+		goto rm_swnode;
 	}
 
 	uartclk = clk_get_rate(data->clk);
-	if (!uartclk) {
-		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
-		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
-			goto dis_clk;
-		}
-	}
+	if (uartclk)
+		up.port.uartclk = uartclk;
 
 	/* the HW-clock divider for bcm2835aux is 8,
 	 * but 8250 expects a divider of 16,
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk = uartclk * 2;
+	up.port.uartclk *= 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
@@ -194,6 +167,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 dis_clk:
 	clk_disable_unprepare(data->clk);
+rm_swnode:
+	device_remove_software_node(&pdev->dev);
 	return ret;
 }
 
@@ -203,10 +178,27 @@ static void bcm2835aux_serial_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 	clk_disable_unprepare(data->clk);
+	device_remove_software_node(&pdev->dev);
 }
 
-static const struct bcm2835_aux_serial_driver_data bcm2835_acpi_data = {
-	.offset = 0x40,
+/*
+ * Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
+ * describe the miniuart with a base address that encompasses the auxiliary
+ * registers shared between the miniuart and spi.
+ *
+ * This is due to historical reasons, see discussion here:
+ * https://edk2.groups.io/g/devel/topic/87501357#84349
+ *
+ * We need to add the offset between the miniuart and auxiliary registers
+ * to get the real miniuart base address.
+ */
+static const struct property_entry bcm2835_acpi_properties[] = {
+	PROPERTY_ENTRY_U32("reg-offset", 0x40),
+	{ }
+};
+
+static const struct software_node bcm2835_acpi_node = {
+	.properties = bcm2835_acpi_properties,
 };
 
 static const struct of_device_id bcm2835aux_serial_match[] = {
@@ -216,7 +208,7 @@ static const struct of_device_id bcm2835aux_serial_match[] = {
 MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
 
 static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
-	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
+	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_node },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
-- 
2.43.0.rc1.1.gbec44491f096


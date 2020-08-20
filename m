From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 20 Aug 2020 11:11:49 -0500
Subject: [PATCH 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200820161152.22751-1-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
Message-ID: <20200820161152.22751-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a driver to get the button events from the panel and provide
them to userspace with the input subsystem. The panel is
connected with I2C and controls the bus, so the driver registers
as an I2C slave device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 MAINTAINERS                    |   1 +
 drivers/input/misc/Kconfig     |  10 ++
 drivers/input/misc/Makefile    |   1 +
 drivers/input/misc/ibm-panel.c | 186 +++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 drivers/input/misc/ibm-panel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a9fd08e9cd54..077cc79ad7fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8283,6 +8283,7 @@ M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-input at vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/ibm,op-panel.yaml
+F:	drivers/input/misc/ibm-panel.c
 
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 362e8a01980c..88fb465a18b8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -708,6 +708,16 @@ config INPUT_ADXL34X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl34x-spi.
 
+config INPUT_IBM_PANEL
+	tristate "IBM Operation Panel driver"
+	depends on I2C_SLAVE || COMPILE_TEST
+	help
+	  Supports the IBM Operation Panel as an input device. The panel is a
+	  controller attached to the system with some buttons and an LCD display
+	  that allows someone with physical access to the system to perform
+	  various administrative tasks. This driver only supports the part of
+	  the controller that sends commands to the system.
+
 config INPUT_IMS_PCU
 	tristate "IMS Passenger Control Unit driver"
 	depends on USB
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a48e5f2d859d..7e9edf0a142b 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
 obj-$(CONFIG_INPUT_GPIO_VIBRA)		+= gpio-vibra.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
+obj-$(CONFIG_INPUT_IBM_PANEL)		+= ibm-panel.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
 obj-$(CONFIG_INPUT_IQS269A)		+= iqs269a.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-panel.c
new file mode 100644
index 000000000000..607e7dd5a0fb
--- /dev/null
+++ b/drivers/input/misc/ibm-panel.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) IBM Corporation 2020
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+#define DEVICE_NAME	"ibm-panel"
+
+struct ibm_panel {
+	u8 idx;
+	u8 command[11];
+	spinlock_t lock;	/* protects writes to idx and command */
+	struct input_dev *input;
+};
+
+static void ibm_panel_process_command(struct ibm_panel *panel, u8 command_size)
+{
+	u8 i;
+	u8 chksum;
+	u16 sum = 0;
+	int pressed;
+	int released;
+
+	if (command_size != sizeof(panel->command)) {
+		dev_dbg(&panel->input->dev, "command too short\n");
+		return;
+	}
+
+	if (panel->command[0] != 0xff && panel->command[1] != 0xf0) {
+		dev_dbg(&panel->input->dev, "command invalid\n");
+		return;
+	}
+
+	for (i = 0; i < sizeof(panel->command) - 1; ++i) {
+		sum += panel->command[i];
+		if (sum & 0xff00) {
+			sum &= 0xff;
+			sum++;
+		}
+	}
+
+	chksum = sum & 0xff;
+	chksum = ~chksum;
+	chksum++;
+
+	if (chksum != panel->command[sizeof(panel->command) - 1]) {
+		dev_dbg(&panel->input->dev, "command failed checksum\n");
+		return;
+	}
+
+	released = panel->command[2] & 0x80;
+	pressed = released ? 0 : 1;
+
+	switch (panel->command[2] & 0xf) {
+	case 0:
+		input_report_key(panel->input, BTN_NORTH, pressed);
+		break;
+	case 1:
+		input_report_key(panel->input, BTN_SOUTH, pressed);
+		break;
+	case 2:
+		input_report_key(panel->input, BTN_SELECT, pressed);
+		break;
+	default:
+		dev_dbg(&panel->input->dev, "unknown command %u\n",
+			panel->command[2] & 0xf);
+		return;
+	}
+
+	input_sync(panel->input);
+}
+
+static int ibm_panel_i2c_slave_cb(struct i2c_client *client,
+				  enum i2c_slave_event event, u8 *val)
+{
+	u8 command_size = 0;
+	unsigned long flags;
+	struct ibm_panel *panel = i2c_get_clientdata(client);
+
+	dev_dbg(&panel->input->dev, "event: %u data: %02x\n", event, *val);
+
+	spin_lock_irqsave(&panel->lock, flags);
+
+	switch (event) {
+	case I2C_SLAVE_STOP:
+		command_size = panel->idx;
+		fallthrough;
+	case I2C_SLAVE_WRITE_REQUESTED:
+		panel->idx = 0;
+		break;
+	case I2C_SLAVE_WRITE_RECEIVED:
+		if (panel->idx < sizeof(panel->command))
+			panel->command[panel->idx++] = *val;
+		else
+			dev_dbg(&panel->input->dev, "command truncated\n");
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&panel->lock, flags);
+
+	if (command_size)
+		ibm_panel_process_command(panel, command_size);
+
+	return 0;
+}
+
+static int ibm_panel_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	int rc;
+	struct ibm_panel *panel = devm_kzalloc(&client->dev, sizeof(*panel),
+					       GFP_KERNEL);
+
+	if (!panel)
+		return -ENOMEM;
+
+	panel->input = devm_input_allocate_device(&client->dev);
+	if (!panel->input)
+		return -ENOMEM;
+
+	panel->input->name = client->name;
+	panel->input->id.bustype = BUS_I2C;
+	input_set_capability(panel->input, EV_KEY, BTN_NORTH);
+	input_set_capability(panel->input, EV_KEY, BTN_SOUTH);
+	input_set_capability(panel->input, EV_KEY, BTN_SELECT);
+
+	rc = input_register_device(panel->input);
+	if (rc) {
+		dev_err(&client->dev, "Failed to register input device: %d\n",
+			rc);
+		return rc;
+	}
+
+	spin_lock_init(&panel->lock);
+
+	i2c_set_clientdata(client, panel);
+	rc = i2c_slave_register(client, ibm_panel_i2c_slave_cb);
+	if (rc) {
+		input_unregister_device(panel->input);
+		dev_err(&client->dev,
+			"Failed to register I2C slave device: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int ibm_panel_remove(struct i2c_client *client)
+{
+	int rc;
+	struct ibm_panel *panel = i2c_get_clientdata(client);
+
+	rc = i2c_slave_unregister(client);
+
+	input_unregister_device(panel->input);
+
+	return rc;
+}
+
+static const struct of_device_id ibm_panel_match[] = {
+	{ .compatible = "ibm,op-panel" },
+	{ }
+};
+
+static struct i2c_driver ibm_panel_driver = {
+	.driver = {
+		.name = DEVICE_NAME,
+		.of_match_table = ibm_panel_match,
+	},
+	.probe = ibm_panel_probe,
+	.remove = ibm_panel_remove,
+};
+module_i2c_driver(ibm_panel_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM Operation Panel Driver");
+MODULE_LICENSE("GPL");
-- 
2.26.2


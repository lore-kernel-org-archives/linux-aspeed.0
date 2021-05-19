From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 19 May 2021 14:49:33 +0700
Subject: [PATCH v3 6/7] ipmi: ssif_bmc: Add Aspeed SSIF BMC driver
In-Reply-To: <20210519074934.20712-1-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
Message-ID: <20210519074934.20712-7-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commits adds SSIF BMC driver specifically for Aspeed AST2500 which
commonly used as Board Management Controllers.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v3:
  + Splited into separate commit [Corey, Joel]
  + Invoked aspeed-specific aspeed_set_slave_busy() when busy
to address deadlock from Graeme and comment from Philipp
  + Combined two interrupts to mask/unmask together [Corey]

 drivers/char/ipmi/Kconfig           | 11 +++++
 drivers/char/ipmi/Makefile          |  1 +
 drivers/char/ipmi/ssif_bmc_aspeed.c | 75 +++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/char/ipmi/ssif_bmc_aspeed.c

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index ad5c5161bcd6..45be57023577 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -144,6 +144,17 @@ config SSIF_IPMI_BMC
 	  The driver implements the BMC side of the SMBus system
 	  interface (SSIF).
 
+config ASPEED_SSIF_IPMI_BMC
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select SSIF_IPMI_BMC
+	tristate "Aspeed SSIF IPMI BMC driver"
+	help
+	  Provides a driver for the SSIF IPMI interface found on
+	  Aspeed AST2500 SoC.
+
+	  The driver implements the BMC side of the SMBus system
+	  interface (SSIF), specific for Aspeed AST2500 SoC.
+
 config IPMB_DEVICE_INTERFACE
 	tristate 'IPMB Interface handler'
 	depends on I2C
diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
index d04a214d74c4..05b993f7335b 100644
--- a/drivers/char/ipmi/Makefile
+++ b/drivers/char/ipmi/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
 obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) += kcs_bmc_npcm7xx.o
 obj-$(CONFIG_IPMB_DEVICE_INTERFACE) += ipmb_dev_int.o
 obj-$(CONFIG_SSIF_IPMI_BMC) += ssif_bmc.o
+obj-$(CONFIG_ASPEED_SSIF_IPMI_BMC) += ssif_bmc_aspeed.o
diff --git a/drivers/char/ipmi/ssif_bmc_aspeed.c b/drivers/char/ipmi/ssif_bmc_aspeed.c
new file mode 100644
index 000000000000..019e51e16a7e
--- /dev/null
+++ b/drivers/char/ipmi/ssif_bmc_aspeed.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * The driver for BMC side of Aspeed SSIF interface
+ * Copyright (c) 2021, Ampere Computing LLC
+ */
+
+#include <linux/i2c.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/iopoll.h>
+
+#include "ssif_bmc.h"
+
+extern void aspeed_set_slave_busy(struct i2c_adapter *adap, bool busy);
+static void aspeed_set_ssif_bmc_status(struct ssif_bmc_ctx *ssif_bmc, unsigned int status)
+{
+	if (status & SSIF_BMC_BUSY)
+		aspeed_set_slave_busy((struct i2c_adapter *)ssif_bmc->priv, true);
+	else if (status & SSIF_BMC_READY)
+		aspeed_set_slave_busy((struct i2c_adapter *)ssif_bmc->priv, false);
+}
+
+static int ssif_bmc_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct ssif_bmc_ctx *ssif_bmc;
+
+	ssif_bmc = ssif_bmc_alloc(client, 0);
+	if (IS_ERR(ssif_bmc))
+		return PTR_ERR(ssif_bmc);
+
+	ssif_bmc->priv = i2c_get_adapdata(client->adapter);
+	ssif_bmc->set_ssif_bmc_status = aspeed_set_ssif_bmc_status;
+
+	return 0;
+}
+
+static int ssif_bmc_remove(struct i2c_client *client)
+{
+	struct ssif_bmc_ctx *ssif_bmc = i2c_get_clientdata(client);
+
+	i2c_slave_unregister(client);
+	misc_deregister(&ssif_bmc->miscdev);
+
+	return 0;
+}
+
+static const struct of_device_id ssif_bmc_match[] = {
+	{ .compatible = "aspeed,ast2500-ssif-bmc" },
+	{ },
+};
+
+static const struct i2c_device_id ssif_bmc_id[] = {
+	{ DEVICE_NAME, 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, ssif_bmc_id);
+
+static struct i2c_driver ssif_bmc_driver = {
+	.driver		= {
+		.name		= DEVICE_NAME,
+		.of_match_table = ssif_bmc_match,
+	},
+	.probe		= ssif_bmc_probe,
+	.remove		= ssif_bmc_remove,
+	.id_table	= ssif_bmc_id,
+};
+
+module_i2c_driver(ssif_bmc_driver);
+
+MODULE_AUTHOR("Chuong Tran <chuong@os.amperecomputing.com>");
+MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
+MODULE_DESCRIPTION("Linux device driver of Aspeed BMC IPMI SSIF interface.");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0


From: peteryin <peteryin.openbmc@gmail.com>
Date: Thu, 24 Aug 2023 00:08:10 +0800
Subject: [PATCH] Title: Select GPIO command source.
Message-ID: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: peteryin <peter.yin@quantatw.com>

Description:
  The capability to choose the GPIO command source
between ARM LPC and Coprocessor CPU is supported.

Test Plan:
Get Bank gpio command source
  e.g.
  cd /sys/bus/platform/drivers/aspeed-command-source/
  cat 1e780000.gpio-command-source/bank_abcd
  ARM ARM ARM ARM

Set Bank gpio command source.
  e.g.
  cd /sys/bus/platform/drivers/aspeed-command-source/

  echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
  or
  echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
  or$
  echo "A COP" > 1e780000.gpio-command-source/bank_abcd

Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
---
 .../sysfs-driver-aspeed-gpio-command-source   |  24 ++
 .../soc/aspeed/gpio-command-source.yaml       |  58 ++++
 drivers/soc/aspeed/Kconfig                    |   9 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-command-source.c    | 266 ++++++++++++++++++
 5 files changed, 358 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-command-source.c

diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
new file mode 100644
index 000000000000..4698f47a1f75
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
@@ -0,0 +1,24 @@
+What:		/sys/bus/platform/drivers/aspeed-command-source/\*command\*/bank\*
+Date:		August 2023
+Contact:	Peter Yin <peter.yin@quantatw.com>
+Description:	Get or set the gpio command source for ARM, LPC or Coprocessor CPU.
+
+		When read, each file shows the list of available options with bank
+		that depends on the selected bank file.
+
+		e.g.
+		get gpio command source
+		cd /sys/bus/platform/drivers/aspeed-command-source/
+		cat 1e780000.gpio-command-source/bank_abcd
+		ARM ARM ARM ARM
+		In this case, gets bank gpio command source.
+
+
+		e.g.
+		set gpio command source
+		cd /sys/bus/platform/drivers/aspeed-command-source/
+		echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
+		or
+		echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
+		or
+		echo "A COP" > 1e780000.gpio-command-source/bank_abcd
diff --git a/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
new file mode 100644
index 000000000000..034183667501
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2023 Quanta Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/aspeed/gpio-command-source.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Aspeed UART Routing Controller
+
+maintainers:
+  - Peter Yin <peter.yin@quantatw.com>
+
+description:
+  The Aspeed gpio command source control allow to dynamically write the inputs for
+  the built-in gpio command source.
+
+  This allows, for example, to connect the gpio command source to ARM LPC or Coprocessor CPU.
+  e.g. let LPC port80 to connect the gpio group.
+
+  This driver is for the BMC side. The sysfs files allow the BMC userspace
+  which owns the system configuration policy, to configure gpio command source.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2600-gpio-command-source
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+  gpio0: gpio at 1e780000 {
+    #gpio-cells = <2>;
+    gpio-controller;
+    compatible = "aspeed,ast2600-gpio", "simple-mfd", "syscon";
+    reg = <0x1e780000 0x400>;
+    interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+    gpio-ranges = <&pinctrl 0 0 208>;
+    ngpios = <208>;
+    clocks = <&syscon ASPEED_CLK_APB2>;
+    interrupt-controller;
+    #interrupt-cells = <2>;
+
+    #address-cells = <1>;
+    #size-cells = <1>;
+    ranges = <0x0 0x1e780000 0x400>;
+    gpio_command_source: gpio-command-source at 0 {
+      compatible = "aspeed,ast2600-gpio-command-source";
+      reg = <0x0 0x400>;
+      status = "disabled";
+    };
+  };
diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index bdea4b0a687b..066bea90bd00 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -34,6 +34,15 @@ config ASPEED_UART_ROUTING
 	  users to perform runtime configuration of the RX muxes among
 	  the UART controllers and I/O pins.
 
+config ASPEED_COMMAND_SOURCE
+	tristate "ASPEED gpio command source control"
+	select REGMAP
+	select MFD_SYSCON
+	default ARCH_ASPEED
+	help
+	  Provides a driver to control the gpio command source to ARM,
+	  LPC or Coprocessor.
+
 config ASPEED_P2A_CTRL
 	tristate "ASPEED P2A (VGA MMIO to BMC) bridge control"
 	select REGMAP
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index 224127a1dd55..3246f41fe2b2 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
+obj-$(CONFIG_ASPEED_COMMAND_SOURCE)	+= aspeed-command-source.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
 obj-$(CONFIG_ASPEED_SBC)		+= aspeed-sbc.o
diff --git a/drivers/soc/aspeed/aspeed-command-source.c b/drivers/soc/aspeed/aspeed-command-source.c
new file mode 100644
index 000000000000..ecf15b56c1a6
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-command-source.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Quanta Inc.
+ */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+
+/* register offsets */
+#define GPIO60		0x60
+#define GPIO68		0x68
+#define GPIO90		0x90
+#define GPIOE0		0xE0
+#define GPIO110		0x110
+#define GPIO140		0x140
+#define GPIO170		0x170
+
+/* attributes options */
+#define GPIO_COMMAND_SOURCE_ABCD	"bank_abcd"
+#define GPIO_COMMAND_SOURCE_EFGH	"bank_efgh"
+#define GPIO_COMMAND_SOURCE_IJKL	"bank_ijkl"
+#define GPIO_COMMAND_SOURCE_MNOP	"bank_mnop"
+#define GPIO_COMMAND_SOURCE_QRST	"bank_qrst"
+#define GPIO_COMMAND_SOURCE_UVWX	"bank_uvwx"
+#define GPIO_COMMAND_SOURCE_YZ		"bank_yz"
+#define GPIO_BANK_SIZE			(4)
+
+#define COMMAND_SOURCE1_OFFSET		(4)
+#define GPIO_GPIO_GRUOP_OFFSET		(8)
+
+struct aspeed_gpio_command_source {
+	struct regmap *map;
+	struct attribute_group const *attr_grp;
+};
+
+struct aspeed_gpio_command_source_selector {
+	struct device_attribute	dev_attr;
+	uint32_t reg;
+	const char *const group[];
+};
+
+static const char *const options[] = {
+	"ARM", "LPC", "COP", "NON", NULL
+};
+
+
+#define to_routing_selector(_dev_attr)					\
+	container_of(_dev_attr, struct aspeed_gpio_command_source_selector, dev_attr)
+
+static ssize_t aspeed_gpio_command_source_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+
+static ssize_t aspeed_gpio_command_source_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count);
+
+#define ROUTING_ATTR(_name) {					\
+	.attr = {.name = _name,					\
+		 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },	\
+	.show = aspeed_gpio_command_source_show,			\
+	.store = aspeed_gpio_command_source_store,			\
+}
+
+/* routing selector for AST26xx */
+static struct aspeed_gpio_command_source_selector ast2600_bank_abcd = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_ABCD),
+	.reg = GPIO60,
+	.group = { "A", "B", "C", "D", NULL},
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_efgh = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_EFGH),
+	.reg = GPIO68,
+	.group = { "E", "F", "G", "H", NULL},
+
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_ijkl = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_IJKL),
+	.reg = GPIO90,
+	.group = { "I", "J", "L", "L", NULL},
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_mnop = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_MNOP),
+	.reg = GPIOE0,
+	.group = { "M", "N", "O", "P", NULL},
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_qrst = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_QRST),
+	.reg = GPIO110,
+	.group = { "Q", "R", "S", "T", NULL},
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_uvwx = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_UVWX),
+	.reg = GPIO140,
+	.group = { "U", "V", "W", "X", NULL},
+};
+
+static struct aspeed_gpio_command_source_selector ast2600_bank_yz = {
+	.dev_attr = ROUTING_ATTR(GPIO_COMMAND_SOURCE_YZ),
+	.reg = GPIO170,
+	.group = { "Y", "Z", NULL, NULL, NULL},
+};
+
+static struct attribute *ast2600_gpio_command_source_attrs[] = {
+	&ast2600_bank_abcd.dev_attr.attr,
+	&ast2600_bank_efgh.dev_attr.attr,
+	&ast2600_bank_ijkl.dev_attr.attr,
+	&ast2600_bank_mnop.dev_attr.attr,
+	&ast2600_bank_qrst.dev_attr.attr,
+	&ast2600_bank_uvwx.dev_attr.attr,
+	&ast2600_bank_yz.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ast2600_gpio_command_source_attr_group = {
+	.attrs = ast2600_gpio_command_source_attrs,
+};
+
+static ssize_t aspeed_gpio_command_source_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct aspeed_gpio_command_source *gpio_cmd_src = dev_get_drvdata(dev);
+	struct aspeed_gpio_command_source_selector *sel = to_routing_selector(attr);
+	uint8_t cmd_src0, cmd_src1;
+	uint32_t val1 = 0, val2 = 0;
+	int len = 0;
+
+	regmap_read(gpio_cmd_src->map, sel->reg, &val1);
+	regmap_read(gpio_cmd_src->map, sel->reg + GPIO_GPIO_GRUOP_OFFSET, &val2);
+
+	for (int i = 0; i < GPIO_BANK_SIZE; i++) {
+		cmd_src0 = (uint8_t)(val1 >> i*8);
+		cmd_src1 = (uint8_t)(val2 >> i*8);
+
+		if (cmd_src0 == 0 && cmd_src1 == 0)
+			len += sysfs_emit_at(buf, len, "%s ", options[0]);
+		else if (cmd_src0 == 1 && cmd_src1 == 0)
+			len += sysfs_emit_at(buf, len, "%s ", options[1]);
+		else if (cmd_src0 == 0 && cmd_src1 == 1)
+			len += sysfs_emit_at(buf, len, "%s ", options[2]);
+		else if (cmd_src0 == 1 && cmd_src1 == 1)
+			len += sysfs_emit_at(buf, len, "%s ", options[3]);
+	}
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+static ssize_t aspeed_gpio_command_source_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct aspeed_gpio_command_source *gpio_cmd_src = dev_get_drvdata(dev);
+	struct aspeed_gpio_command_source_selector *sel = to_routing_selector(attr);
+
+	char input1[4], input2[4];
+	int idx1 = -1, idx2 = -1;
+	uint8_t cmd_src0 = 0, cmd_src1 = 0;
+
+	if (count >= sizeof(input1) + sizeof(input2))
+		return -EINVAL; // Input is too long
+
+	if (sscanf(buf, "%3s %3s", input1, input2) != 2)
+		return -EINVAL; // Failed to parse input
+
+	idx1 = match_string(sel->group, -1, input1); //match gpio group
+	idx2 = match_string(options, -1, input2);    //match action
+	if (idx1 < 0 || idx2 < 0) {
+		dev_err(dev, "invalid value idx1=%d,idx2=%d\n", idx1, idx2);
+		return -EINVAL;
+	}
+
+	if (idx2 == 0) {  //ARM
+		cmd_src0 = 0;
+		cmd_src1 = 0;
+	} else if (idx2 == 1) { //LPC
+		cmd_src0 = 1;
+		cmd_src1 = 0;
+	} else if (idx2 == 2) { //Coprocessor CPU
+		cmd_src0 = 0;
+		cmd_src1 = 1;
+	} else if (idx2 == 3) { //Reserve
+		cmd_src0 = 1;
+		cmd_src1 = 1;
+	}
+
+	regmap_update_bits(gpio_cmd_src->map,
+			   sel->reg,
+			   1 << (idx1*GPIO_GPIO_GRUOP_OFFSET),
+			   cmd_src0 << (idx1 * GPIO_GPIO_GRUOP_OFFSET));
+
+	regmap_update_bits(gpio_cmd_src->map,
+			   (sel->reg) + COMMAND_SOURCE1_OFFSET,
+			   1 << (idx1*GPIO_GPIO_GRUOP_OFFSET),
+			   cmd_src1 << (idx1 * GPIO_GPIO_GRUOP_OFFSET));
+	return count;
+}
+
+static int aspeed_gpio_command_source_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct device *dev = &pdev->dev;
+	struct aspeed_gpio_command_source *gpio_cmd_src;
+
+	gpio_cmd_src = devm_kzalloc(&pdev->dev, sizeof(*gpio_cmd_src), GFP_KERNEL);
+	if (!gpio_cmd_src)
+		return -ENOMEM;
+
+	gpio_cmd_src->map = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(gpio_cmd_src->map)) {
+		dev_err(dev, "cannot get regmap\n");
+		return PTR_ERR(gpio_cmd_src->map);
+	}
+
+	gpio_cmd_src->attr_grp = of_device_get_match_data(dev);
+
+	rc = sysfs_create_group(&dev->kobj, gpio_cmd_src->attr_grp);
+	if (rc < 0)
+		return rc;
+
+	dev_set_drvdata(dev, gpio_cmd_src);
+	dev_info(dev, "module probe success\n");
+
+	return 0;
+}
+
+static int aspeed_gpio_command_source_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct aspeed_gpio_command_source *gpio_cmd_src = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&dev->kobj, gpio_cmd_src->attr_grp);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_gpio_command_source_table[] = {
+	{ .compatible = "aspeed,ast2600-gpio-command-source",
+	  .data = &ast2600_gpio_command_source_attr_group },
+	{ },
+};
+
+static struct platform_driver aspeed_gpio_command_source_driver = {
+	.driver = {
+		.name = "aspeed-gpio-command-source",
+		.of_match_table = aspeed_gpio_command_source_table,
+	},
+	.probe = aspeed_gpio_command_source_probe,
+	.remove = aspeed_gpio_command_source_remove,
+};
+
+module_platform_driver(aspeed_gpio_command_source_driver);
+
+MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver to configure Aspeed GPIO Command Source");
-- 
2.25.1


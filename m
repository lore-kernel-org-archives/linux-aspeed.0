From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Feb 2022 22:23:43 +1030
Subject: [PATCH v2 2/3] ARM: aspeed: Add secure boot controller support
In-Reply-To: <20220203115344.267159-1-joel@jms.id.au>
References: <20220203115344.267159-1-joel@jms.id.au>
Message-ID: <20220203115344.267159-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This reads out the status of the secure boot controller and exposes it
in sysfs using the bootinfo sysfs api.

An example on a AST2600A3 QEMU model:

 # grep -r . /sys/firmware/bootinfo/*
 /sys/firmware/bootinfo/abr_image:0
 /sys/firmware/bootinfo/low_security_key:0
 /sys/firmware/bootinfo/otp_protected:0
 /sys/firmware/bootinfo/secure_boot:1
 /sys/firmware/bootinfo/uart_boot:0

On boot the state of the system according to the secure boot controller
will be printed:

 [    0.037634] AST2600 secure boot enabled

or

 [    0.037935] AST2600 secure boot disabled

The initialisation is changed from early_initcall to subsys_initcall
because we need the firmware_kobj to be initialised, and because there's
no requirement to print this information early.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
   - Rewrite to new bootinfo api
   - Get rid of unused return values
---
 drivers/soc/aspeed/aspeed-socinfo.c | 46 ++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..dc4dfd3df55f 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/firmware_bootinfo.h>
 
 static struct {
 	const char *name;
@@ -74,6 +75,47 @@ static const char *siliconid_to_rev(u32 siliconid)
 	return "??";
 }
 
+/* Secure Boot Controller register */
+#define SEC_STATUS		0x14
+#define ABR_IMAGE_SOURCE	BIT(13)
+#define OTP_PROTECTED		BIT(8)
+#define LOW_SEC_KEY		BIT(7)
+#define SECURE_BOOT		BIT(6)
+#define UART_BOOT		BIT(5)
+
+static void __init aspeed_bootinfo_init(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+	struct bootinfo bootinfo = {};
+	u32 reg;
+
+	/* AST2600 only */
+	np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
+	if (!of_device_is_available(np))
+		return;
+
+	base = of_iomap(np, 0);
+	if (!base)
+		of_node_put(np);
+
+	reg = readl(base + SEC_STATUS);
+
+	iounmap(base);
+	of_node_put(np);
+
+	BOOTINFO_SET(bootinfo, abr_image,        reg & ABR_IMAGE_SOURCE);
+	BOOTINFO_SET(bootinfo, low_security_key, reg & LOW_SEC_KEY);
+	BOOTINFO_SET(bootinfo, otp_protected,    reg & OTP_PROTECTED);
+	BOOTINFO_SET(bootinfo, secure_boot,      reg & SECURE_BOOT);
+	/* Invert the bit; as 1 is boot from SPI/eMMC */
+	BOOTINFO_SET(bootinfo, uart_boot,        !(reg & UART_BOOT));
+
+	firmware_bootinfo_init(&bootinfo);
+
+	pr_info("AST2600 secure boot %s\n", (reg & SECURE_BOOT) ? "enabled" : "disabled");
+}
+
 static int __init aspeed_socinfo_init(void)
 {
 	struct soc_device_attribute *attrs;
@@ -148,6 +190,8 @@ static int __init aspeed_socinfo_init(void)
 			attrs->revision,
 			attrs->soc_id);
 
+	aspeed_bootinfo_init();
+
 	return 0;
 }
-early_initcall(aspeed_socinfo_init);
+subsys_initcall(aspeed_socinfo_init);
-- 
2.34.1


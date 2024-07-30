From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Wed, 31 Jul 2024 00:01:59 +0200
Subject: [PATCH] i2c: don't use ',' after delimiters
Message-ID: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Delimiters are meant to be last, no need for a ',' there. Remove a
superfluous newline in the ali1535 driver while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

@Andi: These changes are super trivial so I put them into one patch. Let
me know if you prefer broken out patches. I think it is better if it
goes through your tree, but I can also take if you prefer.

 drivers/i2c/busses/i2c-ali1535.c      | 3 +--
 drivers/i2c/busses/i2c-amd-mp2-plat.c | 2 +-
 drivers/i2c/busses/i2c-aspeed.c       | 2 +-
 drivers/i2c/busses/i2c-digicolor.c    | 2 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c    | 2 +-
 drivers/i2c/busses/i2c-omap.c         | 2 +-
 drivers/i2c/busses/i2c-piix4.c        | 2 +-
 drivers/i2c/busses/i2c-pnx.c          | 2 +-
 drivers/i2c/busses/i2c-pxa-pci.c      | 2 +-
 drivers/i2c/busses/i2c-pxa.c          | 2 +-
 drivers/i2c/busses/i2c-qcom-geni.c    | 2 +-
 drivers/i2c/busses/i2c-qup.c          | 2 +-
 drivers/i2c/busses/i2c-s3c2410.c      | 2 +-
 drivers/i2c/i2c-core-base.c           | 2 +-
 14 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 9d7b4efe26ad..544c94e86b89 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -479,9 +479,8 @@ static struct i2c_adapter ali1535_adapter = {
 
 static const struct pci_device_id ali1535_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101) },
-	{ },
+	{ }
 };
-
 MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
 static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index d3ac1c77a509..6f0ef587e76d 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -340,7 +340,7 @@ static void i2c_amd_remove(struct platform_device *pdev)
 
 static const struct acpi_device_id i2c_amd_acpi_match[] = {
 	{ "AMDI0011" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, i2c_amd_acpi_match);
 
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index ce8c4846b7fa..f411576a024c 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -991,7 +991,7 @@ static const struct of_device_id aspeed_i2c_bus_of_table[] = {
 		.compatible = "aspeed,ast2600-i2c-bus",
 		.data = aspeed_i2c_25xx_get_clk_reg_val,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
 
diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
index 3e6b80e59b90..3dc5a46698fc 100644
--- a/drivers/i2c/busses/i2c-digicolor.c
+++ b/drivers/i2c/busses/i2c-digicolor.c
@@ -357,7 +357,7 @@ static void dc_i2c_remove(struct platform_device *pdev)
 
 static const struct of_device_id dc_i2c_match[] = {
 	{ .compatible = "cnxt,cx92755-i2c" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dc_i2c_match);
 
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 0197786892a2..976d43f73f38 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -559,7 +559,7 @@ static const struct i2c_algorithm lpi2c_imx_algo = {
 
 static const struct of_device_id lpi2c_imx_of_match[] = {
 	{ .compatible = "fsl,imx7ulp-lpi2c" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpi2c_imx_of_match);
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 35a3f0a64986..1d9ad25c89ae 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1261,7 +1261,7 @@ static const struct of_device_id omap_i2c_of_match[] = {
 		.compatible = "ti,omap2420-i2c",
 		.data = &omap2420_pdata,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #endif
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 4e32d57ae0bf..febbd9950d8f 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -146,7 +146,7 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
 	},
-	{ },
+	{ }
 };
 
 /*
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index f448505d5468..1dafadda73af 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -721,7 +721,7 @@ static void i2c_pnx_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id i2c_pnx_of_match[] = {
 	{ .compatible = "nxp,pnx-i2c" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, i2c_pnx_of_match);
 #endif
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 6b3c6a733368..af2094720a4d 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -135,7 +135,7 @@ static int ce4100_i2c_probe(struct pci_dev *dev,
 
 static const struct pci_device_id ce4100_i2c_devices[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e68)},
-	{ },
+	{ }
 };
 
 static struct pci_driver ce4100_i2c_driver = {
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 031175113dd4..4d76e71cdd4b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -218,7 +218,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "ce4100-i2c",		REGS_CE4100 },
 	{ "pxa910-i2c",		REGS_PXA910 },
 	{ "armada-3700-i2c",	REGS_A3700  },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
 
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0a8b95ce35f7..e435dcbac688 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -721,7 +721,7 @@ static const struct i2c_algorithm geni_i2c_algo = {
 static const struct acpi_device_id geni_i2c_acpi_match[] = {
 	{ "QCOM0220"},
 	{ "QCOM0411" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
 #endif
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4a2c745751a2..d480162a4d39 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1648,7 +1648,7 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 
 static const struct acpi_device_id qup_i2c_acpi_match[] = {
 	{ "QCOM8010"},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_match);
 
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 01419c738cfc..7698d9d59744 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -130,7 +130,7 @@ static const struct platform_device_id s3c24xx_driver_ids[] = {
 	}, {
 		.name		= "s3c2440-hdmiphy-i2c",
 		.driver_data	= QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO,
-	}, { },
+	}, { }
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index b63f75e44296..6cf57e32119c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1068,7 +1068,7 @@ EXPORT_SYMBOL(i2c_find_device_by_fwnode);
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", },
 	{ "smbus_host_notify", },
-	{ },
+	{ }
 };
 
 static int dummy_probe(struct i2c_client *client)
-- 
2.43.0


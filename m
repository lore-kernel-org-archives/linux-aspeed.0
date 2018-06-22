From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 22 Jun 2018 14:14:15 +0200
Subject: [PATCH 2/4] mtd: spi-nor: aspeed: add support for SPI dual IO read
 mode
In-Reply-To: <20180622121417.6762-1-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
Message-ID: <20180622121417.6762-3-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Implements support for the dual IO read mode on aspeed SMC/FMC
controllers which uses both MISO and MOSI lines for data during a read
to double the read bandwidth.

Still to be done SNOR_PROTO_1_2_2

Based on work from Robert Lippert <roblip@gmail.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 56 +++++++++++++++++++++++++++++++-----=
----
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-=
smc.c
index af84a6fa2360..054614f34698 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -373,18 +373,49 @@ static void aspeed_smc_send_cmd_addr(struct spi_nor *=
nor, u8 cmd, u32 addr)
 	}
 }
=20
+static int aspeed_smc_get_io_mode(struct aspeed_smc_chip *chip)
+{
+	switch (chip->nor.read_proto) {
+	case SNOR_PROTO_1_1_1:
+		return 0;
+	case SNOR_PROTO_1_1_2:
+		return CONTROL_IO_DUAL_DATA;
+	case SNOR_PROTO_1_2_2:
+		return CONTROL_IO_DUAL_ADDR_DATA;
+	default:
+		dev_err(chip->nor.dev, "unsupported SPI read mode\n");
+		return -EINVAL;
+	}
+}
+
+static void aspeed_smc_set_io_mode(struct aspeed_smc_chip *chip, u32 io_mo=
de)
+{
+	u32 ctl;
+
+	if (io_mode > 0) {
+		ctl =3D readl(chip->ctl) & ~CONTROL_IO_MODE_MASK;
+		ctl |=3D io_mode;
+		writel(ctl, chip->ctl);
+	}
+}
+
 static ssize_t aspeed_smc_read_user(struct spi_nor *nor, loff_t from,
 				    size_t len, u_char *read_buf)
 {
 	struct aspeed_smc_chip *chip =3D nor->priv;
 	int i;
 	u8 dummy =3D 0xFF;
+	int io_mode =3D aspeed_smc_get_io_mode(chip);
=20
 	aspeed_smc_start_user(nor);
 	aspeed_smc_send_cmd_addr(nor, nor->read_opcode, from);
 	for (i =3D 0; i < chip->nor.read_dummy / 8; i++)
 		aspeed_smc_write_to_ahb(chip->ahb_base, &dummy, sizeof(dummy));
=20
+	/* Set IO mode only for data */
+	if (io_mode =3D=3D CONTROL_IO_DUAL_DATA)
+		aspeed_smc_set_io_mode(chip, io_mode);
+
 	aspeed_smc_read_from_ahb(read_buf, chip->ahb_base, len);
 	aspeed_smc_stop_user(nor);
 	return len;
@@ -735,6 +766,7 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_s=
mc_chip *chip)
 {
 	struct aspeed_smc_controller *controller =3D chip->controller;
 	const struct aspeed_smc_info *info =3D controller->info;
+	int io_mode;
 	u32 cmd;
=20
 	if (chip->nor.addr_width =3D=3D 4 && info->set_4b)
@@ -757,22 +789,21 @@ static int aspeed_smc_chip_setup_finish(struct aspeed=
_smc_chip *chip)
 	 * TODO: Adjust clocks if fast read is supported and interpret
 	 * SPI-NOR flags to adjust controller settings.
 	 */
-	if (chip->nor.read_proto =3D=3D SNOR_PROTO_1_1_1) {
-		if (chip->nor.read_dummy =3D=3D 0)
-			cmd =3D CONTROL_COMMAND_MODE_NORMAL;
-		else
-			cmd =3D CONTROL_COMMAND_MODE_FREAD;
-	} else {
-		dev_err(chip->nor.dev, "unsupported SPI read mode\n");
-		return -EINVAL;
-	}
+	io_mode =3D aspeed_smc_get_io_mode(chip);
+	if (io_mode < 0)
+		return io_mode;
=20
-	chip->ctl_val[smc_read] |=3D cmd |
+	if (chip->nor.read_dummy =3D=3D 0)
+		cmd =3D CONTROL_COMMAND_MODE_NORMAL;
+	else
+		cmd =3D CONTROL_COMMAND_MODE_FREAD;
+
+	chip->ctl_val[smc_read] |=3D cmd | io_mode |
 		chip->nor.read_opcode << CONTROL_COMMAND_SHIFT |
 		CONTROL_IO_DUMMY_SET(chip->nor.read_dummy / 8);
=20
-	dev_dbg(controller->dev, "base control register: %08x\n",
-		chip->ctl_val[smc_read]);
+	dev_info(controller->dev, "read control register: %08x\n",
+		 chip->ctl_val[smc_read]);
 	return 0;
 }
=20
@@ -782,6 +813,7 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_con=
troller *controller,
 	const struct spi_nor_hwcaps hwcaps =3D {
 		.mask =3D SNOR_HWCAPS_READ |
 			SNOR_HWCAPS_READ_FAST |
+			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_PP,
 	};
 	const struct aspeed_smc_info *info =3D controller->info;
--=20
2.13.6


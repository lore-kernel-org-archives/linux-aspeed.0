From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 22 Jun 2018 14:14:14 +0200
Subject: [PATCH 1/4] mtd: spi-nor: aspeed: use command mode for reads
In-Reply-To: <20180622121417.6762-1-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
Message-ID: <20180622121417.6762-2-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

When reading flash contents, try to use the "command mode" if the AHB
window configured for the flash module is big enough. Else, just fall
back to the "user mode" to perform the read.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-=
smc.c
index 95e54468cf7d..af84a6fa2360 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -402,6 +402,31 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *n=
or, loff_t to,
 	return len;
 }
=20
+static ssize_t aspeed_smc_read(struct spi_nor *nor, loff_t from, size_t le=
n,
+			       u_char *read_buf)
+{
+	struct aspeed_smc_chip *chip =3D nor->priv;
+
+	/*
+	 * The AHB window configured for the chip is too small for the
+	 * read offset. Use the "User mode" of the controller to
+	 * perform the read.
+	 */
+	if (from >=3D chip->ahb_window_size) {
+		aspeed_smc_read_user(nor, from, len, read_buf);
+		goto out;
+	}
+
+	/*
+	 * Use the "Command mode" to do a direct read from the AHB
+	 * window configured for the chip. This should be the default.
+	 */
+	memcpy_fromio(read_buf, chip->ahb_base + from, len);
+
+out:
+	return len;
+}
+
 static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
 {
 	struct aspeed_smc_chip *chip;
@@ -743,6 +768,7 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_s=
mc_chip *chip)
 	}
=20
 	chip->ctl_val[smc_read] |=3D cmd |
+		chip->nor.read_opcode << CONTROL_COMMAND_SHIFT |
 		CONTROL_IO_DUMMY_SET(chip->nor.read_dummy / 8);
=20
 	dev_dbg(controller->dev, "base control register: %08x\n",
@@ -809,7 +835,7 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_con=
troller *controller,
 		nor->dev =3D dev;
 		nor->priv =3D chip;
 		spi_nor_set_flash_node(nor, child);
-		nor->read =3D aspeed_smc_read_user;
+		nor->read =3D aspeed_smc_read;
 		nor->write =3D aspeed_smc_write_user;
 		nor->read_reg =3D aspeed_smc_read_reg;
 		nor->write_reg =3D aspeed_smc_write_reg;
--=20
2.13.6


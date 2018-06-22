From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 22 Jun 2018 14:14:17 +0200
Subject: [PATCH 4/4] mtd: spi-nor: aspeed: introduce optimized settings for
 fast reads
In-Reply-To: <20180622121417.6762-1-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
Message-ID: <20180622121417.6762-5-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Better settings for fast reads are looked for by implementing a SPI
timing calibration sequence described in the Aspeed SoC specification
document. The code is based on the OpenPOWER pflash tool and a similar
sequence using DMAs can be found in the SDK U-Boot.

The SPI calibration performs a loop on different SPI clock rates
(dividers of the AHB clock rates) and on different input delay cycles
for each SPI clock rates. The successive read results are compared to
a golden buffer, read at low speed, to select the safest and fastest
read settings for the chip.

The "spi-max-frequency" property is used to cap the optimize read
algorithm on some devices or controllers for which we want a "really"
safe setting, on the FMC controller chips for instance.

It can also be deactivated at boot time with a kernel parameter
'optimize_read', but that was never used on the field.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 200 +++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-=
smc.c
index 0251724eeecb..02387b0eb9bb 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/sizes.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
=20
 #define DEVICE_NAME	"aspeed-smc"
@@ -42,12 +43,16 @@ struct aspeed_smc_info {
 	bool hastype;		/* flash type field exists in config reg */
 	u8 we0;			/* shift for write enable bit for CE0 */
 	u8 ctl0;		/* offset in regs of ctl for CE0 */
+	u8 timing;		/* offset in regs of timing */
=20
 	void (*set_4b)(struct aspeed_smc_chip *chip);
+	int (*optimize_read)(struct aspeed_smc_chip *chip, u32 max_freq);
 };
=20
 static void aspeed_smc_chip_set_4b_spi_2400(struct aspeed_smc_chip *chip);
 static void aspeed_smc_chip_set_4b(struct aspeed_smc_chip *chip);
+static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
+				    u32 max_freq);
=20
 static const struct aspeed_smc_info fmc_2400_info =3D {
 	.maxsize =3D 64 * 1024 * 1024,
@@ -55,7 +60,9 @@ static const struct aspeed_smc_info fmc_2400_info =3D {
 	.hastype =3D true,
 	.we0 =3D 16,
 	.ctl0 =3D 0x10,
+	.timing =3D 0x94,
 	.set_4b =3D aspeed_smc_chip_set_4b,
+	.optimize_read =3D aspeed_smc_optimize_read,
 };
=20
 static const struct aspeed_smc_info spi_2400_info =3D {
@@ -64,7 +71,9 @@ static const struct aspeed_smc_info spi_2400_info =3D {
 	.hastype =3D false,
 	.we0 =3D 0,
 	.ctl0 =3D 0x04,
+	.timing =3D 0x94,
 	.set_4b =3D aspeed_smc_chip_set_4b_spi_2400,
+	.optimize_read =3D aspeed_smc_optimize_read,
 };
=20
 static const struct aspeed_smc_info fmc_2500_info =3D {
@@ -73,7 +82,9 @@ static const struct aspeed_smc_info fmc_2500_info =3D {
 	.hastype =3D true,
 	.we0 =3D 16,
 	.ctl0 =3D 0x10,
+	.timing =3D 0x94,
 	.set_4b =3D aspeed_smc_chip_set_4b,
+	.optimize_read =3D aspeed_smc_optimize_read,
 };
=20
 static const struct aspeed_smc_info spi_2500_info =3D {
@@ -82,7 +93,9 @@ static const struct aspeed_smc_info spi_2500_info =3D {
 	.hastype =3D false,
 	.we0 =3D 16,
 	.ctl0 =3D 0x10,
+	.timing =3D 0x94,
 	.set_4b =3D aspeed_smc_chip_set_4b,
+	.optimize_read =3D aspeed_smc_optimize_read,
 };
=20
 enum aspeed_smc_ctl_reg_value {
@@ -103,6 +116,7 @@ struct aspeed_smc_chip {
 	u32 ctl_val[smc_max];			/* control settings */
 	enum aspeed_smc_flash_type type;	/* what type of flash */
 	struct spi_nor nor;
+	u32 clk_rate;
 };
=20
 struct aspeed_smc_controller {
@@ -119,6 +133,8 @@ struct aspeed_smc_controller {
 	struct aspeed_smc_chip *chips[0];	/* pointers to attached chips */
 };
=20
+#define ASPEED_SPI_DEFAULT_FREQ		50000000
+
 /*
  * SPI Flash Configuration Register (AST2500 SPI)
  *     or
@@ -205,6 +221,12 @@ struct aspeed_smc_controller {
 	((controller)->regs + SEGMENT_ADDR_REG0 + (cs) * 4)
=20
 /*
+ * Switch to turn off read optimisation if needed
+ */
+static bool optimize_read =3D true;
+module_param(optimize_read, bool, 0644);
+
+/*
  * In user mode all data bytes read or written to the chip decode address
  * range are transferred to or from the SPI bus. The range is treated as a
  * fifo of arbitratry 1, 2, or 4 byte width but each write has to be align=
ed
@@ -765,6 +787,174 @@ static int aspeed_smc_chip_setup_init(struct aspeed_s=
mc_chip *chip,
 	return 0;
 }
=20
+#define CALIBRATE_BUF_SIZE 16384
+
+static bool aspeed_smc_check_reads(struct aspeed_smc_chip *chip,
+				   const u8 *golden_buf, u8 *test_buf)
+{
+	int i;
+
+	for (i =3D 0; i < 10; i++) {
+		aspeed_smc_read_from_ahb(test_buf, chip->ahb_base,
+					 CALIBRATE_BUF_SIZE);
+		if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE) !=3D 0)
+			return false;
+	}
+	return true;
+}
+
+static int aspeed_smc_calibrate_reads(struct aspeed_smc_chip *chip, u32 hd=
iv,
+				      const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_smc_controller *controller =3D chip->controller;
+	const struct aspeed_smc_info *info =3D controller->info;
+	int i;
+	int good_pass =3D -1, pass_count =3D 0;
+	u32 shift =3D (hdiv - 1) << 2;
+	u32 mask =3D ~(0xfu << shift);
+	u32 fread_timing_val =3D 0;
+
+#define FREAD_TPASS(i)	(((i) / 2) | (((i) & 1) ? 0 : 8))
+
+	/* Try HCLK delay 0..5, each one with/without delay and look for a
+	 * good pair.
+	 */
+	for (i =3D 0; i < 12; i++) {
+		bool pass;
+
+		fread_timing_val &=3D mask;
+		fread_timing_val |=3D FREAD_TPASS(i) << shift;
+
+		writel(fread_timing_val, controller->regs + info->timing);
+		pass =3D aspeed_smc_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(chip->nor.dev,
+			"  * [%08x] %d HCLK delay, %dns DI delay : %s",
+			fread_timing_val, i / 2, (i & 1) ? 0 : 4,
+			pass ? "PASS" : "FAIL");
+		if (pass) {
+			pass_count++;
+			if (pass_count =3D=3D 3) {
+				good_pass =3D i - 1;
+				break;
+			}
+		} else {
+			pass_count =3D 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	if (good_pass < 0)
+		return -1;
+
+	/* We have@least one pass of margin, let's use first pass */
+	fread_timing_val &=3D mask;
+	fread_timing_val |=3D FREAD_TPASS(good_pass) << shift;
+	writel(fread_timing_val, controller->regs + info->timing);
+	dev_dbg(chip->nor.dev, " * -> good is pass %d [0x%08x]",
+		good_pass, fread_timing_val);
+	return 0;
+}
+
+static bool aspeed_smc_check_calib_data(const u8 *test_buf, u32 size)
+{
+	const u32 *tb32 =3D (const u32 *) test_buf;
+	u32 i, cnt =3D 0;
+
+	/* We check if we have enough words that are neither all 0
+	 * nor all 1's so the calibration can be considered valid.
+	 *
+	 * I use an arbitrary threshold for now of 64
+	 */
+	size >>=3D 2;
+	for (i =3D 0; i < size; i++) {
+		if (tb32[i] !=3D 0 && tb32[i] !=3D 0xffffffff)
+			cnt++;
+	}
+	return cnt >=3D 64;
+}
+
+static const u32 aspeed_smc_hclk_divs[] =3D {
+	0xf, /* HCLK */
+	0x7, /* HCLK/2 */
+	0xe, /* HCLK/3 */
+	0x6, /* HCLK/4 */
+	0xd, /* HCLK/5 */
+};
+
+#define ASPEED_SMC_HCLK_DIV(i) (aspeed_smc_hclk_divs[(i) - 1] << 8)
+
+static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip, u32 max_=
freq)
+{
+	u8 *golden_buf, *test_buf;
+	int i, rc, best_div =3D -1;
+	u32 save_read_val =3D chip->ctl_val[smc_read];
+	u32 ahb_freq =3D chip->controller->clk_frequency;
+
+	dev_dbg(chip->nor.dev, "AHB frequency: %d MHz", ahb_freq / 1000000);
+
+	test_buf =3D kmalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
+	golden_buf =3D test_buf + CALIBRATE_BUF_SIZE;
+
+	/* We start with the dumbest setting (keep 4Byte bit) and read
+	 * some data
+	 */
+	chip->ctl_val[smc_read] =3D (chip->ctl_val[smc_read] & 0x2000) |
+		(0x00 << 28) | /* Single bit */
+		(0x00 << 24) | /* CE# max */
+		(0x03 << 16) | /* use normal reads */
+		(0x00 <<  8) | /* HCLK/16 */
+		(0x00 <<  6) | /* no dummy cycle */
+		(0x00);        /* normal read */
+
+	writel(chip->ctl_val[smc_read], chip->ctl);
+
+	aspeed_smc_read_from_ahb(golden_buf, chip->ahb_base,
+				 CALIBRATE_BUF_SIZE);
+
+	/* Establish our read mode with freq field set to 0 (HCLK/16) */
+	chip->ctl_val[smc_read] =3D save_read_val & 0xfffff0ff;
+
+	/* Check if calibration data is suitable */
+	if (!aspeed_smc_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
+		dev_info(chip->nor.dev,
+			 "Calibration area too uniform, using low speed");
+		writel(chip->ctl_val[smc_read], chip->ctl);
+		kfree(test_buf);
+		return 0;
+	}
+
+	/* Now we iterate the HCLK dividers until we find our breaking point */
+	for (i =3D ARRAY_SIZE(aspeed_smc_hclk_divs); i > 0; i--) {
+		u32 tv, freq;
+
+		/* Compare timing to max */
+		freq =3D ahb_freq / i;
+		if (freq >=3D max_freq)
+			continue;
+
+		/* Set the timing */
+		tv =3D chip->ctl_val[smc_read] | ASPEED_SMC_HCLK_DIV(i);
+		writel(tv, chip->ctl);
+		dev_dbg(chip->nor.dev, "Trying HCLK/%d...", i);
+		rc =3D aspeed_smc_calibrate_reads(chip, i, golden_buf, test_buf);
+		if (rc =3D=3D 0)
+			best_div =3D i;
+	}
+	kfree(test_buf);
+
+	/* Nothing found ? */
+	if (best_div < 0) {
+		dev_warn(chip->nor.dev, "No good frequency, using dumb slow");
+	} else {
+		dev_dbg(chip->nor.dev, "Found good read timings at HCLK/%d",
+			best_div);
+		chip->ctl_val[smc_read] |=3D ASPEED_SMC_HCLK_DIV(best_div);
+	}
+
+	writel(chip->ctl_val[smc_read], chip->ctl);
+	return 0;
+}
+
 static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
 {
 	struct aspeed_smc_controller *controller =3D chip->controller;
@@ -807,6 +997,9 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_s=
mc_chip *chip)
=20
 	dev_info(controller->dev, "read control register: %08x\n",
 		 chip->ctl_val[smc_read]);
+
+	if (optimize_read && info->optimize_read)
+		info->optimize_read(chip, chip->clk_rate);
 	return 0;
 }
=20
@@ -860,6 +1053,13 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_c=
ontroller *controller,
 			break;
 		}
=20
+		if (of_property_read_u32(child, "spi-max-frequency",
+					 &chip->clk_rate)) {
+			chip->clk_rate =3D ASPEED_SPI_DEFAULT_FREQ;
+		}
+		dev_info(dev, "Using %d MHz SPI frequency\n",
+			 chip->clk_rate / 1000000);
+
 		chip->controller =3D controller;
 		chip->ctl =3D controller->regs + info->ctl0 + cs * 4;
 		chip->cs =3D cs;
--=20
2.13.6


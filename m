From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Date: Mon, 17 Oct 2022 17:42:40 +0530
Subject: [PATCH 01/10] spi: Add stacked memories support in SPI core
In-Reply-To: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
References: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
Message-ID: <20221017121249.19061-2-amit.kumar-mahapatra@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For supporting multiple CS the SPI device need to be aware of all the CS
values. So, the "chip_select" member in the spi_device structure is now an
array that holds all the CS values.

spi_device structure now has a "cs_index_mask" member. This acts as an
index to the chip_select array. If nth bit of spi->cs_index_mask is set
then the driver would assert spi->chip_select[n].

For supporting multiple CS via GPIO the cs_gpiod member of the spi_device
structure is now an array that holds the gpio descriptor for each
chipselect.

Multi CS support using GPIO is not tested due to unavailability of
necessary hardware setup.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi.c       | 86 ++++++++++++++++++++++++-----------------
 include/linux/spi/spi.h | 16 +++++++-
 2 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8f97a3eacdea..1b1a891f4ccc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -592,7 +592,7 @@ static void spi_dev_set_name(struct spi_device *spi)
 	}
 
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
-		     spi->chip_select);
+		     spi->chip_select[0]);
 }
 
 static int spi_dev_check(struct device *dev, void *data)
@@ -601,7 +601,8 @@ static int spi_dev_check(struct device *dev, void *data)
 	struct spi_device *new_spi = data;
 
 	if (spi->controller == new_spi->controller &&
-	    spi->chip_select == new_spi->chip_select)
+	    spi->chip_select[0] == new_spi->chip_select[0] &&
+	    spi->chip_select[1] == new_spi->chip_select[1])
 		return -EBUSY;
 	return 0;
 }
@@ -616,7 +617,7 @@ static int __spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status;
+	int status, idx;
 
 	/*
 	 * We need to make sure there's no other device with this
@@ -626,7 +627,7 @@ static int __spi_add_device(struct spi_device *spi)
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
-				spi->chip_select);
+				spi->chip_select[0]);
 		return status;
 	}
 
@@ -636,8 +637,10 @@ static int __spi_add_device(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (ctlr->cs_gpiods)
-		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
+	if (ctlr->cs_gpiods) {
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+			spi->cs_gpiod[idx] = ctlr->cs_gpiods[spi->chip_select[idx]];
+	}
 
 	/*
 	 * Drivers may modify this initial i/o setup, but will
@@ -677,13 +680,15 @@ int spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status;
+	int status, idx;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
-			ctlr->num_chipselect);
-		return -EINVAL;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi->chip_select[idx] >= ctlr->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n", spi->chip_select[idx],
+				ctlr->num_chipselect);
+			return -EINVAL;
+		}
 	}
 
 	/* Set the bus ID string */
@@ -700,12 +705,15 @@ static int spi_add_device_locked(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
+	int idx;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
-			ctlr->num_chipselect);
-		return -EINVAL;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi->chip_select[idx] >= ctlr->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n", spi->chip_select[idx],
+				ctlr->num_chipselect);
+			return -EINVAL;
+		}
 	}
 
 	/* Set the bus ID string */
@@ -749,7 +757,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 
 	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
 
-	proxy->chip_select = chip->chip_select;
+	proxy->chip_select[0] = chip->chip_select;
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
@@ -953,29 +961,32 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
+	u32 cs_num = __ffs(spi->cs_index_mask);
+	int idx;
 
 	/*
 	 * Avoid calling into the driver (or doing delays) if the chip select
 	 * isn't actually changing from the last time this was called.
 	 */
-	if (!force && ((enable && spi->controller->last_cs == spi->chip_select) ||
-				(!enable && spi->controller->last_cs != spi->chip_select)) &&
+	if (!force && ((enable &&
+			spi->controller->last_cs == spi->chip_select[cs_num]) ||
+		       (!enable &&
+			spi->controller->last_cs != spi->chip_select[cs_num])) &&
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
 	trace_spi_set_cs(spi, activate);
 
-	spi->controller->last_cs = enable ? spi->chip_select : -1;
+	spi->controller->last_cs = enable ? spi->chip_select[cs_num] : -1;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
-	if ((spi->cs_gpiod || !spi->controller->set_cs_timing) && !activate) {
+	if ((spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) && !activate)
 		spi_delay_exec(&spi->cs_hold, NULL);
-	}
 
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (spi->cs_gpiod) {
+	if (spi->cs_gpiod[cs_num]) {
 		if (!(spi->mode & SPI_NO_CS)) {
 			/*
 			 * Historically ACPI has no means of the GPIO polarity and
@@ -988,10 +999,10 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 			 * into account.
 			 */
 			if (has_acpi_companion(&spi->dev))
-				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
+				gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], !enable);
 			else
 				/* Polarity handled by GPIO library */
-				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
+				gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], activate);
 		}
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
@@ -1001,7 +1012,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 		spi->controller->set_cs(spi, !enable);
 	}
 
-	if (spi->cs_gpiod || !spi->controller->set_cs_timing) {
+	if (spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) {
 		if (activate)
 			spi_delay_exec(&spi->cs_setup, NULL);
 		else
@@ -2139,8 +2150,8 @@ void spi_flush_queue(struct spi_controller *ctlr)
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value;
-	int rc;
+	u32 value, cs[SPI_CS_CNT_MAX] = {0};
+	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_property_read_bool(nc, "spi-cpha"))
@@ -2213,13 +2224,17 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 
 	/* Device address */
-	rc = of_property_read_u32(nc, "reg", &value);
-	if (rc) {
+	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
+						 SPI_CS_CNT_MAX);
+	if (rc < 0 || rc > ctlr->num_chipselect) {
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
 		return rc;
 	}
-	spi->chip_select = value;
+	for (idx = 0; idx < rc; idx++)
+		spi->chip_select[idx] = cs[idx];
+	/* By default set the spi->cs_index_mask as 1 */
+	spi->cs_index_mask = 0x01;
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
@@ -2333,7 +2348,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	strlcpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
 
 	/* Use provided chip-select for ancillary device */
-	ancillary->chip_select = chip_select;
+	ancillary->chip_select[0] = chip_select;
 
 	/* Take over SPI mode/speed from SPI main device */
 	ancillary->max_speed_hz = spi->max_speed_hz;
@@ -2580,7 +2595,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	spi->mode		|= lookup.mode;
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
-	spi->chip_select	= lookup.chip_select;
+	spi->chip_select[0]	= lookup.chip_select;
 
 	return spi;
 }
@@ -3687,6 +3702,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_transfer *xfer;
 	int w_size;
+	u32 cs_num = __ffs(spi->cs_index_mask);
 
 	if (list_empty(&message->transfers))
 		return -EINVAL;
@@ -3699,7 +3715,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * cs_change is set for each transfer.
 	 */
 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi->cs_gpiod)) {
+					  spi->cs_gpiod[cs_num])) {
 		size_t maxsize;
 		int ret;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e6c73d5ff1a8..a7c2efedcc4c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -19,6 +19,9 @@
 #include <linux/acpi.h>
 #include <linux/u64_stats_sync.h>
 
+/* Max no. of CS supported per spi device */
+#define SPI_CS_CNT_MAX 2
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -163,6 +166,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
  * @pcpu_statistics: statistics for the spi_device
+ * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -178,7 +182,7 @@ struct spi_device {
 	struct spi_controller	*controller;
 	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
-	u8			chip_select;
+	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX	BIT(31)		/* No transmit wire */
@@ -199,7 +203,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
+	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
 	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
@@ -209,6 +213,14 @@ struct spi_device {
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
+	/*
+	 * Bit mask of the chipselect(s) that the driver need to use from
+	 * the chipselect array.When the controller is capable to handle
+	 * multiple chip selects & memories are connected in parallel
+	 * then more than one bit need to be set in cs_index_mask.
+	 */
+	u32			cs_index_mask : 2;
+
 	/*
 	 * likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
-- 
2.17.1


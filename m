From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Date: Mon, 17 Oct 2022 17:42:47 +0530
Subject: [PATCH 08/10] spi: Add parallel memories support in SPI core
In-Reply-To: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
References: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
Message-ID: <20221017121249.19061-9-amit.kumar-mahapatra@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In parallel mode all the chip selects are asserted/de-asserted
simultaneously and each byte of data is stored in both devices, the even
bits in one, the odd bits in the other. The split is automatically handled
by the GQSPI controller. The GQSPI controller supports a maximum of two
flashes connected in parallel mode. A "multi-cs-cap" flag is added in the
spi controntroller data, through ctlr->multi-cs-cap the spi core will make
sure that the controller is capable of handling multiple chip selects at
once.

Parallel memories support via GPIO is also added in spi core, but not
tested due to unavailability of necessary hardware setup.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi.c       | 153 ++++++++++++++++++++++++++++------------
 include/linux/spi/spi.h |  12 ++++
 2 files changed, 118 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1b1a891f4ccc..2721db3b95e1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -965,58 +965,113 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	int idx;
 
 	/*
-	 * Avoid calling into the driver (or doing delays) if the chip select
-	 * isn't actually changing from the last time this was called.
+	 * In parallel mode all the chip selects are asserted/de-asserted
+	 * at once
 	 */
-	if (!force && ((enable &&
-			spi->controller->last_cs == spi->chip_select[cs_num]) ||
-		       (!enable &&
-			spi->controller->last_cs != spi->chip_select[cs_num])) &&
-	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
-		return;
-
-	trace_spi_set_cs(spi, activate);
-
-	spi->controller->last_cs = enable ? spi->chip_select[cs_num] : -1;
-	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
-
-	if ((spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) && !activate)
-		spi_delay_exec(&spi->cs_hold, NULL);
-
-	if (spi->mode & SPI_CS_HIGH)
-		enable = !enable;
+	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) == SPI_PARALLEL_CS_MASK) {
+		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+
+		if ((spi->cs_gpiod[0] || !spi->controller->set_cs_timing) && !activate)
+			spi_delay_exec(&spi->cs_hold, NULL);
+
+		if (spi->mode & SPI_CS_HIGH)
+			enable = !enable;
+
+		if (spi->cs_gpiod[0] && spi->cs_gpiod[1]) {
+			if (!(spi->mode & SPI_NO_CS)) {
+				/*
+				 * Historically ACPI has no means of the GPIO polarity and
+				 * thus the SPISerialBus() resource defines it on the per-chip
+				 * basis. In order to avoid a chain of negations, the GPIO
+				 * polarity is considered being Active High. Even for the cases
+				 * when _DSD() is involved (in the updated versions of ACPI)
+				 * the GPIO CS polarity must be defined Active High to avoid
+				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+				 * into account.
+				 */
+				if (has_acpi_companion(&spi->dev)) {
+					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+						gpiod_set_value_cansleep(spi->cs_gpiod[idx],
+									 !enable);
+				} else {
+					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+						/* Polarity handled by GPIO library */
+						gpiod_set_value_cansleep(spi->cs_gpiod[idx],
+									 activate);
+				}
+			}
+			/* Some SPI masters need both GPIO CS & slave_select */
+			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
+			    spi->controller->set_cs)
+				spi->controller->set_cs(spi, !enable);
+			else if (spi->controller->set_cs)
+				spi->controller->set_cs(spi, !enable);
+		}
 
-	if (spi->cs_gpiod[cs_num]) {
-		if (!(spi->mode & SPI_NO_CS)) {
-			/*
-			 * Historically ACPI has no means of the GPIO polarity and
-			 * thus the SPISerialBus() resource defines it on the per-chip
-			 * basis. In order to avoid a chain of negations, the GPIO
-			 * polarity is considered being Active High. Even for the cases
-			 * when _DSD() is involved (in the updated versions of ACPI)
-			 * the GPIO CS polarity must be defined Active High to avoid
-			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
-			 * into account.
-			 */
-			if (has_acpi_companion(&spi->dev))
-				gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], !enable);
-			else
-				/* Polarity handled by GPIO library */
-				gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], activate);
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+			if (spi->cs_gpiod[idx] || !spi->controller->set_cs_timing) {
+				if (activate)
+					spi_delay_exec(&spi->cs_setup, NULL);
+				else
+					spi_delay_exec(&spi->cs_inactive, NULL);
+			}
 		}
-		/* Some SPI masters need both GPIO CS & slave_select */
-		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
-		    spi->controller->set_cs)
+	} else {
+		/*
+		 * Avoid calling into the driver (or doing delays) if the chip select
+		 * isn't actually changing from the last time this was called.
+		 */
+		if (!force && ((enable && spi->controller->last_cs ==
+				spi->chip_select[cs_num]) ||
+				(!enable && spi->controller->last_cs !=
+				 spi->chip_select[cs_num])) &&
+		    (spi->controller->last_cs_mode_high ==
+		     (spi->mode & SPI_CS_HIGH)))
+			return;
+
+		trace_spi_set_cs(spi, activate);
+
+		spi->controller->last_cs = enable ? spi->chip_select[cs_num] : -1;
+		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+
+		if ((spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) && !activate)
+			spi_delay_exec(&spi->cs_hold, NULL);
+
+		if (spi->mode & SPI_CS_HIGH)
+			enable = !enable;
+
+		if (spi->cs_gpiod[cs_num]) {
+			if (!(spi->mode & SPI_NO_CS)) {
+				/*
+				 * Historically ACPI has no means of the GPIO polarity and
+				 * thus the SPISerialBus() resource defines it on the per-chip
+				 * basis. In order to avoid a chain of negations, the GPIO
+				 * polarity is considered being Active High. Even for the cases
+				 * when _DSD() is involved (in the updated versions of ACPI)
+				 * the GPIO CS polarity must be defined Active High to avoid
+				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+				 * into account.
+				 */
+				if (has_acpi_companion(&spi->dev))
+					gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], !enable);
+				else
+					/* Polarity handled by GPIO library */
+					gpiod_set_value_cansleep(spi->cs_gpiod[cs_num], activate);
+			}
+			/* Some SPI masters need both GPIO CS & slave_select */
+			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
+			    spi->controller->set_cs)
+				spi->controller->set_cs(spi, !enable);
+		} else if (spi->controller->set_cs) {
 			spi->controller->set_cs(spi, !enable);
-	} else if (spi->controller->set_cs) {
-		spi->controller->set_cs(spi, !enable);
-	}
+		}
 
-	if (spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) {
-		if (activate)
-			spi_delay_exec(&spi->cs_setup, NULL);
-		else
-			spi_delay_exec(&spi->cs_inactive, NULL);
+		if (spi->cs_gpiod[cs_num] || !spi->controller->set_cs_timing) {
+			if (activate)
+				spi_delay_exec(&spi->cs_setup, NULL);
+			else
+				spi_delay_exec(&spi->cs_inactive, NULL);
+		}
 	}
 }
 
@@ -2230,6 +2285,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
 		return rc;
+	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
+		   (!ctlr->multi_cs_cap)) {
+		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
+		return -EINVAL;
 	}
 	for (idx = 0; idx < rc; idx++)
 		spi->chip_select[idx] = cs[idx];
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a7c2efedcc4c..64070277cd6e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -22,6 +22,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_CS_CNT_MAX 2
 
+/* chip select mask */
+#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -378,6 +381,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
+ * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
+ *	more than one chip select at once.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -567,6 +572,13 @@ struct spi_controller {
 	/* Flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
 
+	/*
+	 * Flag indicating that the spi-controller has multi chip select
+	 * capability and can assert/de-assert more than one chip select
+	 * at once.
+	 */
+	bool			multi_cs_cap;
+
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
 	 * IMPORTANT:  this may be called when transfers to another
-- 
2.17.1


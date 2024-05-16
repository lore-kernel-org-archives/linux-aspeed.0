From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:05 -0500
Subject: [PATCH v3 38/40] spi: fsi: Calculate clock divider from local bus frequency
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-39-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the new FSI device local bus clock to calculate the proper SPI
clock divider.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index fc9e33be1e0e7..e762690f1a390 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -40,6 +40,7 @@
 #define  SPI_FSI_CLOCK_CFG_SCK_RECV_DEL	 GENMASK_ULL(51, 44)
 #define   SPI_FSI_CLOCK_CFG_SCK_NO_DEL	  BIT_ULL(51)
 #define  SPI_FSI_CLOCK_CFG_SCK_DIV	 GENMASK_ULL(63, 52)
+#define  SPI_FSI_CLOCK_CFG_SCK_DIV_MIN	  0x4
 #define SPI_FSI_MMAP			0x4
 #define SPI_FSI_DATA_TX			0x5
 #define SPI_FSI_DATA_RX			0x6
@@ -70,6 +71,7 @@
 struct fsi2spi {
 	struct fsi_device *fsi; /* FSI2SPI CFAM engine device */
 	struct mutex lock; /* lock access to the device */
+	u32 lbus_freq;
 };
 
 struct fsi_spi {
@@ -359,7 +361,7 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 	return 0;
 }
 
-static int fsi_spi_transfer_init(struct fsi_spi *ctx)
+static int fsi_spi_transfer_init(struct fsi_spi *ctx, u32 clock_div)
 {
 	int loops = 0;
 	int rc;
@@ -370,7 +372,7 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 	u64 status = 0ULL;
 	u64 wanted_clock_cfg = SPI_FSI_CLOCK_CFG_ECC_DISABLE |
 		SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
-		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 19);
+		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, clock_div);
 
 	end = jiffies + msecs_to_jiffies(SPI_FSI_TIMEOUT_MS);
 	do {
@@ -421,6 +423,24 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 	return rc;
 }
 
+static u32 fsi_spi_calculate_clock_div(struct fsi2spi *bridge, struct spi_device *dev,
+				       struct spi_transfer *transfer)
+{
+	u32 div = 19;
+
+	if (bridge->lbus_freq) {
+		u32 desired_speed_hz = transfer->speed_hz ?: dev->max_speed_hz;
+
+		div = DIV_ROUND_UP(bridge->lbus_freq, desired_speed_hz);
+		if (div < SPI_FSI_CLOCK_CFG_SCK_DIV_MIN)
+			div = SPI_FSI_CLOCK_CFG_SCK_DIV_MIN;
+
+		transfer->effective_speed_hz = bridge->lbus_freq / div;
+	}
+
+	return div;
+}
+
 static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 					struct spi_message *mesg)
 {
@@ -429,6 +449,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 	unsigned int len;
 	struct spi_transfer *transfer;
 	struct fsi_spi *ctx = spi_controller_get_devdata(ctlr);
+	u32 div;
 
 	rc = fsi_spi_check_mux(ctx->bridge->fsi, ctx->dev);
 	if (rc)
@@ -446,7 +467,8 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 		dev_dbg(ctx->dev, "Start tx of %d bytes.\n", transfer->len);
 
-		rc = fsi_spi_transfer_init(ctx);
+		div = fsi_spi_calculate_clock_div(ctx->bridge, mesg->spi, transfer);
+		rc = fsi_spi_transfer_init(ctx, div);
 		if (rc < 0)
 			goto error;
 
@@ -533,6 +555,7 @@ static int fsi_spi_probe(struct device *dev)
 
 	bridge->fsi = fsi;
 	mutex_init(&bridge->lock);
+	bridge->lbus_freq = fsi_device_local_bus_frequency(fsi);
 
 	for_each_available_child_of_node(dev->of_node, np) {
 		u32 base;
@@ -550,6 +573,10 @@ static int fsi_spi_probe(struct device *dev)
 
 		ctlr->dev.of_node = np;
 		ctlr->num_chipselect = of_get_available_child_count(np) ?: 1;
+		if (bridge->lbus_freq) {
+			ctlr->min_speed_hz = DIV_ROUND_UP(bridge->lbus_freq, 0xfff);
+			ctlr->max_speed_hz = bridge->lbus_freq / SPI_FSI_CLOCK_CFG_SCK_DIV_MIN;
+		}
 		ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 		ctlr->max_transfer_size = fsi_spi_max_transfer_size;
 		ctlr->transfer_one_message = fsi_spi_transfer_one_message;
-- 
2.39.3


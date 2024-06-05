From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:37 -0500
Subject: [PATCH v4 05/40] fsi: Calculate local bus clock frequency
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-6-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of a hardcoded local bus clock divider, calculate the responder
local bus frequency from the FSI bus frequency.  This will allow FSI
engine drivers to set and calculate their bus (I2C, SPI, etc) frequencies.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Use cfam clock-frequency property instead of hardcoded master local bus
   divider
 - Change default local bus clock divider from 8 to 2

 drivers/fsi/fsi-core.c   | 22 +++++++++++++++++++---
 drivers/fsi/fsi-master.h |  1 +
 drivers/fsi/fsi-slave.h  |  2 ++
 include/linux/fsi.h      |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 27235583183e5..44875f2350b04 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -109,6 +109,12 @@ int fsi_device_peek(struct fsi_device *dev, void *val)
 	return fsi_slave_read(dev->slave, addr, val, sizeof(uint32_t));
 }
 
+unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev)
+{
+	return dev->slave->master->clock_frequency / dev->slave->clock_div;
+}
+EXPORT_SYMBOL_GPL(fsi_device_local_bus_frequency);
+
 static void fsi_device_release(struct device *_device)
 {
 	struct fsi_device *device = to_fsi_dev(_device);
@@ -209,12 +215,12 @@ static inline uint32_t fsi_smode_sid(int x)
 	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
 }
 
-static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)
+static uint32_t fsi_slave_smode(int id, int div, u8 t_senddly, u8 t_echodly)
 {
 	return FSI_SMODE_WSC | FSI_SMODE_ECRC
 		| fsi_smode_sid(id)
 		| fsi_smode_echodly(t_echodly - 1) | fsi_smode_senddly(t_senddly - 1)
-		| fsi_smode_lbcrr(0x8);
+		| fsi_smode_lbcrr(div - 1);
 }
 
 static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
@@ -225,7 +231,8 @@ static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
 	/* set our smode register with the slave ID field to 0; this enables
 	 * extended slave addressing
 	 */
-	smode = fsi_slave_smode(slave->id, slave->t_send_delay, slave->t_echo_delay);
+	smode = fsi_slave_smode(slave->id, slave->clock_div, slave->t_send_delay,
+				slave->t_echo_delay);
 	data = cpu_to_be32(smode);
 
 	return fsi_master_write(slave->master, slave->link, id, FSI_SLAVE_BASE + FSI_SMODE,
@@ -950,6 +957,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	struct fsi_slave *slave;
 	uint8_t crc;
 	__be32 data, llmode, slbus;
+	u32 clock;
 	int rc;
 
 	/* Currently, we only support single slaves on a link, and use the
@@ -1003,6 +1011,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	slave->dev.of_node = fsi_slave_find_of_node(master, link, id);
 	slave->dev.release = fsi_slave_release;
 	device_initialize(&slave->dev);
+	slave->clock_div = FSI_SMODE_LBCRR_DEFAULT;
 	slave->cfam_id = cfam_id;
 	slave->master = master;
 	slave->link = link;
@@ -1020,6 +1029,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	}
 
+	if (master->clock_frequency && !device_property_read_u32(&slave->dev, "clock-frequency",
+								 &clock) && clock)
+		slave->clock_div = DIV_ROUND_UP(master->clock_frequency, clock);
+
 	slbus = cpu_to_be32(FSI_SLBUS_FORCE);
 	rc = fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SLBUS,
 			      &slbus, sizeof(slbus));
@@ -1289,6 +1302,9 @@ int fsi_master_register(struct fsi_master *master)
 	if (!dev_name(&master->dev))
 		dev_set_name(&master->dev, "fsi%d", master->idx);
 
+	if (master->flags & FSI_MASTER_FLAG_SWCLOCK)
+		master->clock_frequency = 100000000; // POWER reference clock
+
 	master->dev.class = &fsi_master_class;
 
 	mutex_lock(&master->scan_lock);
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index a0d7ad0f0f7cc..ff23983ea84c8 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -121,6 +121,7 @@
 
 struct fsi_master {
 	struct device	dev;
+	unsigned long	clock_frequency;
 	int		idx;
 	int		n_links;
 	int		flags;
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index 45190b06fa027..fabc0b66d5bf3 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -48,6 +48,7 @@
 #define FSI_SMODE_SD_DEFAULT	 16		/* Default send delay */
 #define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
 #define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
+#define FSI_SMODE_LBCRR_DEFAULT	 2		/* Default clk ratio */
 
 /*
  * SISS fields
@@ -104,6 +105,7 @@ struct fsi_slave {
 	int			id;	/* FSI address */
 	int			link;	/* FSI link# */
 	u32			cfam_id;
+	u32			clock_div;
 	int			chip_id;
 	uint32_t		size;	/* size of slave address space */
 	u8			t_send_delay;
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 3df8c54868df5..e0309bf0ae072 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -24,6 +24,7 @@ extern int fsi_device_read(struct fsi_device *dev, uint32_t addr,
 extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
 		const void *val, size_t size);
 extern int fsi_device_peek(struct fsi_device *dev, void *val);
+extern unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev);
 
 struct fsi_device_id {
 	u8	engine_type;
-- 
2.39.3


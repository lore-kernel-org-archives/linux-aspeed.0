From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:53 -0500
Subject: [PATCH v4 21/40] fsi: aspeed: Disable relative addressing and IPOLL for cfam reset
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-22-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Need to disable these for the master reset after cfam reset.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 176e596b4391b..c9f6d84e1a372 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -402,11 +402,18 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 
 	trace_fsi_master_aspeed_cfam_reset(true);
 	spin_lock_irqsave(&aspeed->lock, flags);
+
+	regmap_write(aspeed->master.map, FSI_MMODE,
+		     aspeed->master.mmode & ~(FSI_MMODE_EIP | FSI_MMODE_RELA));
+
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	udelay(900);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
 	udelay(900);
+
 	regmap_write(aspeed->master.map, FSI_MRESP0, FSI_MRESP_RST_ALL_MASTER);
+	regmap_write(aspeed->master.map, FSI_MMODE, aspeed->master.mmode);
+
 	spin_unlock_irqrestore(&aspeed->lock, flags);
 	trace_fsi_master_aspeed_cfam_reset(false);
 
-- 
2.39.3


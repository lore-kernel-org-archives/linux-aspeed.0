From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Date: Mon, 17 Oct 2022 17:42:42 +0530
Subject: [PATCH 03/10] net: Replace spi->chip_select references to spi->chip_select[0]
In-Reply-To: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
References: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
Message-ID: <20221017121249.19061-4-amit.kumar-mahapatra@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For adding multi CS support & to prevent any existing driver from
breaking, replaced all spi->chip_select references to spi->chip_select[0].

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/net/ethernet/asix/ax88796c_main.c      | 2 +-
 drivers/net/ethernet/davicom/dm9051.c          | 2 +-
 drivers/net/ieee802154/ca8210.c                | 2 +-
 drivers/net/wan/slic_ds26522.c                 | 2 +-
 drivers/net/wireless/marvell/libertas/if_spi.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/asix/ax88796c_main.c b/drivers/net/ethernet/asix/ax88796c_main.c
index 6ba5b024a7be..65586ff24dfb 100644
--- a/drivers/net/ethernet/asix/ax88796c_main.c
+++ b/drivers/net/ethernet/asix/ax88796c_main.c
@@ -1006,7 +1006,7 @@ static int ax88796c_probe(struct spi_device *spi)
 	ax_local->mdiobus->parent = &spi->dev;
 
 	snprintf(ax_local->mdiobus->id, MII_BUS_ID_SIZE,
-		 "ax88796c-%s.%u", dev_name(&spi->dev), spi->chip_select);
+		 "ax88796c-%s.%u", dev_name(&spi->dev), spi->chip_select[0]);
 
 	ret = devm_mdiobus_register(&spi->dev, ax_local->mdiobus);
 	if (ret < 0) {
diff --git a/drivers/net/ethernet/davicom/dm9051.c b/drivers/net/ethernet/davicom/dm9051.c
index a523ddda7609..835674ad6ceb 100644
--- a/drivers/net/ethernet/davicom/dm9051.c
+++ b/drivers/net/ethernet/davicom/dm9051.c
@@ -1121,7 +1121,7 @@ static int dm9051_mdio_register(struct board_info *db)
 	db->mdiobus->phy_mask = (u32)~BIT(1);
 	db->mdiobus->parent = &spi->dev;
 	snprintf(db->mdiobus->id, MII_BUS_ID_SIZE,
-		 "dm9051-%s.%u", dev_name(&spi->dev), spi->chip_select);
+		 "dm9051-%s.%u", dev_name(&spi->dev), spi->chip_select[0]);
 
 	ret = devm_mdiobus_register(&spi->dev, db->mdiobus);
 	if (ret)
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 42c0b451088d..f0ccf1cd79f4 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2967,7 +2967,7 @@ static int ca8210_test_interface_init(struct ca8210_priv *priv)
 		sizeof(node_name),
 		"ca8210@%d_%d",
 		priv->spi->master->bus_num,
-		priv->spi->chip_select
+		priv->spi->chip_select[0]
 	);
 
 	test->ca8210_dfs_spi_int = debugfs_create_file(
diff --git a/drivers/net/wan/slic_ds26522.c b/drivers/net/wan/slic_ds26522.c
index 6063552cea9b..eb053a76fe52 100644
--- a/drivers/net/wan/slic_ds26522.c
+++ b/drivers/net/wan/slic_ds26522.c
@@ -211,7 +211,7 @@ static int slic_ds26522_probe(struct spi_device *spi)
 
 	ret = slic_ds26522_init_configure(spi);
 	if (ret == 0)
-		pr_info("DS26522 cs%d configured\n", spi->chip_select);
+		pr_info("DS26522 cs%d configured\n", spi->chip_select[0]);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index ff1c7ec8c450..074d6c1f0c2c 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1051,7 +1051,7 @@ static int if_spi_init_card(struct if_spi_card *card)
 				"spi->max_speed_hz=%d\n",
 				card->card_id, card->card_rev,
 				card->spi->master->bus_num,
-				card->spi->chip_select,
+				card->spi->chip_select[0],
 				card->spi->max_speed_hz);
 		err = if_spi_prog_helper_firmware(card, helper);
 		if (err)
-- 
2.17.1


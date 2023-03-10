From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Date: Fri, 10 Mar 2023 23:02:10 +0530
Subject: [PATCH V6 08/15] ALSA: hda: cs35l41: Replace all spi->chip_select references with function call
In-Reply-To: <20230310173217.3429788-1-amit.kumar-mahapatra@amd.com>
References: <20230310173217.3429788-1-amit.kumar-mahapatra@amd.com>
Message-ID: <20230310173217.3429788-9-amit.kumar-mahapatra@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
members of struct spi_device to be an array. But changing the type of these
members to array would break the spi driver functionality. To make the
transition smoother introduced four new APIs to get/set the
spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
spi->cs_gpiod references with get or set API calls.
While adding multi-cs support in further patches the chip_select & cs_gpiod
members of the spi_device structure would be converted to arrays & the
"idx" parameter of the APIs would be used as array index i.e.,
spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 sound/pci/hda/cs35l41_hda_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 71979cfb4d7e..eb287aa5f782 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -25,7 +25,7 @@ static int cs35l41_hda_spi_probe(struct spi_device *spi)
 	else
 		return -ENODEV;
 
-	return cs35l41_hda_probe(&spi->dev, device_name, spi->chip_select, spi->irq,
+	return cs35l41_hda_probe(&spi->dev, device_name, spi_get_chipselect(spi, 0), spi->irq,
 				 devm_regmap_init_spi(spi, &cs35l41_regmap_spi));
 }
 
-- 
2.25.1


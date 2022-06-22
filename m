From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 22 Jun 2022 11:42:33 +0200
Subject: [PATCH v2 2/2] spi: aspeed: Fix division by zero
In-Reply-To: <20220622094233.3681843-1-clg@kaod.org>
References: <20220622094233.3681843-1-clg@kaod.org>
Message-ID: <20220622094233.3681843-3-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When using the normal read operation for data transfers, the dummy bus
width is zero. In that case, they are no dummy bytes to transfer and
setting the dummy field in the controller register becomes useless.

Issue was found on a custom "Bifrost" board based on the AST2500 SoC
and using a MX25L51245GMI-08G SPI Flash.

Reported-by: Ian Woloschin <ian.woloschin@akamai.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Ian Woloschin <iwolosch@akamai.com>
Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ac64be289e59..3e891bf22470 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -582,9 +582,11 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
 	ctl_val |= aspeed_spi_get_io_mode(op) |
 		op->cmd.opcode << CTRL_COMMAND_SHIFT |
-		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
 		CTRL_IO_MODE_READ;
 
+	if (op->dummy.nbytes)
+		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
+
 	/* Tune 4BYTE address mode */
 	if (op->addr.nbytes) {
 		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
-- 
2.35.3


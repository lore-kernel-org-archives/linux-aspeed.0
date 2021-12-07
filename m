From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Tue, 7 Dec 2021 18:27:47 +0800
Subject: [PATCH v4 4/6] drm/aspeed: Add AST2600 chip support
In-Reply-To: <20211207102749.18118-1-tommy_huang@aspeedtech.com>
References: <20211207102749.18118-1-tommy_huang@aspeedtech.com>
Message-ID: <20211207102749.18118-6-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: tommy-huang <tommy_huang@aspeedtech.com>

Add AST2600 chip support and setting.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4b56b3c7597..d10246b1d1c2 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -82,9 +82,18 @@ static const struct aspeed_gfx_config ast2500_config = {
 	.scan_line_max = 128,
 };
 
+static const struct aspeed_gfx_config ast2600_config = {
+	.dac_reg = 0xc0,
+	.int_clear_reg = 0x68,
+	.vga_scratch_reg = 0x50,
+	.throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
+	.scan_line_max = 128,
+};
+
 static const struct of_device_id aspeed_gfx_match[] = {
 	{ .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
+	{ .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
-- 
2.17.1


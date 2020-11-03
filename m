From: kernel test robot <lkp@intel.com>
Date: Tue, 3 Nov 2020 08:33:31 +0800
Subject: [RFC PATCH] spi: aspeed: aspeed_spi_get_io_mode() can be static
In-Reply-To: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
References: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
Message-ID: <20201103003331.GA44379@4742e760afe2>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Signed-off-by: kernel test robot <lkp@intel.com>
---
 spi-aspeed.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed.c b/drivers/spi/spi-aspeed.c
index 795f67c9ca6ac3..6b067dee833246 100644
--- a/drivers/spi/spi-aspeed.c
+++ b/drivers/spi/spi-aspeed.c
@@ -144,7 +144,7 @@ static void aspeed_spi_chip_set_4byte(struct aspeed_spi_controller *ast_ctrl,
 	writel(reg_val, ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
 }
 
-uint32_t aspeed_spi_get_io_mode(uint32_t bus_width)
+static uint32_t aspeed_spi_get_io_mode(uint32_t bus_width)
 {
 	switch (bus_width) {
 	case 1:
@@ -295,8 +295,8 @@ aspeed_2600_spi_clk_basic_setting(struct aspeed_spi_controller *ast_ctrl,
  * content is too monotonous, the frequency recorded in the device
  * tree will be adopted.
  */
-int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
-				       uint32_t cs)
+static int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
+					      uint32_t cs)
 {
 	int ret = 0;
 	struct device *dev = ast_ctrl->dev;
@@ -432,7 +432,7 @@ int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
  * of its related flash size. Namely, the total decoded size
  * from flash 0 to flash N should be multiple of flash (N + 1).
  */
-void aspeed_2600_adjust_decode_sz(uint32_t decode_sz_arr[], int len)
+static void aspeed_2600_adjust_decode_sz(uint32_t decode_sz_arr[], int len)
 {
 	int cs, j;
 	uint32_t sz;

From: Joel Stanley <joel@jms.id.au>
Date: Thu,  7 Jun 2018 16:39:59 +0930
Subject: [PATCH] clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
Message-ID: <20180607070959.31995-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is used by the host to talk to the BMC's PCIe slave device. The BMC
is not involved, but the clock needs to be enabled so the host can use
the device.

Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
Cc: stable at vger.kernel.org # 4.15
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Tested-by: Lei YU <mine260309@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 4d425594999d..c17032bc853a 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -91,8 +91,8 @@ static const struct aspeed_gate_data aspeed_gates[] = {
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
-	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
-	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
+	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
+	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	CLK_IS_CRITICAL }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
 	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
 	[ASPEED_CLK_GATE_LCLK] =	{  8,  5, "lclk-gate",		NULL,	0 }, /* LPC */
-- 
2.17.1


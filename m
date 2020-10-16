From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 16 Oct 2020 14:26:00 +0800
Subject: [PATCH 1/3] peci: aspeed: make the driver support 64byte mode
In-Reply-To: <20201016062602.20014-1-billy_tsai@aspeedtech.com>
References: <20201016062602.20014-1-billy_tsai@aspeedtech.com>
Message-ID: <20201016062602.20014-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At ast2600 peci add the new feature can support the transfer size up to
64 bytes.
We can use the dts property "64byte-mode" to enable it.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/peci/busses/peci-aspeed.c | 67 +++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/peci/busses/peci-aspeed.c b/drivers/peci/busses/peci-aspeed.c
index 2673d4c4dcf9..d6039b1c4494 100644
--- a/drivers/peci/busses/peci-aspeed.c
+++ b/drivers/peci/busses/peci-aspeed.c
@@ -28,6 +28,9 @@
 #define   ASPEED_PECI_CTRL_INVERT_IN		BIT(6)
 #define   ASPEED_PECI_CTRL_BUS_CONTENT_EN	BIT(5)
 #define   ASPEED_PECI_CTRL_PECI_EN		BIT(4)
+#define   ASPEED_PECI_CTRL_64BYTE_MODE_EN	BIT(1)
+#define     ASPEED_PECI_32BYTE_MODE		0
+#define     ASPEED_PECI_64BYTE_MODE		1
 #define   ASPEED_PECI_CTRL_PECI_CLK_EN		BIT(0)
 
 /* Timing Negotiation Register */
@@ -79,7 +82,7 @@
 #define   ASPEED_PECI_INT_TIMING_RESULT_MASK	GENMASK(29, 16)
 	  /* bits[4..0]: Same bit fields in the 'Interrupt Register' */
 
-/* Rx/Tx Data Buffer Registers */
+/* 32Bytes mode: Rx/Tx Data Buffer Registers */
 #define ASPEED_PECI_W_DATA0			0x20
 #define ASPEED_PECI_W_DATA1			0x24
 #define ASPEED_PECI_W_DATA2			0x28
@@ -96,7 +99,39 @@
 #define ASPEED_PECI_R_DATA5			0x54
 #define ASPEED_PECI_R_DATA6			0x58
 #define ASPEED_PECI_R_DATA7			0x5c
-#define   ASPEED_PECI_DATA_BUF_SIZE_MAX		32
+/* 64Bytes mode: Rx/Tx Data Buffer Registers */
+#define ASPEED_PECI_64B_W_DATA0  0x80
+#define ASPEED_PECI_64B_W_DATA1  0x84
+#define ASPEED_PECI_64B_W_DATA2  0x88
+#define ASPEED_PECI_64B_W_DATA3  0x8C
+#define ASPEED_PECI_64B_W_DATA4  0x90
+#define ASPEED_PECI_64B_W_DATA5  0x94
+#define ASPEED_PECI_64B_W_DATA6  0x98
+#define ASPEED_PECI_64B_W_DATA7  0x9C
+#define ASPEED_PECI_64B_W_DATA8  0xA0
+#define ASPEED_PECI_64B_W_DATA9  0xA4
+#define ASPEED_PECI_64B_W_DATAA  0xA8
+#define ASPEED_PECI_64B_W_DATAB  0xAC
+#define ASPEED_PECI_64B_W_DATAC  0xB0
+#define ASPEED_PECI_64B_W_DATAD  0xB4
+#define ASPEED_PECI_64B_W_DATAE  0xB8
+#define ASPEED_PECI_64B_W_DATAF  0xBC
+#define ASPEED_PECI_64B_R_DATA0  0xC0
+#define ASPEED_PECI_64B_R_DATA1  0xC4
+#define ASPEED_PECI_64B_R_DATA2  0xC8
+#define ASPEED_PECI_64B_R_DATA3  0xCC
+#define ASPEED_PECI_64B_R_DATA4  0xD0
+#define ASPEED_PECI_64B_R_DATA5  0xD4
+#define ASPEED_PECI_64B_R_DATA6  0xD8
+#define ASPEED_PECI_64B_R_DATA7  0xDC
+#define ASPEED_PECI_64B_R_DATA8  0xE0
+#define ASPEED_PECI_64B_R_DATA9  0xE4
+#define ASPEED_PECI_64B_R_DATAA  0xE8
+#define ASPEED_PECI_64B_R_DATAB  0xEC
+#define ASPEED_PECI_64B_R_DATAC  0xF0
+#define ASPEED_PECI_64B_R_DATAD  0xF4
+#define ASPEED_PECI_64B_R_DATAE  0xF8
+#define ASPEED_PECI_64B_R_DATAF  0xFC
 
 /* Timing Negotiation */
 #define ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT	8
@@ -125,6 +160,8 @@ struct aspeed_peci {
 	struct completion	xfer_complete;
 	u32			status;
 	u32			cmd_timeout_ms;
+	/* 0: older 32 bytes, 1 : 64bytes mode */
+	int			xfer_mode;
 };
 
 static inline int aspeed_peci_check_idle(struct aspeed_peci *priv)
@@ -144,12 +181,13 @@ static int aspeed_peci_xfer(struct peci_adapter *adapter,
 	struct aspeed_peci *priv = peci_get_adapdata(adapter);
 	long err, timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
 	u32 peci_head, peci_state, rx_data = 0;
+	u32 max_buffer_size = (priv->xfer_mode) ? 64 : 32;
 	ulong flags;
 	int i, ret;
 	uint reg;
 
-	if (msg->tx_len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
-	    msg->rx_len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
+	if (msg->tx_len > max_buffer_size ||
+	    msg->rx_len > max_buffer_size)
 		return -EINVAL;
 
 	/* Check command sts and bus idle state */
@@ -167,8 +205,11 @@ static int aspeed_peci_xfer(struct peci_adapter *adapter,
 	writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
 
 	for (i = 0; i < msg->tx_len; i += 4) {
-		reg = i < 16 ? ASPEED_PECI_W_DATA0 + i % 16 :
-			       ASPEED_PECI_W_DATA4 + i % 16;
+		if (priv->xfer_mode)
+			reg = ASPEED_PECI_64B_W_DATA0 + i % 16;
+		else
+			reg = i < 16 ? ASPEED_PECI_W_DATA0 + i % 16 :
+				       ASPEED_PECI_W_DATA4 + i % 16;
 		writel(le32_to_cpup((__le32 *)&msg->tx_buf[i]),
 		       priv->base + reg);
 	}
@@ -215,8 +256,11 @@ static int aspeed_peci_xfer(struct peci_adapter *adapter,
 		u8 byte_offset = i % 4;
 
 		if (byte_offset == 0) {
-			reg = i < 16 ? ASPEED_PECI_R_DATA0 + i % 16 :
-				       ASPEED_PECI_R_DATA4 + i % 16;
+			if (priv->xfer_mode)
+				reg = ASPEED_PECI_64B_R_DATA0 + i % 16;
+			else
+				reg = i < 16 ? ASPEED_PECI_R_DATA0 + i % 16 :
+					ASPEED_PECI_R_DATA4 + i % 16;
 			rx_data = readl(priv->base + reg);
 		}
 
@@ -349,10 +393,8 @@ static int aspeed_peci_init_ctrl(struct aspeed_peci *priv)
 		priv->cmd_timeout_ms = ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT;
 	}
 
-	writel(FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK,
-			  ASPEED_PECI_CLK_DIV_DEFAULT) |
-	       ASPEED_PECI_CTRL_PECI_CLK_EN, priv->base + ASPEED_PECI_CTRL);
-
+	if (of_property_read_bool(priv->dev->of_node, "64byte-mode"))
+		priv->xfer_mode = 1;
 	/*
 	 * Timing negotiation period setting.
 	 * The unit of the programmed value is 4 times of PECI clock period.
@@ -373,6 +415,7 @@ static int aspeed_peci_init_ctrl(struct aspeed_peci *priv)
 	/* Read sampling point and clock speed setting */
 	writel(FIELD_PREP(ASPEED_PECI_CTRL_SAMPLING_MASK, rd_sampling_point) |
 	       FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, clk_div_val) |
+	       (priv->xfer_mode ? ASPEED_PECI_CTRL_64BYTE_MODE_EN : 0) |
 	       ASPEED_PECI_CTRL_PECI_EN | ASPEED_PECI_CTRL_PECI_CLK_EN,
 	       priv->base + ASPEED_PECI_CTRL);
 
-- 
2.17.1


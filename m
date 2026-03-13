Return-Path: <linux-aspeed+bounces-3660-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F44105F78B
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:09:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv53M93z3cMD;
	Fri, 13 Mar 2026 21:08:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396513;
	cv=none; b=O4aZoGo5jI0gIr05a5Lt8KZyy6wGfDDuotuXbXrrLVewx+Jv50TR8/IlyJT9Ma24IEq6LaWGOsvVorR3mCNxDQPgE6y8Bau3rfDC9Jv78UGOQdI91Sgf3APf3j9/oYlAnLgSHC5VD8uo+TlkU2OXfevz1eUGYj8MdL9E8ilkS7JMIpYz0NZzUwrEwgUcD4CkecEQxcYVeLGixl1a7ei93Uh44WdTnj2D/SMb9tLWsgZFqliTijvIJDVGDtDoFGlwvcvAY8GnSTbxEB8QcBt63WgIuRCEVA153tG7By572QpcUXbl+MF8NnPEB/pAJITtWXRBKtAJ/+A4uxkbzzix+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396513; c=relaxed/relaxed;
	bh=b6Izk2jJPmZoQmADbP4Tisuabvg12TPEtsTVK7PRehA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W5anwNge1O7WB4N5IcYp3kVhFd3gWrOM7I+93IXwf9niYag6h6ZSKESEwcqtUKCiQplMRsm6LP1ump5m7bwiGc7K7x/oGzt3mZlvKGYhkksaspkoUDgHzQUxdqeLmYTqctspOgwiuXjR2Z9b2CBToD6asAhd2NBea79M8ISnBXIYJUX4TitAgfPVP/vPcvnCzabBAnSkJBd+khpM/oBepFskJ0F4wns+WK9fj/0s5nApv45+NAZWX5LYVzUkYpDpahIfraTmZ9iAZrXE5450qPRsnHcHG/RpvSLFB+Gl5leo8NlakQHkPOirxF918GQ3s0jB2lkRiiwqpV/+SGaJIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKv43k91z3cM8;
	Fri, 13 Mar 2026 21:08:32 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:07:40 +0800
Subject: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
In-Reply-To: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <maciej.lawniczak@intel.com>, aspeedyh
	<yh_chung@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=21460;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=R/eqy8WdSTvFKjfxkwSMJf1LY2p4PUDk6hGG7OrrdZw=;
 b=f4kurhFCFaw+qcsSTwnIQnrVcHGlQfjRd+JqnL81rwfZFoTx/h99zBIib3+lRjnb8N6b1NjHt
 EZUaf6JX8STBUk+DV8R/CnWxAxwVwa6YnePiEwQK5JkjxpnpFhwXrO7
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

Add flash channel probe/remove and function operators for core to
receive/send eSPI flash request packets. Flash channel packets are
handled in core to address storage requests via the LUN-like interface.

Note eSPI Flash channel may start transaction prior than kernel boots
due to host might accesses BIOS image in early stage. Busy checkings are
added to avoid resetting the Flash channel during probe if transaction
already begun.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 drivers/soc/aspeed/espi/Makefile           |   2 +-
 drivers/soc/aspeed/espi/aspeed-espi-comm.h |  62 ++++++++
 drivers/soc/aspeed/espi/aspeed-espi.c      | 239 ++++++++++++++++++++++++++++-
 drivers/soc/aspeed/espi/aspeed-espi.h      |  36 +++++
 drivers/soc/aspeed/espi/ast2600-espi.c     | 165 ++++++++++++++++++++
 drivers/soc/aspeed/espi/ast2600-espi.h     |  19 ++-
 6 files changed, 515 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/aspeed/espi/Makefile b/drivers/soc/aspeed/espi/Makefile
index 30f9dbf92a0f..44f2adc4d358 100644
--- a/drivers/soc/aspeed/espi/Makefile
+++ b/drivers/soc/aspeed/espi/Makefile
@@ -1 +1 @@
-obj-y += aspeed-espi.o ast2600-espi.o
+obj-y += aspeed-espi.o ast2600-espi.o espi_storage.o
diff --git a/drivers/soc/aspeed/espi/aspeed-espi-comm.h b/drivers/soc/aspeed/espi/aspeed-espi-comm.h
new file mode 100644
index 000000000000..510b4afee82f
--- /dev/null
+++ b/drivers/soc/aspeed/espi/aspeed-espi-comm.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Aspeed eSPI protocol packet definitions
+ * Copyright 2026 Aspeed Technology Inc.
+ */
+#ifndef __ASPEED_ESPI_COMM_H__
+#define __ASPEED_ESPI_COMM_H__
+
+#include <linux/bits.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * eSPI cycle type encoding
+ *
+ * Section 5.1 Cycle Types and Packet Format,
+ * Intel eSPI Interface Base Specification, Rev 1.0, Jan. 2016.
+ */
+#define ESPI_FLASH_READ			0x00
+#define ESPI_FLASH_WRITE		0x01
+#define ESPI_FLASH_ERASE		0x02
+#define ESPI_FLASH_SUC_CMPLT		0x06
+#define ESPI_FLASH_SUC_CMPLT_D_MIDDLE	0x09
+#define ESPI_FLASH_SUC_CMPLT_D_FIRST	0x0b
+#define ESPI_FLASH_SUC_CMPLT_D_LAST	0x0d
+#define ESPI_FLASH_SUC_CMPLT_D_ONLY	0x0f
+#define ESPI_FLASH_UNSUC_CMPLT		0x0c
+
+#define ESPI_PLD_LEN_MIN		BIT(6)
+#define ESPI_MAX_PLD_LEN		BIT(12)
+
+/*
+ * eSPI packet format structure
+ *
+ * Section 5.1 Cycle Types and Packet Format,
+ * Intel eSPI Interface Base Specification, Rev 1.0, Jan. 2016.
+ */
+struct espi_comm_hdr {
+	u8 cyc;
+	u8 len_h : 4;
+	u8 tag : 4;
+	u8 len_l;
+};
+
+struct espi_flash_rwe {
+	u8 cyc;
+	u8 len_h : 4;
+	u8 tag : 4;
+	u8 len_l;
+	u32 addr_be;
+	u8 data[];
+} __packed;
+
+struct espi_flash_cmplt {
+	u8 cyc;
+	u8 len_h : 4;
+	u8 tag : 4;
+	u8 len_l;
+	u8 data[];
+} __packed;
+
+#endif
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b/drivers/soc/aspeed/espi/aspeed-espi.c
index e369738119bc..7d58c78ed397 100644
--- a/drivers/soc/aspeed/espi/aspeed-espi.c
+++ b/drivers/soc/aspeed/espi/aspeed-espi.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/device/devres.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -13,7 +14,10 @@
 #include <linux/reset.h>
 
 #include "aspeed-espi.h"
+#include "aspeed-espi-comm.h"
 #include "ast2600-espi.h"
+#include "espi_storage.h"
+
 
 struct aspeed_espi_ops {
 	void (*espi_pre_init)(struct aspeed_espi *espi);
@@ -21,6 +25,16 @@ struct aspeed_espi_ops {
 	void (*espi_deinit)(struct aspeed_espi *espi);
 	int (*espi_perif_probe)(struct aspeed_espi *espi);
 	int (*espi_perif_remove)(struct aspeed_espi *espi);
+	int (*espi_flash_probe)(struct aspeed_espi *espi);
+	int (*espi_flash_remove)(struct aspeed_espi *espi);
+	int (*espi_flash_get_hdr)(struct aspeed_espi *espi,
+				  struct espi_comm_hdr *hdr);
+	int (*espi_flash_get_pkt)(struct aspeed_espi *espi, void *pkt_buf,
+				  size_t pkt_size);
+	int (*espi_flash_put_pkt)(struct aspeed_espi *espi,
+				  struct espi_flash_cmplt hdr, void *pkt_buf,
+				  size_t pkt_size);
+	void (*espi_flash_clr_pkt)(struct aspeed_espi *espi);
 	irqreturn_t (*espi_isr)(int irq, void *espi);
 };
 
@@ -30,6 +44,12 @@ static const struct aspeed_espi_ops aspeed_espi_ast2600_ops = {
 	.espi_deinit = ast2600_espi_deinit,
 	.espi_perif_probe = ast2600_espi_perif_probe,
 	.espi_perif_remove = ast2600_espi_perif_remove,
+	.espi_flash_probe = ast2600_espi_flash_probe,
+	.espi_flash_remove = ast2600_espi_flash_remove,
+	.espi_flash_get_hdr = ast2600_espi_flash_get_hdr,
+	.espi_flash_get_pkt = ast2600_espi_flash_get_pkt,
+	.espi_flash_put_pkt = ast2600_espi_flash_put_pkt,
+	.espi_flash_clr_pkt = ast2600_espi_flash_clr_pkt,
 	.espi_isr = ast2600_espi_isr,
 };
 
@@ -39,6 +59,207 @@ static const struct of_device_id aspeed_espi_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);
 
+static void aspeed_espi_flash_handle_lun(struct aspeed_espi *espi)
+{
+	u32 cyc, len, tag, pkt_len, addr, offset;
+	struct espi_flash_cmplt resp_pkt;
+	struct aspeed_espi_flash *flash;
+	struct espi_flash_rwe *req_pkt;
+	struct espi_comm_hdr hdr;
+	u8 *payload;
+	u8 *buf;
+	int rc;
+
+	payload = NULL;
+	buf = NULL;
+
+	flash = &espi->flash;
+	if (!flash->lun || !flash->lun->filp)
+		return;
+
+	rc = espi->ops->espi_flash_get_hdr(espi, &hdr);
+	if (rc) {
+		dev_err(espi->dev, "espi_flash_handle_lun: get_hdr failed rc=%d\n", rc);
+		return;
+	}
+
+	if (hdr.cyc != ESPI_FLASH_WRITE && hdr.cyc != ESPI_FLASH_READ &&
+	    hdr.cyc != ESPI_FLASH_ERASE) {
+		dev_err(espi->dev, "espi_flash_handle_lun: invalid cyc=0x%x\n",
+			hdr.cyc);
+		return;
+	}
+
+	cyc = hdr.cyc;
+	len = (hdr.len_h << 8) | hdr.len_l;
+	tag = hdr.tag;
+
+	len = len ? len : ESPI_MAX_PLD_LEN;
+	pkt_len = len + sizeof(struct espi_flash_rwe);
+
+	payload = kzalloc(pkt_len, GFP_KERNEL);
+	if (!payload)
+		return;
+
+	rc = espi->ops->espi_flash_get_pkt(espi, payload + sizeof(hdr), pkt_len - sizeof(hdr));
+	if (rc) {
+		dev_err(espi->dev, "espi_flash_handle_lun: get_pkt failed rc=%d\n", rc);
+		goto out_free;
+	}
+
+	req_pkt = (struct espi_flash_rwe *)payload;
+	req_pkt->cyc = hdr.cyc;
+	req_pkt->len_h = hdr.len_h;
+	req_pkt->len_l = hdr.len_l;
+	req_pkt->tag = hdr.tag;
+
+	addr = be32_to_cpu(req_pkt->addr_be);
+
+	switch (cyc) {
+	case ESPI_FLASH_ERASE:
+		rc = aspeed_espi_lun_erase_bytes(flash->lun, addr, len);
+		resp_pkt.cyc = (rc) ? ESPI_FLASH_UNSUC_CMPLT : ESPI_FLASH_SUC_CMPLT;
+		resp_pkt.len_h = 0;
+		resp_pkt.len_l = 0;
+		resp_pkt.tag = tag;
+		espi->ops->espi_flash_put_pkt(espi, resp_pkt, NULL, 0);
+		break;
+	case ESPI_FLASH_WRITE:
+		rc = aspeed_espi_lun_rw_bytes(flash->lun, true, addr, len,
+					      &payload[sizeof(struct espi_flash_rwe)]);
+
+		resp_pkt.cyc = (rc) ? ESPI_FLASH_UNSUC_CMPLT : ESPI_FLASH_SUC_CMPLT;
+		resp_pkt.len_h = 0;
+		resp_pkt.len_l = 0;
+		resp_pkt.tag = tag;
+		espi->ops->espi_flash_put_pkt(espi, resp_pkt, NULL, 0);
+		break;
+	case ESPI_FLASH_READ:
+		buf = kzalloc(len, GFP_KERNEL);
+		if (!buf)
+			goto out_free;
+
+		rc = aspeed_espi_lun_rw_bytes(flash->lun, false, addr, len, buf);
+		if (rc) {
+			resp_pkt.cyc = ESPI_FLASH_UNSUC_CMPLT;
+			resp_pkt.len_h = 0;
+			resp_pkt.len_l = 0;
+			resp_pkt.tag = tag;
+			espi->ops->espi_flash_put_pkt(espi, resp_pkt, NULL, 0);
+		} else {
+			if (len <= ESPI_PLD_LEN_MIN) {
+				resp_pkt.cyc = ESPI_FLASH_SUC_CMPLT_D_ONLY;
+				resp_pkt.tag = tag;
+				resp_pkt.len_h = (len >> 8) & 0xff;
+				resp_pkt.len_l = len & 0xff;
+				espi->ops->espi_flash_put_pkt(espi, resp_pkt, buf, len);
+			} else {
+				resp_pkt.cyc = ESPI_FLASH_SUC_CMPLT_D_FIRST;
+				resp_pkt.tag = tag;
+				resp_pkt.len_h = (ESPI_PLD_LEN_MIN >> 8) & 0xff;
+				resp_pkt.len_l = ESPI_PLD_LEN_MIN & 0xff;
+				espi->ops->espi_flash_put_pkt(espi, resp_pkt, buf,
+							      ESPI_PLD_LEN_MIN);
+				offset = ESPI_PLD_LEN_MIN;
+				len -= ESPI_PLD_LEN_MIN;
+
+				while (len > ESPI_PLD_LEN_MIN) {
+					resp_pkt.cyc = ESPI_FLASH_SUC_CMPLT_D_MIDDLE;
+					espi->ops->espi_flash_put_pkt(espi, resp_pkt,
+								     &buf[offset],
+								     ESPI_PLD_LEN_MIN);
+					offset += ESPI_PLD_LEN_MIN;
+					len -= ESPI_PLD_LEN_MIN;
+				}
+
+				resp_pkt.cyc = ESPI_FLASH_SUC_CMPLT_D_LAST;
+				resp_pkt.len_h = (len >> 8) & 0xff;
+				resp_pkt.len_l = len & 0xff;
+				espi->ops->espi_flash_put_pkt(espi, resp_pkt,
+							     &buf[offset], len);
+			}
+		}
+		break;
+	default:
+		dev_err(espi->dev, "espi_flash_handle_lun: unsupported cyc=0x%x\n", cyc);
+		break;
+	}
+	espi->ops->espi_flash_clr_pkt(espi);
+out_free:
+	kfree(buf);
+	kfree(payload);
+}
+
+static void aspeed_espi_flash_rx_work(struct work_struct *work)
+{
+	struct aspeed_espi_flash *flash = container_of(work, struct aspeed_espi_flash, rx_work);
+	struct aspeed_espi *espi = container_of(flash, struct aspeed_espi, flash);
+
+	mutex_lock(&flash->tx_mtx);
+	aspeed_espi_flash_handle_lun(espi);
+	mutex_unlock(&flash->tx_mtx);
+}
+
+static int aspeed_espi_flash_probe(struct aspeed_espi *espi)
+{
+	struct aspeed_espi_flash *flash;
+	struct device *dev;
+
+	flash = &espi->flash;
+	dev = espi->dev;
+
+	flash->dma.enable = of_property_read_bool(dev->of_node, "aspeed,flash-dma-mode");
+	if (flash->dma.enable) {
+		flash->dma.tx_virt = dmam_alloc_coherent(dev, PAGE_SIZE, &flash->dma.tx_addr,
+							 GFP_KERNEL);
+		if (!flash->dma.tx_virt) {
+			dev_err(dev, "cannot allocate DMA TX buffer\n");
+			return -ENOMEM;
+		}
+
+		flash->dma.rx_virt = dmam_alloc_coherent(dev, PAGE_SIZE, &flash->dma.rx_addr,
+							 GFP_KERNEL);
+		if (!flash->dma.rx_virt) {
+			dev_err(dev, "cannot allocate DMA RX buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	mutex_init(&flash->tx_mtx);
+	INIT_WORK(&flash->rx_work, aspeed_espi_flash_rx_work);
+
+	mutex_init(&espi->flash.lun_mtx);
+	espi->flash.lun = NULL;
+	espi->flash.lun_path[0] = '\0';
+	espi->flash.lun_ro = false;
+
+	return espi->ops->espi_flash_probe(espi);
+}
+
+static void aspeed_espi_flash_remove(struct aspeed_espi *espi)
+{
+	struct aspeed_espi_flash *flash;
+
+	flash = &espi->flash;
+
+	if (espi->ops->espi_flash_remove)
+		espi->ops->espi_flash_remove(espi);
+
+	cancel_work_sync(&flash->rx_work);
+
+	if (flash->dma.enable) {
+		dmam_free_coherent(espi->dev, PAGE_SIZE, flash->dma.tx_virt, flash->dma.tx_addr);
+		dmam_free_coherent(espi->dev, PAGE_SIZE, flash->dma.rx_virt, flash->dma.rx_addr);
+	}
+
+	mutex_destroy(&flash->lun_mtx);
+	mutex_destroy(&flash->tx_mtx);
+
+	flash->lun = NULL;
+	flash->lun_path[0] = '\0';
+	flash->lun_ro = false;
+}
+
 static int aspeed_espi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -109,11 +330,17 @@ static int aspeed_espi_probe(struct platform_device *pdev)
 		}
 	}
 
+	rc = aspeed_espi_flash_probe(espi);
+	if (rc) {
+		dev_err(dev, "cannot init flash channel, rc=%d\n", rc);
+		goto err_remove_perif;
+	}
+
 	rc = devm_request_irq(dev, espi->irq, espi->ops->espi_isr, 0,
 			      dev_name(dev), espi);
 	if (rc) {
 		dev_err(dev, "cannot request IRQ\n");
-		goto err_deinit;
+		goto err_remove_flash;
 	}
 
 	if (espi->ops->espi_post_init)
@@ -125,12 +352,16 @@ static int aspeed_espi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_remove_flash:
+	aspeed_espi_flash_remove(espi);
+err_remove_perif:
+	if (espi->ops->espi_perif_remove)
+		espi->ops->espi_perif_remove(espi);
 err_deinit:
 	if (espi->ops->espi_deinit)
 		espi->ops->espi_deinit(espi);
 	clk_disable_unprepare(espi->clk);
-
-	return rc;
+	return dev_err_probe(dev, rc, "%s failed\n", __func__);
 }
 
 static void aspeed_espi_remove(struct platform_device *pdev)
@@ -142,6 +373,8 @@ static void aspeed_espi_remove(struct platform_device *pdev)
 	if (!espi)
 		return;
 
+	aspeed_espi_flash_remove(espi);
+
 	if (espi->ops->espi_perif_remove)
 		espi->ops->espi_perif_remove(espi);
 
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.h b/drivers/soc/aspeed/espi/aspeed-espi.h
index f4ad7f61fef6..7598bc622b95 100644
--- a/drivers/soc/aspeed/espi/aspeed-espi.h
+++ b/drivers/soc/aspeed/espi/aspeed-espi.h
@@ -9,9 +9,44 @@
 #include <linux/irqreturn.h>
 #include <linux/miscdevice.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #define DEVICE_NAME		"aspeed-espi"
+#define ASPEED_ESPI_LUN_PATH_MAX	256
+
+enum aspeed_tafs_mode {
+	TAFS_MODE_SW = 1,
+};
+
+struct aspeed_espi_lun;
+
+struct aspeed_espi_flash {
+	struct {
+		enum aspeed_tafs_mode mode;
+		phys_addr_t taddr;
+		resource_size_t size;
+	} tafs;
+
+	struct {
+		bool enable;
+		void *tx_virt;
+		dma_addr_t tx_addr;
+		void *rx_virt;
+		dma_addr_t rx_addr;
+	} dma;
+
+	struct mutex tx_mtx; /* protects tx virt/addr */
+
+	struct work_struct rx_work;
+
+	struct mutex lun_mtx; /* protects lun metadata r/w */
+	struct aspeed_espi_lun *lun;
+	char lun_path[ASPEED_ESPI_LUN_PATH_MAX];
+	bool lun_ro;
+};
 
 struct aspeed_espi {
 	struct platform_device *pdev;
@@ -21,6 +56,7 @@ struct aspeed_espi {
 	struct clk *clk;
 	int dev_id;
 	int irq;
+	struct aspeed_espi_flash flash;
 	const struct aspeed_espi_ops *ops;
 };
 
diff --git a/drivers/soc/aspeed/espi/ast2600-espi.c b/drivers/soc/aspeed/espi/ast2600-espi.c
index 8effd0404d1f..c3ea01866b45 100644
--- a/drivers/soc/aspeed/espi/ast2600-espi.c
+++ b/drivers/soc/aspeed/espi/ast2600-espi.c
@@ -7,6 +7,7 @@
 #include <linux/reset.h>
 
 #include "aspeed-espi.h"
+#include "aspeed-espi-comm.h"
 #include "ast2600-espi.h"
 
 static void ast2600_espi_perif_isr(struct aspeed_espi *espi)
@@ -93,6 +94,166 @@ int ast2600_espi_perif_remove(struct aspeed_espi *espi)
 	return 0;
 }
 
+static void ast2600_espi_flash_isr(struct aspeed_espi *espi)
+{
+	struct aspeed_espi_flash *flash;
+	u32 sts;
+
+	flash = &espi->flash;
+
+	sts = readl(espi->regs + ESPI_INT_STS);
+
+	if (sts & ESPI_INT_STS_FLASH_RX_CMPLT) {
+		writel(ESPI_INT_STS_FLASH_RX_CMPLT, espi->regs + ESPI_INT_STS);
+		queue_work(system_wq, &flash->rx_work);
+	}
+}
+
+static void ast2600_espi_flash_reset(struct aspeed_espi *espi)
+{
+	struct aspeed_espi_flash *flash;
+	u32 reg;
+
+	flash = &espi->flash;
+
+	writel(ESPI_INT_EN_FLASH, espi->regs + ESPI_INT_EN_CLR);
+	writel(ESPI_INT_STS_FLASH, espi->regs + ESPI_INT_STS);
+
+	reg = readl(espi->regs + ESPI_CTRL);
+	reg &= ~(ESPI_CTRL_FLASH_TX_SW_RST
+		 | ESPI_CTRL_FLASH_RX_SW_RST
+		 | ESPI_CTRL_FLASH_TX_DMA_EN
+		 | ESPI_CTRL_FLASH_RX_DMA_EN
+		 | ESPI_CTRL_FLASH_SW_RDY);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	udelay(1);
+
+	reg |= (ESPI_CTRL_FLASH_TX_SW_RST | ESPI_CTRL_FLASH_RX_SW_RST);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	flash->tafs.mode = TAFS_MODE_SW;
+	reg = readl(espi->regs + ESPI_CTRL) & ~ESPI_CTRL_FLASH_TAFS_MODE;
+	reg |= FIELD_PREP(ESPI_CTRL_FLASH_TAFS_MODE, flash->tafs.mode);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	if (flash->dma.enable) {
+		writel(flash->dma.tx_addr, espi->regs + ESPI_FLASH_TX_DMA);
+		writel(flash->dma.rx_addr, espi->regs + ESPI_FLASH_RX_DMA);
+
+		reg = readl(espi->regs + ESPI_CTRL)
+		      | ESPI_CTRL_FLASH_TX_DMA_EN
+		      | ESPI_CTRL_FLASH_RX_DMA_EN;
+		writel(reg, espi->regs + ESPI_CTRL);
+	}
+
+	writel(ESPI_INT_EN_FLASH_RX_CMPLT, espi->regs + ESPI_INT_EN);
+
+	reg = readl(espi->regs + ESPI_CTRL) | ESPI_CTRL_FLASH_SW_RDY;
+	writel(reg, espi->regs + ESPI_CTRL);
+}
+
+int ast2600_espi_flash_probe(struct aspeed_espi *espi)
+{
+	u32 regs;
+
+	regs = readl(espi->regs + ESPI_STS);
+	if (regs & (ESPI_STS_FLASH_TX_BUSY | ESPI_STS_FLASH_RX_BUSY)) {
+		dev_warn(espi->dev, "eSPI flash channel is busy, deferring...\n");
+		return -EPROBE_DEFER;
+	}
+
+	ast2600_espi_flash_reset(espi);
+	return 0;
+}
+
+int ast2600_espi_flash_remove(struct aspeed_espi *espi)
+{
+	struct aspeed_espi_flash *flash;
+	u32 reg;
+
+	flash = &espi->flash;
+
+	writel(ESPI_INT_EN_FLASH, espi->regs + ESPI_INT_EN_CLR);
+
+	reg = readl(espi->regs + ESPI_CTRL);
+	reg &= ~(ESPI_CTRL_FLASH_TX_DMA_EN
+		 | ESPI_CTRL_FLASH_RX_DMA_EN
+		 | ESPI_CTRL_FLASH_SW_RDY);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	return 0;
+}
+
+int ast2600_espi_flash_get_hdr(struct aspeed_espi *espi,
+			       struct espi_comm_hdr *hdr)
+{
+	u32 reg, len;
+
+	reg = readl(espi->regs + ESPI_FLASH_RX_CTRL);
+	hdr->cyc = FIELD_GET(ESPI_FLASH_RX_CTRL_CYC, reg);
+	hdr->tag = FIELD_GET(ESPI_FLASH_RX_CTRL_TAG, reg);
+	len = FIELD_GET(ESPI_FLASH_RX_CTRL_LEN, reg);
+	hdr->len_h = (len >> 8) & 0xff;
+	hdr->len_l = len & 0xff;
+
+	return 0;
+}
+
+int ast2600_espi_flash_get_pkt(struct aspeed_espi *espi, void *pkt_buf,
+			       size_t pkt_size)
+{
+	u32 i;
+	u8 *pkt;
+
+	pkt = (u8 *)pkt_buf;
+
+	if (espi->flash.dma.enable) {
+		memcpy(pkt, espi->flash.dma.rx_virt, pkt_size);
+	} else {
+		for (i = 0; i < pkt_size; ++i)
+			pkt[i] = readl(espi->regs + ESPI_FLASH_RX_DATA) & 0xff;
+	}
+
+	return 0;
+}
+
+int ast2600_espi_flash_put_pkt(struct aspeed_espi *espi,
+			       struct espi_flash_cmplt hdr, void *pkt_buf,
+			       size_t pkt_size)
+{
+	u32 i, cyc, tag, len, reg;
+	u8 *pkt;
+
+	pkt = (u8 *)pkt_buf;
+
+	if (pkt_buf && pkt_size > 0) {
+		if (espi->flash.dma.enable) {
+			memcpy(espi->flash.dma.tx_virt, pkt, pkt_size);
+			dma_wmb();
+		} else {
+			for (i = 0; i < pkt_size; ++i)
+				writel(pkt[i], espi->regs + ESPI_FLASH_TX_DATA);
+		}
+	}
+
+	cyc = hdr.cyc;
+	tag = hdr.tag;
+	len = (hdr.len_h << 8) | hdr.len_l;
+	reg = FIELD_PREP(ESPI_FLASH_TX_CTRL_CYC, cyc) |
+	      FIELD_PREP(ESPI_FLASH_TX_CTRL_TAG, tag) |
+	      FIELD_PREP(ESPI_FLASH_TX_CTRL_LEN, len) |
+	      ESPI_FLASH_TX_CTRL_TRIG_PEND;
+	writel(reg, espi->regs + ESPI_FLASH_TX_CTRL);
+
+	return 0;
+}
+
+void ast2600_espi_flash_clr_pkt(struct aspeed_espi *espi)
+{
+	writel(ESPI_FLASH_RX_CTRL_SERV_PEND, espi->regs + ESPI_FLASH_RX_CTRL);
+}
+
 /* global control */
 irqreturn_t ast2600_espi_isr(int irq, void *arg)
 {
@@ -108,6 +269,9 @@ irqreturn_t ast2600_espi_isr(int irq, void *arg)
 	if (sts & ESPI_INT_STS_PERIF)
 		ast2600_espi_perif_isr(espi);
 
+	if (sts & ESPI_INT_STS_FLASH_RX_CMPLT)
+		ast2600_espi_flash_isr(espi);
+
 	if (sts & ESPI_INT_STS_RST_DEASSERT) {
 		/* this will clear all interrupt enable and status */
 		reset_control_assert(espi->rst);
@@ -115,6 +279,7 @@ irqreturn_t ast2600_espi_isr(int irq, void *arg)
 
 		ast2600_espi_perif_sw_reset(espi);
 		ast2600_espi_perif_reset(espi);
+		ast2600_espi_flash_reset(espi);
 
 		/* re-enable eSPI_RESET# interrupt */
 		writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN);
diff --git a/drivers/soc/aspeed/espi/ast2600-espi.h b/drivers/soc/aspeed/espi/ast2600-espi.h
index 309479ee1187..251999dba73f 100644
--- a/drivers/soc/aspeed/espi/ast2600-espi.h
+++ b/drivers/soc/aspeed/espi/ast2600-espi.h
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/irqreturn.h>
 #include "aspeed-espi.h"
+#include "aspeed-espi-comm.h"
 
 /* registers */
 #define ESPI_CTRL				0x000
@@ -27,13 +28,15 @@
 #define   ESPI_CTRL_PERIF_NP_TX_DMA_EN		BIT(19)
 #define   ESPI_CTRL_PERIF_PC_TX_DMA_EN		BIT(17)
 #define   ESPI_CTRL_PERIF_PC_RX_DMA_EN		BIT(16)
-#define   ESPI_CTRL_FLASH_EDAF_MODE		GENMASK(11, 10)
+#define   ESPI_CTRL_FLASH_TAFS_MODE		GENMASK(11, 10)
 #define   ESPI_CTRL_VW_GPIO_SW			BIT(9)
 #define   ESPI_CTRL_FLASH_SW_RDY		BIT(7)
 #define   ESPI_CTRL_OOB_SW_RDY			BIT(4)
 #define   ESPI_CTRL_VW_SW_RDY			BIT(3)
 #define   ESPI_CTRL_PERIF_SW_RDY		BIT(1)
 #define ESPI_STS				0x004
+#define   ESPI_STS_FLASH_TX_BUSY		BIT(23)
+#define   ESPI_STS_FLASH_RX_BUSY		BIT(22)
 #define ESPI_INT_STS				0x008
 #define   ESPI_INT_STS_RST_DEASSERT		BIT(31)
 #define   ESPI_INT_STS_OOB_RX_TMOUT		BIT(23)
@@ -147,9 +150,9 @@
 #define ESPI_PERIF_MMBI_TADDR			ESPI_PERIF_MCYC_TADDR
 #define ESPI_PERIF_MCYC_MASK			0x08c
 #define ESPI_PERIF_MMBI_MASK			ESPI_PERIF_MCYC_MASK
-#define ESPI_FLASH_EDAF_TADDR			0x090
-#define   ESPI_FLASH_EDAF_TADDR_BASE		GENMASK(31, 24)
-#define   ESPI_FLASH_EDAF_TADDR_MASK		GENMASK(15, 8)
+#define ESPI_FLASH_TAFS_TADDR			0x090
+#define   ESPI_FLASH_TAFS_TADDR_BASE		GENMASK(31, 24)
+#define   ESPI_FLASH_TAFS_TADDR_MASK		GENMASK(15, 8)
 #define ESPI_VW_SYSEVT_INT_EN			0x094
 #define ESPI_VW_SYSEVT				0x098
 #define   ESPI_VW_SYSEVT_HOST_RST_ACK		BIT(27)
@@ -287,5 +290,13 @@ int ast2600_espi_oob_probe(struct aspeed_espi *espi);
 int ast2600_espi_oob_remove(struct aspeed_espi *espi);
 int ast2600_espi_flash_probe(struct aspeed_espi *espi);
 int ast2600_espi_flash_remove(struct aspeed_espi *espi);
+int ast2600_espi_flash_get_hdr(struct aspeed_espi *espi,
+			       struct espi_comm_hdr *hdr);
+int ast2600_espi_flash_get_pkt(struct aspeed_espi *espi, void *pkt_buf,
+			       size_t pkt_size);
+int ast2600_espi_flash_put_pkt(struct aspeed_espi *espi,
+			       struct espi_flash_cmplt hdr, void *pkt_buf,
+			       size_t pkt_size);
+void ast2600_espi_flash_clr_pkt(struct aspeed_espi *espi);
 irqreturn_t ast2600_espi_isr(int irq, void *arg);
 #endif

-- 
2.34.1



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D4606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IoiAq0lz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDGyh0Pp1z2yR1;
	Tue, 27 Oct 2026 15:01:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793068843;
	cv=none; b=VTjmCygUD+5up6kblmPx1hgtCfFiyA4JyUWlSApGc+SEVYR67i8LImeerQx5wwuMDkSe31UAoCWXbV1X6iRnWPvRM05pgrP7+dkWmgCCAkaiTJkDqDw715JoOE4v5XzKd7zAnB7Wey9Z+nN4r7ZqGFVHwLpSvJX3ybDH3sg4nGyFn6amgF2RnjoVaVJ98igsfIHfWyb94T5+WWf8BLUapA72rJsidqzuXt6RcsvpSNkpnC2qZPt2uCu01Jt+0aqJ7z8gSCiU/lcIT9NbfiTokUinUDUfWS5J6jKaX/6C9loMkWqNhLAYqODQsGht5bru5EeWf84EU0iYBVeojP89ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793068843; c=relaxed/relaxed;
	bh=/r7sbHgOMl6flEmwGOSI95NWBozhJ6tRqgN4OdIa9Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cINGAPbX0pcc230XTiUzh0/h0efvNCc21by4O2QLvsHVsOEnDOW/lfAyYnnXbHj3Oq0/zqAu1de+IJ8Kr8WqQoipWDeZVQNs+o7IfHpORYhW1A3Wk86xEmjUPFEY4Esf/hjxnof1F8ykVnGc2RXw3iSbYbJ+vWdrunHcReYX2TxTasLVKXhGNJq/67AmPQwYe02x1wEf3t/7FwGNOtbOdn0r0aMbNGZeCwwcIlVFIY3B1cYdkryIYXH30353riLwOE2dSkkx7bEEcg/BJtQ6eAMUuvENj547T5lVu29QQwnNwGkp2BCSsS6ED0sD6UgboANOS7nJyID2/3l+HCkoDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IoiAq0lz; dkim-atps=neutral; spf=pass (client-ip=115.124.28.217; helo=out28-217.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaopeng.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IoiAq0lz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaopeng.com (client-ip=115.124.28.217; helo=out28-217.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDF953z4Fz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 13:40:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793068832; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/r7sbHgOMl6flEmwGOSI95NWBozhJ6tRqgN4OdIa9Ik=;
	b=IoiAq0lzz+Xa6mNkUhwDZ20qZTPimJZ+yMNOLFBjAy3pFImNXVJELiwPZhH6lFj8Bh621T7uSxSNnEabKQkkjwJL0gdvgM+pPlu8fUUn8iFVZMzKMya4/U3G3EBVAGcjz+xJE7O3PYfCvebKZKkIj/Iow0pf4oiSQNwbPZ8EWpE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439248|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.011536-0.00151875-0.986945;FP=14732518330469582032|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jqKXZaa_1793068829;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jqKXZaa_1793068829 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 10:40:30 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: neal_liu@aspeedtech.com,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	zhugl3@xiaopeng.com,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: aspeed_udc: fix u16 truncation of descriptor lengths
Date: Tue, 27 Oct 2026 10:40:13 +0800
Message-ID: <20261027024029.1310175-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ast_udc_epn_kick_desc() computes tx_len as u32 bounded by
AST_EP_DMA_DESC_MAX_LEN * AST_UDC_DESCS_COUNT (7680 * 256, roughly
1.88 MB) and hands it to ast_dma_descriptor_setup(), whose tx_len
parameter is u16.  The length is truncated to the low 16 bits before
the descriptor list is built, so a descriptor-mode IN request larger
than 64 KB is described -- and therefore transferred -- as only
tx_len % 64 KB bytes.

The caller still accounts the full, untruncated length:

	req->actual_dma_length += tx_len;

so req->actual_dma_length never equals req->req.actual and the "more
requests" check in ast_udc_epn_handle_desc() never kicks the next
stage.  The request never completes and the endpoint queue stops
draining.

The same handler accumulates the per-descriptor transfer lengths of a
stage into a u16 total_len.  Each descriptor carries up to 8191 bytes
(EP_DESC1_IN_LEN mask 0x1fff) and up to AST_UDC_DESCS_COUNT (256)
descriptors are walked, so once the truncation above is fixed the sum
can exceed the u16 range: a full stage covers 7680 * 256 bytes, which
wraps modulo 64 KB to a value smaller than ep->ep.maxpacket.  The
short-packet check then believes the stage was short, completes the
request before the whole transfer has finished, and adds a length to
req->req.actual that does not match what was really moved.

Widen both the tx_len parameter and the total_len accumulator to u32.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 54f81e668009..f8c58158bd51 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -472,7 +472,7 @@ static void ast_udc_ep_free_request(struct usb_ep *_ep,
 }
 
 static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32 dma_buf,
-				    u16 tx_len, struct ast_udc_request *req)
+				    u32 tx_len, struct ast_udc_request *req)
 {
 	struct ast_udc_dev *udc = ep->udc;
 	struct device *dev = &udc->pdev->dev;
@@ -899,7 +899,7 @@ static void ast_udc_epn_handle_desc(struct ast_udc_dev *udc, u16 ep_num)
 	struct ast_udc_request *req;
 	u32 proc_sts, wr_ptr, rd_ptr;
 	u32 len_in_desc, ctrl;
-	u16 total_len = 0;
+	u32 total_len = 0;
 	int i;
 
 	if (list_empty(&ep->queue)) {
-- 
2.50.1



Return-Path: <linux-aspeed+bounces-5024-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83872C982D0
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 23:45:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmC6v4Z45z2y8p;
	Fri, 18 Sep 2026 09:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.195
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789641140;
	cv=none; b=mowaV47xwnSKeM5Ag2nozSEH7HnRtNFEuhi2zQwv/hLqeHSZu4T6loCQBbvlolW3MggTzLVp/Mnpfg85KaukBJqk0Ycm7QuvFktRHxQbJqO+RXQCXBEoLQtza/pK8tpdTDOCwLt6pTLdIohwBonag6B2b/y0ZiVzXgasXByHewJRB80NVSVDMpEfEu2aLi4+HKsnzfohPS+fv41SAIpVrpksMA0V8Utkj6mMOVaZrnT1Jo+EFsIM8/124gp5sOO1LgRKg+KB/Mlur7zCTrri+XWCBkEe2e9KiEo5oKULjMdu55+cxgQnRHi7k62sypgERK4mWOFx3CebcevFZ543RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789641140; c=relaxed/relaxed;
	bh=92DqYzsY5tQw8zrK7ygfUYU1Rl0yvZP1MFAZ/+j1d2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byB760hRKqolcxdZ7NWD4eAasYOznL1UCBHV+ssQjvdLy16Ve9yX1f73S8+G72234zNkGLX9r6oNac2qTUeC9fCIi6xBZbEmXT64OmV34AZscWJIrcexB/Xe7DROAtkz6Bm3oFhSaylLGZEBctn67/2kuqZ11/DWru9GbMrGMwhbTHUqXbDExnYga4zXLoRXoOmM+3hKaFTpUYnYwjnF1cvZk0uWbsngEqsqqojO2JlKriGFCp/HeL9kO+QKIV0ZPrI4iID6l+S/fxa1aG5XaTpLNS693RfJZgaEqQ9da3s0Uie+e2nrH/xphq3uL8E+6HuNoLvxLcXyB48zBbwPVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DIFBv9vz; dkim-atps=neutral; spf=pass (client-ip=115.124.28.195; helo=out28-195.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaopeng.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DIFBv9vz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaopeng.com (client-ip=115.124.28.195; helo=out28-195.mail.aliyun.com; envelope-from=liuc63@xiaopeng.com; receiver=lists.ozlabs.org)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlsWj2NQBz2y2Q
	for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Sep 2026 20:32:14 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789641129; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=92DqYzsY5tQw8zrK7ygfUYU1Rl0yvZP1MFAZ/+j1d2Y=;
	b=DIFBv9vzZDQyghPTPFIYA0+tJtS0/Bycsd6zdJOd7AO2XAjek9+nx2YjOdaQRGCKJMrCGHqgxShrOPLv4w2wlRH2U5wotUY/n6ZYqlQo4/dpvC2f1CB+fm/frxsmaIJi+hQlr4vLrZtw/d5WGF8G/lHKrimv5pgmxqmv/ecReJs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743678|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0333185-0.00133189-0.96535;FP=10121135997339731664|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jFzyINx_1789641126;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFzyINx_1789641126 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 18:32:07 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: neal_liu@aspeedtech.com,
	gregkh@linuxfoundation.org
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: aspeed: clamp transfer length in RX completion handlers
Date: Thu, 17 Sep 2026 18:32:04 +0800
Message-ID: <20260917103205.3049861-1-liuc63@xiaopeng.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ast_udc_ep0_out(), ast_udc_epn_handle() and ast_udc_epn_handle_desc()
read the received byte count from hardware registers and add it to
req->req.actual without clamping against the remaining buffer space
(req->req.length - req->req.actual).

When actual reaches or exceeds length, the subsequent DMA has already
written past the end of the request buffer.  Across multiple short
packets the overrun grows with each completion.

A malicious or malfunctioning USB host can exploit this to trigger a
heap buffer overflow in any gadget function (e.g. f_mass_storage,
f_fs) layered on top of this UDC.

Clamp the received length to the remaining space before accumulating
it in all three RX completion paths.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 54f81e668..53f6218b4 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -793,6 +793,8 @@ static void ast_udc_ep0_out(struct ast_udc_dev *udc)
 	req = list_entry(ep->queue.next, struct ast_udc_request, queue);
 
 	rx_len = EP0_GET_RX_LEN(ast_udc_read(udc, AST_UDC_EP0_CTRL));
+	if (rx_len > req->req.length - req->req.actual)
+		rx_len = req->req.length - req->req.actual;
 	req->req.actual += rx_len;
 
 	SETUP_DBG(udc, "req %p (%d/%d)\n", req,
@@ -865,6 +867,8 @@ static void ast_udc_epn_handle(struct ast_udc_dev *udc, u16 ep_num)
 	req = list_first_entry(&ep->queue, struct ast_udc_request, queue);
 
 	len = EP_DMA_GET_TX_SIZE(ast_ep_read(ep, AST_UDC_EP_DMA_STS));
+	if (len > req->req.length - req->req.actual)
+		len = req->req.length - req->req.actual;
 	req->req.actual += len;
 
 	EP_DBG(ep, "req @%p, length:(%d/%d), %s:0x%x\n", req,
@@ -944,6 +948,8 @@ static void ast_udc_epn_handle_desc(struct ast_udc_dev *udc, u16 ep_num)
 
 	} while (i != wr_ptr);
 
+	if (total_len > req->req.length - req->req.actual)
+		total_len = req->req.length - req->req.actual;
 	req->req.actual += total_len;
 
 	EP_DBG(ep, "req @%p, length:(%d/%d), %s:0x%x\n", req,
-- 
2.50.1



Return-Path: <linux-aspeed+bounces-4200-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8536CCD8CAC
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 23:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ8260DdKz2xJT;
	Tue, 09 Jun 2026 09:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780906809;
	cv=none; b=gQPEi2izCTcz0f718ukIP/0H3u15xDhIXyR9SB0/ygwrX1JkQiw+wtA4DR6OQoVBfLe364rGQltG4a5H9bK+KoE8c3QfUlA3TETtMV4UDtuOciNu55tY8poTp+3vGEueR5DmQ9kBb0/yO28Zfmbdo5yxZA3Ey4JoVGLngry+UTAaA+zRTw9PBRgGlL6VWh9+ur88ugKcRKh05FwbiRO01e9x58U1TAjYzh4XLHtOdDsF6Pu99+XrLIVf6fVomfE+MJtruTbgEEOzXT6ihh5/a5Aa1AgfegWBQwETRp6Kp+bxKJ72G4Wso0+TbRqJot+uBUM63e9vUGU7VfJ9RRSIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780906809; c=relaxed/relaxed;
	bh=QaxSxNePW62N/aLYNU2ICZZcrY71w9JpJK96h4Ml418=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5smtTn8u1/kojvq+kEVPlznhadmSLj1dsth0PhSYmQDaCBEQ5WAX0D2BhzJ/OEeXLpF9Pf7YqZKnXFpcecmFHylLCR+zey88Tw+/+/PR0lXNVucGjNzbTr5/QTaJO1vuCMU4y1DKC/FIny4Kurm+LN7nlvuwvdRWFMczqrowWN9+O7Te760g7O50xmyDUxYAwsNH6YavBPLT3tjXxQNkEqIyftoFooA+cHbAJYgHqbEypXTRiDklFtCvhjOEa7ZhnTwXv6mn9YfRnJyCDuV/otDF+B3W0ulKfXFWRdTkqiXpcaiCJFzigKMp57vSI6arqebUqo5MHJEKsjdxF+nrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jW958x5Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jW958x5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYlMr5fqVz2xWP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 18:20:07 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c0bd02d97eso46736395ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780906805; x=1781511605; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaxSxNePW62N/aLYNU2ICZZcrY71w9JpJK96h4Ml418=;
        b=jW958x5Z3/vRnqzT5tnySyiKL/qd+jC8w4xmQRfha/+PvqfYFmh9CdYczZs/AwZ2eB
         V9Um/3dqg0KB/q0Jqi2mWRaNDXdOhrXs1GkDWXaJL4I6yic49C/yaMk7KhJaEKkgmyyv
         iqH31cnu04cBhME73Xq+xz3mwSh4g3N2I2Coau90z9eGH2fmyRacWV4TwhYl4+IdIcbp
         5VfC8LpVwSRv/SWgtIrPt0s8/O2cDCL++NouaahlUk3VxBC8y29pPV5X/20kLIJTdNI2
         GZ0rK/QWAoVrN7bRrXa7CssqzRjy53v1hjGnljcdSVnO3qHE93pWRTAl9p5oPcwfJF5+
         BY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906805; x=1781511605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaxSxNePW62N/aLYNU2ICZZcrY71w9JpJK96h4Ml418=;
        b=H0YCJ/snX3DFqjmxYKyJfes1+zptyIFFTHSaAExLgnaPE5HpbRutGuAzSfSA2BFMoF
         2EAwifh/BEDN+EoK3BAxQoY+swVyN1Yym1TABzHTh+eD3f3+YG2m3Wn7Gs89gJIVCbTN
         ojtZPeB6jd8cZsrXV0zGsGLkmIAg2WofL3ahZSddUPqWzutnlaN/Y+/p6zAVVpE4oXlR
         IITURAmlgwB4S3Mvcibkc/+YuPj6XzchQiCaiBwfvWznnn9jl+wbLDRur/d9IxGeg/kr
         K56BOIy6RZKWi/dsSHRjOHU3/KjQ+vtfUbGy0RN0/JpY0naQRugD3ygqbpadsvh/jAmo
         huAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+z3ME17/dgtIG50OF0LxWdI1EZpF2fbeIVVqB83f8eQr/dRLMmJvZIZQimRdRvrxhTOQVijqDUYaahKPY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyyq+BV2JOgeEKaIMd2siNXx72QE/Wayfv9YD3JTj8B+lhtCfL4
	LTmF9pqxHvTh3XRFp1db3usjqZmKJNrw9E4L7phwmOJPQ24zn1kpiDKe
X-Gm-Gg: Acq92OEkQ2FV5bwog0rPM/snnr62DmSyZKe4ds3KvNQFr/N1O3z28C+V0fa+0oo/7g9
	KushAFa2zY4KyOxw8E8A3ukgXhc41t9hLGlMzYgUaTUtFy6209X67KdsMj8wgjXwPeYU75K3+fy
	2sgg8XU8sLkvCAZanLJAC1bJbaOrWnuGXPrZMkzuDV0XhLGg5jNsxY6AIHv7RnrHumXCQ74lAru
	O3fCnv1RP7sgR1uL2GZjMxJP/pLiGDLyUm5Ro4BYZ46ji0ZKitLaCmgn/1V75qyL2lxHBxBMKK4
	Vy3lbfkd9JFP780zZBh2k1ByyjDtMOz2LQ9yyyCDYqN8cbqdUl+3kwYpMzsw62aw8RjkVY/0VhN
	3dcPlJ9m7kU8/lCDKd1YO5bIGBi+TAsNS8SicrQVBRZchOidiHDBRwrZQnGh00GT2aqCUkcvbGl
	rW3kCHe8LP+A5E0w+ZLcFulkDFgoNIIn4pCIW7eYAGapcfXKxSVdLu
X-Received: by 2002:a17:903:3c48:b0:2c0:eee2:fc40 with SMTP id d9443c01a7336-2c1e80cede0mr162261145ad.3.1780906804922;
        Mon, 08 Jun 2026 01:20:04 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:9a2:954d:67fe:d9c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa3a5fsm183050945ad.36.2026.06.08.01.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:20:04 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] usb: gadget: aspeed_udc: check endpoint DMA allocation
Date: Mon,  8 Jun 2026 16:19:48 +0800
Message-ID: <20260608081948.3-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
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

ast_udc_probe() allocates a coherent DMA buffer used as the backing store
for endpoint buffers. ast_udc_init_ep() derives per-endpoint buffer
pointers from udc->ep0_buf, so a failed allocation is dereferenced during
probe.

Check the allocation before endpoint setup. The existing probe error path
called ast_udc_remove(), which unregisters the gadget unconditionally and
is not safe before usb_add_gadget_udc() succeeds. Add a local cleanup
helper for probe failures so pre-registration failures only unwind the
resources that were actually initialized.

This was found by a local static analysis checker for unchecked allocator
returns while scanning Linux 6.16. The change was checked by applying it
to current mainline and by running checkpatch. I do not have access to
Aspeed UDC hardware, so no runtime testing was performed.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Note: a 2022 patch attempted to add only a NULL check for this
allocation:
https://lore.kernel.org/all/20221213025120.23149-1-jiasheng@iscas.ac.cn/

This version also fixes the probe unwind path so the clock is disabled
on allocation failure and usb_del_gadget_udc() is not called before the
gadget has been registered.

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 7fc6696b7..809a7d5b7 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1434,11 +1434,34 @@ static void ast_udc_init_hw(struct ast_udc_dev *udc)
 	ast_udc_write(udc, 0, AST_UDC_EP0_CTRL);
 }
 
+static void ast_udc_cleanup(struct platform_device *pdev)
+{
+	struct ast_udc_dev *udc = platform_get_drvdata(pdev);
+	unsigned long flags;
+	u32 ctrl;
+
+	spin_lock_irqsave(&udc->lock, flags);
+
+	/* Disable upstream port connection */
+	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
+	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
+
+	clk_disable_unprepare(udc->clk);
+
+	spin_unlock_irqrestore(&udc->lock, flags);
+
+	if (udc->ep0_buf)
+		dma_free_coherent(&pdev->dev,
+				  AST_UDC_EP_DMA_SIZE * AST_UDC_NUM_ENDPOINTS,
+				  udc->ep0_buf,
+				  udc->ep0_buf_dma);
+
+	udc->ep0_buf = NULL;
+}
+
 static void ast_udc_remove(struct platform_device *pdev)
 {
 	struct ast_udc_dev *udc = platform_get_drvdata(pdev);
-	unsigned long flags;
-	u32 ctrl;
 
 	usb_del_gadget_udc(&udc->gadget);
 	if (udc->driver) {
@@ -1453,23 +1476,7 @@ static void ast_udc_remove(struct platform_device *pdev)
 		return;
 	}
 
-	spin_lock_irqsave(&udc->lock, flags);
-
-	/* Disable upstream port connection */
-	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
-	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
-
-	clk_disable_unprepare(udc->clk);
-
-	spin_unlock_irqrestore(&udc->lock, flags);
-
-	if (udc->ep0_buf)
-		dma_free_coherent(&pdev->dev,
-				  AST_UDC_EP_DMA_SIZE * AST_UDC_NUM_ENDPOINTS,
-				  udc->ep0_buf,
-				  udc->ep0_buf_dma);
-
-	udc->ep0_buf = NULL;
+	ast_udc_cleanup(pdev);
 }
 
 static int ast_udc_probe(struct platform_device *pdev)
@@ -1523,6 +1530,10 @@ static int ast_udc_probe(struct platform_device *pdev)
 					  AST_UDC_EP_DMA_SIZE *
 					  AST_UDC_NUM_ENDPOINTS,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
+	if (!udc->ep0_buf) {
+		rc = -ENOMEM;
+		goto err_disable_clk;
+	}
 
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_HIGH;
@@ -1553,20 +1564,20 @@ static int ast_udc_probe(struct platform_device *pdev)
 	udc->irq = platform_get_irq(pdev, 0);
 	if (udc->irq < 0) {
 		rc = udc->irq;
-		goto err;
+		goto err_cleanup;
 	}
 
 	rc = devm_request_irq(&pdev->dev, udc->irq, ast_udc_isr, 0,
 			      KBUILD_MODNAME, udc);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to request interrupt\n");
-		goto err;
+		goto err_cleanup;
 	}
 
 	rc = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to add gadget udc\n");
-		goto err;
+		goto err_cleanup;
 	}
 
 	dev_info(&pdev->dev, "Initialized udc in USB%s mode\n",
@@ -1574,9 +1585,14 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_disable_clk:
+	clk_disable_unprepare(udc->clk);
+	goto err;
+err_cleanup:
+	ast_udc_cleanup(pdev);
+	goto err;
 err:
 	dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
-	ast_udc_remove(pdev);
 
 	return rc;
 }

-- 
2.51.0


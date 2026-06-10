Return-Path: <linux-aspeed+bounces-4219-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D191CD8CB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 13:05:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5cS5PPvz2yfD;
	Wed, 10 Jun 2026 23:05:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781093434;
	cv=none; b=A7gAVsK+45hh1aOL7yiAsFDVJXju2CKxnVaa9xlPjkCnEeT/uJTB1z7s044IAFiOvXkYx9dT6lnkaCEqaLLyLcc/o9r2X6HDtjUvjOv6oyhXbNbdGBykh/jv9ULx8prnAnTI/mVAQMbJTRVWjyqoMYXLACKpKyuO7eoLjn2Hd2aAcdJM+PGQanbeQ3AgbnFWyGtupbwOJl8wMPT6J/kAok6xUQVT5aWWdNQdJL4BO6mXIZl5wlI2GBFS5jMJ4IK9r7De1ihGoTNYY1aOQJic/g1hCrdcXCjzMtN6kesqzWyyzF4Zjj8ybbgZX1Us77PGzedtQb5XNXBm68sS4/QK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781093434; c=relaxed/relaxed;
	bh=Bn0e0V+HEIAY5dAJYzbVBmSmbmUkCyWOZZSIYcy0Q78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCbqQJqAZrOKTFiqzCC0RZc9Rr7Sou/z1WOBIXGOSbvhBWM86dytMR/MOo8D4fo1bHdMQwUempF9iHB7Oi3zNsz7LqQtPprXgAsAw2bXW8PXPUthrnHIAXN0fdrjaDGqO2ES79BiPce5gpYpokLaOFNb1uQWqKzjpolwWc2JjTq4tJf7/JMMRQOwZja4yurhGtP/gzGeNcIhxuNVNNMUXWRV3khUzIF/x0UOFHVwmH/HC8lybeX+68QrGSSh1eIsghiDRSdg5NhAJAztDqJ2pnrrlS+w4OEDfGR/II6HlvR/3ve2C8gish3ZIzHBM5XSEsGJ9Oum326c15hfPqk1oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3NNAdgl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3NNAdgl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ruoyuw560@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb4Nn2FMnz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 22:10:32 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso3135441a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093430; x=1781698230; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn0e0V+HEIAY5dAJYzbVBmSmbmUkCyWOZZSIYcy0Q78=;
        b=V3NNAdgl3N4VdeIqhoEH5vrx82/w1f9dFL489eYrlzrCDBDaXO/p/IST6eeUbLehPj
         QyOUUpP+Z9g/tA8J86IXtCtSjhPlkGhvVauKUEEmOkxq5zxlKBO93Vy2vFa1FA9JZeKc
         3sbhQgcFKuEIbLlBg0C0DlmQUWeq4F+BkF0/tTCKX+BYMQGRJSWbCppfeyFX3/EW7s0m
         ond3FHrpN3vmMrOjFJ4n/xLmwqPLN8elRuzlpiSUQJDt9/9glSkhjt25v3jScynm0+FK
         dWo6mZBS0/nxplPDEw4jyvqDh94WBQSz8LXn2Z7AndMoJKJW5kvD2d7cRVYPDdPISrSI
         txGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093430; x=1781698230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bn0e0V+HEIAY5dAJYzbVBmSmbmUkCyWOZZSIYcy0Q78=;
        b=BJ5HzCo9doDDcsW5Ede3ahKmwzi9UIWmShDj23Oyx/Ut1/u8YHphPECFyDeWWtu3oo
         QIFPwEW7kLqOVvQf2HEEYaBIqQbMojR2VuM0sEx9NxYzK0/961RvNig6DZOEzCm6qb2g
         yN+gLmHYXU0nT7WMd9TinSnDUcPmOp1DJBw0p0X1qlnnZTOt/EgDzZuFwx5fwkR8i1g6
         d+EMQMPCxW3KyzbKyV3ev96iwOOCbj/SaEcCOQIFyNH1tUHtDyNdiRphr4if2dCz0/ft
         eTSjkLG+CD0lXaa24FGZLh6lKYBw4IQOb9W4SJMI9HfI5N6GIfPEz5hmK37lkqNMjEoy
         hVpw==
X-Forwarded-Encrypted: i=1; AFNElJ/jotDLrgyn3wRWEBahen4bRBSU5vlRvzUtTEjvxPu9lOIj4hqNWR7wUo/KB6rFBlBF9E9j7x6ckNSI4gY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywf5B+vuihFKi2fpZEXAlhQIIMeqC9zQJJqPFldFw7D1iHmqf53
	vUG+JhtAG1k768qWc4JEXEI/PImy95v4EbKQDUMfetlKtZm6MsPoH9Ev
X-Gm-Gg: Acq92OGpXKkduLV5KmytkRDW54sbyNT1vg+u1DyIPu2NunDGauSnPEiTX9PIcgej6HJ
	S4RR1xL7jsy5bI8tzzsJQgXJzpXtrGWOWWLPbuPPy/yalwa83xNpVcp5r7kvfytL54l6qL7Y6vP
	nyd0vCkjNn0L6EcaH/QuMDZZ68j+R715u0moHLFmBSoPjG9lcr1pMPJzM1bO2TwU7bxDqhLr8/p
	5pqauHVVAtzyQNsRqSs97ksrS3VJCUU2eEvXc4rdJ47Rs3QN67TxzYBJF5Jr3BDcxewyF8+0iPt
	UgAnXUpJEUxocONagd8nqc5YVMYVeu9vUMgtLNdsWYgS50OXNQgxHcQ9CDLA4ig/cdbdDqILoDT
	+FtTIfCVRiJtBz6PID+PpaB8zYRqrC1SlFby/8zBhGeKKN09Tk9n+O1FfY1iW3n+VSXUlkhPdmA
	8gN4+UQfUAUofhl50peXmpUSbD6EMgEJI/iDEpuMQoDvUWq3/EB2n8bA==
X-Received: by 2002:a05:6a21:7e89:b0:3b5:530d:d980 with SMTP id adf61e73a8af0-3b5530e0518mr2279602637.20.1781093430459;
        Wed, 10 Jun 2026 05:10:30 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:b72a:532f:bb14:101c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4afdsm24704308a12.19.2026.06.10.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:10:29 -0700 (PDT)
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
Subject: [PATCH v2] usb: gadget: aspeed_udc: check endpoint DMA allocation
Date: Wed, 10 Jun 2026 20:10:22 +0800
Message-ID: <20260610121022.3-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608081948.3-1-ruoyuw560@gmail.com>
References: <20260608081948.3-1-ruoyuw560@gmail.com>
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

v1:
https://lore.kernel.org/all/20260608081948.3-1-ruoyuw560@gmail.com/

Changes in v2:
- Simplify the allocation-failure cleanup path as suggested by Andrew
  Jeffery: disable the clock in the allocation-failure branch and let
  err_cleanup fall through to err.

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1434,25 +1434,12 @@ static void ast_udc_init_hw(struct ast_u
 	ast_udc_write(udc, 0, AST_UDC_EP0_CTRL);
 }
 
-static void ast_udc_remove(struct platform_device *pdev)
+static void ast_udc_cleanup(struct platform_device *pdev)
 {
 	struct ast_udc_dev *udc = platform_get_drvdata(pdev);
 	unsigned long flags;
 	u32 ctrl;
 
-	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver) {
-		/*
-		 * This is broken as only some cleanup is skipped, *udev is
-		 * freed and the register mapping goes away. Any further usage
-		 * probably crashes. Also the device is unbound, so the skipped
-		 * cleanup is never catched up later.
-		 */
-		dev_alert(&pdev->dev,
-			  "Driver is busy and still going away. Fasten your seat belts!\n");
-		return;
-	}
-
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* Disable upstream port connection */
@@ -1472,6 +1459,26 @@ static void ast_udc_remove(struct platfo
 	udc->ep0_buf = NULL;
 }
 
+static void ast_udc_remove(struct platform_device *pdev)
+{
+	struct ast_udc_dev *udc = platform_get_drvdata(pdev);
+
+	usb_del_gadget_udc(&udc->gadget);
+	if (udc->driver) {
+		/*
+		 * This is broken as only some cleanup is skipped, *udev is
+		 * freed and the register mapping goes away. Any further usage
+		 * probably crashes. Also the device is unbound, so the skipped
+		 * cleanup is never catched up later.
+		 */
+		dev_alert(&pdev->dev,
+			  "Driver is busy and still going away. Fasten your seat belts!\n");
+		return;
+	}
+
+	ast_udc_cleanup(pdev);
+}
+
 static int ast_udc_probe(struct platform_device *pdev)
 {
 	enum usb_device_speed max_speed;
@@ -1524,6 +1531,12 @@ static int ast_udc_probe(struct platform
 					  AST_UDC_NUM_ENDPOINTS,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
 
+	if (!udc->ep0_buf) {
+		clk_disable_unprepare(udc->clk);
+		rc = -ENOMEM;
+		goto err;
+	}
+
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_HIGH;
 	udc->creq = udc->reg + AST_UDC_SETUP0;
@@ -1553,20 +1566,20 @@ static int ast_udc_probe(struct platform
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
@@ -1574,9 +1587,10 @@ static int ast_udc_probe(struct platform
 
 	return 0;
 
+err_cleanup:
+	ast_udc_cleanup(pdev);
 err:
 	dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
-	ast_udc_remove(pdev);
 
 	return rc;
 }


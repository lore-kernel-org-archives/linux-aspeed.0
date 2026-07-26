Return-Path: <linux-aspeed+bounces-4554-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB53C531CC
	for <linux-aspeed@archiver.kernel.org>; Sun, 26 Jul 2026 06:46:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7C1H1zzkz2xyk;
	Sun, 26 Jul 2026 16:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785045377;
	cv=none; b=MvSJOY/kvaVdbFRkkEVNiy6r2Hnp0NzVzBx/vfalb7GMsnD8z2TEWk9cMbv33aSHXs7D5f3SKwvcE5naNNW6hY4IK2EIHP2Gs8BE/U4uJnALBVfllBD2WfyRuHE8q21Li5cFDAg5XFS8PMFCTMnBAldebioe2p9Ra1idYH86BV9BIiVRYzcnY4wxFqGJZzc3bj0deoPaqL/Us9XyUL0lqrMSil21kIsCnz+6Aq1o1UCJryDg8oP7clyaASJRz8zuUniPDara2DM2lDS4+csa9kQwNBt0MJz1pRrUukgdUM/7L2ROWGiL8aK/FB7hUDK7pxaask2JOZGkh6U1LEwvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785045377; c=relaxed/relaxed;
	bh=AUcD5ksjUKN4lUkCAGne15+WHerBURaeoW1rDkQe+0E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=egyaADHDZfqUuMQwBmhSqgczKgbY8kdu6MyH5eiZ+k4eTtNRo6UQjKkkFkMFXhqn0G0srL9koQ/KNi0enXx4L5hzzj5dmUBFoOOtUpQOkXzFR3oWf8S9DX68w5AC8fdEJx2SCoUg2C7hFXrpLyrT1YWnq5g+RyUF/LAXI19tKpXz5OXoaY24+PSbyWYDSYaPNUi6F5Y0tdxA3UAPLG8bTo8nKpMqnWUBH6gnmpB5DFj701pdKyxsrkFpns11Y85WxkBvc92JGV+k1f0Y5Hx0I1laXtRgJYvQmt0B9ROmggjNd+5y03q3XeVsB8zZhGBG9SOlvG4p4cd8UsL+F6WxIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WZQWhyEW; dkim-atps=neutral; spf=pass (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=1298662399@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WZQWhyEW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=1298662399@qq.com; receiver=lists.ozlabs.org)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4h79vc0qXCz2xLg
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 15:56:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785045365; bh=AUcD5ksjUKN4lUkCAGne15+WHerBURaeoW1rDkQe+0E=;
	h=From:To:Cc:Subject:Date;
	b=WZQWhyEWPovPNJrmS7beefeZ6A7z9bn0qR138Xj7RZjFlQMUk6fxl5KjhYSDBjo/W
	 6XaaI9Z7MjSCItGX46cILtxESb5DWLWtInr4xNxdycUJFs30H+Ivo+96wPL80S5q0l
	 Ob9ZUTzFduz6KyQrWUic5q6byKrjSCyGMjI1ZHwo=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id D119CEA3; Sun, 26 Jul 2026 13:52:17 +0800
X-QQ-mid: xmsmtpt1785045137t7lk3fqds
Message-ID: <tencent_6E0FD0F7F7BD32B33EACC80AB25B97C26905@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5vSxp2mtbmBjvV0CTeSn8BFhV6yybodv5U8x88r+qSOWsTPGDu3
	 Gg2y/0d6uYEhugUhdBMLZLD5wSfnsgpxiA7cEBrhoTRRZ3GtaUf7k4d943j/CqWv3ibHxFfHOakt
	 INdCMg/T0lvCZ22ScsQZDidgW3aNddN5fA5dh32huhGC5kVi/77WeiHUSlRLUsG2ephhhcwzQ1xR
	 jNad3DkCWA2M4479gb4/e2Hi8tQ9HHKE9SjT/yE7YaEYm3Zhenqq5WjqRL2tF45l24c6H/vHdyRq
	 rcfdPae6zYlo7jq5z4cdAdpxOoOJvO6Yqr3rlGnbd8CLD4xRwFxf3swcpJMSavoFJYYcLUZpmxgY
	 WGdmt+EFFYUrspcVSavMFHT4ppxDo+0OW1Iq629TRsDZfUmjwZ2MLNsfJcwlE/Ei4ljXxDtIteJk
	 CcgOBWMGP2b4nkI75CfQKGqIkT26wRCGeLfDEVphOOaiBjLLMjmU4sya3knM8d7vWhEEMH6kvUOp
	 Lkyw9WshRN/dOYjyHVcJ7OxeSgg/wiNeci3B8FXJ2lscUfSuxG5E030U8iJxptoL8XDwQHhH7ulL
	 681kAs3TXPos5yZ7pvVWJ/95nmvkHFwf/xZ7tzZnMGbQM3Gxv8hJw+RKWc4BwcBO9J6RioGw/7dH
	 9AND1dKCxtS1UFhTuo8UIj6yoy4UlJ6Rc9k9aIckBH94bPmACrlUsDTqVRyjbF16MdcN4+8/3kxH
	 jIUxO4A/1XktU8aVc7RL/6a+ait1RHbKWbUKGJovSdj3iulS8Fs8xOJo4iN+ODiGCGp9yjKi0UUV
	 plVz6v2WzeyV1VkDEm4ZNTp+sSIW5YZnu0geu5N5jrkmzeyjmVWcD0gpVwxDIGH2j631XNcVKiqh
	 gDBXL4X1Au7QmM4kV3WMYVEtpoMrWOcfCjCpAQLvfihbA5JME8z6RBPoY1fI5A2GhfG3NC4cnTSd
	 EcBUaFUJW5WstlP/lajmV08qsa1Buu9bJx8ntyXVZtL0J6SHUCkSEhuT6C2wxn+T+OYIFyxD8G8a
	 MsctCgxsLY4uWdqg0vFL4/GScGf182c+OJdvxpLjzb69SVpUNNYxijHJG4mZc=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jiawen Liu <1298662399@qq.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] usb: gadget: aspeed_udc: fix probe error cleanup
Date: Sun, 26 Jul 2026 09:52:15 +0400
X-OQ-MSGID: <20260726055215.1389043-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
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

ast_udc_probe() jumps to one shared error label for failures after driver
data is installed.  That label calls ast_udc_remove(), but remove assumes
that the gadget has been registered successfully and that later probe
resources are initialized.

For example, failures before usb_add_gadget_udc() can call
usb_del_gadget_udc() through ast_udc_remove() even though gadget->udc has
not been set up by the UDC core.  Failures before or after DMA allocation
also take the same remove-style path.

Use staged probe error labels instead: free the endpoint DMA buffer only
after it has been allocated, and disable the clock only after it has been
enabled.  While doing this, also handle dma_alloc_coherent() failure
explicitly.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 75f9c831b21a..877a9f7539f7 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1474,6 +1474,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	enum usb_device_speed max_speed;
 	struct device *dev = &pdev->dev;
 	struct ast_udc_dev *udc;
+	size_t ep0_buf_size;
 	int rc;
 
 	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
@@ -1516,10 +1517,14 @@ static int ast_udc_probe(struct platform_device *pdev)
 	/*
 	 * Allocate DMA buffers for all EPs in one chunk
 	 */
+	ep0_buf_size = AST_UDC_EP_DMA_SIZE * AST_UDC_NUM_ENDPOINTS;
 	udc->ep0_buf = dma_alloc_coherent(&pdev->dev,
-					  AST_UDC_EP_DMA_SIZE *
-					  AST_UDC_NUM_ENDPOINTS,
+					  ep0_buf_size,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
+	if (!udc->ep0_buf) {
+		rc = -ENOMEM;
+		goto err_disable_clk;
+	}
 
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_HIGH;
@@ -1550,20 +1555,20 @@ static int ast_udc_probe(struct platform_device *pdev)
 	udc->irq = platform_get_irq(pdev, 0);
 	if (udc->irq < 0) {
 		rc = udc->irq;
-		goto err;
+		goto err_free_ep0_buf;
 	}
 
 	rc = devm_request_irq(&pdev->dev, udc->irq, ast_udc_isr, 0,
 			      KBUILD_MODNAME, udc);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to request interrupt\n");
-		goto err;
+		goto err_free_ep0_buf;
 	}
 
 	rc = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to add gadget udc\n");
-		goto err;
+		goto err_free_ep0_buf;
 	}
 
 	dev_info(&pdev->dev, "Initialized udc in USB%s mode\n",
@@ -1571,9 +1576,15 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_ep0_buf:
+	dma_free_coherent(&pdev->dev,
+			  ep0_buf_size, udc->ep0_buf,
+			  udc->ep0_buf_dma);
+	udc->ep0_buf = NULL;
+err_disable_clk:
+	clk_disable_unprepare(udc->clk);
 err:
 	dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
-	ast_udc_remove(pdev);
 
 	return rc;
 }
-- 
2.34.1



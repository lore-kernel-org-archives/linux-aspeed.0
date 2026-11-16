Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09341606A323
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Nov 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XISsBhif
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT1nS0VPnz2xGr;
	Tue, 17 Nov 2026 08:53:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.224.83.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794839731;
	cv=none; b=lWbIiy8/lQYV3YksDXOrb01XV9TCCmoI4wBRNTGiPwS/y8tEdTVSiKSETLj5D/yc84RqffWN0RJDBke2N79oksLU1gSdx/Z29Fvr0AZhEW5IpAYTTcXy9BgUhVvEnoDh6w/4p2eZ3aIcpZ+iRlbvaLCjD48nbdk7wBQoXELoU18jhDGKtO0hCDNR9M0Xk3jr7jp7oocH16LbWUM7RSbHOo1eyoh/PQqg0mAzGTY5FIzx1oRgop+u03p1xG/6GnxapSgrfa/VW0ejmHoSZlMcdK1+QoAZ0jgGVOtGopuKoB9O+kZsEUx4J3od3P2cMRrWHr2syNMTsOXL+of1wUIPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794839731; c=relaxed/relaxed;
	bh=vsitf1gCOt+86OlSnGNHzwq1zmuiy2PBWHlc3qqYy+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUQO5JZAiu3bMeNHacQGKwTjsN1R5F3zJ71indub/ifH+RNyvj8awCbkgld/hMnxt18yt+xYlp+OkiFaBErP+IkrsMtNMIbOZlwtw2xkMIrwc50JFtjx8tYfpWIxTrw8ZTRL4MPhYa4cCKHQBgZZRE0hTvgm2lMq5AQ7IhC7S9gMRKetskxxHRGVM9C/YgyKsthljPTcNRSYoRtVBfAI9OXYuLDC8XkslVqD1iyeeVfWxqXqJG/4wpVc1yJ9dFzHv3aLzE3RiTXylojLujHLsB5hxCB147/4GIxn4KrA82kzBLJITjBP9RZVXMSFBUJo2WB/sdHxiWdniI0z2auq/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XISsBhif; dkim-atps=neutral; spf=pass (client-ip=156.224.83.18; helo=mail-m8318.xmail.ntesmail.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XISsBhif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=156.224.83.18; helo=mail-m8318.xmail.ntesmail.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 303 seconds by postgrey-1.37 at boromir; Tue, 17 Nov 2026 01:35:27 AEDT
Received: from mail-m8318.xmail.ntesmail.com (mail-m8318.xmail.ntesmail.com [156.224.83.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSr4b4j4Hz2xfX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 01:35:27 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54dbcb476;
	Mon, 16 Nov 2026 22:24:29 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: 8250_aspeed_vuart: Fix potential stale port on probe failure
Date: Mon, 16 Nov 2026 22:24:28 +0800
Message-ID: <20261116-c29ba55625-serial-aspeed@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e4bec2f203a1kunm8be27f0910e50c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0NKVkhOTR9JGh5CGE9MSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=XISsBhifYCn6xh7OaTRbFGgVwiNZZiOpkthsG6JNvk/Z/i6mtIwSCXIOBml8hm6ef4Hr0L+SAmpO8kJt09+6ziFv1NkOJ838dmKWYaXigNYLolHm7Ss50Jr10pdVwp/2F8qJqvoI1xFDpiNrm/dRw8kN0YJ7F/Vx/F2d3LdYnjA=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=vsitf1gCOt+86OlSnGNHzwq1zmuiy2PBWHlc3qqYy+Q=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Invalid LPC configuration can fail probe after the UART port has been
registered. Removing only the sysfs group leaves a port whose private
data and mappings are released by device-managed cleanup.

Disable the VUART, shut down its timer and unregister the port before
returning from these failures.

This issue was found by our static analysis tool under development.

Fixes: ca03042f0f12 ("serial: 8250_aspeed_vuart: add aspeed, lpc-io-reg and aspeed, lpc-interrupts DT properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index c8dc87f6886c..2cd1c9146ec8 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -513,7 +513,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_lpc_address(vuart, prop);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
@@ -525,14 +525,14 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid sirq number in aspeed,lpc-interrupts property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
 	if (sirq_polarity < 0) {
 		rc = dev_err_probe(dev, sirq_polarity,
 				   "invalid sirq polarity in aspeed,lpc-interrupts property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
@@ -543,6 +543,10 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unregister_port:
+	aspeed_vuart_set_enabled(vuart, false);
+	timer_shutdown_sync(&vuart->unthrottle_timer);
+	serial8250_unregister_port(vuart->port);
 err_sysfs_remove:
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	return rc;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4


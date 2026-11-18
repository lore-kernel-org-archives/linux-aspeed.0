Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCCA606A32C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SJqmsQ0u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV47J3c82z2xSl;
	Thu, 19 Nov 2026 01:42:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795012924;
	cv=none; b=de+J7rCyQR2HqW7q75jW4qeajA0gBsPijMrHxXcqbtZsHdAMvtjnpo/1MDz3C4/mtR7lDytNhvvXrcp9e9/DDj+qPz+3VbutL+7rrWz7DwwnbAw/uLoFnY3OJQA6vaSsvc0U1uR7NtnREdeASqaVW4eLzjZkM+mooEIla5o5RpeJ9RMMgMd4OKpGYJwXncITZ7oebk60Vdq6uBRDRKtUVXUtHkoYVuRNDFBCZ6h+dJX6AzsQB45a18ymFqUcQjmhG2MqRdgc6Eqb4mO2RTQ9y/HOapxb/SR8Tt8iWlKFPF3b3mlHMu6PCYWRu+JS9Bq7hPEGl8lspdXJUdPAxyQrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795012924; c=relaxed/relaxed;
	bh=nFXqbRa1OhelbFVhcjizOVyRIMqDJEhst38NtKslZYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jimpgOdIB8kfeNn+OqNuiJFbrSMTsIYnkIeTKnOC7rXpGOgfBzgsE/WMm8iGVyGiFDTKe1W64IKx8H3CcC5gefahgOdquGxHWB2VEPGmi2x5TcLXLviFMLygwlgIdwDSd2t1gZxbc7EJlWksf3fpHd1jURhjNEYIBw3Drx8VS4GCC5EKCwkn1HaDQTPHHUVlkD2mi/y3NhGZLfCNMpfDXrknHc5siQ0RYx7HOwdMAK/vO+IJbmCoaj+mfcUaGAvQ7Z57JIp1ocLe697AynaDaOGxsvh+Q060gdra+hQw+W3bcX5nHj85CUm+Sy/nhe4F0w/AiWGSU0oynqrCAFF65w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SJqmsQ0u; dkim-atps=neutral; spf=pass (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SJqmsQ0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 1229 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 01:42:01 AEDT
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV47F0Dk7z2xMt
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 01:41:39 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d794e;
	Wed, 18 Nov 2026 22:21:20 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gpio: aspeed: Fix potential coprocessor bank map leak
Date: Wed, 18 Nov 2026 22:21:19 +0800
Message-ID: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa1ef08970203a1kunma113d6ec1a11e7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhlDVk9JQk5IHkpDS0IeHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=SJqmsQ0uS+5cKunv2Q1gw3yeNHJ31mxKPRdWXq42AJzPd8YIz2EVvhnTxBVEcxUfVaTPpWWa4ycF5OoU6bX9WixaC5ZQsjaZuLFRNZRto9hgJnPvL51ERYHphi3h/5Cc74atzmTdvvdHfxkp5HtkOusdvtPWu0TCavL3cOxlgso=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=nFXqbRa1OhelbFVhcjizOVyRIMqDJEhst38NtKslZYw=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The coprocessor bank map is allocated lazily but is never freed when
the GPIO controller is removed. Its only owner is the device-managed
GPIO private data.

Register a cleanup action before adding the GPIO chip, so removal frees
the map after removing the chip and before freeing its owner.

This issue was found by our static analysis tool under development.

Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpio/gpio-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index dc53b2decb66..bb30bbf8c60b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1300,6 +1300,13 @@ static const struct of_device_id aspeed_gpio_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
+static void aspeed_gpio_free_copro_bankmap(void *data)
+{
+	struct aspeed_gpio *gpio = data;
+
+	kfree(gpio->cf_copro_bankmap);
+}
+
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_irq_chip *girq;
@@ -1364,6 +1371,10 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
 	}
 
+	rc = devm_add_action_or_reset(&pdev->dev, aspeed_gpio_free_copro_bankmap, gpio);
+	if (rc)
+		return rc;
+
 	if (gpio->config->llops->privilege_init)
 		gpio->config->llops->privilege_init(gpio);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4


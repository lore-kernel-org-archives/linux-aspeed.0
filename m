Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AB606A337
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Nov 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N7ngKo7Z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYkw62XQDz2xlw;
	Wed, 25 Nov 2026 01:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795528806;
	cv=none; b=Fz6Cy+1TXu5jY+vxNO4E3ieN3EYwldwT9Ekgb3H3eBXEOT5ZyCILZEYYgfkKVjSPCboXo8G+b4b3CbBEyoVcCW/t6faTpso3zka6JnE5DUR2KAtshf5a8bhQIGXoE3mFsln7W4+DR0SmZwmHZr0kopTV5fj2zpyEMfFdeg9ORRtUnDdPrnO5iWjuphKYeVVdedmJNF7jwCb3LIkftrcbcmq5m4uNAIWcOBOsvOPfKITfv5ZqWjsr/2SbFLGcf9v4WyAgxq9x7qHSlc1DFh8XL3V0MeguPR1j2aq6q19MBJolACO3CX6U0fgP0l5M2ZMkDPBspgAwAx6MaswNrkrtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795528806; c=relaxed/relaxed;
	bh=ovezNbKq1di3ZHCw1znvhP+NWifa/caqVGbMLX51hiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZyqHXSBXQnXxgkH+7wYYxAWRfyjlfW1nZqaMzDRf4Zs2WtSnIhv9d4VY6HwElEdxqCsGRva3OM3lJCfzWb7ao1mBAY8H0jLS75CTXhmkl4YTiuBW0XKA/7HGh87K2OrYyr8O0HRi2OVrdWploblFKBTEl7L5bLHZtmyAFGJB/I6v6zX5YzepDwxeQPZregiObXZIjmIRr1b1IWFL+Me/UWFxL4VLBw4FwMT6g6RbyMNGYcVuuqZz5ex30luvXg5h9qbL96Q30Ox8Xp6w1aV6c/xleLKtvzvZ48b42o5lmA2qGGRruvCx768SdbryiVWtSPei3y492gy63cO3hQkeng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N7ngKo7Z; dkim-atps=neutral; spf=pass (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N7ngKo7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYkvf5pjzz2xNT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Nov 2026 00:59:02 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb9b;
	Tue, 24 Nov 2026 21:58:34 +0800 (GMT+08:00)
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
Subject: [PATCH v2] gpio: aspeed: Fix potential coprocessor bank map leak
Date: Tue, 24 Nov 2026 21:58:32 +0800
Message-ID: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa20dd9e9d603a1kunmd236b143342496
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh9DVh9OGk0dSU8dQ0NJHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=N7ngKo7ZCWnEgm4MR1UoljiLZqL54oYjinK4ncmiSoEaPirLBbsyo+85LUBwKLvBuarDaB8Q5pXvSaCApSG920C+GgMA71CLMTs9mzyz1KjCto5XKCAygIYxfuPQGONJcSRYbG+M8JAZqq1kwgw5mqO94kMa2z9zqcQuEsMxYF8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=ovezNbKq1di3ZHCw1znvhP+NWifa/caqVGbMLX51hiQ=;
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

Allocate the map with the controller's managed resources before
registering the GPIO chip, so chip removal finishes before the map
is freed. Round up the bank count to cover a partial last bank.

This issue was found by our static analysis tool under development.

Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Use a managed array allocation instead of a cleanup action.
  - Allocate before GPIO-chip registration so teardown callbacks finish
    before the bank map is freed.
  - Round up the array size to cover a partial last bank.

 drivers/gpio/gpio-aspeed.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 45e90ebaf078..8f66be7ff9b5 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -944,10 +944,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
 
-	if (!gpio->cf_copro_bankmap)
-		gpio->cf_copro_bankmap = kzalloc(gpio->chip.ngpio >> 3, GFP_KERNEL);
-	if (!gpio->cf_copro_bankmap)
-		return -ENOMEM;
 	if (offset < 0 || offset > gpio->chip.ngpio)
 		return -EINVAL;
 	bindex = offset >> 3;
@@ -1381,6 +1377,14 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
 	}
 
+	if (aspeed_gpio_support_copro(gpio)) {
+		gpio->cf_copro_bankmap = devm_kzalloc_objs(gpio->dev,
+							   *gpio->cf_copro_bankmap,
+							   DIV_ROUND_UP(gpio->chip.ngpio, 8));
+		if (!gpio->cf_copro_bankmap)
+			return -ENOMEM;
+	}
+
 	if (gpio->config->llops->privilege_init)
 		gpio->config->llops->privilege_init(gpio);
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0



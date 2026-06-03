Return-Path: <linux-aspeed+bounces-4171-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81980CD6E57
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 01:26:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVVR7541fz2yMn;
	Wed, 03 Jun 2026 11:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780448227;
	cv=none; b=DoNFuEP3iF1UpeCpI2gE1beCYdi6IdUhZE4P1yKNs+qM3fPmJyRWHlNASI3gU1d7KEbdmBW9rcPaQYXgrqgfmqST42u9VDjkyLJUbLo8lBZ9ao5S5jLOXIeq50BwCwrQnvlmA3kBCO7TLkyivSDtWiLjUiFUIEUN34z1ajrBfHBzhHVy+6d5feAE5w+b+QwgkKi2oQaU1Tszj3F54IGoM4Vhx2vJxLsPSWGj28F7QrBPvk5QYgQkcc5yihm6n7vwA3Ml7cXEeTXeJ46NL+fmXWfvOBCOoq0nkMQEW9J5DipkDrFEHMVtuSvDI9MguTo7LJfcelsB+AIYWLu/wcC+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780448227; c=relaxed/relaxed;
	bh=7Jhe81GLnFMt2SFFisrAqvCgJB0UsWbau4qiCW8JuqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZP8EijB6cBjYp2077KW+OZvFMjmj2EhL6ofBppZBNO8sWfAZV6UqX25URYsaGPz6YHH7Wvf7SaOxC3GMYB8iX9sl9AOz4v7Gze6WzIjpC2gFxzOsOVLY+79nr5OB2XTcShCbu2vr/ctq3IAcTItURtFqZ/K57ICNE+9I7rqXIJZUM/CcpWURJhFA+b+Ox+HXou2hIx1bQ8R8uWApFDlSQDRM6X8QxQ58DykLhikTId3NdLiaK5U3mf5S/ClAG6BKVr7YrcjJnaxlRkca0Lc4PmW/vBwc62Ad3KxRTW3lH0lvS8P42UNz6QWDYpbKs61BLO5c32mCNhvhTfpr6Ae8vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iKnUyP5K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iKnUyP5K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVTmy2MHdz2xc2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 10:57:06 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-5176096116fso22180501cf.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448224; x=1781053024; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jhe81GLnFMt2SFFisrAqvCgJB0UsWbau4qiCW8JuqQ=;
        b=iKnUyP5KPdIE+jDzJdh94JqxoAxBIzamxCHlNnC90lIk3AIHNtJf84e/iPNnWHKksB
         eFhopjwwr+iUjqvAD8sqOnXqYwSpm+n92F+uuy/fBYOYep/RTjXwuzMqFm/LW9DlUhTd
         OQaG1TEbPa2TA9N+RXnU1Le378+QEw4L1oOxvTeMVS9djwMiGApFS3yu9XCfXT49N2p/
         yZCpYiMtVtwaR4BKJsLMPfp7SIXgdwJ6YF8qeV8dQzGKO4lxGbKl/KEjkN0tC6J8yiRE
         iCtC+/N+q+g1YCHRbVggI4kmY3AiUjJGvApLpiLWBtjqDwZQ0lw7ZoVgaIx17oP5rw0N
         33SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448224; x=1781053024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jhe81GLnFMt2SFFisrAqvCgJB0UsWbau4qiCW8JuqQ=;
        b=nPR22bw4qhLtnbW1pYVw+f3q7ThkpUxoUjsjuotvtuyTj0CqfsSThXWpgCDHrjEdfA
         yWRj1Kqb6Cn+gxryIRF8rGXtAdhmb4t7Njylj5UgARPTWUVOH1bWO62Sqcfq/8AZkObb
         qOXGhJBQJOOGLwCV8jo1DWxoKShM5qWTAmrtae50d/Z6PE82ylNt+kvfLAOOJWVgcB5D
         jTVZ6RvXj80120WpTc8VvCTih1PhceabvGVB1v3M9qZJvW44ggyMu2Q2TKiq2PBHBR4g
         kOu+Uifa0e5uWDniSQSO1XlOuoci7wI6YgVV+3eMF8NN8BBSBkcGthouosf2jc02IdDu
         FK3w==
X-Forwarded-Encrypted: i=1; AFNElJ851BpOwm+yvqNWF/pkQ8L0693fiayQBf2LG6dmWqJZ1FMKBRUd/RmHR4Yy2ydT1slj1vflgmvIcxnGU84=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySXMrYxHpGRpMnVRP4ARRjobX7NQf5k8J3UHurJWbTH5IsNWZt
	VZxLNSO4ouyy0FGVxAWrZYgQPQd6yMmOeSUG264u+luIz52C7ouV11if
X-Gm-Gg: Acq92OEmybyKCGXjs6LeqvQqNB0zRGQVgQG6A0D8MrV2zQp12Q4A78Wuex2uPeR2hrz
	fK4ZzHEyBtzwgblnkBkw60wxvSXS+Ao1FgfQiaNNtNSdN5djrSU4IlU8zaEpmGcvhXlrshRRYYT
	hmcfMDokQf1s2hAVgLywOaWbFwkfhmQp1spm5yxNyCTO8NVXUVVvFvoRiCho9nzfRHXyIzq7dkn
	J425ANydes6M+h/vnO4AftT8RL7MfXQ6SeilALWTsnx3t55c2OUF+2pQKqdOFtSslYOIqNKfUzN
	y+lox0qP7ZMdy2nEhOjuY7XiIE9Y8ekzVUK5MoY97N77sMjxwL19X1n8AkV7pO68ZcuDi5AeOJF
	OMIbI+H+Soqy5q7qtvOt3iQYAFA8zON6pYxcV42M5VLSi22n4rzA3fyUOUO3scHtZWo7FZNUIqR
	4BYZOZAD3cd6pHNcarBBZ/HBDf842Lay9jwNJX2Gf1Rco+HYTr00vNQ9GcQ02WrzykOB8oRZwCK
	S67z4jSSAe7AvJYElgfa7vQd+VksuJ6CpV7HVxNTHn3og==
X-Received: by 2002:a05:622a:4114:b0:517:642c:8196 with SMTP id d75a77b69052e-517785921eemr24993891cf.12.1780448224112;
        Tue, 02 Jun 2026 17:57:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c297a8sm12121051cf.8.2026.06.02.17.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:57:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openbmc@lists.ozlabs.org (moderated list:ARM/ASPEED I2C DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: aspeed: Simplify resource mapping and IRQ retrieval
Date: Tue,  2 Jun 2026 17:56:45 -0700
Message-ID: <20260603005645.227239-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Simplify resource mapping by using devm_platform_ioremap_resource()
instead of the longer devm_platform_get_and_ioremap_resource() helper
as the last argument is NULL.

Additionally, use platform_get_irq() to retrieve the interrupt
instead of irq_of_parse_and_map() and propagate its error code on
failure.

Assisted-by: Antigravity:Gemini-3.5-Flash
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a26b74c71206..f3c28c7c547d 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1006,7 +1006,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	bus->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	bus->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bus->base))
 		return PTR_ERR(bus->base);
 
@@ -1064,7 +1064,10 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(&pdev->dev, irq, aspeed_i2c_bus_irq,
 			       0, dev_name(&pdev->dev), bus);
 	if (ret < 0)
-- 
2.54.0



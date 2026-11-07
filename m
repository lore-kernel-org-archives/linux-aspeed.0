Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9C606A326
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Nov 2026 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKATQmCP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLyyN621Qz2y71;
	Sat, 07 Nov 2026 12:24:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794014684;
	cv=none; b=h1yxoNVLlWFaRNfKtHxGMzkMipaA5cfl4SFo/HwcJ8RS1tV0pvGIQWFCttg+pJ7D8VJMF3bBw1gc71FG0AWdgacLVBlo5Q1LzPl1ZfRcTsr0rQq5SeOhFDye5Px9vyAxGTAfCV1GGALO2ZxOdqg0NTl1cmOekjqbUa2Qr8m5LZ26rMGlldS5ZQi11c2PQmjDBwU/ua4vxqPKXOB/71fGdgiycx6ZaEdtBZNIBR3voyD4qURSdFO2V2b21A0YCDiyFAQOFMY4VW7JyszoX2Be+4MwiC8woMhJB1GWp0WjE20njxKWoygFPhuX7w6uc6QOwzV6b1XfD9SGQrKpl8rY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794014684; c=relaxed/relaxed;
	bh=Le2Yx3zcrP74iTf6eGB+z3D+FEYMTB52lqn+/VIHlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs0W1HFOPnfQXXlQ7nUlVA0MwuetNPjjkL5RxLn5lNwI0cSYe8CChiRaswEaeyMz3djo0omPIgAVeEev1EkfM8l0nGWJlBXDxhVsaFKyx840pEaosUlL3jVTy6PFP8zMxK+fvhOBQNz0MrOnVhBbf3DKndKTx3QKGLzmpHK1Jy96ZtPsZedfbGHHdF1xZ0aPCP7bms+1eS+pc3haORUXrpkpC4d0HIYMSLsaASR2mIP+7YxjE5KqZcn5xDRoBlSDTs64dG8H1/F3hx3YBRY5Q2Fcy/IALPyNWUxHVHeRK5HJQAjzL4XGNd6RsG95mm0Z9eL9EDFLE17zn1bkXSGLAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKATQmCP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKATQmCP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLyyM2mS3z2xS6
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Nov 2026 12:24:42 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-170135e43c7so2143224c88.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 17:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794014680; x=1794619480; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Le2Yx3zcrP74iTf6eGB+z3D+FEYMTB52lqn+/VIHlMY=;
        b=BKATQmCPOl66ctIsElSERo0a9dc45IgBv+FazmnqkEA9J0895D+dnXgkVqNuCm4LM/
         0l08jVv+0WxQiNN64vi4SqQlJ+XYtQXOeWud1qq3gTH8njYvADTCWl5MT9ShImmT6fM7
         ZngKTPPYNyleE00x94RufghOkZOzFXlTbu6vQLdkwRmL2matO8cX3XtCPmU0PY47NKix
         ugSM2ruJGkM8/rYGZ6DqQxB9hrS2At8SQpOFWDt2bytv1G1zYQHpeX3chW2tWUoqGjX0
         JxPxsn+fSYnobA3RvViWg3BXOAKRoBZorcH7XXUeyfYdbC/tvp6jHT9LhjFp5NnISsD9
         l9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794014680; x=1794619480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Le2Yx3zcrP74iTf6eGB+z3D+FEYMTB52lqn+/VIHlMY=;
        b=p+wdeR9hHCxQ3FytxGtu4JfbHYsYAOr1eJd624e2VgkVE7blG9pOE6aUWA+Shuxj+k
         vN+dqZrhimlW7DOiRzp/GXwjX7bfRGwlyd1SvSeWmIMa+io7gBZ4Gm8prowjMU0Td1A/
         TbYoJ29wq52XB+xgVQUSdVqqtCyB9P0kFEtDw+V/8+KwSxf/mXznTQqWn/hIucDJrN0J
         6KzAep++JOtnpMNM3MWko2+f5QbElD/wKmPvnwfXQ/K10iZHGCNQawBiXz5oB9WrwXga
         HQyQS6r+XQNKW6DfUe2lz01sXrc7ozvb7F6KHAZcDkWYCK2rridKoPSZKS/8k/iCPr06
         daWQ==
X-Forwarded-Encrypted: i=1; AKwUvBw69IdoZKWrxsbVVlHOoqv+VNGuuRiQCd6tHFr3Mnp2W9qkeQ/UGmiW4W1x/mnBJgtxk9gDwPhBFXCeqBc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z98KE5JLByNvPpAPmJ+vdRRVvY3IXVY43PSk3Fi52iKpI5j4Gk0
	oxYmp9dloo6qdQ3XAUEY6xRgA+5yKTnBFpR2P5Tc+ky4Jw0UB2Adxszp
X-Gm-Gg: AYBFou3NfocA+cvN66KQ0NitBA4sozioOyMLbBOj2HjYsq32GJvIZj15361WZgeWdDa
	DPiH2PUafq3SGUgizzVXDBfSWEG8oHaytL+gs5UuMkSoLWrC7HkqcG6WhCobCc2NGJTQqXBdFQX
	yb3PgDP7Tgc+sh0fHQiUASPsV0E4eNWOY0tlMEyKM8vL7vmqAsdt3Mf2kMTtKukY+VkUYjLNvC5
	XscK073zZTpR4J8md5bi1GOlZQqBprstZsg/masdDW7xlGiDnoNod0U+vgmwqoFlx3L+5IIL+mY
	mz2d1IrwCh4nL4Hr8r6zFpDe/+zn0ag+eF1dUQQ8wafLATRxF8L4gCQPOlZBS8cpi1ceF5hiCaD
	G7skQZFmFchjca55tqRa0O2TWSKEjyei7y2NHAuqZx/z3+tVcdBmJmIJ0+pgv9uTpj5purgkqsL
	OsTLhKHl4OJarvONd99CYOoGKYdYRWq2RN72sE6Z/d/D0N34feSJP8urSuu3YaLyiNGJKZvoO/1
	TkQPzdqmS//lIyC8p9Bv2XZShSFOYhdNrr5BXjDyq2u3zsHbs/ceS0i3QzIpMjODe/UgQ3NITAY
	bHc/ehqZ9aHanQz7gX/jUtBLxRLl9n6DxmuHxZnB88FjcA==
X-Received: by 2002:a05:701b:2905:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1b25d3190eemr4699302c88.19.1794014680193;
        Fri, 06 Nov 2026 17:24:40 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4880dasm8436986c88.8.2026.11.06.17.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:24:39 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: andrew@codeconstruct.com.au,
	linusw@kernel.org
Cc: joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH] pinctrl: aspeed: Use managed pinctrl registration
Date: Sat,  7 Nov 2026 06:52:36 +0530
Message-ID: <20261107012236.28069-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared Aspeed probe helper registers its controller with
pinctrl_register(), but does not unregister it on device unbind.
The registration can therefore outlive device-managed data.

Use devm_pinctrl_register() to ensure the controller is unregistered
during device teardown.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 7e0ebf11af16..eb5f404af8c2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -461,7 +461,7 @@ int aspeed_pinctrl_probe(struct platform_device *pdev,
 
 	pdata->pinmux.maps[ASPEED_IP_SCU] = pdata->scu;
 
-	pctl = pinctrl_register(pdesc, &pdev->dev, pdata);
+	pctl = devm_pinctrl_register(&pdev->dev, pdesc, pdata);
 
 	if (IS_ERR(pctl)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl\n");
-- 
2.47.3



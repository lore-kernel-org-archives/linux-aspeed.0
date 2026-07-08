Return-Path: <linux-aspeed+bounces-4438-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16136C44503
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:20:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwYx55YdNz2yfD;
	Thu, 09 Jul 2026 09:20:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525119;
	cv=none; b=jwl3rzmTlamxoS8lHk9q6qEEKAPXzCRLsusnFi2UC/bJQi0eezxD1aQ0gZ/+YPhOnrNa2Pdp8aUZ+xyRBVyWp1gQ1NJrXqKf6/N9VWEEAlXuRug1fsmVIXllYPGFaxlbmRM4IHzGnKTz8UKxnyQI2xSdbAs8EepKPz/LlH016Rpa9GESBqUf8VR2RQtiGL/Xb1qNmHiHHozennWTLda8jnE9NCIS+yk1J3THv2QgoSRTicB8uVCpYnbL+4d4M5U8pAKs9HI2x6PV/8KOo+BILVKrLW5uQmJ3C3Pf5DOdaQvPQgPoOQQwg1ZkbLMgttXxdAuGJNBYyei1EAYfBKrSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525119; c=relaxed/relaxed;
	bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpwZ7RaGd2Ip9ksOIEwHMlhUlCYoSWBLQchXRt3G1NK/YW2cn0+YWgIjNZm5DmWm9wdIIvFxn9lHH30YLzOfCJ8TdMNLJ9pkoxMzSqPRUMiVeBxFA6cKmRmEkNvQ5VHM+XyIoYFC+07U8Yu2khOhGBYIbmy+SyMUBbGeuwQxLUOChCbrBoWSK9WBMSvUHzwv/WjjRZyhe/hZCvgsr15UDZAe/PRCbY+NA/R0FBqS6dctVhyL1H466o+2WxJSoIJFhEQG4AG8C4+Oe3ioy4QKi1uH6VwelkJ1j8fg/ErcKT/CpQlHJBCu5xehQa4pqwh21LgEcCnJRcKTmfjSTPZcGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SKa+6u+D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=SKa+6u+D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMgz11dmz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:38 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-4798bea72f9so605078f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525116; x=1784129916; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=SKa+6u+DstJZWNUH+Tjl5DCu2S2M60ZqqOKC7iDfvee3ztSFoo2dnS99mWFIyCLRpC
         V5+3ynfXGHP9LA1xqaA4fMboL9WyEaGagZHcHBPetSJvocVOMvpzSer2yaueDH1wenKa
         vj3JDcmeRHUEoTjk7kb8EE6eq1EjNWYVK6b8QqM7SbZPF7d5EgxqN47okKwakmAbQD5u
         85ADOUsIYkov71OjY8hHS2LazHmM65qReSCismOv9pfNEC2riYWm5s0zaFedxMxwbqfu
         tUj1cjrkfpOh37IC+57ThbJH7b0vl/RiNNyyrFHdsTXdBNnz57jeZzMFuUkGBuTRTd/h
         OB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525116; x=1784129916;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=bgaNxOQaTifHkUFTXVDbawL4IKVxC3Gm9AgYEnlfE4izsVaO+zBpadlXKyzhfmXdY/
         CGA5/4HSgsQpYcj98CDHh56IKO2GQPn0Vv8tXtrVhnMn8SqLPKvIih/9KPwrTXXMOzPH
         HrsP2f/ppUJaXBocdz7AVxMywpRekNQFxnq/IaQyGFAWHzk+oyHGRDMIAvAF6YZ6FM3m
         odNWoZ5bU4wttk/2M4eaCaBrvHff+Sbv16G7W6nST5BbQFS8KfZN///Kh9HDOls8iapn
         TYptdfwH7yFPlLPKq71uM1GhhIvkCSIB4lu+hDdZFl7PMkow6LuB8nlZ9GI1LFMJ8b6W
         piyA==
X-Forwarded-Encrypted: i=1; AHgh+RoEPSX4ZOhFnOc5Aax2604JuXNCMlf/8Jx96LLjqs81wgVCMuy+0S0SWsqZQXJwZEFObOIXWo/0/Eq6/a4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDp0G9XiYmMHgialMvvf0wN5MSZK294j/A0xo/hcrFoVl50q1b
	Got5+ORRaFVRRiDIa3AnL1ZtQHyHgl40PNNjS7+j8xIvAJJBjefVJ7arVhdxEwK979Y=
X-Gm-Gg: AfdE7cm8Oxyl2LVL28f3YdSTlFUiH1oO7+AWJDT5c4j0yDyNRXTIdI6tSHROROhFqsL
	D+j9qOsGN9tBfwmXo/AK6sVabwlg8kfGq/9LYZ3k+cpBxqnEpsgD4A2dbVYfbAMyTeMxNYWSrmg
	Czg8pOp9uk1q4IhsM6CDzodwqp9TToWiw6j3Broner3QQ1GHy7kWB4pXXE2neC78GzmirOAf0hm
	J2rgO2mD6uf9fxRQvyNNXXUQ0dz4oI4Gpnafw0JCl2+ha4aJBmComwMZgs8aAWCLYPIkAGRVyOu
	Ut7Ty1sclAFEBwrUAwooN+3BkjBGiO3KmBjBZ+3+1sw4rt8DYnOelHpVhP7ihCxk1ejJ4GH0haJ
	VTDQ7Rox/LQl05izvPhGVHPz2LM9yM9N95V7qBlMsdiJYPxSKjNUa/U7+lOtEFlTVPU+l6XWv1B
	7eEnas13un2JKbRRCj2dA/cM14+Aw307hMtZMorBlGD+6j6tidjmM3lqJSiPOxVcal8d+yzGjlb
	X0+h0cBUWFvm87VsS4yYZn3tL++
X-Received: by 2002:a05:6000:2510:b0:477:80fa:f462 with SMTP id ffacd0b85a97d-47df075e2c5mr3515239f8f.35.1783525115919;
        Wed, 08 Jul 2026 08:38:35 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:35 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 3/7] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
Date: Wed,  8 Jul 2026 15:35:55 +0000
Message-ID: <3598f3d668717082adbffa5179b4afbe39b2a946.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the driver compatible with the ast2600-vuart.
Enable specific configuration for the AST2600.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..6afa2f4057e1 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -560,6 +560,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2400-vuart" },
 	{ .compatible = "aspeed,ast2500-vuart" },
+	{ .compatible = "aspeed,ast2600-vuart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_vuart_table);
-- 
2.54.0



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E3606A33A
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNgzQU7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBFb6wRsz2yLY;
	Thu, 12 Nov 2026 18:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794467043;
	cv=none; b=dHMElbyAObBDWigPZwWmkkfEPU+LFbpy2a4zb1cGSIAqTe/5i9SH08SvcfEpOieHc+1fJVlVZLaboxxa4o/NZTs7nj21VD+JYn/9soQw2KQF6/4Z37K4+kdCFrYyP7lXaDO8ql2RamADwpWbxomHJLYvhYqtqsL8psh4OMZS8wKLO2LrMOlgF1ox/17rZUYmsqzuVFUVMRL39+A5z9nbB2FGGG2Y22TlpwHgeIskrANOU0MXz5EE4iTOUZ7/UxsSJal6gd9RKlE+7btktW0fqxF1v32qukvUZ/FHAsIwRwOqHj20zX5n4yyi6q6WeMok6LL4X9yuTYdr+Ld52qgcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794467043; c=relaxed/relaxed;
	bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouP+OFynNltlOsPzNltfngIDYJZszZaCzUhLZrTIXsRPhpoR/EZUEtNJiKq7vEVHnbtlhLu6OxNF3pzBT3+K8+Xbh42yXl9XfLTlw9X903Q10vUCvn5jOTG9grtXz0e11w7AOud90lN9Lc/7LCHoD3ntCKQUixSIVDTiy1iQg8SV1AFKHP24v1enNcSgFHzXIwHGB/Wti5KuA37/Bd5iw7VpFg0cnjuG6V/4WuxpvwMd/OKFLKd6MRGUa2U2XvT3MEQy5vCyfKSUiU5uwYJjFyMi8mmqnY68m7+M885WqsR9+kCrXvSKgz92DgkXvl6fHb0JFLW3BxcIYRfR4ALT6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNgzQU7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNgzQU7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBFb0kmPz2yKn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Nov 2026 18:04:02 +1100 (AEDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-93e635220b4so363602985a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 23:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467040; x=1795071840; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
        b=KuNgzQU7u8TzZTykMbz+Lj7HS2Q1433s/YBD20vn705FMrAB8CwyoJ0s8IXGLG9QT8
         170YEsRStAQSAWQbOG/OD7skGtA51byo6jR1Sfn9tvPfwCJvRyhqDpVur3ixqm0CP47j
         7/6J6nCPFD2uZpXVhiUklLO/P/dv0MPB8xcXl5ihrlG2naB32u40m5eNx5OL7V2auEI4
         BMDnvzz5ybwIZ+RutCmUb8nLLQkggFRiSY5dSh3grpOjnCJp/trj/POYy2SIt9KD+J3p
         bWpGbdcRRI7hDeNMf4RUmeS+7ZKH7umettqsqbQ6sV0U/Ww4rbfktM7MY3vkovtd1x77
         ToTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467040; x=1795071840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
        b=KsgN0S3KnPIS0O+4bAZjQ593tEsqaGW2/nUcnaz7Img4CxzqMrWNQsXcvJEhRm/TSI
         iXrakczfeDZ9VaYJxLUAGFbSpSEBcoGRNgrRQWdrGrhsbe61CWywdc1ni3dfDmPziArw
         MakDvMuxoe/lVhFOHDwang2VP/3DsR9diEdOcACMr8DjekQ8n34lgOgNl1HmAMYk19pk
         M8Dad2ZjU70GVjSSbLnJ7uTxjmDxlUUHlBngry0D4tcF4xc2lvBECbW8VTGTCARl0UJz
         4tQFeALcauvLDvQ5hDrlSXd1qNe4a/5HDLSFtfZZ7qIEkZliQU/DzUagHAzxpvLIGxE3
         c+IA==
X-Forwarded-Encrypted: i=1; AL+hErEZuzFezjUUABzBARRR6C8xVN+aNWPTdNaejCNxvKYOKaSooIT/gqx8Np7ypRJVEJi1yEXAgaPiSfoGI0Y=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8doWfBlQIAD4TNkLKDBLdrrmBGiGEsmQefhGDk8iCiMX1GOOSa
	StPYvZy8Kx5ypb5hQQNE+D7lrycJCVmoU9oIKrPSHElwC9G7htQaW54=
X-Gm-Gg: AYBFou2Ga70Gxmv38PAs7uErMX05lO92NukubEd1O3CCiQgKV4WQk+EPjML3XLQ1dZ3
	xgDoQN18IMr1cxQRIyuQ26Vzc0uucY0nuGnNffXWjM0EkWITLp9zbpTHRRDXci+oh7P4RJN47iW
	GvATmaq8uNCa6GE9rsxctJrRPw3yaBYiT14EJRlthRgLd2qn/FvyFOZDrVW7yPjf8vy9ZvgN8tN
	bb/bdG4pGW6vkpFK2e9Bn6d/sv2u2450JtDwuQaQj5hV+xzWzrW+MDraAx0HY7MJBNBfiYs+P3B
	VKRmd8nd+ggF9PhYFPM03ySWHqHX2VmKmInExS5++xt6Q0R2sm8Alf5byGxu6Y4+ms03emBGQU0
	svPX32LaWmKZ+Cxz6UfVL2JP/YLks9Rgo+XgdSl3N2LHY+brc++m1v4NmZ3fhbJa6gPsMk1ic8D
	xyndx6CW82NLrQ+28B91ToI9am+ZBWYb2uLY79+kW+C0k9Fa5FHyOhi4W5RU6X6jw8cnJeBMN6J
	XcPYEr75HlUQeBJnwXVfoynNSRgPxP+ypLo3iiqxWRaBzdNXK9S3R7d1f5ShqlRAnZronOw13wP
	w0ZDyLoEJpSkACnMAEQGqL/xJFTCk2yd1gfWk0Bz/R12ry7e7gOCIHRHS7Lb0DmekB/ZssszLPQ
	gypWMUmIv4Br6X5BwwsNYyVd8qykJnOOxR1toR6P2MXYMXBatRrxgvZmsckHVw4XwVmmHMTn26l
	HGrGLGCYqz/0FtDX53/0A3kfGre3yogC2LpKP1USdEZdZUmljKKcQwzQ==
X-Received: by 2002:a05:620a:460e:b0:93b:ef24:bc8c with SMTP id af79cd13be357-947afff0a6amr852657585a.47.1794467040229;
        Wed, 11 Nov 2026 23:04:00 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7f2edesm663463585a.40.2026.11.11.23.03.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 23:03:59 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] serial: 8250_aspeed_vuart: shut down the unthrottle timer on removal
Date: Thu, 12 Nov 2026 02:03:57 -0500
Message-ID: <20261112070357.38870-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

aspeed_vuart_remove() deletes unthrottle_timer while the port IRQ is
still active. An interrupt can re-arm the timer before port shutdown,
allowing its callback to access freed driver data.

Use timer_shutdown_sync() to prevent rearming. Keep it before
serial8250_unregister_port(), which releases the register mapping
used by the callback.

Found by a static analysis tool under development.

Compile-tested with W=1 for arm64 and x86_64.
Not tested on hardware.

Fixes: 5909c0bf9c7a ("serial/aspeed-vuart: Implement quick throttle mechanism")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 452bef82bec2..0776675b8382 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -552,7 +552,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 {
 	struct aspeed_vuart *vuart = platform_get_drvdata(pdev);
 
-	timer_delete_sync(&vuart->unthrottle_timer);
+	timer_shutdown_sync(&vuart->unthrottle_timer);
 	aspeed_vuart_set_enabled(vuart, false);
 	serial8250_unregister_port(vuart->port);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0



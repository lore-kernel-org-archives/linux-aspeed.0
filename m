Return-Path: <linux-aspeed+bounces-4287-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DCDCD4F26
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:54:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMNm2kpxz2yY1;
	Wed, 24 Jun 2026 09:54:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782224991;
	cv=none; b=Ot90I9ytntOj3ram+jLaJoPV5z88AHi5ZuMK6a5uEQSgWHg4p9MhvROfrQ15mrumqFGPYrn1mWkju4bTdIrmZr1DavxoEdh6S2LaabWCBnB0/ky8uTcUxQUMZrZkgFg8L6hy0xo7uAgT5I62WlyfdxwvMWL1lkVYOsTR3KXFs8Eq104MEkknGvzSiCF5Xo/hfDYWyrdgCUsUiLI1Ez8qsLIVYKVNYJyD0KRMb1Mav0OsPczWvfAaBDYAik551OI6BwRNRrXgg8iAbwIpp5qysl6wVGsHhePQCQmctU7QMBv7wDE8qyX5x5+60l5KkIO13Y5P6Uk7xwWDDrkLgCE5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782224991; c=relaxed/relaxed;
	bh=QVmu3f7j9ByFGe5OedcL6Pz7umApHSUq7F28TFt4Y78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1NadLdg/MC2AD6a/8+3DpYnqems1Soi0Ae3BC1TmRf3WhDaVfQRbW3Mi4zJ/ARAYz3Ejgcz9BKi9n6h+mUXOnsPnKk7qaIO0HRYJj7aHHMnnUQ/bTQixtI0KibCJQadqbC9H0hF30ZT/z3pfq2UsFMz+NaJSIhf+t6Xm813Tq3lYfSodSYF9PUKzTzK3UmQqSCCxuRwQbqARZGfqaGdqUqid3psuuTXcOz2/8ikXiFkjXUm1Ul8UdneWRnGdQaVjd3CO9NEPM4C932ie8rPLxFjD3tkbnGkhWmUyScoYC906dUoaeDpBNUR8DSoLhRiib/DfoGH8vos/GNJwb7l4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=PRIE0lrx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=PRIE0lrx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sV1qmVz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:29:50 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-490b3637b90so44458155e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224987; x=1782829787; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVmu3f7j9ByFGe5OedcL6Pz7umApHSUq7F28TFt4Y78=;
        b=PRIE0lrxqkl8bRfbFdmv6QYWzG+p7gaztaPrV8mkVtxQEMuVlRVpNuUS9/BlfKI2jS
         +xnYWKDqJQ6EJ1fsuMh9Er3OvLVSYB2jkhnvpG5HlzH+cmIYxT6mHmcbvisBvlDmRBz3
         qMcotuG49JFc7VEZVRLC3Hdwx9l3/dHeyEpRF925fOPDQCXk+H5snsR2ZdkRE4uONZNH
         YMAp3emS2nGCitSMSM259VP4/MjuDK4PmJHCNJAnQeplWyEZw7SH+uBWFzz2ALcB2pSX
         aXKML4mvBrADxCaS0jhJ/7u/kJzoU2YLoVS5L4mP4uUL8nDNHAjhHqaW88yz1fZ4EizQ
         h4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224987; x=1782829787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVmu3f7j9ByFGe5OedcL6Pz7umApHSUq7F28TFt4Y78=;
        b=pRg7JT6Doq0kXhAFC4ujlwuhVAn3hvuZSNjoM4+5G1IIcC5aZ7wb9EqPAmxFhDiNMj
         kDiXedGx5fDnlwlFo9nYQ6L/R0d1nO1PtD4PGgpi3pkKwDF05IR+bGlwFYWlCqhpaYPK
         s1cgnwpUWm6L6CSdA7VXarz2pTkReCTTEmf+QHBLuJgvqjbiJF3v5tLjNzW231JV9fds
         etmI4WUJiAJqKhuBglYNRvfAiW3GPnPBJZwvJdP8TM5JcTeNZ3mtQ0w3PEM/1rC6iRfh
         uCVN6+1pNjrEjUHOTdC1a7F2K+9cZ1shnpJgWwSvBU3DS0s3Uf1mJ7jcCexAAudzsAg8
         RoZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Y6w2TUMIDMb3hIAKLfaI6durQKHsZl4MuhTMXbzZ93AYy/vyJRP1TmUVAnakwaBiSR6CDohorTQZ8Am0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqnIpmI13YF6mE+M2x1klBqrBYa+NLBfQxAKCvNrmmh9ySWpU0
	pDgfNHhvEiZve2UiAUwKSiHyvdm/LV6RCUT+Q+xtV79cvWGryxDD/gXGS4CPsqyyqtk=
X-Gm-Gg: AfdE7ck/doDpkxR05EHeVYuoQitPtZMRNXGjmihett3+dEvw8E1IFF4Vvjc1oaDesRG
	AOXcvqk/M1T+Md5EdvYjrpmJJlgj1L7YZ3Ow3qZ0bl703U1Xp3kt6YwnzryLxZnwwWDsVUvLiVd
	kXmQjnZR4n5uhtHvrY1354hNbCSK9Go5l8gFi20C9lrR4pW84HXJkP7bLdMGST2VuWAmOyHyuCH
	aFSn94JnEGUHOnEzXAfEgedhjSUhsdWfaFPly0hn7Z5gaRZkawsniut7aQfuE2oWe6UD+BviR9K
	Wj6vPMMTEAgjwJPZ9jSJujkQic/oAOs6T+Q3GJ7NXBKUr01spiwV2B6UukxKo7E8oI9lMI9H5kf
	RLm+UOZumHhfZLEJWeuWigs91dd89HiUekQH6UqhYV47qFxoDL6n3McOoNRSBeIiq442chG7W71
	dEzgG9GdHNeaU4TzR3DoXtLpRE2RmWNASO0ArZfBx7l3DSA4Xsm6pNKOQpfoY7uNSvR5VQe9SuA
	6NYkTQTbZWrmSkgbNaM2x87JcF8
X-Received: by 2002:a05:600c:8b18:b0:492:46c2:f5b9 with SMTP id 5b1f17b1804b1-4925b389c2dmr48178725e9.3.1782224987165;
        Tue, 23 Jun 2026 07:29:47 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:46 -0700 (PDT)
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
Subject: [PATCH v3 3/7] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
Date: Tue, 23 Jun 2026 14:25:41 +0000
Message-ID: <56c378923566ea0be831f58fd7c2f186ab3f5cba.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
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

Makes the driver compatible with the ast2600-vuart.
This enables specific configuration for the AST2600.

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



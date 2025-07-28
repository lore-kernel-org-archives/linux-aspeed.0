Return-Path: <linux-aspeed+bounces-1851-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F9DC87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75h2rwgz2yLB;
	Mon, 28 Jul 2025 15:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682200;
	cv=none; b=XNYwjAj94loJ4cqX0brp+tSDBoSK02O5FsV0FryL4z7nJD066Cy/sk6bGgmq8vMP+3pWeXMRKJfMOx/Wg518rz2D2bDo/SdRsk+J3uo4aXulP8SS0FvelPGybQfKtBiScsz6myBWJIeq+z2oFMQZ/fYpAjcpkTVpd03emxGLKv11TIUbkk+vZxKawcWPOyz30ioZZhZvVU4UfSSRJLrLlv0d2mzKcyvxVYrZEcSWWb4MR2wQ9C+KkqLKT40PFDBpoivnQ9cIKqQilTTY37yhyksPIZkv9NEXHtjOB8fmbJ32dmLsk0UfaqlSTxaPxIdlQqA4MIHFLppirfFqlYcMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682200; c=relaxed/relaxed;
	bh=zqOVyINMYuNtnSjdNQ+edIzC8dJzm5etAOwvnetYLt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7wz7usSQGYrq5gPP/TrLbz5yWhUqoCcUa9+F7PgdBYb8ruSL39cj3JgqqrDyukuQyr/dWxRqsVuUWlZiWrI7RpOP+eAe1CmlejhrqdCzniMdlvNDUbAaOMP1KrLKXf66g0fihvRyL8nbgEShArX9P2NNXMs8OCgBxxXDG0gpSH51PhPoZDlFR0YDl2xdSyfoLJMyKiUAv3cBZ1iHO/I4aJZCDxCfkfcs/UYjNOTxwAuN78vE9YQ1CDkUNiThYCPZuCgj7hKNFUmzShwlnqLfiFUsp8IeZTIJiyzSSFTs4c8BvZ/YMvb7910pPqoQDbfoDVvdIx0QJQuCkecqX+0Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VaZr1dwb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VaZr1dwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75g4qS5z307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:39 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-24049d1643aso152995ad.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682198; x=1754286998; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqOVyINMYuNtnSjdNQ+edIzC8dJzm5etAOwvnetYLt0=;
        b=VaZr1dwbalUF6w7LnAKBUDuF1AVcUGAhqU2SHv7XgzSp+m8C3FKEi0Tw52VST0057H
         Drze/ZTdHNtf4QnRwcoXf9AjZU5xIaznoe1CgLhCjZvMYZQoKK0p+iXgOCthy4bNhWT+
         r154haop55dUD+SFvrJeEn0rVNSQ/Rgd7kejUmZmlA/nRYuAFNB56vTBhbtCf9woEAZD
         cxVLP+fAtbI3yecxy74AZ6w/GTveO8pElb22Vpqek6NS54wQMhRVl/uE5TouvVSjbREZ
         8kqfg4DBd5X82zFsfVSZlIES5Bb9DIme6AX1jQOUwVQGWB1W6LwEm+MW4eutUQOzMaGF
         7jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682198; x=1754286998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqOVyINMYuNtnSjdNQ+edIzC8dJzm5etAOwvnetYLt0=;
        b=YyvImtmFlcsRepNkRqhEoUaJH71mdI64klQFimkvBnqZfhdAuu0uYHK5Wnibmy0vNB
         UEI8V65yLEiWZaY9CrvLTBc98F8F6XuRYtRafz7z15VJ0dYu4o/m2F60vZ07IICeT8Y1
         Hbvql/hBMLTKJ2q2cgnyzGgKbDUcFm1e2gtD3ote6z24hFv011xc9gfYp8YPKKTyfd2z
         P/1KTmJ/ApJrfcmrwtz8fIRjzK83Gj8DORmkjH1AKvzQAGKmsV/J26b3AC1z5feOphX7
         jGLCiUNCiDEUU+0BhnxbEHdR4oEG7KgP0CsUlsjVxC3Ay3YE4nhIXWHCfRpCSMX977He
         dSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWt4iHmaNEj59/bOESAHM4fy7ldNUDE9hTt+osNGVzzg7DUSKvndrunsNdNb7TBO+fKV3vwX0Y22zcltFg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4oErjzCHTxIjbHJIxOXid2IdEgnO0AE9/SpIP7rMtwhOMO1BY
	uRtejLPLKd/ZFzZiINUYzIpUTaXeahAS72pho1i0ALKlehWtdg2eBecX
X-Gm-Gg: ASbGnctHIqluujgk1Q7ZSOtSw6AwONry07ukDU8bvtIG8kXh4Hf2BSApBLZvasRp5ih
	IlgnGAr6Rsd0gqd/LBVtIgwNvifScshQ2P22eHzn9wxLvLenBrl62hiohCxS30eo3XHCth+EaFJ
	njzDQUQW/5Q+1Vr2n2NtHHvxAENAcydFd5mvh6cACUqesMb8R83r1atnYmsqLkuUORFfnE6TvJm
	68gaZShiuVxaiNOPQ2yYJ0euNaU8VrHy/ipVydNskS69ojxTBhV2twG1n/BfuPpUWtCPNJ/3Ip0
	2TleZNcH1509OIPQuTIpKm6nZA2SCPQo4t7uKrpePH5OVPCEH/WNDtlyk+QQfgoENaAsr/Gf40Z
	vMKcrzM7x+aec0pZsUhGqwvBadc3g99Ue1JzlTtlRnn/CGOZr5wpCYip6z8+pyHcoJSB/0bqF+8
	c=
X-Google-Smtp-Source: AGHT+IFBm1mrwen/QlGU6O64ea2pU34DFNUrcoPJ9y+PKUl8rOqB7Kvb1drivW0O2i/6eJF3sUumhw==
X-Received: by 2002:a17:903:2a8e:b0:23f:adc0:8cc2 with SMTP id d9443c01a7336-23fb30b2f8cmr145174495ad.27.1753682197770;
        Sun, 27 Jul 2025 22:56:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:37 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 09/13] dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
Date: Sun, 27 Jul 2025 22:56:11 -0700
Message-ID: <20250728055618.61616-10-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Fuji-data64 board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 0c9d6a30dce0..3cc6e62ae5f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,fuji-data64-bmc
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
-- 
2.47.3



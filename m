Return-Path: <linux-aspeed+bounces-72-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48118D132A2
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Nov 2024 09:22:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XhmGD6Kv4z2xk1;
	Mon,  4 Nov 2024 20:22:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730712164;
	cv=none; b=gMA8vBUkXv72XWBu6lMQ4roYmA+ZzzkgUwTt6OAi2CFaOBNd389X9t6LSJYrlSA+a+h5fcEd4oSndyNue3VXsU3zVvL0GKq433wOd76IYEWIhEjZi8MoxH54gKxXKNAY5+TbJaJ2F+EVQV1Xw+zaOgN5X4Nq+7tFlihGi8/wvgT/IiGbsAySv6DYRFguMQW8d+j6Jtt2i8sBDjpdSKZTVyIXLV75HAnvk7cvtyQeiOlEoRpNqFTZkiTh/kFYWWEeexRahFhx3omeT21oiZDwFHCzSmaRWzzWSpQ91Ms6TE6Ke6u7+56m4IBU4RxgN4GyfFiQdEyFZ5S82UVLsqAkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730712164; c=relaxed/relaxed;
	bh=0x8YfzKgLTDDx7pLL9ZIfdpCd48D9g1TybgGh/+DyxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjlSaDYTSJO2401hwAggh5N8PiGlOQl2U1zLC7LbO9dOYKGokyPya2Htaft6qpaWP/fQA1mV8VqitxvxW6GJ15NKhTsAoyNrqUQTlAm7qr5wnG2KehEJJk4IpoGxH4Cx5fBgVUCuzjDaO2Ib2m7op47WFAsZP5y/f1qKxTM2i4QhITRRzdkF/lJlBNJ48Z5i+2B6IhmCWnRkC4QELI3eJNvyPlS9mkCoShUFhDvMSW19dVGwcDvQQLy7bTj3r0o1L4O4LMj266291MH3UKH5NlA9YFhcY/CkAbbX02Juke5JhsPKXmOFYazGlVy8oWCW0E8XGCJgWeavDc9mqhAO3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=XHi8+mMH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=XHi8+mMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XhmGB6b8Vz2xJ8
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Nov 2024 20:22:41 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2327160f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 04 Nov 2024 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730712154; x=1731316954; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0x8YfzKgLTDDx7pLL9ZIfdpCd48D9g1TybgGh/+DyxA=;
        b=XHi8+mMHrcM3wiKS/qjZ/M7bzOtM4Gfrt1QBqI6sP4+t2lBK+zFlbuOek443x8qmZC
         VQWXPM7kMXkaQDrdjxSe0hY1rui2NgamCs06+8kPvNoFZVfMN0Aae3Ab4mJfF0afpnUU
         70pHb+kJkGgPjtzWaBYm5PhQglfXNwKzvd7k4r86Jr1QxhpVaL8bipeXu0HJXxrjBe59
         +cncdMgOZADjRq3RDpZlHT+8eh6r4dWHjohVN7KYHZ9w6FXSxiWycDc1nENQ3FV3iZb4
         miW0YMngBqoYdvJq5ARTwKOYvGayJalB20eQ2FgP/XssgEQn62LC9tVPIkLPCoqLMk5/
         t6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712154; x=1731316954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x8YfzKgLTDDx7pLL9ZIfdpCd48D9g1TybgGh/+DyxA=;
        b=jpWJphYqxqr8tflKDFHMtdUs1p127DTkVW3m7qO+gKPcxxiegJPZfgwo00qbeRq/5W
         +f72ffH6NRHivlDRoZQBGob5AlAy6mKmaBx3TyJZnIOdrnptxten9kfG0TZf8oKJJZjU
         0YoEsxLOxFcpnZ4TCfjxjxPR6zF+wWmVnf4rP1Z76rkvKuo21crBcB8TsNgmKOeSKq7A
         Q0rMltC41FNbmnZXBQ18UVVlqh3Fj5xqcys94HtX9lx3/El9imZO3O/WRFYXN9llVKFA
         ra037ozTE1rNyM9aRc05fboidYXZ7Ogc32ASJr2On8jly8IEP27r+nZcX5vqAyQ+dpQW
         S1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq6w0EYEwmMOcSQ7jv/kqge+4MYLhpapVZKfPi3YREqvqP/wy1t3wrjmjAIJ1vgHvl52GrGdbbNdhUchA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwH8uOUhXp2eepcKezNsIzDg+UqgHcLyGUwDoj5S4hDhEgMqn4v
	z4QyMme3kV3EY78VAnuis4H6hBu6T3COwz8qbshZ4u15pAt7WxUEigwNIhaQlcc=
X-Google-Smtp-Source: AGHT+IEP9RuCeHmDYOOToxOTcWwGxpvwDvs0FtYDNiDwDu9dBrotM0xovdSu4CmO4Yn3WMu3dC2yrw==
X-Received: by 2002:a05:6000:18a7:b0:37d:45ab:422b with SMTP id ffacd0b85a97d-381b708b694mr15447460f8f.31.1730712154262;
        Mon, 04 Nov 2024 01:22:34 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm12744872f8f.96.2024.11.04.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:22:33 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	sylv@sylv.io,
	linux-hwmon@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Mon,  4 Nov 2024 14:52:14 +0530
Message-ID: <20241104092220.2268805-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V4:
- Retain Acked-by from v2.
- Fix alphabetic order
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..c79c74ab3d78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc

base-commit: 30a984c0c9d8c631cc135280f83c441d50096b6d
-- 
2.42.0



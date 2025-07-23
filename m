Return-Path: <linux-aspeed+bounces-1802-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824FAC83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVk01nttz3blF;
	Thu, 24 Jul 2025 09:30:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313432;
	cv=none; b=m9pOb2VJ2o3DGg/C5p44jmYqM4J5IIh/GHEU63iVgFm5jFAGIJqS8pJdujbHQH8dMXjsOZzR7RIjAVzE0He0v0h5Y0/aJIwMSb5fJw9hVX+1cebXzO5wwqjTg/QPeNglGW8xRzBitVN7iOY1IeHUH9C4bFxctWa7JP13cfyGqWLGMEgBI5wqK5lJOTVoHSR1K2eWFBmIN9euuHKYzgZInDdhYc464jj0OC5KmnA8rYYd9H+MKXX56A3cDlBnIyN4FScesMVtNJ2Mv5HPQvXOXVEeIUxYA8soSrLkLPiwbKeVBebgxYDg5jawaCzmUToqFRJCGuvGrrN9GpBU+eg3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313432; c=relaxed/relaxed;
	bh=r0GTpnFk/bVgaaL0uc3H/ZWhqid1SYz87+1rRrLNxfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bdo4buHZi6BoKfl6R2CfNOWcQ/gnHPcJdjjXVwM9HPdfsxSuX+mbYwhl22xCW8q22SjcTmxCceJKzgj+L6nKeFArrWgzTCUuu+kcfxPL1QV0wfdW0js80b0djo6ho7t1VdWdpQfPr5oYzvjssU8h7zidzBCpsemfksd1ZZ4Kd1VlZNOIdS2rNg+KA2rfW0OoSqFcs94RYv1IEFFB/R2vjb6faEtomdD9mInKkBXmcLVdZptfaqyoPuU2LBr5FzZnWt1AwnKtMvs0Mlt+T/JS7aijs5Chg1TIijA1pUuAOg8i872BXvWl9ERXlJnKlKoCyIW2vIhuplfgxXmqeCPtEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GwLXNB0W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GwLXNB0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjz4qfKz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:31 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-23dea2e01e4so4930035ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313430; x=1753918230; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0GTpnFk/bVgaaL0uc3H/ZWhqid1SYz87+1rRrLNxfk=;
        b=GwLXNB0WvS3XulasxqSZFxY68bpQURQu7Oh2FPZ5ox1gj7tJyXy09Qt9kAyMFghrly
         7/ggT9Otjl4idgk66Of9rz7qyTmDC+lWMcbR3r2gTdMejdbpiqghZ1PzCR5P+TgGfb5t
         kx180KjNe/6MucJUaUe5UVlVLjkcwZ2VbQgNVh6Zq2NE3bMR9fUz6iDM0hW5YwJ/O4nw
         HSeD82ljbjoUo8iQx6ZMcQZLGh+SxmgCFBPlirV2DNBw543lJm3mGFIciiYjcgF2/V9q
         qtLVL79heZBo6YVJHyOrbsJgDewSalUaSUFjY6EPi+S0fe/fSKsi9ds0TgZtctxIwdRQ
         X0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313430; x=1753918230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0GTpnFk/bVgaaL0uc3H/ZWhqid1SYz87+1rRrLNxfk=;
        b=AkHb7XP5r0Xg4a9ccC+vPoqUlfohUcLOhzQIt5iYy0I6u+LePa7fz5QdNysqXZspdL
         z62u+9KP9J8zsPQFHXPGJDjSIjqEkqGTuZL3inlpXhEOX5OEMUqZx8oKuiTQ/eyDL1wT
         x757yNAtX9c67yY6hKFQrR97nez+Bzt2Rx7arg5xop6/Yjb6MS79UcmiLg3ca8F85Ohy
         k5HR8AC0YjJ4Di3qWAiQbUWg2fva+kUkDSKkejvlxV8P2kaIhXPRyE6q2nlcs0RpWVHJ
         +9dFHfuYDdyBJhsAi6bJKflm/FRUPlC9QkwCG6+R9VS+lefN6rj71h1CPgdwM3tnclT6
         DMfg==
X-Forwarded-Encrypted: i=1; AJvYcCVysTSX7kvyuSr82BW3mDBQvUxce9VqXOCr0g3vGl7s3p4m3cUewqOXKcCIwLI43opPGXMdwnsgc7P2/UU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxy4XHhulqGgh4GgGkRtAhUfVLOF8Mp0masPC9UcT+qr8hWlh/c
	MSpIGoUAz2KJMj21ELXuXMEIKBRluL6cOBU4tMHWNLeW86A3h+jCu3KD
X-Gm-Gg: ASbGncuv4tXpOBHLkyFkqF2jez9Hs886mI82hmVmu83eTavGdvbm56E2KqgpixqVQMp
	00qIwWmD1cmehxi+J3sLpatk4/JC8miWsqoONqqmcuQmqcb4RJy7V2jClZQEY88mqr1tT3j92cf
	BlUdVTzOadh/KmNqqNkwVS0UOjjWC2qkK0G3hqJ4SsWsUAIVq42zft0XE/TZ4pHHIsHbU7vR3vd
	kDL+UPO2mDRyzXX4/C3zTcJDvDpqGHNp9FtAZj6Ya700So92UOyJJTf4wBC8VtQccWpTaQVmXkL
	BwWCjb8Rw9XcrxeuAoyeJ2FN4UosnKqHK+KIudBcm7KL6EomCIs62+szVQhDZy0yHgNTA1LT4ji
	AIHSgMo5wUrwwf3nKoxkMnBSvBWvj0YwabgKYb/hxt7IXOY5//y4LiMdN9mwOrSGfAJbSlsrE1M
	I=
X-Google-Smtp-Source: AGHT+IFcQmIgGW6y7P89Tcy+OQuCYio6ZcoUtY2+xTcgHdOpWxirQXUIq6CUl1omDMrL8MI72xV40Q==
X-Received: by 2002:a17:903:283:b0:23f:8d6a:8e32 with SMTP id d9443c01a7336-23f98132957mr51684445ad.6.1753313429797;
        Wed, 23 Jul 2025 16:30:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:29 -0700 (PDT)
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
Subject: [PATCH v3 06/13] dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
Date: Wed, 23 Jul 2025 16:30:02 -0700
Message-ID: <20250723233013.142337-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Wedge400-data64
board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..0c9d6a30dce0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -46,6 +46,7 @@ properties:
               - facebook,yamp-bmc
               - facebook,yosemitev2-bmc
               - facebook,wedge400-bmc
+              - facebook,wedge400-data64-bmc
               - hxt,stardragon4800-rep2-bmc
               - ibm,mihawk-bmc
               - ibm,mowgli-bmc
-- 
2.47.3



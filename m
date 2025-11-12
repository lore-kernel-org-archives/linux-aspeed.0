Return-Path: <linux-aspeed+bounces-2883-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539E2CD4F22
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 22:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6JXx3Fm5z2yrg;
	Thu, 13 Nov 2025 09:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762981980;
	cv=none; b=CwBaYcJ0Qgs6qi6HMqNMl/m8/lZcDZH+MGIL/olDxa5MOFpq2e3iLF1zrm+MvFGIQxaJGu6X54LOt7qT2CIAOeb8v4soSu1gyYoAIB2ViDFje2tYsK7LxRlvMsDJfD/ZZREwUUjESvv1Z2ytbWiKPxNpVS4Gf0LfIgweHy3YwPjVYcjmJVBPYrnC4A40Ju6xn7TWUFTwEHNe9UdzQp96045ZmP2ohtxe62r573WV2dlZJBb2BXUMHFWwLm8QdP6oMtXBz83ddWhYVjW67VGJVOHU+s84EaUiNwkD4hsdBkG3neqk5UV8yVDnPhIWsCp+tDTHr7xOgWg+MzA73qkpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762981980; c=relaxed/relaxed;
	bh=IjuDF77Nvin9wqVFgToN8rViAxLn6q03uh/wAmweEAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dglv13OzKlYU3HfZFCD7j05hPo4DFUOwPMuxc1/UxxUi2LUnR260SqTCKqKAdfDcTNmX7zI1RheuxJ7wpmrMTrZMDWqatP6AMEFWTxj4K+WeV+R1zu6dJoMOz6Rx5dVhxCB4l0NMFlnYTY4cubwV+DERqBG3oL4lqsVRidMl7OjVLPAqKweCjJkLeB8dOOj36C6bG42sIbGiMYJA/LuJbkQq8RwdHfkAEvxJEZqM3V/aOaW9P9W9B5LG/s9cN7+JBAyEWcYG/SQe1hiPYWFvkjoH9L8u2DuVZsoHsjmodV57cZSXOIHoizlyW5flJ2By3WC5UxRbu3ibizuWWTxzpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XuCvM0/+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XuCvM0/+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d6GMb5bNSz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Nov 2025 08:12:59 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-bbbc58451a3so63926a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Nov 2025 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981978; x=1763586778; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjuDF77Nvin9wqVFgToN8rViAxLn6q03uh/wAmweEAk=;
        b=XuCvM0/+aOqUEECsO2PZvj1ScrhBb7xz65amoUameREt9Hp3iocZa+aJOV+3eHgVZV
         E84WOnc+nSRi6Bvcx6+t/mtVLVwLyjL1789GFAqvg4O2BPYUo3wnwrsRbaB18BW1o5m7
         4lZ8yDoegBxl77MoFldE+JKDpW9RCA4L4k9wBAYwfYlCrUYlY1iTOGxb7dFjvRRH3HZi
         WJa/5/KiZKczBfcoUVVB2XLVhI5tIynXXH5Dj57o/9ifVsDEqnRFhzTqBHEMbbqCj0vA
         oSca0B68H9tN6hmfLLkRkhT31xKry7VGU6lTsxdumKfOern3RBAJNDAQukBf5P1SJtpe
         /ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981978; x=1763586778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjuDF77Nvin9wqVFgToN8rViAxLn6q03uh/wAmweEAk=;
        b=xP80EBLODd7lsyBqFlBSeiGFuph8EH0m8Y7Ho7lLAimR4enzcaBeqCNnRfxjKoc/6U
         vgTDd8u8fkc/UB4KNbFg+HS8eX1E6JCXPd3HOAaXdsv2XSIbneZtYrFf1Lw81Yl+GZKP
         STWKFdakR/KYxO9EJNAnttGHxlxAdntWR5VWN8p2fccb7WGzTb365LV6yusl0odJDv0S
         JtKN3XoY2Je8e1G2vXepvdDKK8qCia6O3uOf6j3WzvGyNxOOz+EHjTdXzoEIzDY8qNNN
         94l7d3tlJm+109YqKDxBVOjcmCHPvurDJKIpFAOy6ziMejxqSWpjxljFyrzbLFcZduwx
         NjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJIxH9wjlE10WFYe5fNgwVBkYiO00M0Ahcy4f3eRMJrYSku8kR6KtiPWe4vadcwaVd6rjrxqIoOevwkOY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTHiZpicrSv3RBI7gKpo67kD1c9XzteZ6WBMqlY1mveYZuWPZb
	BevtAnKHngSQurtI7Hc+686Ljehn4UA5dRbu/wXWJrTA8EHMn5ifPfst
X-Gm-Gg: ASbGncuaOr8fK5B4wFgGKUy7Ho2JNJpJRUSkzaNHNm2CzM6IQD3etbGLttXjy2E93d/
	VWYZNpEAioKCYbKQOUFizvyPewab1AIh8DajN9Zww85zPMLF3q1G5S+shW9M6LxMwkYdkrkPLC4
	klIBgC5bRtGXcpsXc8KDlaSzwZ067GTII8QTjP1jumc91QHTfQ9oS+pZe0LpditpXNJzZvgWek2
	9xyr2VeAFLmnAOlSbch9eDpGGrTa86EzHHrtNaEy1tn+gbgHXf5aEudsRyWijqnvTrTQafjfyWk
	ZsNpU0Fg/XyGLAVWRJWFdwFHbWSnrHU4Dj/HOX1vEisYyX8c31sjYhV+iGchhCsh1fSe0+gg+D/
	tsQSdKzEw6Yn+jWSrgWOFLPtpyrI+R1bs+KjrbNcewLRGrXGPHfZYfQNsJZ8J+B9sv5c=
X-Google-Smtp-Source: AGHT+IG+mV9xg3XsxHHZk9IEjI2mp5r4vWAmColXzizBEHkP0uzY8AdSktbXnLxB4bTq6cCi6YDFug==
X-Received: by 2002:a17:902:d551:b0:295:6a9:cb62 with SMTP id d9443c01a7336-2984edaa8a2mr55489145ad.35.1762981977752;
        Wed, 12 Nov 2025 13:12:57 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm1011525ad.32.2025.11.12.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:12:57 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Thu, 13 Nov 2025 05:12:47 +0800
Message-Id: <20251112211248.3711889-2-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112211248.3711889-1-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
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

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <sjg168@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.34.1



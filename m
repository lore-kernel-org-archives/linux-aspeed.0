Return-Path: <linux-aspeed+bounces-3175-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF790E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFWG2wcmz2yFb;
	Sat, 20 Dec 2025 17:54:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766135867;
	cv=none; b=Y2S3FtOIauyv0ZjH4ga6Lu6oL04l/dXKKITOlCkTNztVKK4NWmj3sDAgWmtmbwKoO/InfxRrlhovqXoPYOIA5fjqB0Lz4Rp1xfA1SKEBs6ufwl69kCVZXtXgHxz27kPXzfi9pwlb5K4Iu3dB5P8su+dDPOudFuXdy/Mwhgmnz0BPIXv/Grm59F0QGNWNXrilTfBkBrFTxg6NLPGM8kfMs0Zt5LGYKkhuXtjzmIqbKW8LLBCs8wrHaXlkxzen60jidJFHzIBkRjTA4aQHrCQlB0gkixkUqYZsyLiZnqJhCM9mqiFNAov59cTN2T5bGkcZVJFqXmj0hKAM9jip9WwD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766135867; c=relaxed/relaxed;
	bh=seg1Djb22mG1EtBOW8bPVm9ZKhEV+FEwOFvHSuMZezs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX363csYz4Sgc1E9GwfUnSlHE9I2uXnWzCeIjVt4NakhvEpUeY9oe2RAGZxhF0j9TS58UFmzTJoaLIyptJXyQOHNUBbP1c2Roi2H1OItpw4YYSypreTTRDqeR0OYPD9dMcDl5wOS6zXWaFEzVXwAJZdbwGnjxmtDTzwn8Cg88pRd1OFVorW1Ub+LFQnGk8DqBhfQjmZw8CLZVWjZCF/9TjJcZn9fTUzy/h1yWeu5XAk4AWkxsYoTmQxG36jQB3kHwMyKTz/ZYPM5fVirrgoekJacSMKol8ICXn2IrS7J42h9fhqzyK7HmrWYTJKVYk/465z7ymrCX1q3MpA5Uc1LsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=et0Jq5n3; dkim-atps=neutral; spf=pass (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=et0Jq5n3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXhlG56PRz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 20:17:46 +1100 (AEDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c09bb78cso10633225ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766135805; x=1766740605; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seg1Djb22mG1EtBOW8bPVm9ZKhEV+FEwOFvHSuMZezs=;
        b=et0Jq5n32Qg0cSJlkkeB2+lo8UrY6OA5J+5wzcI18yhfxEck/boYe1DPJ/lq5yl6kt
         yenLWvj+6YgxzTP1VyB4X9H5IAR/wtGh61gzE3BBSlRSLIMaY4PjppGeXJhm1TmDcXCo
         Nad5xZWDa74SW2S0+OtazTUqccse1M8S5vWCALPLCwEM1C28i7q0mZvSZt1LEovCtA/J
         pXyNHIQbaOz3bby99ATyHhZ/i2gntY2i1JTN8rWSjsIs1wG5w55YdSPPlXRTGmFBF367
         2WtXQ+R3usKl8o/vivxZQBZsMfJYjkXSgMPItV6pJ4mgzhMt4LnD4QkqK4i//zENpIpM
         Mzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135805; x=1766740605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seg1Djb22mG1EtBOW8bPVm9ZKhEV+FEwOFvHSuMZezs=;
        b=u5Jj9Jip3kEOY71czc2Z1C9uTgsYkrKtgAUTu1B8Se+Ioyk0JYe0wxJ4IDVfB36YlX
         ue0vf8oCr7Ye00+/RQpy4eA7dFI5g1GnacJ04oBIJPK1RWzwfowA4rbMCMfi+81FeUhc
         Z2CxRemzt4XNiuNUJvrH/NFtasGMBvKWwsj11XsT56sw8EOxOqwtA50Z3kZY6vlOMdfV
         hN3hW5yKBV4F1S8afskVVB4u3iLKzUgX5E3rQQ7MLNTcx7Mi3N5h6VWiE+H3Oprh6wrS
         4fc8w7lyC1K/ZhVUdH2KGDvX7reF1VWDF+dIIGY1ZoF8QND6OfjtnOCuRY68uz8TP7Td
         lX0g==
X-Forwarded-Encrypted: i=1; AJvYcCXZLadFUK0R0X5ftFZDT+6AsrJ0Y4ecF0beZwjVHb4qR9e3ULkyWJB6sKgdNznbY7UTSGRbEGpRF81Zn2o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjJMi5fNnbuFgp2kN9hM2RSiNwTF/ukXEyy+sddym7wBDEUrLz
	nU87CbhzmCX/UOIubwGq3cb9ig3SJkyXOoCoqBR5sTTDj7162dneFVBB
X-Gm-Gg: AY/fxX6YEGKJBl+PgVja9VXYnzMYoz6RffrtOpmzFfhXsOwm0yaZ9wbXB0REGvFvnEl
	LMz9GEa6FWvI5NtnM3B/n/PDtc+m6haynhxieMGHgHKXH3Msfc1BqvPgTsSnH1PrSNfjDPXIWSx
	Vh1R9oQbzJf7guRcADKRK3Zv9xB52jkl8qk9Dbu5ax8qBv8zINmPze0ivmamaL3NirDp/jPjQ9o
	swU3/6BkpASBxAe8Vj00hBtpVbYsRTOx+uNdNnsm/KLJ2oiwdQp3VLNER8DrJzsNDu530ZO9lDI
	+DoUYybq+mERDYe8uvZWTzo5YeWKqRVekzBEqeo52NXhZml+CyZ5XPYA69d4Aqk9O8TtR23KqWa
	8bnrVTt4oA3uxNTyGFxRnYEOyB8e5tuFvTs7hpGFNNCAzQky95tNgaLgthNrXSWyKDER98eYILs
	Pk304Z1J/D7oHt
X-Google-Smtp-Source: AGHT+IEJ9Q5qdYN7r5wkxKvXn/1Lu7RoXv9XQ+En4DMwtXVbXRE2hJNNeOmPbiwOSmaKWGCsKMsYAg==
X-Received: by 2002:a17:903:1105:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2a2f0d2db41mr23919525ad.15.1766135804477;
        Fri, 19 Dec 2025 01:16:44 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm16831515ad.59.2025.12.19.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:16:43 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com,
	colin.huang2@amd.com,
	Peter Shen <sjg168@gmail.com>,
	KKrzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Fri, 19 Dec 2025 17:16:31 +0800
Message-Id: <20251219091632.1598603-2-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251219091632.1598603-1-sjg168@gmail.com>
References: <20251219091632.1598603-1-sjg168@gmail.com>
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
Acked-by: KKrzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..4cbd79363da2 100644
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
-- 
2.34.1



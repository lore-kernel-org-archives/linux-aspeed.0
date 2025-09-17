Return-Path: <linux-aspeed+bounces-2267-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3AECAC59F
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwnt1fFVz302l;
	Thu, 18 Sep 2025 10:03:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758095523;
	cv=none; b=SZFJI7NHIJQFNLGl+2YgKvuBcQQd42Lqg4FNKno50wroA4tNcyZyhjOb0IWKaQQ5jUNk5cYuhswYLWmr6H0RH9aL6wXGIH/Z8zH5Lng6HSy9MXkvNo6DRqPj9apVU5SLt13Wb1QFHhsGlLnp208GF0E4H2uPgEWeszXKSiNZ8usK0AqFHgWdEAQ5Qn2g4ZdbJcsWJUZz49TQSUu44RpPt//15XLju7+6Be5rPGpZ7KMSoy89RO845eZKUUPSwLr9sv33yrMWsskq524NkAGHY8mHNJ79ye1reZ1ND2cBPQYDJMxyGIKfBUP8RTnyXMvIGNuVyz9MwldOXCD5SmYNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758095523; c=relaxed/relaxed;
	bh=abYjL49SciLzOaOA35f0uMdKGEjHBbwqKbxX7MVH+24=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mVDB+2VdZdCOpLhlCSbRxhBVkn+w2f5O81NhVikocIyGGZR6ht0ydrOPmcSzqhX5ScYWTgkDr2icflxgMcRlyOulcLH6ehqZA2e712r20dZMAlxrwZYjYU1MlHD+m2QcKCfRnMzu5LJhME0zClMigs8yXkfSEQEth6T22ycfNPnJvEypGas2QpIFTfL6pCq71fNARcscdeej0yjrSlTB9wFwh1Hd+K3WVSi3YotVWAn+f6yMO377EhnVia2Atg/JtO02uiaM9ZOEC/Qiq0h1jDFJxs1VAKbiwq1XoMfPxTfgokfzanVVPnt9zz5OArBzCR+AOzYLiJV0qTk7hJqIkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NeAQZ3GF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NeAQZ3GF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRWFG6CKkz304l
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 17:52:02 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4606671a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095520; x=1758700320; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=abYjL49SciLzOaOA35f0uMdKGEjHBbwqKbxX7MVH+24=;
        b=NeAQZ3GF25ONHixRszHoTp8lXP9BWy+uOF1Oi+h2tz060CTRwP1goirS3pWBEsRqMN
         4ZR3OE+A0z+rN5mVSAswzLvnKq9HGfvWNYYz5VYvbN/HrmETYUejH+ViOo788UQGIDkt
         a6d4USUD+PtUTnEz1i+9ZOSctNwgsLOTSSKwBFnyhejk+qt16d3qg3Lt8C9rZhrnF6wv
         D+tBKEAwnKpJUVc8BtxCM6GO9lcxMJVL+WLt55Tdk4jXMlw8A3GygMcoQDHM3YGTdB5t
         TS0eAGBS6X3xXcFyvD2Z1m8MMfWPbtvwhlaEc2HjYlMhKNoNYxwe6TUSni32PRvgXxlU
         cB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095520; x=1758700320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abYjL49SciLzOaOA35f0uMdKGEjHBbwqKbxX7MVH+24=;
        b=mLvpxmVbZHkJu29PxQHDf4Nee6YgcteOLhevICWi2ATE3kkGbRg9JFilHbGhNNemlR
         4Z2nQAJnibfIzhLA8ASHy0KZhFaRiNXaBm1BypK4WkA5+z/GnXyr2cfPE6WTFspN/8+0
         PGF43kPuibP1sQA9Px+F0Xr6FE3qNF737XvPrnxQuGcYaRrT0XPblRUn1An4jvF5m7Zf
         7BPVQzRCos1Ui+Vf3aF02LpGmgEmOqpP+b0DbDvJX/805qrBEEzohBIa758iSmSKizSm
         g/8G1rRZ3INZ/ZHsg+6na7zjMNIl1XpederzEX1ZkzpP6MnOdhQHjhlRbfURyq4mt+lJ
         JmwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVHvDn1IhXmhVGfxJn0d0BmBLDUrTqA/iGMResux1GLXIjYvGrrxAyMVgRIPe/84VVnMp77HQlf80TvuI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzYL9Y0Wzm0FGr7dm36OHR4HKYth/waJNPFXJEuVoCyiib6iPdY
	oUVzIgIhuHGdFLiQPpM++bj1P7Gmp465fMW4rOPm9SrgUIWn46Woq+aj
X-Gm-Gg: ASbGncvNWgLmGf6LOO9XurYTHZnb0kOTet1olVdjhDSfIhV7e5/DFYUqjdC5KqMxvwI
	dTIwt0G8BIblMPTjXbrj3KOOYXLkGrRwczckCxzeN1CWtawskRLpU9rFdZPG6NRjsPTLe2jEqnr
	vQeEpdrjU9w8K60ogxMa418Fzbv/0qzULeiAGX/WWgC93X/XsBi9Rav/ErPJblKAerYM9+rQ4J3
	5Chlb+RJ/u1z0gnRgV8YxievuK+fALArJprGwYnNYZVGc026AjGX73zpflmYorIS22rn+NAaLCN
	OMyfYhphtqXUZHGFCEEBWGWKqBKMjZbNvazNaot4rJg4F0l1NW98+LciY7io6GHrEn/qFcpr0Vk
	05H+duIurwgH9FrDSSHNItrVcVS7nNd22TYRa
X-Google-Smtp-Source: AGHT+IHUW/wTOhIs1KEMt39SwXanfpFrThAcQacQ2rNisK/1xxjIdZlvOMm825vyXwIFErVxjOFrJQ==
X-Received: by 2002:a17:90b:2c8c:b0:324:e96a:2ada with SMTP id 98e67ed59e1d1-32ee3f2ffefmr1335606a91.21.1758095520454;
        Wed, 17 Sep 2025 00:52:00 -0700 (PDT)
Received: from meta-device ([2001:b400:e359:6d3b:3881:d7b4:5e6b:c23a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54f6d51fdbsm253168a12.26.2025.09.17.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:52:00 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Date: Wed, 17 Sep 2025 15:51:56 +0800
Message-ID: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Document the new compatibles used on Meta Yosemite5.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..6f2b12f96bd6 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -89,6 +89,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - facebook,yosemite5-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.47.1



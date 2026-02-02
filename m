Return-Path: <linux-aspeed+bounces-3457-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2B3D172D4
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Feb 2026 06:05:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4GM5035dz30FF;
	Mon, 02 Feb 2026 17:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770012352;
	cv=none; b=UJ77qtfB3wLhI13Vd9OKcEN1NExrtUY+BZ5F75c0LOiLZV4eWQBUYuvtKX28llAXQSGjPsx7+dCKUBeUXrQlKLd+4yMtuk2u+5cXI7BKnNnffw5/LQDuWUbTVCZz+KleIUrVYZW3wiLEeKEAQntRjmCm0CtZ2cSO2bCgMhFI8XS9cv+DZ7F7ymL8DcquViDwWxttrrR7eXD9o3Yo3yeEvwtAl893BkeqOnWqD+43/zBK1QB1Afeo3+/ta0J098n/fIW74wegK/k6jKcGofwv/4EZ32f2vji3A7KNFqBexAnAEMHdJOtC9viLTgp4GZivm3J9vnNmmeEtk+Hmjpfe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770012352; c=relaxed/relaxed;
	bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyQLweBvhJ04AGdwE49FO2aUX2XAse/Ws+rPuHdu5/zV779jnzqu8Jq5SGny3WxjrDfoxASmTblvG0Y7Ck0qA9U3GzfxwA9qX/aAmymqAJFwmZR2vrLTv7Kot+vJwCiMsHriNZRLpA+PsOhX7hMN+nMk9IsWf8YCrnJ3MLM2pO9iuKTHw1xFbntiPgB0yonRvWhlb33d1C4BqBilr50dAzn2zpdcA0RbQez7cshYXxeTsv8gf4asdXohpCW9GV5IyPTTz0P6YUTXO72Naum7jr3HVAOc6dhm6JHjRVN2CBkFifcGqcjoZZHXWL6/Nonyn6UqBf8QThvPrdY5Fl0ptA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jp/ZSY58; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jp/ZSY58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4GM42g7Kz30BR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Feb 2026 17:05:52 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2a0d67f1877so26571785ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 01 Feb 2026 22:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770012350; x=1770617150; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
        b=Jp/ZSY58ABqou/FZCbfwEeV/G9AKB+JaC9nOhH3Xb8C5NnzdC/A26Gcody9QqnliiW
         tIdBh8XqCl2/gngpOPltJP77otpVRiX7fo0ak6FdbgaXkFR55OVOzbaNYA7iIcL5gMs4
         cBOMtSyVPhGG7FylbkNqZregZqbJt6dTu7UBx1t4VFWtob6wpCCSg7bWT/J3E87t+9ZQ
         tBYoHVApdtYuEkDhCTyf2xjegnkj+2w8BLC40zOsl6fI/B52RuX7IW4Ipw4wD+gtO9DG
         //pUKj/lk0VMfjpZPWjow2bEUqEEF9Sxfrd6gnx+4u/D9wMd9esQM5caiXxlRfMQ0riu
         m2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012350; x=1770617150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
        b=myo1/zJ9fmIDg/clQZq4+FkS946RESx2KqGW9vALIpXAK6/xoZjPiYqrqmg7vyZs6j
         LVHlOUedqo0sd9dKewVjvj6ARZbOy3eA22WWUYzpk9SZwzs4GWEx2nYvfj1XYZnl4dyS
         yWxGHcecPuLQIckFAxNKGhLlx8J9QyOdVsvrvm1cYLH85PgTcggFffs4QCcQpE1SOndq
         G9HDOmZOwfWpZjDYB28fwv10O85LkBmGfTk7ODCgQ3gbkceHhGPrXCN/uOGEeHEy11zX
         cOAo+aDXZmtJ89Spfp3tGhCYaSoT1OFEAIVvXxPBLXtdFUK3IMogreirx9jqgrBFo8/t
         vBhA==
X-Forwarded-Encrypted: i=1; AJvYcCVM3D3mYwF0u/IQGukUyov+scuPNXn02/wphbGRAq/XsJvppaqaEJNbuEax09fkze/S90M4l9FOaF0QAaA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFXRkSnEoDezEWoBfYqL0tk+Zmur8U6EGMGOO1JiOVLbnYD0pY
	VWaf6vZ8+9eleL/vAT2cP3SFQiwHjnUzVgw/RB2/8opdcCfX5KMqd/s/
X-Gm-Gg: AZuq6aLT3FryU+Ice1LMsNxVrldPtP/fytuwF7LmlhO6kmA4WFwFyBvAuaU0DRs67MK
	HZsu3MFfMkjpDSDtafV/6XHBETGepB2s10E/wrFiQb5xD6JDVl5D2FgJoHW8OMDCLRMrbaEMkc5
	Uk9AMpOBb7E6O1oGXTWocdIfDIt4wu5dfSlSmj9ct16lGB8SaGKlcPh8u3QSbinPxeJbo8p5w3R
	gNrRNNROtahEDwzJMa05WwD1jDaz77fna1BA1a0+YwSOJqvIOGyOi8+UXU3lFsKuKUef35LE2Is
	K4rdTp0BWwg6jWtHQmUcvKt5nR0Dc0azUxIznMpl8Qh+YJ+ju4eRXKarfVbENN1EnEPq48dz99t
	e7Nm7bqfQ7Iy7BXnw8atxK7+LQfVf7BT9o8QiK2RZvmzkv/oVoyuLZDD4SXbyarEi2Ir4To1c+t
	rgi76mjOgH5vidYTce0LZa3Sv7KByX8w/tTVAAEJzq5Y7pj6TZuc0fAAEGXH98edhAuQkHdmFba
	Q==
X-Received: by 2002:a17:902:f708:b0:2a2:acc5:7a42 with SMTP id d9443c01a7336-2a8d81801aemr108152325ad.48.1770012350239;
        Sun, 01 Feb 2026 22:05:50 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm132926135ad.78.2026.02.01.22.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:05:49 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 02 Feb 2026 14:03:16 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta SanMiguel BMC
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-sanmiguel_init_dts-v1-1-c0023ae41899@gmail.com>
References: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
In-Reply-To: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770012344; l=841;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=awDe2howAZDyvltIFZvQ9S1Z3NdAcsc3EqMeuy1puZc=;
 b=kEp9CUwnACmR9NE2TIjtVwLyacYjzLHZXZVw5BEazIRRzng2LDy+t2D5cYB+vLl5p49SqUkt7
 BZQ8VeQwu+HCJwN3aaRbYw/PF6VzsDrAOdJC7cddPQyYrAXH2ndXXaJ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Meta (Facebook) SanMiguel BMC board compatible.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..6c84e6c80978 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc

-- 
2.31.1



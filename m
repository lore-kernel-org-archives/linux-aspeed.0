Return-Path: <linux-aspeed+bounces-1190-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B6CC3ABC3
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 May 2025 11:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZwykB15c3z2yGx;
	Mon, 12 May 2025 21:56:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747049480;
	cv=none; b=fbwQ+0m84oNy0EVUiXnU0AUHvNAC0tg9pO0D9FYRzuDk3TBsU5eZkJlXRb/9kqzyl4hKtyD+G3mcZb9r/2tOQOWmkXgkdn/CkGl893t+aH9oWQIApjcp/s7a4+X9/r6HuKbQcfYXfTcKQREpkCmJX5AJQ8FJlMpBOmvCvd81z8HhTZjG4av3gnNpXSlBe7zAgqft74Tr0xUAJYgSBkvW25VALkZmPJh5uvV8+kH46w1Ibhy1wHFmfl4diGrNvYry0cRo/MmFRnuTFbpsuUvqfW055VwA0oC66QknMelJWsEXE2zFIhe0Co7+gSmT+JPOdwNVI06nh8yWhfIB7Uqivg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747049480; c=relaxed/relaxed;
	bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A2FVGWIxFQByjOBiPNBcLmClMAMzzWctp9v2aPK5ImZls/H7KXExdGO0vhQb5Zewc8ySuVbgURyMcvcKbqUHUj7QtXwdXdvIfgus5WG4MQKntRaAlHFVDPJ67ggauD9PEc6vCGxTW6QdjsfgBFoV19SpF81qwUbdD8qwvduBeM8JmQVL7dycqaTWPnz494/0u3R3+auCBbdNiHpxLNRtFfmBdf3Whxq9cMZVldF29NVj0+Wj96e6ZGWzlzfjo3i7tFuh0bQtSfvqy0sq92qTV33+cWvVilMSEi/hXk4AcpecuiQ9VNMugsK2wMvsQkF9FIvw9g1+W+4LHQbMdAkFMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EYiWna23; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EYiWna23;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zwy9M5gg1z2yGf
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 May 2025 21:31:19 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-22d95f0dda4so49988915ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 May 2025 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747049478; x=1747654278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
        b=EYiWna23QT0Xxm9yKWL+5Y4Wk5YSmruiqQWsNnHoOENM6R0Bw6dhuUs4dd6ql0aFd8
         2PdKzsgfizFuIsyWzpXJuFzLoq9XpFiNzegq3iTLw7WZYfJE5MjXSudPOn5XlLTchJpc
         7D5EW5GdWKhmfDlaKRUK4EK/TFdLqiZ0CGS7NlQ0//PedSWoQfyldxGZFpbhgRLPZbY3
         4sB+y1vw5OfLONkzFRq1qLuiXgd4HrrKGIKL/c8AknEoasm32Pu+DrV3bSDObxbUEsCr
         n5I3XD+Du1yadS08z70oxI7N8L06k0/MOX/ONt8PMiMS14/e0/Q85T4BZuqXb6WW/JA3
         MuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747049478; x=1747654278;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
        b=K8HmW2CUfAQyEjbTKiIBrh/5e2+NQy7sAp91evd5PGNfrEcSuaDczE9UwfAsXY2Ja5
         Aytmqv/AHTLUHktUKytut31n6KO9yYmMZJLpXhYKnu8W2sp/w1oCC2DpNRWWUaEXA77x
         RwHZ2gJgzCPq0IRwgXm5F4qoowJgRmZsrDCR+CGeJw7g7aji3x32kowZBzAYzrlxdAtn
         Rkme6DRwNNazqoQXunOxV3X5Vifdlr7xesD/sM/YWs0c3BZ7/iGXM+sR4C6owpufziB7
         miimGyd71drFjGi/KTiFKshmZweIsaWwIfLRWonvmEZ0GFhwYOxdwe/lDsxoqA6fYDtP
         TxaA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZ2sX/0iO2/bg/8nGrz6fCynPZjR+D8cVqP4g0t1aUW2r+bjf3de+6HJOTKKkFUh51P3ubRTbkUArrUQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxE2tya03nXkPSuTnonWv+3eltOOIcwKThCeYvlkzlICHUbQ1dH
	CdxRCZa8edn5T+AfgpnK5jAT3SZE1jWTJQna4bpWou8meZmFg21Lj1EH9A==
X-Gm-Gg: ASbGnctj1BFp2SX6q7gQoB/20wxaJ3ixhHfSmfIAEgK5C695VCk95KGY2rV5Im4wsya
	SNNx1T6T52nXCjLfg9jgVXY/yTOkxwPgv8lWikHbpjGx9YJFiLaQhNFXTLTHHKxESE/DmPSie1L
	CwdBoSKKQ2GalWEM+cDR9lX2QHpjvahJw+Qngu5CN956Vt8HIlMP2BFe+9MukHFTXmBRKp8d4Ag
	zUZzYrYXXtu5SIi9wdeeeF0cpHusmRaVFAvV1B0Sxk2JvMi4ctyBmuhFIo4RetFVFeezpj518zc
	Ew2issdYuB0J+cgUbjuE9NwmJxKuWqYtYnCwGJRSQL0kGICDJ6aYrExEGTliuYgyMy0e/+NS
X-Google-Smtp-Source: AGHT+IExxyFiytciXzSdjgPQ7rTz097bkIWdvh5taz9amgHJiu7hfwWP19TIewHg/quu33Cj0p6pYg==
X-Received: by 2002:a17:902:e747:b0:22e:5e70:b2d3 with SMTP id d9443c01a7336-22fc8afeec8mr186571865ad.1.1747049467733;
        Mon, 12 May 2025 04:31:07 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742ce2sm61074145ad.80.2025.05.12.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 04:31:07 -0700 (PDT)
Message-ID: <6821dbfb.170a0220.3b15e.aba8@mx.google.com>
X-Google-Original-Message-ID: <20250512113026.264785-2-LeoWang>
From: leo.jt.wang@gmail.com
X-Google-Original-From: LeoWang
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	george.kw.lee@fii-foxconn.com,
	leo.jt.wang@fii-foxconn.com
Subject: [dt-bindings: arm: aspeed: add Meta Clemente board] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Mon, 12 May 2025 19:30:26 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512113026.264785-1-LeoWang>
References: <20250512113026.264785-1-LeoWang>
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

From: Leo Wang <leo.jt.wang@fii-foxconn.com>

Document the new compatibles used on Meta Clemente.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index a3736f134130..4416a40dcd86 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
-- 
2.43.0



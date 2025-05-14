Return-Path: <linux-aspeed+bounces-1214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6607C3ABCB
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 May 2025 04:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zy1Ch2XXnz2xck;
	Wed, 14 May 2025 14:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747193165;
	cv=none; b=ob2liA6fFV92YqYU8cJALqf2z3XlfOlHPH/xQMbMyqdKfyae4BphHvb/hUGNFJ5rRh6Qis9yOWf8lHEW3fQxs3kWFLwhne33x3fHNRPJhq71k5fLHSFPy6rN5nNVULjZqCZLMwV7eLoIe/35sO34DejAOl30Dm5O9juW/TwxRN2HOeLLQ8Wz+Ojv8yDwSm7/vBnEF4FNpmqi9fCKOM27PNVbSZtiqvzRV2UD8rGsETXvlpExl/AXo/4RCwzJ/wiMgmXL0l5UChW8CKWXFA4ASSR40GkLIDq5GhEVBGu2NquqQ4yKE3vYQG06vZr9BrFBN7scr5Mt89Q6s2LLa6U82g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747193165; c=relaxed/relaxed;
	bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PjtZ0bxkX0LszPHC2Qv2rIskn0cO7NzU4eaWafWLfdqIoCJ+UY2I5DI91cGQ3qFQ9602GLwKlA704icrBvMyb23Pq8RccX3zie23So3p5f/afmRKFtSyETofVb1SyrEXLf8FR5JRmbdLk3wiueHskPKlwno1T6XKA9YOuhgwtDp7ugKTQkAVC9n1lI0FRybKUkdkU8he9EpwNFRK7K5w2KeyR6Qvtck2CNPqTvXsN4ufN5mkWB0b5DEUrjDWJu7kuN8958OtiFdBi4sjL3g1WpEMNSUEko9r5zI+aDC/CfrT2muE+KtvcPTzHa2xGsyMz33POQC0/FuZCVrS7NHtcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LIXw7SZ5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LIXw7SZ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxzJX04l4z2xHv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 13:26:02 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-30e390ec275so71804a91.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 20:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747193160; x=1747797960; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=LIXw7SZ5YqGeUtsoMrjgPPqGGYlF8z3x+0crVb38J0LrCOmGu9rGSDGq+8D3yXw24f
         NqnqBdRou0Ehv+YbNED2C2m/7eTvpaAWPOgA7Yfgt8KeZ1ZD4mG53Qf9Vk15BvfZSKwJ
         sNrTKszZP+gI+0HaXj7Q1WSS+ubnBR40dMUIFf8YBJsx//M2hGj6Yg8opB4WBiPptSsl
         wn0V/bGAzsF73r2HY9c+l4kJ7e3iOtVkdZiBbgZEMhoxAZhYMpE0rr5Xgnk+5YVK8SIZ
         iE3InAExcvX81UNrpzvEf6es86qA0+vkEiZvuuY1yOd+ylmV/EVjSx13xqwHdMymBMl8
         sDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747193160; x=1747797960;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=ohYnUEbt8xQu9ELvmwazECisNGgHHSYS7lwckhtVF+ICrzovC5ZQ9CMSPSh2kQHZn8
         S49vJS+YeNopqPub0I13AiG1Bn2BL+fFWoB+w23NaERN/57HN6+ryBeNjF2mlvybKc+J
         04PEtpPhiOjCGiDKLSSNBoRTqKbfJtkq/Y4lhrsHPHAPECw+2BU71QfXTlMg9ekyR3LN
         +bfQsMjnZzWh1KQVjjMdyBFQ75buJBZl3T9iBm216drD7pGoWo58tJC9ZSJKvAax1UtK
         O0kUZOQwVCb2ey45D7KIwoIyM9MQF1Fywb2FZH3IWtN8oA7jDwMdE4gmaky4p/UED83t
         EBoA==
X-Forwarded-Encrypted: i=1; AJvYcCUSVM9aOoQx+x8Lat2mePHEpyKJxr+snKwQ89m0N/W3xPIOjiIU5Xr8IPPdMuGTqKR8fJ+WRMR2NjfOAWI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgU3Jnmzo+Os0cUKiKkTDaXV37b5R9MIOP5YVRJYptTG5xnPni
	Dj98A94t8UBliwx1+td/OxYn4dNQYSI65EVxWMWWSceraliKq6c4
X-Gm-Gg: ASbGncsGTgkLKRjG6/X/4Ewa9FaCE53ah6wLr4+kfDmD9NgHMmYNbyqmQhXyLcG4rey
	KS8pn6CaF8V00u3JsGlq++lZMkAnjrPMz8pRGEloHhvgjz9q6YunHz2HbUBttNkWLyfKKuBdk5M
	ldkmta+8zPjhySTkCvLk65yFWoP9DLNmDUJ9T5147y5CHPE5lxaMmbwjXp8Cg9Iiuv21W4aUyMF
	W7knF4nSZKT6AtMXz/rR+aI9YP0r/BEV8/8p3kJameKUcn4v4ygR24ke3RQZxjha+EwS/dsBOrq
	9Fo4pHcAnZvkGGR44BnOL9jBzYAQk3hirOE6/Rn+4cgfUon41y/kAuy59D6zKJu/YYH6Y//T
X-Google-Smtp-Source: AGHT+IFgFmbcbTy2fzroMryy0JD+lhC7K5WXE5pPjhmZCsckNBHxwrPKsqyWRirO1mBQ4wl5Y94zsA==
X-Received: by 2002:a17:90b:3b4e:b0:30a:4906:c20c with SMTP id 98e67ed59e1d1-30e2e644d17mr3039146a91.35.1747193160314;
        Tue, 13 May 2025 20:26:00 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33451e6bsm414599a91.22.2025.05.13.20.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 20:25:59 -0700 (PDT)
Message-ID: <68240d47.170a0220.ba589.0feb@mx.google.com>
X-Google-Original-Message-ID: <20250514032452.275855-1-LeoWang>
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
	leo.jt.wang@fii-foxconn.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Wed, 14 May 2025 11:24:52 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6822b830.050a0220.27a24d.d064@mx.google.com>
References: <6822b830.050a0220.27a24d.d064@mx.google.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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



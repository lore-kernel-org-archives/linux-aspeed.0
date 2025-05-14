Return-Path: <linux-aspeed+bounces-1215-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98E9C3ABD8
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 May 2025 12:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyBkx37H3z2yqW;
	Wed, 14 May 2025 22:01:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747205091;
	cv=none; b=XwUlOFWkxOX3z01Nz6t4DOTDXhZWL6waJxoY7WXpaEsr3CN9VBGAQMGScUpRAx8qT/Io1/7tJJz1aHE2fbE5vuN4wbdo3p6+REf5LytyBirrMQrut8+2cIANN+Ty5wRrtYLS6i3XQyiDWy+N2EmfEJcl70JhIwfLG63Vyo4ZmkzPbG1On6VN7PKmugwWa40EuSHIllNGKg6N8jw7z1FxMdGV5zOxqqsx+P7Tokt/Rt/esfLbr9DvUmjBNoWioeeX/A+kQwb1+KCoqHeyKqmzRH8tRMxXbfJTVsNNt4rgYkdaOAwVsoQsexi13FSl/hy92D+VeWMFwrltip1JaJgDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747205091; c=relaxed/relaxed;
	bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mlSZPhRYhEuPl2zOLtOecRS8fAIPu23Q9JYzJxCtGyFyuit25t7+MZxidUCl25Way2gMeR3v+ItIizZ7hZxln/+KLViVxXCdkpEWrLcTcI3wcKM1t6jCWRWLSkb5SD020KoYVgqyrSItZx3Mu2gq/g7VNRPXiPfCTPwuKUyo9XIG2ubfs893b8er1SaXIvyP94EIHs6cxSDFy1D/1pmQTeoMNu2epWm7KzzR9kWYyd/5am87U+bcjpQM2A6d0EvHd88/CPg41y9QMj9yb3E+Elc/q74gj0igY2Vojt/ND6xLv4AlsZHhTzE/ZzfM7V2F+lvxmoeEGKtK3wli99IQ4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZbUIf8CW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZbUIf8CW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zy3js5Qnmz2yrl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 May 2025 16:44:49 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7418e182864so5318298b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747205086; x=1747809886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=ZbUIf8CWGnVF9CBzKgzktjshGXDn8n+k3zIYD76PVnHtBqduQMrIdlkRW6yAqRijB0
         PCuIxk7es3UAX54M49fT9wGg/cVZufjzbc1xWtxfQ9omIA8RmQfUg/nEyFQGbtLpdKk8
         njEQVczaO3xIQ4FagsOTeQA0ftZIgdyIJaC5gJsTFcj0GEtQbYU1T8FAo6RMaEhonUWM
         xATLaIpDOTZAOwPoGWZoX4xLcy9TFtbJpKbepv1LNxWLFMvINGCfCpo3nTxiIFYtVL38
         MY9dojwBsa/DzGBlPH3z3fPhDhBvY2N4JSRb2vTDh/UfLEClwBUdPAwJky0nS+U8AgfH
         zFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205086; x=1747809886;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TcDZQwTmMdtyKKt05qTa4r45+8RvNA2opPyhd5OidXw=;
        b=g3rgui7qN3P4weSMk0B539JAmULWiT6h5Q2uiHya+uP6Ghscin1IcVzHDhfhij2mQe
         Q814zeDyjimJS9azR28vAKM5du1iaghEYEjdx3vW75Oof1t/bBa3O1HFuhB8CkdGnc6p
         svFjm5DGJfzWPN7W+StZdzGwzHMRymyR35gQO+oX/SkrCQqotZVAe/Kd+sA0mV2WD/zU
         ya6BDUNZId61GRKsTPA3a4DvNf9U0OjBGv/vywcgGkXGGc0gmGQWZYgH+Btxzf/ailYx
         znSf8ywbSdx3NAn5As2GhAUUH+eNCDF3xaOW2iRj9h+4YFjh8qMHrkKt0N4Hb00yK0kv
         aBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH93TNu8CTS5bL8ntG7Moat5+/yTHqiGTLMLf/UzAdHK7wE8UvlBuUZIUjmvcu4H4ciNrVGOREUYtQ5eI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNDW3hxzc/1epjvZDjolnmFvinzGpqgbHHakLQkUQ6rOy/Va+F
	yGyMx9CkXczy9bcRfBBsEGTTRAr2NDM+0Sd+cwwwdr1lY3HnSMU5
X-Gm-Gg: ASbGncuL/X6yw5znXRsCLfMd4Z7DGRP1e7nAvI5JUf5bmpVAMrH8YBor/gMvqO4GOI/
	GzxLDUT060QAcTT/9Ka/+54TpV5FrxqYIZ7LsGAb69DHTxzxDCSKzupUS19KWjMneC60MM6/8DE
	FXUBfwq8pcGNfLgNhVp4oXPzCMOqqXuRVUoYfzxey1iEs19FGoP9gD9thpVPjSz/vd936G+H61L
	NjCAHEWeGbBBCXfKhkOA00xR9IvAezAHM8oU1tvBdVlic9XyDkj1qLrSyv2Kww1osibNOA1q1/B
	97qgEqNiRD50mgQMgi4JwflO6s6G7Bi+XVrjdQfHV7MiRDvj51pwi1uIZccevbdiZw7/2ygR
X-Google-Smtp-Source: AGHT+IFwIZrYPD3WbXFDRklDUuXUJrldwY/u0s/EqxIvE+gIjhV/Huxd9CKq/cSzMKDp1d6ZGWTLgw==
X-Received: by 2002:a05:6a20:729f:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-215ff0eba21mr2915171637.17.1747205086397;
        Tue, 13 May 2025 23:44:46 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742d13sm92517375ad.90.2025.05.13.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:44:46 -0700 (PDT)
Message-ID: <68243bde.170a0220.12d995.13f9@mx.google.com>
X-Google-Original-Message-ID: <20250514064430.284576-1-LeoWang>
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
Subject: [PATCH V2 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Wed, 14 May 2025 14:44:30 +0800
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



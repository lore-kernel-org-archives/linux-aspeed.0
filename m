Return-Path: <linux-aspeed+bounces-1501-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3FDC7115A
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Jun 2025 00:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bN19K3pzjz309v;
	Thu, 19 Jun 2025 10:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750239628;
	cv=none; b=JA34qMMcznBPSq8mLMppOuQH2HzBc/EpBvw+ra0k0KIDQtyzzpLL3w01kh8pKxceVJasMxPOinP/ZrO8kzLGAx6//AB5VZI9XWRTTq1DZ361zo/aj8OmyhnYifoFIYErRh9RsvjgDb+fYRkuwe2Btddhp0Xk414oVg1eRDZYCZcF6D3nn7eZE+19wLNWY3mE387o/vKzqmsEdvh5h2QGVDbGvvd9y2fEoNSuRSTfcBAcq6iH5EsDXmHVaZF3VBxK380nPts4Fnl9rZcRImhsDw0QvD7b6KeFahAHEseZLvofmVs+jBdqkCRMRWMEve0TwOqsVh9vPBwCmel0y012zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750239628; c=relaxed/relaxed;
	bh=yxyNJvaFnNxHerMMufs0K/uUcVxpSEfQTxbEEXxGd3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vn3sZpWuO2fxpaF98KyOje70eYq2PLpGVzdtNjMhHE0dg08uBkoIiMVeL63X0ppxccKFdK7fn3bMTJwzEOFrKbXhwUjwOsKu7p+gs+5NthFK0ZLQc4fO9XDQYcu6SFAzT1+OIEdaeB2AeAj1+l6q6fkSvMjXMnhCeRepB08/4ogasZ8tiLniNoBTZ1FuCiji4+zN8IqZTGosR+N6TFwG7FdSZDRK8KrUT7u9udFMefwT16Opi1VHjD9M+ieXc2MMLIDUolg/yxeP5HSAZm8J79fksViMz8gHUh+JN3YRFrl45RHBuRWaWVYA0WEH1iOLe0CWJzy7nG3iukhyJGktyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HSFMjkzt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HSFMjkzt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMdyM4l0Jz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 19:40:27 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-74264d1832eso7483507b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750239625; x=1750844425; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxyNJvaFnNxHerMMufs0K/uUcVxpSEfQTxbEEXxGd3U=;
        b=HSFMjkztWYuvmSrmJ/ImsB04mpnbWzrDcKf4c/+O9aZ6qES8ZMKBV6BVxZ9MAQ+z95
         aFRcC4RpNhSM9cy24ncQgmHbTri377nqF6W4WNtB9grkJif208pXTf5F9YW3uix8lDwr
         nL9SaxCTz0sKwUgYGFP3D3aZ5q6pBk+BtZV110uvNhAod0nTlmQ751dkuY99yjRgYT0l
         eGTMhlohkUCKMrj1LsN+TbZ8DBzaUNZJztb4LhkmNdSJ2jTNwgG1kJcqGXCA2vOcwFH+
         XUIAu1bK90n+L9+Jl2bGZWV4LKmm1YdFXjbx6eFXGkgO0FcYTcqMXp6l4G6RQV4AGz33
         bg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239625; x=1750844425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxyNJvaFnNxHerMMufs0K/uUcVxpSEfQTxbEEXxGd3U=;
        b=udUHDlcxv3JRtxVN5kyIrhv6adQ39OVmwei4DBzGxPwTzE3yXoNeqCafHl346Iiy+s
         b7HIbjWnFeKU/HovKCTtRezyq60T3Wl5uAMJBtxM8NMnNBaq5+7Rsdyz+9OG5oxmXR2m
         f272oqy1GCe/q86I1M2eRvON7y0aNEA5NE/G3U7mNEz0IVxSgvDSEO0V3tEqRKEL5mIR
         hPsT5QaQGoj4BJcby/bEKyON4eCFsUTliMYDeW77SVRzksYltool2q3p5jfpt1zpb6OM
         ZbxqWtDzbbFc1qgFII3Nfw7xUVqOJW4fv66CJM5QKrtSKjEfOAa2ZAON7KapOMP86Nva
         GWHw==
X-Forwarded-Encrypted: i=1; AJvYcCWaIQJyAkHoQcieuFEAfNdCMg98mG3C79OLmTd8uwszTeP8cOKsHENVr07q6rJfkhzneYceXr/8BO4B9PM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yymwk6G2nfsxtk+KMuc/6SLiaS2VoDBIB0xGAqHb3zR+Y3Mig5h
	iNyno0SmscnquAK7Ytg3DFm8nEEDzTZ7lbBzeo9qUFHq5YBaTpvfwgaB
X-Gm-Gg: ASbGncuBjAfn5cuxgQW+HX4IgGxTLx1pc2WI12ZHHfsF4JVtENIDHdRmEVDbIaTCq2N
	QOokdxy7DAt3W1kRdmP6zV0j6LzmYmcl8CQsyGKzM0LeKM437kmp7+JERHIkJxyS+yaLSfvnHZC
	5irh/o7+mHGugguQwLMNyJ2W07PzIAXtlZlJ4Bbwrhtk6UVEfvbcF3u+aRo8d76o8RJCcxCDG04
	xRK1zfoNJY5j7XJdl14oD6RmpNIKKd3kTPqCVGP2gupmzgcyvypl6ZvxRJTf11r0tGz1XkerRr3
	1AZHSqGX3nVynUbPSYwgEKDjhEpi4wbX+dSAiyvpvfUHlOVOx1+AhyfHieiru+P3IlDaizAW11I
	ELrMXg3dZs/p0T9lorrJLY0w/5yfGYVirPKo4KhBKWQ==
X-Google-Smtp-Source: AGHT+IGIFkT9F9++RE5EjOQYpeKdGxSShR/I1mIh5GQ/Kl0wHl2IVWy44QjHga7/1JaOEFqYchwQqw==
X-Received: by 2002:a05:6a00:893:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-7489cffb9ddmr25901716b3a.24.1750239625553;
        Wed, 18 Jun 2025 02:40:25 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffee2aesm10527123b3a.24.2025.06.18.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:40:25 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 18 Jun 2025 17:40:02 +0800
Subject: [PATCH 1/2]
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
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
Message-Id: <20250618-add-support-for-meta-clemente-bmc-v1-1-e5ca669ee47b@fii-foxconn.com>
References: <20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com>
In-Reply-To: <20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750239618; l=939;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=GnJuV3HZHZ5dsfk5omBq556B4S6C3GeRW49ZlxKiQm4=;
 b=kKncC1/JfGB/N2IhW8rVIODlEvFaJAyarQUMd5sSJNJUJOeW9FTUDNZ+HazhqmrGqkNcIPgk7
 1Pq8/J1gtwtDKVQlAfgt2NZ9yC/3HZC2ixJ9zGBeriuVgFpHIe0dvQ1
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
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



Return-Path: <linux-aspeed+bounces-1947-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15EEC87FCF
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:51:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBG0HKTz30TM;
	Thu, 14 Aug 2025 09:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755079477;
	cv=none; b=BHeQa6z1TZsPLo6vgkSAdxMmw4S5qdMkyR0E5+fGugN/csDAYe5lRJK2u455SmT4C+lYS7BtkplgKUo4P5GDnTWPMwtBjKRDxdChqyaM5ssyvwnonqwg3KPu2CAdzUMAYjmJXoq3TvhFPu/lQ0ndWQJRpt8dH7UkpECPdJ1r/bwTyxSHTduFoazHV+WrliGUvIs7mf74dHjeQSrJKyjX87X5FiSDb18LneFrcLitooCnUjO9aaI/Zcy8BGnBY9LMT0jSuwLM5mbpiY1yGdo/3A/EJ/vo8h3Doy6NbXiWGkAt+FA/EF6pA7O7LOmndMZg6VQ0Bcrcp5XPb/N3RRVmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755079477; c=relaxed/relaxed;
	bh=WDWyXMYmlYyqkjQ5tAi1Mo+9H+BsqxqH2MJaH3c+pQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJZiU2i78/lbfySBmk8OcC44TEOxGV+Ur4KHotWXfE79xkapVZpJge3VnNmJt4txOpB444NS95slYmr8YuzeFJoLuXBMK2bjGZ4cVyGrJ/T5h4q1cuHMkwrMqbOkhkdSIjRjgTVy8nkMdOS3Muw3Tw4L4c7jDlnXe289AvFG11DcvkGgI8dJWqn+0h3LMxg03OxIStPnOaCmO7awLDHZfG8Wz0Cht044DDMWQYlbWMjRO1g5qOGuCK3To7r3X+vxfV9nVg26JAACNcgMkhBWFpGxJ2S116bkuoS4O2QIdzd5vRX56Uo6/EZeIntSPtaY//X5Z//1bPzAwX9mKvCAEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b/8mdr/m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b/8mdr/m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c23rN5yX1z30T8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 20:04:36 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so4294851a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755079474; x=1755684274; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDWyXMYmlYyqkjQ5tAi1Mo+9H+BsqxqH2MJaH3c+pQE=;
        b=b/8mdr/mAuih7Wfyl8Tx540BlAzpgLc2bcJ/PbtrrVDVJxHnugXNwl6qKiFTLTc+hQ
         lHGUP4su37VvP9iB6XdlcLXcS4BqoFpCNsmpQ/HvPdT+suGHHZb5NEuG17xyXOR5nMKt
         k8uibs1EfMhDziIyFNvSbRX4eiDMvmwG5TRbu41dnPBLryj/ahjnmmIDZWxSQlh3yOIH
         wJLWOCHm1cyfwNa/DrsJxfeBoJ8bjXPdqnz/flIEMltIi3l1k9244GVsM6P33SZTDqh2
         1SwmjRbEtu2Jq/9/Tnzk/YVzyVjGGrzFw+kwt+LtqUKVrbmSH9Ulf4nOHAAZ4YIcvYpE
         lYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079474; x=1755684274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDWyXMYmlYyqkjQ5tAi1Mo+9H+BsqxqH2MJaH3c+pQE=;
        b=Bd9xshcUX1huuknX9s//XBCOAorX1B/dhKa0XnaWSQRmgtkR71BA55ffaeYHutQVBb
         OIoUwG99mGPqmLNqtFkv754lR+uiPvMMWw+Ez5dUTFLgdrK3QeFwEW6ktspcMAaMEGKe
         flWiHsSCBCVomOS3G9Tt1iIADIJoaL7Rzxpemf7B4mJso8upAUriqXmz9iDoKtk1s5ED
         g4m7Js2K31NtulGPMRqfgAIYj1/MZai2ZidYSmIxbdiSyc2ObpMka/psHWPE7JtlMJ6x
         xica2Gu4fSb79JWAujgQxHWeC/vNx/c76CL0p4tDAhNNSxRGBSmcgtQSSUhdXDJO3Qyr
         MdcA==
X-Forwarded-Encrypted: i=1; AJvYcCXls7pT4wL5yHD/OoRjePdXlMMwQp537QKbgpuKZ2yJ0Jnb7iC8UVDuJ/AdpVlKDtn0raMPRR9B4qRztao=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwXUCvWyaAuI2Kc+mWeb+GvpfOhh0+Oi+RSY/JGELiqNPdIE7u3
	co+kQpzEJoVwGmzHPP3S/QZNwD6xYchGf6RcX1NO8teAtm5wblqC0ssf
X-Gm-Gg: ASbGncus6zEKUazbRv5KkAOAq1hQvlhBSsGGUCyZchs+WNPqWxpeSCe8mtbPWpHvtFI
	BetTWRiCfUcYLeraNBHsZRYvBGElISiwuGzqWRCv3eB4ForpMYx/m87NSrT+a4vYwsfbqXkzhZj
	nHpnmFX0g5iniWZQn490Ij8fLitnw0YV10vY+qEgypZ8pjbu1OPH8ih1fe3d3d0GIfposutVgWx
	t/8xm4yvGkMFmN9avpuIOLfon8WHvdSUaa3Kz7xUDWay3+EjQdbRf8IkPdTZeqgvFZRD9XXtSzw
	CmqJjlSUEXLXk+ho4AYtKeGW3emyExsWSeHp6BKlGmfIvGoZai3wWy1FgRt4lDQMkkmyb0cq8W1
	qeMmKttzx2eO6+JVFlEm2ePLZxXXxdDWG4803uyv9z7Q7Q4YLLTKufrVILncNduysp0bSi/wGLB
	SUfw==
X-Google-Smtp-Source: AGHT+IGT3aAhDjpoio/fVFfqmIOKN4CEmb3nnrCVJEFLXp1M8jEYK3v6BzGjhuS8hShYz0ZD8JlaDw==
X-Received: by 2002:a17:902:db12:b0:242:a3fc:5917 with SMTP id d9443c01a7336-2430d0dc67bmr45068265ad.2.1755079474310;
        Wed, 13 Aug 2025 03:04:34 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm321545335ad.167.2025.08.13.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:04:33 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 13 Aug 2025 18:04:13 +0800
Subject: [PATCH v11 1/3] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250813-add-support-for-meta-clemente-bmc-v11-1-8970d41f88b0@fii-foxconn.com>
References: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
In-Reply-To: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
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
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755079466; l=935;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=+J69e5YqTj9k0Q13XCuEnilTg/3SIAicfVR3jNTVkYE=;
 b=W00fAaXOnIiR/l9ZRnJcClS1vfLntgZc+ygrhDBzU+WRFiaQLz8OR+xeA5TrFS1TEUl0Noci9
 +Xx83IRKylaDGTK+9a95nhTQAKVaVg0PhuVGMJ3HoxhQ8Vu3njwx103
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b3c9d3310d57c065215054211cf5bd2af816906a..aedefca7cf4a80b5c9d14098b60ce277391fcdcb 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -82,6 +82,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,darwin-bmc
               - facebook,elbert-bmc

-- 
2.43.0



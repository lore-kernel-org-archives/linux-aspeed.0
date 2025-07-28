Return-Path: <linux-aspeed+bounces-1854-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD72C87FCF
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75m6W6sz307K;
	Mon, 28 Jul 2025 15:56:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682204;
	cv=none; b=jxMIrhqYclt8Pw8ZboIJYTLrXPw4U04Xprvyf4KynKym5fiFEaYZzZsTJclPvMbbKKfMqEsTnW7IVNoK2+RIn4LBYG0Dos3E6jFf5vevFsv5B8FrZgIbRjtsMNYWUibOFJ8rCEFbs2XETW5STGIDpQaLQQoYnpFmxFFXuV9+FG96pdWCViwAHy62yn4bTTjYxR/1xH5SIRViX9Rb8m5z41oz3xtCd8gSHBpckca96rYTza80mwXuyi7Mxnib7jaZcCYDWEsNy1ux8KxlBIv5ITd5TK6TOsXNuUvbwGbE6Bfu2ciwolwFsaTFOAsRYQVBolTjy/o4ejh29bJO3FQVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682204; c=relaxed/relaxed;
	bh=uwv8jVW8Cpw1HdPZHR5pkIUQOrnV30U4PbqXFmi6s24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arBnMYBP2LVqLP6SQDrUebX2FygxgeLvKTaQaoktJHyLzwlaffoA9/4fZHdythwZM+zHvrDD/YypAQhDmUuH0cqbCehIMBwE2xBkKEsU+9yGUCx8GWe/NroG8MtMAP96c9tVh5g4EXwHZIGe/TYD+Hyn2nSi4A90jK45RyfXWdGzhPbmKDdAaFaFRrsrXsiwBR1UD0o7N7TXnOV+3SVH9gIiuj1HQnxdcV9/O41wB26lx8F76aFOgO2bKW2j/5GGqaU8ygtmmNMvyCBFPeRgpkqTPI5Xu7jKCQ52MAM3ygVvGu3fpv93Gfni+1RWmdANipLP81qEWe5jNuuTxHkMow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f7+yRxbT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f7+yRxbT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75m2cxvz30WS
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:44 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-23fd91f2f8bso10212695ad.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682203; x=1754287003; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwv8jVW8Cpw1HdPZHR5pkIUQOrnV30U4PbqXFmi6s24=;
        b=f7+yRxbT+DDavnl1OwhKVSu4+jrVea5mBDsHslTmMDLuxyyZkpTc7FJ0/prEJBLRW1
         gFqW8O2MYdNAlKH9lcbzacO0WG6JYGPFX3xaoglnU5v5PQgin3eFaDpBCSfR9MAYSoL0
         chqQhdk1RShrkD/4028fSw6raRrdrScDikyuw/XsAOcyNF9cwWtq5YVlmEeQGiXF1Qmp
         FkPwDven6HumdyxozKug6Fq+CuMlbz9HL8N7NC5iv7gnnYLi3NlKvMuWRrxFzRou9stm
         WraRFV+zm+QUZeDHV2FFeZedBqxLHEMZQq4hmk87/zQIz7S4hLGSPFb3weXUwjYHo98N
         BqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682203; x=1754287003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwv8jVW8Cpw1HdPZHR5pkIUQOrnV30U4PbqXFmi6s24=;
        b=emrtlDPeNqx0GfczHYw/2tQnEc0ibhT4FBjPGfHySsq0llbGOz5x1iJ2ikAymeNIhz
         knofOiuyDR4AS4EXaXqpO9p9Ykqngcq4/RkSN+29FzS+x6+v3lHIuhQ7TAsslALrX7bo
         PYEwvPhtq8m2jRCzmFQUuGShCb7sDxc8CIpyAmOfKIBjgPSfXGbQHy4o2ZKz+OnK1tbg
         9b6LgN5X6fm3xMOf6VUbklytlrJWOKYeDMsuI3KCIaxg0FNHK5KI+W9BRdU+DK851ALe
         TKuDWLKg4Iw1Z0LoV8Si39mjhU3PTfItrr83nriwLR7wqFU0cQnGy3UVAOfgZokzgv5N
         27Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU1BLdXWKNTxijLSOrW8wxn2ZUCCo1pdBBiW9jlkun/izKSb1/cOWdgOv1DKQkjSX5ezcT0tnGuPOIeWXE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwwgcFl8mmEUUsxJqUEHEmjib+RIzXO/gx+18ILt2u3WJcwGpPN
	m+VBb6WtQrglJXL4spLSFNp2IEQxT79MnlUPZzd0WGK2fG0GxCgTEm5E
X-Gm-Gg: ASbGncshoYV1Dxy2K7qiFLeo8owxdYoz8fMabEhL4HaO4JR+OJ+NVaeBfVnwHKFDg1z
	20z3OfXdAR525Jp+vZaJ7Ko4+Go+m+2raBaxGlSQm+atB9tX0fVsxD49Ay0JWa8p+ltkGE5GlXf
	Q94C9OC6WzzT59RqaScK71X3m5jGHu4Q52srkOtlSRVjbO6UFX07EtoXKbFFX7rstkSkrqx6CzC
	7o4QDHodn/bMMiR/HX5wyAouAnOGMr0UdWmsaZpNp/UXKcIv55y/eQMhZJdr5LyAwi0clAtZ0bo
	K5CGeTAGzdwscdRjfNdXSPN4nTDOukh/cba7cdPnsw+pev9eUz6XlFFAbwa+ZtenyfYWU4q0M0y
	847UV9FD8k5kg2z4IDgpKzCyR1hZs7Ic62FWlJSu8OisHX2NcEhVRxB0aP4BClNsgWQzq6hKMly
	E=
X-Google-Smtp-Source: AGHT+IH9RbYstZRftDP7K1JFfq4K9/bJOuDCvgnQtsdkV8ZotM7LNFEtIGdprzRSpoN4SreniMPYxQ==
X-Received: by 2002:a17:902:dac5:b0:240:aba:fe3b with SMTP id d9443c01a7336-2400abb2552mr50892895ad.16.1753682202708;
        Sun, 27 Jul 2025 22:56:42 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:42 -0700 (PDT)
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
Cc: Tao Ren <rentao.bupt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 12/13] dt-bindings: arm: aspeed: add Facebook Darwin board
Date: Sun, 27 Jul 2025 22:56:14 -0700
Message-ID: <20250728055618.61616-13-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Darwin board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 3cc6e62ae5f3..2887565d4170 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,cloudripper-bmc
+              - facebook,darwin-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,fuji-data64-bmc
-- 
2.47.3



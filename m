Return-Path: <linux-aspeed+bounces-1805-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD0C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVk531wxz3bm3;
	Thu, 24 Jul 2025 09:30:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313437;
	cv=none; b=hAlCVVzDZ/e+jHtxxWuqoZm5/I0vtwQWxIdeXC663bnFgTyfoeCsKLtP9eJfz//dIT3oQUVQaVHhvkcPD+mgR9ZPPecrzKoYC2zhNe/nJofoJOZg9Wgrvzkyir5d9BgKGcsirBItnwQ4yYxMAUW+x7FKZCDLQP5HV7B7YuDzdAJyhpRX54oOvGZuqrfviqpV0uuGCL5uZ7NLSN3DAQMa/Ht6mt3+30hPhmJpH/YGbYRC4FNWXgpawCysGyBr1NUKpa3y69BKsOkTzItPB0WXytNWTGPVuG5gjueYUtLEYhTfkOCBn1l9xVWywAKkS9WXkpLUJ6x6qbWS7dCPj1oigw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313437; c=relaxed/relaxed;
	bh=BZdmnC8PcEOZPd/qRotPAi5bThc5SgobYaLTba1a6rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ70bWXKUgZsaT/v0Cw8yC8NN1nsF7pTlgxB0j25Ylu2OWYcUVv6V+yXQ2UQ4FPblX+HADgXaGim0jLasiEO1qFkiCRA3d3RvFEWvcfCHmS0ksoaScidD+uhZsfuguSKdOTlR/jEDjrpF/hQql2mAAwk5MSJ9zSV+65btsZk3jkzOq25pfeS3B3EQ3aLnuwopvmyaG4r7F3fpV0M+WDF19AUbwA6ubnt+Ox+6eA2ARMxHnmuErP5Og2l+3N4UcWG1VBJWNKP4h/bFR89WhCWcvw4/ap7SlHVcKHpa7lEqhlx8rIqOEDXzQ5Pq5v8b4jU1DyLMF+3aF4f+vvYiAII8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iSy790vB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iSy790vB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVk46LBhz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:36 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b390136ed88so360447a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313435; x=1753918235; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZdmnC8PcEOZPd/qRotPAi5bThc5SgobYaLTba1a6rA=;
        b=iSy790vBGFxlSFBDPYfwMHG0xaPCHrm4qgflwah07kwNl5/0sWhlekKD7m798zzGEg
         E3QrFt9OiYxb1I4Eowt+Q2mWjBaSTjZMAfnpNI+OgSzBOvL2lkPWVfNrurd+deUW3otm
         Z/SojPfsm+Jj/pl+b/o5hofrJmPJXvEaazjLEX33SEx9vOCJHKqjzWLVN2AQ+XiqJGhL
         7Cq6FqWCyn0IEgPA3XmWA7H86qPMwuGbkiugur109Tt1nfDZMdgiCWHpC6gedNXnvFj3
         oc9EWpkcKohLkdfxZIDgJHlOaFeibVTw5KE/eJfnKuwte3165xgpZtwXVvVl5SV3Yzbt
         WyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313435; x=1753918235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZdmnC8PcEOZPd/qRotPAi5bThc5SgobYaLTba1a6rA=;
        b=KOYlvN6yCiEOEOrQ60IMCoAuqTu32/KBa3wBHfgs1Vpyd870Vtqor1152svmZHn40k
         V5q9o8Bb1mVq9Qwj606obBhZNZqQzNaHMi29/uULE8zIXML34phKHETWiq4+nmrrDuVS
         CxB5qeguMBksGSdyZQ0YtfXhoGnoXTICGzCM4F1tyr0hEczw8/DMDeLSRWxDutkBggJY
         37FnrMTuzgfwp19W1RWB2dsU6Zi7/49p1YOk3Oh3JPfdwmr8+8MFzwp7rN74yQjCvsp1
         LGgtOIQJxbOaIUzGwiXWFKr2j3DjnTDuoS8/xF5vb8iNjdQ2tuhfdU4Pf0FKvS1M6zHz
         Q86g==
X-Forwarded-Encrypted: i=1; AJvYcCVbXvdesoFVrpLYOg0uywDZC6RTj9dmKrV80MzU0ypoixycM40C0e+Rfh8B1a2F9MPCmA8CwQvKRbNpBHE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3tNg3gyVrAQ8Y9ucb91i+9TuS0eguZIzouFnivVg1vfLTBh91
	SNjPd9knOBfziB4atTXgzXIP9+erodVfBut4XJz7RTLnC7Gpd2Dy88kk
X-Gm-Gg: ASbGncstvGaSR48ShZHgMRL/Nby+wlCSr5j8E9mHFcPu4QvypOkmqGWMIF5s8jdKV9j
	6w3Pc7eOhgZEkeHkdyBDnUqAjUHVrjKJoLm+Il3eK/j5lck18rzQXB3V/lutvD8lOKr4UBirrrS
	Gwbs1OPGWs/otkotDYVDTreio/GOA2Yp+8dZDqRzxfELmaSohkwnZySdkVKIbpv9CRUR93LKGVs
	cw8a2WyALxnhKQhV9fZ4AU0VEsyItz0P+nKqnH8O3yYMvt1hTTZcyOglTeGumdDNqU1PV3IWVhS
	SW/FMzQ/K5Oc/wvnGzKZdLv+XxPKPokdd8jhhEBCug9Pl/KzC/XKzU6sBHMlYBonx7rCo9iq7/j
	xQJjHRNcl6VNA5jb9kKoADScBD7fsqdkQkMHQ4InQ5H7ixV/n9hP4mVhLPZnE4s7yIduHdaJciW
	c=
X-Google-Smtp-Source: AGHT+IFIyOTSA2qmRbTVKiynYv9ixlJ90tvw04lgs/CHVeXhcLa/lbzWOVby0mnDzFVJ3P7H39lEgg==
X-Received: by 2002:a17:903:2352:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23f9817696bmr78290955ad.21.1753313434862;
        Wed, 23 Jul 2025 16:30:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:34 -0700 (PDT)
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
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 09/13] dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
Date: Wed, 23 Jul 2025 16:30:05 -0700
Message-ID: <20250723233013.142337-10-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Fuji-data64 board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 0c9d6a30dce0..3cc6e62ae5f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,fuji-data64-bmc
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
-- 
2.47.3



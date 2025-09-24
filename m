Return-Path: <linux-aspeed+bounces-2340-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C914ACAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 23:45:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXD3q0cgkz30Qk;
	Thu, 25 Sep 2025 09:45:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758716944;
	cv=none; b=GIYt8mmHQ0B/Lk4ivZqE1OJnm5ISUbIXAZxGj6slg9bdCAupFHsVTJvpj3VaUAF+VyG7iV7xVzBSSfBBTtWaAgghs+6cu+jJvFidmnKo4EP++OTmZ/ctVAajB8QRSZW52ZdvFYEzY6Wzs27T4CN7+cNZjcKxvqlEYIs88wDsmZXr/oknTWGMWTdsDknMAEDVUFinlj/X17pMbzsNdzYbZyfe7/NuqfJyEsCuPTOw/Yio7xC9dTwHsYGa09WumVpWyRzU/NYUNVVgANm1VOuG9PNWEQ356BakNL+vai79CEsPkIgR5/kf2yfb2C2QLVmqhPSJ6v1bHKt7X5PLKicfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758716944; c=relaxed/relaxed;
	bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ki5+vEcH4QI4d4VELz7bIvZJYYRcnhKky98jylbnRx26eyo2Z+r27Dutu9CHcGDd6a/bZey7bofjhuzIj+wkKr4qPYiozSfANOI5bqXny5YJlQ8tuX3IE9pg6AAc3Epydztx0gzZH37+DPjjMiV38cdIx1eu8Et6o4jxYSjELcnlqLRfXLYCJPVAIlQIEpaG34IR6P8TH0T5/9uNlgNOENw68pYoYAScqEAqA/4V6thN6K8faJdsDrp/H0ad6BZX/v1K1FVIZKNl//2C1Baz0UwQzcxG95zj00pP5qPb+CAzju585KY/tQwIEQmbbKI6I9HmzN4j+AnrsW3Drt9qOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hjmg7Sz5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hjmg7Sz5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWx3g2sfxz2xcG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 22:29:03 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-77f1f8a114bso874757b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758716941; x=1759321741; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=Hjmg7Sz5KzDyWi8tswE0/MAH8nfGDT4jVs2CYRUYB3PE2B5S9dcWVAICrh2xDRO/4M
         MQDInSQjDp+tcxvcnpw1nYm8/PyTa0Y7Z1iqQTOF5u4sgrx/bbGXT+XryKgR7g22HPtP
         wlTdYWq2JlFRc9HgGvgGTjsHTlecaKJot0OPRBx1wE2AcbhaQ6FBuIg1D2sbuGkcW0cO
         RVSj18FPArgMB2TaoiiLJGj8QFtcw247K9PdDGFxSmLmpi364HB8Y8JsOwr1bwgKjVkr
         M7j7z0eVDENioHvayFYmBK8Nsuq3tGsvJIfquRZAQeD2y/FdaBx6aRoLkFhSuQW68tsk
         MPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716941; x=1759321741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=N9Pg0y0wMOUQET79WYthtWeXNsWYN+hqWC9rhPbC+S6NSRMFhYLzMoQaS5vAeWY2yS
         o1ClGPC99nicEZib7IEocuqbLp4j43i5QY5QIF9UO0cNeQ4U/u2Bm9lyDuaDUoodNIZ4
         GN2IMEzG560gDTt3k4farpb9/SRlN42kUQHtZCnsOTX/ShxWOl/tzZ0qoFxmfjS0AwJx
         CiO5UEfEkV32n6AYlTNPJzSZ6+6/8Yf3NkvUc/CE2MfEALRK8i9OCTWOP29ZLN8HDh90
         72yXhbppIpeGroj1UCkJ4xo0jjm6ip8Ujp9RwlKmrUO77X2RS7GT2WjbjyxQR0ATM3F1
         OMaA==
X-Forwarded-Encrypted: i=1; AJvYcCXzcKss0LbID1dp8yzCD/oz9oHlQpxZUB/1bWfXSlLVmENptAdUMUJEGLhoApz0/+QMr9x1R5A4H5qsQYc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsABUIHFMuUDf9IKsR38UOCUdDGlc++++tEg7itoE9l9GgBe+s
	z5q6SM1fdZdhsYHz1JliMRTexdTb1yrcWKzucfzZ9Sf8e7at3xH4GyPbJgOCyZcD
X-Gm-Gg: ASbGncu1DZsHZjYzzspyYiBU1WVcXK5vC7q0h6pSlJiXMpDAsCJmnH/hR8//Mab8zEZ
	WwCSnu+yNvuIfcc9rijbnj/Rv35aG2NRMpjqGljifNvmQYg/ed/04UJlnv0r0lEF2SpREX5Am5P
	4TjxXl6w0nFwQYYHADElqU/jE/tK9ifMaj/E+hjWCJHRkefgq3KrzMLQxEwyNK86HpeNGTsAK/g
	WfszSYRYDYRvjMJFz2aPfTYijp97ROVFleJDKe8w27sJ+WluOqUNZ1w3IxYlLNaZoH3N3EzYb/a
	/M8noJCiTVg+A8dZZPCTbtQW3w0UQNPDPQEa6MneOPqUao2l9dGB+L/qKmBy8ddZqKtcHO8wXhp
	vhDTT6BaarbXtWDDKSrZXdN9PZnceURu8uWlY04qorzKkkj1Re/YSWKsz0wnghK5VshIUqmlFGH
	oGfGEG5fgzbKEn1ESXiuTKT/8IcPrpfd4wzkNj4I5yHFAEdkabUdc4K4p2MiRbdqJTEhUc3PTIT
	1PZMjURUzI0GfN/1E9shZQ=
X-Google-Smtp-Source: AGHT+IH06rBToc1Of5UN6Ch+ySAAkAq1UnVhWSHME11cpwxSnnZRbpfNLzn2Dr2TU8ADryfYeNx7XA==
X-Received: by 2002:a05:6a00:4f94:b0:770:4753:b984 with SMTP id d2e1a72fcca58-77f6984f9b0mr3074239b3a.16.1758716941404;
        Wed, 24 Sep 2025 05:29:01 -0700 (PDT)
Received: from 2001-b400-e384-7809-32b4-db27-121a-a0aa.emome-ip6.hinet.net (2001-b400-e384-7809-50d7-4f66-57aa-588c.emome-ip6.hinet.net. [2001:b400:e384:7809:50d7:4f66:57aa:588c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f254f8f68sm11058495b3a.56.2025.09.24.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:29:00 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 20:28:50 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
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
Message-Id: <20250924-yv5_add_dts-v2-1-39a4a8e3c9e6@gmail.com>
References: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
In-Reply-To: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
 Leo Yang <Leo-Yang@quantatw.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758716933; l=886;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=YB1a54MMJXi5nKTH9gbuafJV6b8bO8PW9GeT78qICUA=;
 b=niNRJVGxu/G3iuEdL49yqUkGn3N0ZSiWXbUk1WNZzk0EayhrlvQV4FUn6veJSMmD9Z72xEqo8
 RLa9pscBXnjBtD5vl3CExk+zp4wJKthnmKhKAmJe/yDHYmpwL2Tw5fS
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Document the new compatibles used on Meta Yosemite5.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e109a78d931dffdfe28 100644
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
2.51.0



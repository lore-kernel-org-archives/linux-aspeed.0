Return-Path: <linux-aspeed+bounces-1741-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCEC83F1A
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 23:45:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjqLQ38ZFz3blg;
	Fri, 18 Jul 2025 09:45:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752764369;
	cv=none; b=baEPugedHfmq1QLf6VNgtcYzXq2s5xWLsM29E2xParvtAb7IQ1s/43oqke+URGvLLqgjR2u15N5Px92IlP29zZTOqgs/gvE8h5wtDUJsWwPeZHzUQbzQyv3x2x6S2mCPmXL+xzF7oYEgLg2oBAYncVMSlDdhoJfgn0pj8L6r5pKNctEVxCLPbQ6IANnd9YslvpHYsf9EdxJ7Qy/S+/WME0q5n6Xee1IwVXxUSo75f8ufVehy2WmciVMM8N1McZ6IcpLM9PcYNYowECrtCjysNda8WdPRyFQfL/uDyTEH6tk2srkel7iGuIKGFVysI/9+rcmpuDFl092hWPGdlXjxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752764369; c=relaxed/relaxed;
	bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcL9VcglXRPaiUlzJbIMJSmVkwWyMt66hRpXrgazhcgSzUH2mSfKRbUaSnkfU8ljtSdadoeSAaYR2e1I4eiefI9ub10LksrfsXEHI5GAbk8dVNJJRaqzNZRtOjOIOnd45GV99K7z+RAMcvY+tEQuTJHDNWbVwYEWMkayp8p5tFQzpPBinqdGs24tgjJkQpJE48sdcZKEwb5+oELwIY3FjdmhH3S1EdAn+NQttwYBkOzbY4FVDq8bo9FLMmeIEsYvCQkQ22+l4TrLE90sCxmiwHS2EEYjcmBrpm+TuXaLJBxk66Uy7yrTKNimPv3HRqb1RXGysIQip8b5iFQGGS4JZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YuZ/Hl7e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YuZ/Hl7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjbg503gdz3bvW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Jul 2025 00:59:28 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-235f9ea8d08so9443135ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Jul 2025 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752764367; x=1753369167; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=YuZ/Hl7euQZBbSzeML0VPsA5XSuS+6fs5Open/Q3BdvsNx4NqaTZiFKqepCcNbq+jL
         d/waR59VbA4aEkBRRZescgrVd44t3nBXx1ZiUN902qTkVZt1mQjbqZWeoJ9nMJW41oZ1
         zDEuMPfKUKt+aqCW0LRbZ7yXXALXDrFIZvBiqC8cTkBSkC+zShH0gJbojpPlDfqeGwPH
         E3LAuOrFaRMnq4Hy4RUFO1T+OzeI54zCJDaWsGQg0W36WH4WskYE5PAOF5BFZ1Evt5TL
         DJsN2rOSTexiLRRqmqdbPb9UqmqfZopSWz/CLNk6tBVLBPamwImskaw+2kEIemwswu5A
         WAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764367; x=1753369167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=FsK/60ru/YuCi5fzW2AvC3gaZqREsAYA5m9M3frzsAVZVp88aFoZKpkZ6yDYYOyCTq
         Ag4EWGepGs+J5uzvkr602Vnb+BuDtLsKQzyfG/hMb9EsWT3NQiTFUHZuIN+IfE9s/sx0
         K5SjDAP/3lhcjDG4mTgjpm5zAiT7txkh57+zpXbUTzgXGIBJzVSkI9fSI3d4lfvXn4QB
         90RgwzjPQxXgUus/fU/vpVo058BQo7LFHrMU6p8NDSWM181oCyRvzfHi/LvwArUd7jDE
         Ti73M3+aj5Ft11Ff20DVRLliq7ivBNeoJCFbLypC5ncjA2wTQIskKZV5gkgBWknjcfci
         iV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqEKZguEtWVpbgumn3m/XNLUDr1K9eASA/eKvh9Gu/3wyMyDfj+4d+LjFsd9KtUAYLAu2pKSahdjP3Da8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2wqsLJVu8M5cI8lYQ28EEvYxndEP/Pv2ykcRRcDRPav3NJjpj
	RsRaQ2ZFlvC+A9PdGlBKSxVu7IMZt08vy/4GmaXthIX6wqcPiCSoNSZl
X-Gm-Gg: ASbGncuh0AkUmkrqnyT8U2xKJoYsH3CkuOiMJ2jV5c/qo2mR97dB5lHVxYXis8+1h3+
	vAL/w6bISuFb+xCiPmlii/zZKrfaRK0dascNBw8ikX3UlY5ylXlx+BMsl0BEXhTbCpe4NstFuXU
	dGhdGjDF2YWLWGI/dzf4PAi8VRsxgHHOicruwp7+yBwdsh+CjzGP/dAVLOanpjQVFfDrsdFQx18
	fKQb1BiM1zSvZKTm3zUTx6ZodLc461c61+jtVOCgYGQG111uGB3cTJjN44S6A4hKjWWoFbMfFpl
	/1b/7yzgDoqDjqRwQnpqfsH2HFGzAPtSeSFbPLkedG5Ydp1IuWYKcNyPgI4oJaWHco+/ORbMSWo
	4YTp1zWOhUlAa7FCeXb9Fe0HIstyurUndDqjL4Y9095hP+SWELAnNU6wRddnaTO9lPqU=
X-Google-Smtp-Source: AGHT+IFH71SO9TWQIjWcDvGZVaf8c0bfz40+DZK0ynM687AwY01e4hF6qPVMkaNoG3Tz4KEJj9XPFg==
X-Received: by 2002:a17:902:cccc:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23e24f94735mr87868625ad.47.1752764366837;
        Thu, 17 Jul 2025 07:59:26 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aea81sm144603915ad.82.2025.07.17.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:59:26 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Thu, 17 Jul 2025 22:58:59 +0800
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250717-add-support-for-meta-clemente-bmc-v8-1-2ff6afb36b0e@fii-foxconn.com>
References: <20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com>
In-Reply-To: <20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752764359; l=933;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=UnfBA/U+nB3GVshcJhQl74M74uA3eyzQykqLq1TeLXk=;
 b=IJJvmEuw0NMsZbR0pvDfxaXzgRUhvDfogvZ87vBwQarC5NYmD/jvO1en40LOFgsjikc3duK7Y
 KQ4xpm2evtkA/KHguxccp4vll1YN5VIB5UoeBTJf1adwFrZSpItUR9K
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



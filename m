Return-Path: <linux-aspeed+bounces-1212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B87C3ABCC
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 May 2025 11:21:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxYvB643Lz2yZ5;
	Tue, 13 May 2025 21:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747105845;
	cv=none; b=aeNu6WJQQvMnhF6nZnfvZH55fmE89h+nFDyJNpIKSkpEQ0FAeFuiuLfgBCJnSinAttB/+lKQy8YbW+YFn1EtzORVLm35rUqX9RIwHQx7K8OkVRvtkLwkb/h8tZPflrRkEvEAcSjfBq+GOjlGO8N6n5ShcSv+wdZC3Qvu8xNqWQC5M9b8j0CoMWZCoNnO75NX7EKRYWaQE6dQffWlGbcNn7VC7MdM+ai4Asj9CF8YdRH+YneXK0bY9hsXZn1HG+LsUs7YsGpdMANGzghgOY6TDZV4sNtcX8YJzmiKV7N+93tgbnO9W2Dtd6S1AUNhdafnxSK3dXAW8Twy0Gh+0RzTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747105845; c=relaxed/relaxed;
	bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=R6yvxiIEVzRVZLa8JYB64K6mcm7I9+BOgakDy/QQ+ksQ4tnliecHl0IFKDorcWrGJWWYpyv/aRHGol8HOVsFHB3DV/FJv6meHdwkd4kPbKTiQY9S9laDqoARr3lulp6ZVBTH8BRoBpDbL3oMxtbsd+yZHQsgmzntn4PVovp7XHU8LE52RcsJPia4tOg8QqWCGz8ZrjIqr0GWHpQy9S70F5WK8pa6WGvHtd1SnP0ChBBXYBEEg/8b/JIh6FC+tuBvnFVl/DvHFjjONpLBtRCrx4wz5R3EwrdT4nkvrKfemitgqPkHZ66qH1xIUsoIJ0+XSeoy0Qgj9RDfN6lN5wPDTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NsOVBdz7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NsOVBdz7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxM1J3TDGz2xck
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 May 2025 13:10:43 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-30820167b47so4309663a91.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 May 2025 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747105841; x=1747710641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
        b=NsOVBdz7IpcB337RW2xGCVJUTdbn7KtsORr4e1/f+RFsFVknFretNZkzVFvdjYqrqZ
         hk85uP2lsbyv8BjZMAeX99/HvuOZPXLqmVx/PW+ClELHAu3MWsmmyGIR7KBJi0A2s6bb
         bRoMxSfBnvev35XPGNFhgYROMiuTkiYinbBNMbQMY4DVqdnZccAtqIaIYFSwgndmIA8t
         VcZlYZQj2rZ1B8siI9/OV6VMBXKn1XAYhEY+E1evXGcddq4Dt5tl58KTx0Krq/mnkMEk
         a5cpUDKANNXxYP0xvBwj+y3842WCeCv1IOGYwmT5EZVJ6ar55VF3L6ASwam9jg93btC6
         R+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747105841; x=1747710641;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcuJtm+iInMJ4xEpzdwpahbYr7IroCfNfGVeO9DKr0A=;
        b=xAlyKpkRiyHICKgJ0NV17SMFee/z4Ct+fx3Bs9/sh7HdI+g+gEFadGRoxe80L/7jLD
         To+Y2ykdxlkks4l6cisJBEkqX0LRylam9sLR0+eKJ2DylJ7AvuZhjCIAAcAOS/FAUSCq
         2STyX1VH0va9b9lqE69gsjGUZ+mky1IbOnaYxqIDJEViq594JZrEyetq+GyNETlbBQdA
         j9dd7h+PY+RJhpWAHuFq2X23hhfrgKseEwiBC6y7zljwRqz7fXhhQCoOzur4uFbK2mdd
         1V50YRGYO0oApbMVC4Kt090puXphHWOM4Sb78yMzhi/HSfcGPrCjmWmquqqlHdGkjyeb
         np3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKydvC0hHBLXRMJjwNHv76IPaH9Zwf659iPGrPO5q8eIxOPcwiLG/o0QeBniblIstrbRZVpMriTLxzLtY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywgu3e4Dc+adkt+raPa8ZiKcJGAzCNjoaZFr/mllQmOvWl1ogYP
	pUHFCjhra+yWwkujJ3a2TwK+SCmpETcwD4scNFJSWF8FV7N/eHlU
X-Gm-Gg: ASbGncvaw7Nfq6iTRL1LIQq4j6aG1rJFhIBjpudEM/hUQhTtjMylCgE+i+DKPo1AKN6
	8DanYEP4adeBhpIn2lQ4NLxIeHSH24g7dVo4mz3VSFzXhGK54Cp43Tcybyns2T5h/gHk/0Xk7KG
	IWgGW1u3Fi5o7JYR4uJkLywHyC8W0gbOYoLJKXuaO76um1yJMnG0QO6mQfr4fLYyl7vtrUB5iDJ
	uopllcwY48TrkrUZSNH1pPelUNmxZmYVKhRbn6W7DrF6Ik1WNaG/BbvM7IQcYNVS9xMT7Xj1tNH
	D7JwWUG4HADMEWpsLn/owKZpuAUIRqJ7Dv6mbJJmx7bmATxlcwlZV7Z3fShd61VsDNTYl/I/
X-Google-Smtp-Source: AGHT+IG1fT6TiYe3pTrZKUSJyBs6nE+x+ZjDtyWth+bx63s94p++vD/MoGUkW74HUXfleYGKFUeLcw==
X-Received: by 2002:a17:90b:240c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-30e0daf825bmr1697698a91.4.1747105840515;
        Mon, 12 May 2025 20:10:40 -0700 (PDT)
Received: from dea88b1475bb.. (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2453f50b67sm5082852a12.55.2025.05.12.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 20:10:40 -0700 (PDT)
Message-ID: <6822b830.050a0220.27a24d.d064@mx.google.com>
X-Google-Original-Message-ID: <20250513031010.267994-1-LeoWang>
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
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Date: Tue, 13 May 2025 11:10:09 +0800
X-Mailer: git-send-email 2.43.0
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



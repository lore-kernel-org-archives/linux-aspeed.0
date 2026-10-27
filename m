Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A5606A31A
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nqQNAX7J
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDGhY3Dnlz2yVT;
	Tue, 27 Oct 2026 14:49:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793072973;
	cv=none; b=fPyqb3E7rt4C501jhv4s0vYlmTh+TNyx5FfvlXH0uv5fuHPVareMbnNSa9CeYmAL7l76bW+N9Quk6H302ADC9ySr72/EA6hnls17Tf3/lUg+3P6P87SEVemZs02tmeKEuodIoM6VWK8yNkypOam0RYky/GpIZ+uvHMaZw8SkEUGXqGIcvTUIn8tfVZWWsDF1rRKR85oceULJ9cCNx9fltYqik+E6rpHB4bc1FQW7IgHmHS8uwGI3iYBGlDzNBWvl2DlC1TQbt0siY4oH4YEKcgVi7hMVOCSFlLwD3YulYUPC397uyQNh1G3FvXO4WHooviCJL/fLy+q59v+6GtjurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793072973; c=relaxed/relaxed;
	bh=bVKdd+rg0dOMU+J41LGwwuebdjS7SkBQhNfNvVlqcdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgKJI/BXLovsis1raGJhcaTCuizf36+MsQzO6RWEltjOilDRzfR885AJl0gn7sQyKrm3EiFfbN25iudpY5n53/ryUsEKZdZCbLvtABCaTQaiVvKUEti7Qjp2zEZV9JWZU2L/bGjvWd9FTFatOR4/zgNKATC1QSoE9SIGLNMkqCJ22n1K9F8jJneyGs6gK3afMzbTNun7kNT5dP7bLI19WgUjwPUXHYSN3Ym42c8zNw+qhdNtkKMGhAE50Z8RytqnPnqUbz2ZD47loYr/pKiuA6Ywsj/hmsBBt8rmaVJUutiARoEgI5NXKg3rVEUI/gOL+Phuy3KkdXDvRpy9lgjhHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nqQNAX7J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nqQNAX7J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDGhX5Jcwz2yTK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 14:49:32 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-35d0be18c71so700795eec.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072970; x=1793677770; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVKdd+rg0dOMU+J41LGwwuebdjS7SkBQhNfNvVlqcdA=;
        b=nqQNAX7Jotwnb7EWnDgeXu2Vxn4JQ8BoQ6C3EKYC1VKFzb6oZCvxZEMFVk3eql7XBM
         nm8uYD0AFRmy0D+FstW219esd1sHACgs4CDgHuL2H3XkZbD1FnfcRXhWh04h+1Ug/wm5
         k0qM4Q0vBC5YC+qbg32hQGy3sObB8vSqByLj4Zo6aWzs3Y9ib6CjOnDuIq52u5CHY2PH
         d6IswfBxUlOv6B9jkfwmzppAUsRW10WGP+8ECBXJrE7RX9I8TVhYH2ypTTm2uzPdlu7k
         rKAcvfYfH1WkCYMp25orMVADaIYJGEI4TTQ3qdRsB2pU9A8sTpfOHoHihIoI5lvLRGlM
         kVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072970; x=1793677770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVKdd+rg0dOMU+J41LGwwuebdjS7SkBQhNfNvVlqcdA=;
        b=2pfSyW+oAZkneenFWKCG0RcRyznraR5HCKI97jmoYEMSJrVImp0tRhzT34uuOhpXyw
         Eae63aVvqiItxrjOO6G+S6vupaCiEUCD/A0WejUwer1gTBSbqqjYj3bX6hfl/it/7WNK
         EwairkNWNDxcy45i9KCv4uNXwdMMoA9dh1vfJsglq5KcSMX/voveM9CcueidlaB5DmNv
         Rm23JV6d7xxKRBaw4aM3WDTbJrXLW5aMq1OO77WWABB1f7yY9bJBRaGr3QkE5UGL4kb0
         zd+zWtVYQzoHOoTME0COjtruD9jJiTKNcJt8gn8LgVtfSJHSkAuV617VRmnQK9oyF1lh
         3k5Q==
X-Forwarded-Encrypted: i=1; AKwUvByjGQikE0YcDYAokYJd1CNYw4aLtFWzt8eJ6+NsR4835scm8ES8gDAU3soFdPPKwoxWc18VssgCGSmT3xs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKR2LmazNZXW+eA8S7zYDnSwxORaIkwlYDr1ZKCYIE/1d7ZdcBo
	IC//nqB4QNO6YuhDbcdoNSJe7Ow69skp0KSrlCVX2tu6PGuR556Nv/ZE
X-Gm-Gg: AYBFou3HgBPWm6eozIo0sFxNzDU5Ty7KqT+Loj5fxoEw90W6GJOFSmk6VfBa7ZMfFOQ
	b+oEo4xdvr4tz3ma+5Rx8MGZ17wFrJbcJX3eH76df3U5pkWvPNCTfbQpcYGxSo5zN7WzqPa2Wo+
	i9l6P6tNvB2QuY6HCMR6Q8u0GDfb1zyj/dJPVO7RuzzZl8I8zFG2e/J4IEURARnEWYuPYcJJmQy
	sP3V0FKwRTVZuoOhm5ZefP9JUSCRMK+z8s2BXxx5U4Gg6tcSMuCtVszG8bfqgTeZqaNV2j4bxGz
	Iubht2h8BrGo9zDqPe7FZ3x4G6F3EXUTkraXDapAig3gpHnZaylnRGNMj4w/l3qxomzOpphpeaF
	BpU9PRxxD7YptAqLyQ6VUpXKa3Q2jFUKE5ph/M52a2AuUpZQIpuKJh8CPI7xUwPcj/iP13rZ5Dw
	AfmmLN0GA6sFWg0w9vDa1X0/LpnGPTyW/PH8YXgl7bT5xUoz3kL55J++FybrVetxBk3lVDVGrcD
	IoNw1+Am1cIfoNcP7QxPBvDod2eCnVdgt+myq/uQciP7mbAG3VJpgEg261tvvqt4IbU8qo=
X-Received: by 2002:a05:7022:47:b0:14e:5e6b:e6e2 with SMTP id a92af1059eb24-1a3c904cc2fmr2284657c88.18.1793072970015;
        Mon, 26 Oct 2026 20:49:30 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm26430012c88.19.2026.10.26.20.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:49:29 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	andrew@lunn.ch,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Tue, 27 Oct 2026 09:19:10 +0530
Message-ID: <20261027034911.99482-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027034911.99482-1-prasanth.padarthi10@gmail.com>
References: <20261027034911.99482-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the ASRock Rack B650D4U BMC, which uses an ASPEED AST2600.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b7e70868e..3e6133e2b 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - ampere,mtjefferson-bmc
               - ampere,mtmitchell-bmc
+              - asrock,b650d4u-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,ast2600-kommando-ipmi-card
-- 
2.47.3



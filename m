Return-Path: <linux-aspeed+bounces-4032-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCEDCD4F25
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 May 2026 23:52:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGnDl1W9Wz2yF1;
	Fri, 15 May 2026 09:52:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778728600;
	cv=none; b=KiQIqgwr2EvG6M7eC4zQ3lQwnRq7KwH6QnamUWLGZCi/jxcISQ56UJ6iiWELHFGbujmf1bSBpXWIusw98b1TgDMySQHiuMdpfJmV0OIfAgWyly4L30GCAQcOjPIzcsTQpmp3FF+SRElRNRQKk0GO/MhfNIRc95u9Wl2QsBYGywT4gTz7+z9btT/dtdjTqReXUIK/BV7X4R7/yUxyr6xC/9VcydR9ivMkvPmx7qB1wIXVmTP8oJQMcxcl+4Z+x5IrHL9oedKjE52lVKCULukLeKaSlVOI/MxUKgnrcpaU5G72nGTYBSB5zNPC1H7kl+ecfybn9Lpro5VGT9fh3mavRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778728600; c=relaxed/relaxed;
	bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibv3DxGYX0Y8Z9pD0p7DjVMIzHS7B6wAmp1ndG8d6e5feLSoonZC4Ov6txE8lPtnHRRVM9BAiW99oc+Hx+KTm332NdY5o4s0B3MQzo/NHrab+cDVHGThw4164TLKpSZDy/g5SrOd7p0Ac6dFv3SiKIYaKZcTMhO/Mlu8Kx4jFxRxMEJ1s+EklLzRbe24H3KOdlArq0E0k0gBvmxP7mLMNvk712TifqmlHt2H1GcE4rpbd/vEmR/kMJwL/eYYYlRF0WaRBsFf3gPBYU6LN8eXegWSuyPa2coX+kSae2B4dlfKwOayl+npOH5p20j6zZ1tt5EsKRh1uHGcganEIrRdFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDjO8n0P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDjO8n0P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGFqC6sGVz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 May 2026 13:16:39 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-362e50b4641so4788083a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778728597; x=1779333397; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=kDjO8n0PdhEI0S1rLI4bjWVYNqRx/hE6+nNBVTS8x68WoKWtxZyHBaAqD2qvJ+T1qq
         wWrVb0pg6vq/VGr8k+VAx5heOElH7teoO5QUBTj4DeWKkoZn4IA4jvj1sXD6/wRb4h8r
         kTquhNgGci6fSkiHuo7R7PzgE1qYM4KEjoeDmHdL9Vr+kDd9p8AEmh3yX1XjxQovbgYb
         A4JTrqhK3t2VaeW7XGJKa8iJ8E4GDIxVEZrk2QNYzNJsJqzuNaZK728JxvzbvP+a9JN3
         RhzA9A4s6KTRDE/z3yWfTA1wSjgAYgQsZ+TgLRT1uZI/A/uDy+StBtzcnqTe0WtvyZ6C
         YpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778728597; x=1779333397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=j9snJsZmeNlWsk/WFWGhBSdrzg7d/Spmf6N9LlQgyHnB+KytWzhkoquXHKhtQgOUY1
         T81z1DZUuLay2D9IDot3HXr3UZclRyqVeKg6wQdl84lWE1gPB9kLzj69WlayQJH74ctp
         i2pzU9i3bi/1SbOlWflTxgPZX1kwFNUNEvmEF2pQF8LJwi+n3lG6pDorhTq/Oc5teTQn
         Z2QSTqiWrKvHIZsY3/zb0puzlFaw43LuudFkFuhqs+UwqWWrZQU+0SD+6lLMmGLnxyrk
         9PpAYOc5fXMDuDkuoXErxfX2VTqD0iCEvTv1X1cR6fgjKCDSVWzTl7C2wSeTqSRl/bcR
         1n/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ijOqv6xSlPb/f+bj8EsS9ls65/n4tHgfHq7uVQiUF5jonJ40h+MogZDG1DhMi36g5ARJMNdwYmqq7xcc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxu5XeNooaat0UBgjhjluJROVrNR2NWe+T5HSmA521Z+ZH4GnoA
	WT53KABCsSxRp9P6wA8l/A2UfnSZMK7g7FkcSH3JjwqoVOI6tGPC7wVk
X-Gm-Gg: Acq92OEwQvYfv48dqIwXsaoQ/wjwGKyjXOtqM9rs4tbcdx045A0gbPTzZSrNZzzzjp8
	Ov2R21cFKaQpbFcxfjV6Vg6LQQVbBQZcJhfm8wcOUAZC4nkTmaK6GI7V9ri3Ojz4WZKz0mLgrzr
	RkHJGtx5tCvagi+VLJnVolN6Zuo7sDn5ZsibP+IsLtZDzuJTCYa37AbubvjvKLEa4VT9K1nyZub
	V1iJw66mosFevLlgDuG+CXnQKEyNJo3CubvVMBmbeY9zzSY4ebtIUMYFKiwAur+WZlc3nOt/FCq
	DcAQsXEDsMi5r8+WS5Aou/Vt0jpLEiH/6qZgWcLcEa5rKQEBFcW9R4w5x0mK8rUVk9bCGkijGic
	vh3eVWBZi/0LpT/Y02XC3ZiXPxsDlmLy5GOrUN8GWSkT4tu3LlYpKRdm1T+ekadllf4hR4K7xF/
	SUgI7TEcgZe5HUh4Jhid8Tfk0EVrTzup33FcRPgM8g
X-Received: by 2002:a17:90b:46:b0:368:af5c:67f9 with SMTP id 98e67ed59e1d1-368f3aa3ae2mr6181333a91.8.1778728597547;
        Wed, 13 May 2026 20:16:37 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692a94205asm320047a91.7.2026.05.13.20.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:16:37 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Thu, 14 May 2026 08:46:21 +0530
Message-ID: <20260514031622.1416922-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
References: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
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

Add the compatible string for the ASRock Rack B650D4U BMC,
which is an AST2600-based server motherboard.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab0..656397850 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -77,6 +77,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
-- 
2.47.3



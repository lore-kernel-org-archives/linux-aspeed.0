Return-Path: <linux-aspeed+bounces-1962-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A4CA0EDC
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 23:42:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c31xh6Dxsz30Yb;
	Fri, 15 Aug 2025 09:42:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755177446;
	cv=none; b=R8HflronVpA3m20EzUI6Ja989jhEDG1xrnQVDYXkQnLic77ko4atu3ZHtggcasHjUU/UqAHLQbhfPwY8kOAzc7FLQTtpQ8PkXPpBtT0RnY7ZPFmrWDE9BRfqJyhYJ4phuM9R+iHsHB1IAqPSkJzsl3UmOMLbEr3z/zyrRBA88I8rdTrd2QcmoLk1zteQAIKOa0Z7tWDr2aLvOK7MyS4vVOwb8mRh9A1XmU+CiqS2AUhrl0sN/nhOANBGKWik9JvWdVqgI4M030OM29HfNcxgONfaq5uQKQyXOcGJMGkc7VeLY/0Y3feIqcUsoiASWTGg07/sAdlefEk0y0SiSxqYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755177446; c=relaxed/relaxed;
	bh=Lsr8NoDBS2RQArrp1EpyLZ8skAK+yEiuZh8RDSmxYGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap9F+GDAF2vE1dDRt75TmUyPf/WDfU5/+EwR/NQHMbbnHWrhyTFEFNln58a8SkSgYp7Jb2EF9YtbVrlZ/l/WaJel5QsrbUMDv28JHBbP8SJhaHS5lgNPgrt4sfulQVzbCYfcK7zhx0CLzsTbx4oPWfhWgnSo27XK07J4G/Xa9/+KXJrStaNKi4KDctlis0p5vQVFnZAA+j9GkBJVJT4zG849Zl2agmve/qGWTXMNmZvfsDMc8VBBpndKF4vV/bLR5+wMK/zyyjC6zWsJooQ9k/bOYwDKL2jdYOhCBcm9CCLguzozT8dHoAYvAJWet7quMv6mHXH/iLnL2v/xhDSlhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GMnp0nHA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GMnp0nHA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2m4P6bvMz30W5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 23:17:25 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-24458272c00so12242995ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177444; x=1755782244; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lsr8NoDBS2RQArrp1EpyLZ8skAK+yEiuZh8RDSmxYGs=;
        b=GMnp0nHApOSWASb3EuZRcX9MoRmQUcX7MKhQSk1L3mjiQeA6lUJ0I3XyFlfd9DNE56
         e9QxrXwrpB0RIiiVVryEkqxm2YpvWY4C9EkEbTzdC3SlxBPQAghg9cfL6dm2+9I/Lfbd
         FXw3FhtCKAEN+qQBVJcV7yJgfgoskdCbI12ETt3J7sYKxucy+A2yuvQi8TBTI0x7lJHj
         AygYA9dgNu+05ZisDlpDGSUoARsXvRxuiIH8IhyMAsusYSy0bxUOkO0dEbfWgQFtSrSu
         gia+6Q+fz0ZLrLDiW7jOj3lFQjpaWd0fjqA3IRb70h8xFATfa4RY3jMenXIu2vioYY5j
         18xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177444; x=1755782244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lsr8NoDBS2RQArrp1EpyLZ8skAK+yEiuZh8RDSmxYGs=;
        b=Yeymw+Uh+SNeprQLGI2ndOzRkKVoXFd2xgVqXP7guCmFCZ6YjSh3XY+7T+3cPDmIJp
         eq9i/WOKvxycbYxd1WX+rChD85yS2DxTAClZIwmU/lDvG+ysrPZz3CYuP1yKANwvvbFW
         MCYCHpbN/ta32+bgLOFuuOv2MKQu0Bx8qhzeRmzgB3rwkNgw8OeJaVlcckSAWmMmFs3Q
         HyJkZbDGdzofnHPyAfwh+Yb3RojGBwzQdrjZbUyo+KCm5sCzqzcutV7OLoY1BSlyS9Va
         IVHnhgOEhs7uYEwugmyqZ2IfxWD94Sq4u+4zBvGDu1VnGNE/Mq8ha3/2E60FEe7n76e1
         xDgA==
X-Forwarded-Encrypted: i=1; AJvYcCWO5iwra7ifArCc1MIejer/LmlLDsHvejWjW4dC7CTEPTigVOief5aM1cXtKsOqWmbbIddqNuv258bT5+4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAAl+Swfg3+fKct8NVijvDvl6//NOhvDqZnj+GvB9gU1vT4S0p
	ZCq17xW2bY/o3+JII7aa7T4APdDYVLgcf8avC70uxf+u+y5yHQob3Thd
X-Gm-Gg: ASbGncuKFZT+yoh67aimJAXSPz1zVat2BnkXGOr5M9MQiIPmsmXqPjsiXoxeUqyX6C8
	r4GZb56/T+pl4CfRTpQNEr51EOYi6i0ispW2stBUM0+X9iOMdHHPhYNleB0//TcQqoZQ9pmiMk/
	pWV78d3/moMOOrU7A/Tb4vCA2heTn2QonSSb/lWq6NE1Srv5H4uAqYhs6YQ9aR8Xbz44kKuu5fZ
	PJqAO6QIbYz8om6uYRJAdZuswkZ1Dg1lEl+1MtImizZ632jtUb/p/I4PRpQ2FrN17RJBmal6oNq
	sCls+mV3T2jk7QrjYDAinuCF9XkU+pW3Vz2qAlDu9LGebXfFIIZnIjzrX6v8YBGH20Neu0pNro3
	y5EhJjLDRmjEPhqKV9DkQz5mWyI13tlEkxYs26N/+1n3YE5w/7L/Vp5EPGljnHgTQlGATRRLEnp
	TaxICThy7GRfs=
X-Google-Smtp-Source: AGHT+IE2z0Mn4IzOfVrP5fVEkPK/wTu7L7FYQyC/LTk08Q1390PeBweG1bRkM0f2xG6YdF4ltPjpOA==
X-Received: by 2002:a17:903:1b50:b0:240:14f9:cf13 with SMTP id d9443c01a7336-244586f6e7amr44650985ad.51.1755177443544;
        Thu, 14 Aug 2025 06:17:23 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:23 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
Date: Thu, 14 Aug 2025 21:17:00 +0800
Message-ID: <20250814131706.1567067-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
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

Add leak-related line names for the SGPIO inputs that report chassis
leaks, so userspace can detect and handle leak events

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed2432f37609..6af8b22f72e1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1767,11 +1767,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0



Return-Path: <linux-aspeed+bounces-3864-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFD7105D992
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2JB3BSnz2yhV;
	Wed, 08 Apr 2026 09:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775570088;
	cv=none; b=E/fEhKqPe9rRmwImZRUjuaWOLoyMU543MjKn/eTrgRlBVrpihR2tBG7X4xsrjMzgKUbneAm/oGUvDdL8s/30jBU0tjEZw4Et7zbaeb7zRRm2OkP2mmKqd4ah1YTTMx0I2qeOSK+XUg5uda0rD5EOMMkJZ9dsAW2L1XsvWp3e0i+kyPKyBNW9RQdYy8ayTgt4JmFYzuEKywB40EwKDTKrE6W2eYszK2hryzhLuTrQUrNY4FkzbRfbHtiPOSlZq+D4WtUyRyWyjL2UWeY/D5FJuAP0p9lpcFo8TrWwDwc12J1BJFQ+S8gUQjIEH8wTDEUShneMCSctfBlNtEUnkOi1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775570088; c=relaxed/relaxed;
	bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSYZZE8gmbBrsz4tUkqoO+go0WM68u6mNMNjS3/HyuCQXaySvcskW/A/mARN5wbjM6eoK8vFao8tMd4tPZoX3Qg8WfEdInyeG6wHPLYpeZFkWtGCzw7wabifJAHGcBMgH4PMicRHQ745mI8tFayGJqRhL8Vs/kicNTRslxSLFTkBryOjXhWuF+18lf9wvQoK9aBLLN0UotAGjpGG4N4+t0vIHStpWYRbMCBQtfxfWirfBVOPPcVNPdOTOVDqqM/M0PGcaWhiKDFPD2dn1Ell0en16aptXlt7bdcJI+GFRcBzsLjRcKoY/u0JKDwEIONyGG50BI24/iiiTJExtR8hHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cy7txoN5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cy7txoN5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqnkb2wV5z2yZ3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 23:54:47 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso4358139a91.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775570085; x=1776174885; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
        b=Cy7txoN5OAJX3z0HUy/+hOFEP4eLegxO3fuyLy1EW/s7Uzt/D6VQhHzTfIf9HW8GSk
         uoyS3RxX6/ZQiOneLeE0zPQg25kkxhQyTdMSeKwhUpVip95ARkF8EAi5Un0SAMwPnDvb
         T9DuSKhziADtg2y/sj67zfT9akH49OHzVH1KBHwdhiL86/3SMWHR3OcF/YSX6EMxsbAp
         1S1WuRyxZH1TbRbVlwvLK2lzyYjFzg0y5YoQT0yHmRP5nFU/yH+9RANBk/Zng3tacyZu
         YVO+H0BhyUwywtp2l3cbjlaUc3pO5LjDJXZHztkJt/BRSe5DLseVrKqc0+HN7lwsJktA
         Fm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570085; x=1776174885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
        b=ZeWhCO+M/YPgUvl8XoiHan5LTbsR52zAK2SZ9CIuGNv1+nKWzIrRc6/lsgeZRps61U
         /svOluOC6hJE+2vj8/pPG3nw2FAIwcctlHLFWpB/NFGXkJIMZqhDB+2oWaILlSF2j7VX
         dNUVnuSIWmm4yk1yF7cvMt/VqjtNJxEK3IRLGXIo/esTgtUQk4NyleXvVO1xmgRW7Bbc
         y7I+qo2x5NMggbdfH1LEa7yoQIkEMbyqL4gz2zU2lKRYGF18+6v1VMHhRDjcodWSZJeM
         96WVXipoe23J70K4JjrJn66CHPM8Bt6xTmmTMabgu4xdrAGi1b+I+Fokz3TJKp90j4vc
         C98Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2wELUmeJga6KzlIuik5CRFm3TMhE5misGc+FPqeh96M8Q0mNccptyQqLMx57ORBkFNfCx5bo47SFOlbo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6CSo8JxQFtLaz5Sg4A+CSw3RS0HTojpFHFQzogO8WDMkGvIgO
	9GGVPb8rFMGdqRkRmpKkyycBks+ut8ASlUWyDknDzAB/PtuscXurrTMZ
X-Gm-Gg: AeBDiesDjdc4ggsVJNDO6EzC+x558gM+25kg2SABOz6Zzke9MglZEcs1reqRqVCeOI2
	TKI9oejLmQZUp+O0XKwMzXP6iMNJVh4KG4qMPQZk0rKhcVYOsCqyqvaFiquY4xNHLxh2SN0Ol8Z
	URKWnyjoechdwZ9glP+snFKM0SYiWfKzw9AwmGnmObm9QdD4dj1o6lWfu2vGXIY0cYd2ZxS72R3
	rQFFcBIFDm9S6TeiN9fDBQShAx919nuAzKm1USJg+6lVbHRk2lYBZHvgPawbLl78iKy92OiAKCB
	ewuS5YV0xQ/1PBmo1ITSMi4f1nPepZ+JPW6qzSBfieBgZOHDKVtm0tiWf/h4dEFkPXsRQu9y3oq
	EE/JJ7gLhms9qB02zEdmTaaO8g1bnJirHr0myOwPEWIHfYL9YU8NBQ7y5tsB0jjvHh9PzFIPnHd
	4KrBuhKkJ2klmZEMkoHDs=
X-Received: by 2002:a17:90b:3bd0:b0:35b:e529:7089 with SMTP id 98e67ed59e1d1-35de67f0e5emr14853030a91.10.1775570085230;
        Tue, 07 Apr 2026 06:54:45 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35364edsm17111559a91.0.2026.04.07.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:54:44 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Tue, 07 Apr 2026 21:54:32 +0800
Subject: [PATCH 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 board
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
Message-Id: <20260407-anacapa-devlop-phase-devicetree-v1-1-97b96367cac3@gmail.com>
References: <20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com>
In-Reply-To: <20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775570079; l=882;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Hk36uMGemdglD1N155LHlYS04DfWcX4jaFk3m0XEMoY=;
 b=zEf0wBENQdZ1MYnJAVX3kBcym3nuKDr8HTDVq54QHm8/2nimXbBwvrkgA8is59NSRx5y1G3xs
 zQAtAkf9TK3AuF5g7Xm3QW/N2AjpAMbHlUINbcw4/GCDvy0yRUUORZk
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

Document Anacapa BMC EVT1 and EVT2 compatibles.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..c4b87c014941 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -84,6 +84,8 @@ properties:
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
+              - facebook,anacapa-bmc-evt1
+              - facebook,anacapa-bmc-evt2
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

-- 
2.34.1



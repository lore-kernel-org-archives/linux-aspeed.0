Return-Path: <linux-aspeed+bounces-1848-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD41DC83F17
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75b3FPzz30WT;
	Mon, 28 Jul 2025 15:56:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682195;
	cv=none; b=kdR8x9f85Ahp+M2P9m5Jh6NbBIsnLpjt9kaVeEuaAC2fLTpa16twypikJcGtN7Ij6nYFOQTVCQdT71jwZ7K2+Xg6tKumwDkhF91UAnKT6ygm202YodQqPCfm1LZSXeu3xLSan10oXrVdijmP9XHXtI12q+v9UPIGmz33+6TmLRkq/GQ5ztFKFAzas3GejR50PSzHaIP0mhMTbbX6kWNcO+aHsgB68kYXMUShRN5DW47aQKKf0hsCFC5Uhff5q029+PvffV8lIcdPuKhJfzOB0LAR+KBCUAhitb3esSCosBM9AmunDpVWgQpdRJOKcSQL91/tKHMCrZshyNhiB9oWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682195; c=relaxed/relaxed;
	bh=JbL/s7XfG5xt8Ti9QG9pgz/kChTPn+PeGi5taFv6Wts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3x61MMTQqsBlfFHtjIjO1pBUWSVFspjs+p6OImKfvKwVraev3vs2v+9Lv/QsAUXw0xN13bd5Hb7lT26osGeYnSf5uLUboPR/kM6EksfJXo9qmhWzyGn6BFYOI6GKLys+AIMyNcE0b9TBG02ckzV4HvDGmK3rJPELK1BbRiVCevje5Aq0qQ6NpxQC065510y6S2CJ9AGy0L35gQfWIM/ASJpfHdmtOQWpVvtAE/MyWNEF3E+p/4KgXLP2yjqfZ9WYeltlXkMky43/IhaMCDCZIB4fNgoAIUJydw3gA/ohsFWqXc7KOqzCTLmo5ophSWZKYxMlcHmC85VLj9M1vBPDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E/HWwTMX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E/HWwTMX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75Z53wKz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:34 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2400f746440so6915635ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682193; x=1754286993; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbL/s7XfG5xt8Ti9QG9pgz/kChTPn+PeGi5taFv6Wts=;
        b=E/HWwTMXTyVqMj461v3xsH9a6lsLdF+P3UuCyH+yoWen9STmf74L7B6XggSkjzp6FF
         RaVflZ0b/oyOaCg6vfWH7vrl0UMKXV7by0S6smBcvXbkD4QLVtx3306OK+YtN9l4okqQ
         0EIjypwl2Sg+BvPBOMckbr2lGUb+xMtSbTAQv1AYJejF5JoLi++jHyiuz4DZ6OmaSBF4
         FRw/xOQjEjexrDAlMJbIYNrf7NBTKXopnlDpL6EzjxidHVfOquIsKcbtAjF7NKFe+WVO
         Z9Zljmffk/zm02ld6+TIon9AlwwO2nPWGnktufj3RalmW9/tJ1jwn7TKcUBIvQtwKpQt
         rLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682193; x=1754286993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbL/s7XfG5xt8Ti9QG9pgz/kChTPn+PeGi5taFv6Wts=;
        b=im+aOdSPL07hlyybyUq4b5Xya/BlLEhaKEwLPhSAMQS/Sdo86cKQr7sqzfRgdNni8T
         Xi7bluDjTbeyMuz1hgT66+/QLgRo7c2kNrud0gw7zhdpfHpy3l4T4MEc1rZSvFk6g+Zy
         6vYN6Mek61Inrb3VwFwNauCa7ID2cIj703Tx+fs9aWPU88VsEckJ6netWvAzYAhI4aUE
         0rkNWt+vu9uaMIXplvg2vX1kRKrgdrJ0Pp/GaHegfxFptOy6K5UsPKIRfYBiAxrbBi+I
         FYMAOI4uUEZ/swDOQcIo+Su9CQYYF/gHVT83fmAUbmvmkLR5BPYN9fyImN6szma2KhsV
         lyUw==
X-Forwarded-Encrypted: i=1; AJvYcCU4E4n+y4r2BIOuZG1mZx/NV9LHnKmqPIqXfdPdcRhDfoz0C2nz+ANxmU+NSNXrQJuIC6GslaZEE42DbQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcYAAmEwwq8GRvmUrKO1CPWATval+CjUMDpNBtTi3f4c6aFhTO
	GecTmzLO9UVyUBpeT1M/GkKOzs69zWV5mk+EyO2Te4MM4Dpy5DBZpWMB
X-Gm-Gg: ASbGncuZivJF9+dEVWmLdBttabB8QZIY20WwmEUm8TBBuc9f7as//nbUWTRWHgyGQES
	U4fHzqnOz5ZY7k7o0u1OdcTTmJSEJCTAKQ9ikd4IqDGXle9Q3y3z+Xg2Ldt/699flCBPccd05HB
	kuJDFMcqkYjP4QHSUmT/TSrlrWbdK1mVjQ4OE5Uz/+arUjJ4NKzqqqoEzjBUU6/E5KRkZiUQl+Y
	ajd2XIxKunTHvQYG6moIFzXJkW+2TyDYKTEQtAHA+iLaQ7+jrO66TejmIls5kp0SncwYkS0MA7g
	wP5TBFHE5WI+1mfIk1nNQ97yTYLrpGulmU91V0LZppo7PEyEV67wkE5jgrn+cGG8ihfEn7hAmdR
	z1WTARKm4RQnZgqdqg0D5NyCxGPCaI/BWxYST9tAZaatUqW3MXFdin7766BVvXKxH66KPnul7W4
	Q=
X-Google-Smtp-Source: AGHT+IGjBjOZSuFuT3oqj5s+Dx4Lmr33TfDS+NDJuKJg8oPiu53W+GX6Z334iGOeg/ZkK+U5oI36SA==
X-Received: by 2002:a17:903:13c8:b0:23f:adfa:3a63 with SMTP id d9443c01a7336-23fb3021609mr159555545ad.16.1753682192519;
        Sun, 27 Jul 2025 22:56:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:32 -0700 (PDT)
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
Subject: [PATCH v4 06/13] dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
Date: Sun, 27 Jul 2025 22:56:08 -0700
Message-ID: <20250728055618.61616-7-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Wedge400-data64
board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..0c9d6a30dce0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -46,6 +46,7 @@ properties:
               - facebook,yamp-bmc
               - facebook,yosemitev2-bmc
               - facebook,wedge400-bmc
+              - facebook,wedge400-data64-bmc
               - hxt,stardragon4800-rep2-bmc
               - ibm,mihawk-bmc
               - ibm,mowgli-bmc
-- 
2.47.3



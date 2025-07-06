Return-Path: <linux-aspeed+bounces-1646-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A77C83F05
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5H4Bb8z30Tm;
	Sun,  6 Jul 2025 14:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775859;
	cv=none; b=ZfsBnIwZKO6SUDXbWa6fAOEJUH63MOvUJRRu6vAGfI9t1WA4eqXF1dQvTgEKmmC0fgE0EUD6yehmT0aOmr/nZwfxjNn25zDNiKGRg2Us6M/EEHeHpwA95XqBd0y83PkCmC8tt1ULKux+qvIkTILE2RujWaPvbtn8d1daVMcb8ePbuMlGpvjtMZcddz3wvHEv0B/1JZdRJbbnJp8BG2ermnYUfq4ewUloSud3WaZU8EQc/SpbjLMK+DuGUsH+0O/QU8RM/n1CqzJ1Z9w3LoOMAcMYhNT7VTopqA6WcHyYpcHJMqxbNSm4QXn/mv/ena4gYoBLh+vpfcUM4S6eya80xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775859; c=relaxed/relaxed;
	bh=a5hvQYwSO1DDyOFBRxzz4gXM+LbX6JZNHrIcl99wJbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbz7FyQ60r0jcaE8kLvAqiycGB8sbwXBahY8tR/yvafx0O4SujxVZR6KREkiCSqkKd14ntGsvDrOrxrroC63oFgdiyRX6EzVMCRWOgwMbVGCZ6jIrGJG2GKqfRRIabWrlGGjkIwRSp68vCc0/iNSwZM2Tdn3WegJlYQrk/lp2eUJwI1HnedK7tnmFxWjGd1W/ImOtex6wl3p/e1fJ7fvcekW2aHw1QiFThepRIY1fEQye4Q/0TwkLkLKJ1m/L7VlV2ldnFSu53ProlvUgOIcBrd5dioYd4DjoctZWsLithu3Qrby6YbF1AwbhR3ReSfRAo+/e9DA2S8b3nSIK05t4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HHxQg0/M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HHxQg0/M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5H0FQ0z2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:18 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-747e41d5469so2379593b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775857; x=1752380657; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5hvQYwSO1DDyOFBRxzz4gXM+LbX6JZNHrIcl99wJbw=;
        b=HHxQg0/M0dlycktqHC9ydCQy8Hy1EpbYaFA/VhD6wTv6t1jy7vMkxcsR9iA/NAWQ/3
         8l/fvoN3Ry7B80ixbIV+kJf2iqtWwWhZyMv/UUXdddl9rxhreQ1mLjXpToAxNFE6rPkZ
         OKv+34UJXQwybBY65e81KZuQnR2oPiy3J+yf1qe3Gru2gttEdDmlw8OCe0FNijiY8jbH
         t8VIHw1rqCABTzdtvW6GFpb0gq6o0tQNTzh5cOq7MtwsevYr36mxDiRKoOeGQpE2bEff
         UGFMb9j1fsBpE9rGp2T/UXrxjKHlJjbvSFy/fBQLRHbgOuIAbPXfCsWRVs+u0QZYmU/J
         YP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775857; x=1752380657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5hvQYwSO1DDyOFBRxzz4gXM+LbX6JZNHrIcl99wJbw=;
        b=UTqkH2Argn89jIjtwhbmhOfyug6NFyubdcG5DthfLR7qDZRngl0kncP3rc2RpSS3N5
         5/Mys8SUvaFA6WDN7P7ZbTqkhi80ny7Uz1+smMQXsax0grpo7/lIJ7DIbow+DdK4QS+u
         J+QR788ofqPUpo5f4PZpzTAIRM17HJteD8MpN2kTj73RJJf25H7a7s5shlk27Aa4Jbyv
         26ySxXU+JEpJH62675f3dpeM7axQrt4OKgovWAI2lXGh2kJv6JnyrdAGY5jNX88X1hh2
         /Svs2EBwC5a2eboqEeVB73E7KhH2suAEiOCTXUsR15sK4d2nf1BcllhVM9mfDd5IxT0Y
         wfhA==
X-Forwarded-Encrypted: i=1; AJvYcCU/YDj/kOue+675gLzIUOJkRnL0kJGz3c/OJ3liJEQBMXQqJbCHBkxfBrmAZDcvQU9Tps/3PD4OP/a2dEo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkKivewc4qH2cwTJVGbIAxOck2JKBqRY80A6VkQIcYtNSrCDp7
	2JVYnZ3Uktnb7kPhC0VbvU64Nt2EWt41dBqNG8Sdu+aNLDfm+giuLXgf
X-Gm-Gg: ASbGncuPwmgXpU1DyP1zq7sL5TEXg1I3+RAAy+z6cDFuIhspSQSNWdJXmB1SayxpZ26
	ND5x7YDQGdM9XMmbDtwJZWviHJWcd6mBEP840TnlAyUWFoxGcY8uuI2cof5mou9VjiU8CFKMzNp
	yaD78/qLGO1gnOdz3tkFnVgSDSbx73R3CMl4jO7b7iZFuf3qoswgJZ9T4PdyoS3MJPDqqWSBE9E
	V0MdaqrMTXtn4J0w5hQLZpUPRG0mr+1rDgyOJlMo+SPOb+EqlxuZfPgz7ikyMCGE3Kt/KfyTSg0
	0ArsHHUvf18nFX5KECzbl5Hpu5YMHwSWarBaOES5t51ztY5Z16MWo1aoizbJp12MOUSeaG2sL4e
	n/r18k4KdETyg1qikc1FiO8y8/Kcra6tIj2mIlD7Z2os1b4CeRg==
X-Google-Smtp-Source: AGHT+IEDh07y4O5UrpWhHEn8NMy7TKn3Wcl/ge+wEXWwvw6/1ARreXKO3us1HCxZEGHLcjY9QbNDfQ==
X-Received: by 2002:a05:6a00:6ca6:b0:74c:f1d8:c42a with SMTP id d2e1a72fcca58-74cf1d90239mr7504338b3a.13.1751775857389;
        Sat, 05 Jul 2025 21:24:17 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:16 -0700 (PDT)
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
Subject: [PATCH v2 5/9] ARM: dts: aspeed: wedge400: Extend data0 partition to 64MB
Date: Sat,  5 Jul 2025 21:23:55 -0700
Message-ID: <20250706042404.138128-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

Extend wedge400 BMC flash's data0 partition to 64MB for larger
persistent storage.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 3e4d30f0884d..cf6c768cbad5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -92,7 +92,7 @@ tpm@0 {
  * Both firmware flashes are 128MB on Wedge400 BMC.
  */
 &fmc_flash0 {
-#include "facebook-bmc-flash-layout-128.dtsi"
+#include "facebook-bmc-flash-layout-128-data64.dtsi"
 };
 
 &fmc_flash1 {
-- 
2.47.1



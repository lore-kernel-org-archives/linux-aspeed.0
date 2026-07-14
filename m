Return-Path: <linux-aspeed+bounces-4470-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5098CC43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 12:08:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzykf2tJsz2y7W;
	Tue, 14 Jul 2026 22:08:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784030906;
	cv=none; b=f930quWLMyMzRHEvzKvf0RmAYQKBanq8/jmZfqojZRxe8aNuPDnxVRrLt6cI2Yna9gEAOOUSd33ZeYo793rmdtajH196niZetVUbqNO0J5L5bQysttk4m0sySLpNla7hdjEehnmiFEuEJCCvP0Y0H86wpGyt8VoKiOcECDoH6wc4h/iin2rPO97eqI00jMxyRDf6MtOMUVVPEZiljUjfs7yLDl1s/+gJpnxjXC5UYdDSE6B5LN+zjOLC4XjUGx1XzbEMBX2RlBTZIo0YG61GooWd91PnkQSLKTTgq7eyhCRp2MPGvaMCE3/cgq/kBHNpii73hpKKQ7G8KQc9sBRGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784030906; c=relaxed/relaxed;
	bh=6Oe9aWVjKhDNM43muNwN/DRmahJ3UH9WTei9WupS48E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acxiioKce9ZoHNvtYocK79hDOU0u47bySexyGZfxEdvpj75qnnIe0QXYr+K3k2Y1Lcq3fPXcVj+1l2il5j6PmPvR/64p0hoyBc1bsbo9cQdUHX803gfKOov6QsH3gJQv6mPKqAAM9jHEJZmp8rLzHL5GZQQtpwO770s5A30hSCwSP7RSUoYAU6ylPXLCoJcaXaKtAXAsFL2SPA20UwcbGfJIKm6GAujs553Prbet/VDgd9lYkGcCxKSq+f1kWQ7ZES6XEhxvcRAXzns/zrWOrLkMMtgp6SFWHH35BI8hdS8Kv++uSfc11ez9QHN0ce22Tebv+uHui9xjWoPPLf4UGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oKcnPdJJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oKcnPdJJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzykd1SZYz2xqn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 22:08:24 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso635939a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030902; x=1784635702; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Oe9aWVjKhDNM43muNwN/DRmahJ3UH9WTei9WupS48E=;
        b=oKcnPdJJdNVPLRxR5a5MBjKRYPq4plsfHzF/Pxm/5krKJPvR2FnFxSH2iHvXjWOZuN
         qcDrbZXRUVGBiD42itPyyt6jCb568+TxfrwsYdF/2Cf3nZy/sti3b853AIkRPOfEguhE
         CP6o0QBnA8OThVmUbXGKjkWdRaKmi//BL2Qd71DithLSdaQWcXNo/L+t8zewDNkLaRww
         sBLY6toUQEa02icEFmn/w6YyhmoXrI0hxWMKEW1JyZwQ6I6hleFjM1Lt2eDnJq85L08T
         tOTpJUAnG7fJnwvbu7DU2ajdlBQKCuoyc0pNEhfFWSZHwxRqnWuk8xDU8qsLQA4+WmrW
         HsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030902; x=1784635702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Oe9aWVjKhDNM43muNwN/DRmahJ3UH9WTei9WupS48E=;
        b=LuoQ5kKDqItC8bg8ZT8R5auTqPHQLUs/k5cNZllx0E3uGQ8mKljiJq+whwuyBM0Fqi
         +lCI8Nt6YOujjdzLknjvVDElo9K6l86qn4eSZNYjVansgYKelYNGkAsSnAeoNzCiCIM+
         0zHWF1LrR/eVB1bgh59nWt9SjEj9VKF1yroQi9csycvr8n4ZDlBnTpp0dfz0CNAjw6OW
         LB0vkNvwt3Y7dr2eeyg+ZS2aYwAJbAKWk8zTaG7xhR6JVxLi/PH9yMw8GPiPBe1+qure
         1lU0nFq9wMOjJ4K5LiRXURfMGYlC12BvwrXVqQA8inaVlZEokEgrh2CYvirSdYAUmk48
         07Hw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4zEeEAEsqQDv0qyeHGZYzCbkIbjzUjCPgHtog7lXa2wtf6mOFp3wBSJxlUOa+3XxdhqoXPdti4p7LOX4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsZTS5Mnqs6GltVzlRC4xHCKUWIIQaNkb4nn5zX/9HXAOMmzVY
	RXBOLbgJtoO61hn3mReeAoVqDtWCjUtqtuoSakxzpDLgkfUTM996IzTs
X-Gm-Gg: AfdE7cnpCNlfx58EyYswm+TtWIS4ChxvQGsgrn0pEXTiVekhBnnzeBaYUtupPYQhs+X
	XsrO6Ka0E4B8hz79JbO0qPsuBuLMXpgZViq7VjQqGGCY8DF40tbRBLW9/BG6HeUjeYl/+4Jr4Hn
	26YwJERzY69LJ3/Wbgg3EXN/UFeYn96rl94zVA27NrJLnNlrkARna8vVKHqWMdtMkaLjzXVxSaS
	sRuhYTpb1UBlqoX7h1Vd8p0cIsNPjprgduu1194QXWuHELGdKMvHRllPdrLhPO0h28cZdsl0AYy
	pRYZ7KSUYcjrRQ7fc4yP4bGr0Ai4CKwTN6jRUnXW5xu4gArkwUWgxkRx0Lo2J8YU7sBnDTDQ8vU
	aQGb9ZagDsDtVRYbCFNVdy32Y0r1DBbbjX0fvBqPa8rxcMK8Wpvs8KU7VbCg4pL4Xp/JogU0gNJ
	q1mTGJ4sfv6i9qYVnjjRqrw3x9rpxBEgXorC8qStwRlIZaO6VMObkw4xaj+qI=
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id 98e67ed59e1d1-38dc81c1b09mr9238776a91.9.1784030902088;
        Tue, 14 Jul 2026 05:08:22 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172dc530sm1384425a91.8.2026.07.14.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:08:21 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: bletchley: Add second source devices
Date: Tue, 14 Jul 2026 20:08:14 +0800
Message-ID: <20260714120816.1504058-1-chou.cosmo@gmail.com>
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

Add second source RTC (ISL1208) and LED controllers (PCA9532) for the
Bletchley platform.

Cosmo Chou (2):
  ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
  ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers

 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 294 ++++++++++++++++++
 1 file changed, 294 insertions(+)

-- 
2.53.0



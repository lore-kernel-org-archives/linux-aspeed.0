Return-Path: <linux-aspeed+bounces-602-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E730C0218F
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 02:57:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmWP83dt2z2xGT;
	Mon,  3 Feb 2025 13:57:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738551420;
	cv=none; b=PKV4mvveTGEC6oRA455VBoTjBdWL//J5xHSFHs8bYSaScKM6F3MvrLQMzAeUsjaFBZSIyrc7KWFK0QBG0JNnUW/aOPsijgUQyBgIzdBItRv/WLmVAIQ9l/NWZfld2rYTfRVcLsS6gLKmSBDsOlNLOULcnXiAzEAsR37ijiblbfWekLT12J74W6JOYfg2WZvCqHpKUUjEkw4gtHc4YBBqRNT0SWfQ0vPVD3Wu/Ht5pmEJwa+ZyRIqRUihAUUh0zG9Yy4SC/pJK1p8W4GOiN9gmg6c2ZxV+xABh+TAOn9QKlVPxttGHKpzPI/OSyWzq6m8yiAJhS/ogLzfx9mAI3jH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738551420; c=relaxed/relaxed;
	bh=/M3u/UfzPn7K2j1tUy85ouRPJtHFLSPO1KCwoEDBz08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LjmLlatqDzMsrl4oJR0qthzzm/SIJdjts5vAqwEZNCuaJHo533+pwRsitlkgqirEM5ctm11Yk1RMgPNctdMqVdcf6xtGs5PsqtmRXx7r7XPVHQCPra8+TC+u2F4lSxgRHYDabqrGMI4+B63sNU77tJeOs6FroYXrWaWWZCvdYk3rqzedpCCdPpjhg9/k7dCS91wxBmmCqpw3RqdF0hnQTpQ0RV9T3z6S2FmqaGjcmPYZFZy1XdQ79y1Qa0lBcQApDsAaQhpXGlUbiQxQfovBUR6fie+yJ4nZteVYUtywCO+L4qGs6wxyAJUYXDSwjDm/ipAxn8lcRqt8z8Z0d/xBqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=keaaDwqB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=keaaDwqB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmWP75s2qz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 13:56:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738551418;
	bh=/M3u/UfzPn7K2j1tUy85ouRPJtHFLSPO1KCwoEDBz08=;
	h=From:Date:Subject:To:Cc;
	b=keaaDwqBcwuRr2sI322cGvM6QhW3T8VZUIxniSpkWNFtHxvEYmOnJqsDXFQTvVwij
	 TV62XwwNM8Lny3y/GlktCxB2By33Y+iKiDyxrqh09BD3xef6UI5VFwY26s3weL4xaJ
	 qrMrMhFX3YY9SHuv9T+JdhQrw/eV/nirx005KyFZBSSF+gTXotW0xcKu4itLfs2vuU
	 8HXubwBXbJvZyBaO+s/GWRpfUvE8RdHjK87epWug2CxO+pQZABSg3tvZxx46F0G6J9
	 64ZkKgFyBgnnAmohCv4wDPnkyP8flCNPAeAng42WH6+STBsZ+Fcgxm3nCgrbnQb5Dg
	 ctkVcjJ6ugq3w==
Received: from [127.0.1.1] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C2762703FB;
	Mon,  3 Feb 2025 10:56:55 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 03 Feb 2025 13:26:31 +1030
Subject: [PATCH] MAINTAINERS: Mark Andrew as M: for ASPEED MACHINE SUPPORT
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-aspeed-maintainer-v1-1-60bc3a5f0a7c@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAF4woGcC/x2MOwqAMBAFryJbG4jrp/AqYpG4T93CKImIIN7dY
 DHFFDMPJURFor54KOLSpHvIUpUFTasLC4xKdmLLrWVbG5cOQMzmNJwZRCMi3oNZXNNR7o6IWe/
 /OYzv+wGLOVJiYwAAAA==
X-Change-ID: 20250203-aspeed-maintainer-dddbbe22da46
To: joel@jms.id.au, linux-aspeed@lists.ozlabs.org, arnd@arndb.de, 
 soc@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

From discussion in [1] and in-person with Joel, flip my entry from R:
to M:.

Link: https://lore.kernel.org/all/CACPK8Xe8yZLXzEQPp=1D2f0TsKA7hBZG=pHHW6U51FMpp_BiRQ@mail.gmail.com/ [1]
Cc: Joel Stanley <joel@jms.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: soc@lists.linux.dev
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545e2861abe46ea7029f9b4d3628e..305e5530560e53c10f0b610fa7b4456ca78fdfc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2285,7 +2285,7 @@ F:	drivers/irqchip/irq-aspeed-i2c-ic.c
 
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
-R:	Andrew Jeffery <andrew@codeconstruct.com.au>
+M:	Andrew Jeffery <andrew@codeconstruct.com.au>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250203-aspeed-maintainer-dddbbe22da46

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>



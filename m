Return-Path: <linux-aspeed+bounces-1184-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9B3C3ABB9
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 May 2025 22:38:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZrxJf4SdRz2xrJ;
	Tue,  6 May 2025 08:38:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746484722;
	cv=none; b=koHyApXm2lq/q9WIeO01jCVnm2npTTWs+i8b+rlruDluwYHvknyYadfPOl1tOpLPFrV9kP0qwyHtzZXbjTMTquAFMa68nF+Q6O4cmjGQcvStboRFIWDPe8t70M2HtCFZfEm/InVENalKW21dDGkybAiBAl/HByNy0xt0efC5KLCznqqwf5BYPBGWqYL6gcSiDO7svlRHk0mufRp1MAFjlQW1+H5P50n5HFAXiik22O38n4LySRh0z05EuztP496Hw8KMziF5tGgAvyNJeFkM+ASUEmrg5DSutj0JCP2zdGweMdf9/1v83nPmEFIgP27xpQDayt6nScu9UMfxTvphqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746484722; c=relaxed/relaxed;
	bh=Uupg95TEkoWXsxdOgQ+3J4EM/An2UdOuPjBjvw/AeDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRAyQJPA0RGfaq85d9k0jlltpCshutdGkeBOvumocQfmF9iesV2p259voVmZysg4hotqRG8FZ+Kz8aRL4QedUpHl+L36Q6z+BYbWOyk7lUVeIKfctfkgwIX57Ocb8Wh4pRp3ZbnkMn8FPSfwgZrKTrpU836+QEgD+zVEYgl96Ibba9hL3Cdm/fxRVbH/uIM/y4bSq+f7j4QTQfDYscSKfaIrlU5NREz7eeDj9VDwrKHgm5HXfoiUoNoW9Amhy6CvxYbzVnN/wN2FcLcfatsOS2wif7BYc3jKUYqSdmWTJKfW8eib3djH1+UwyrMyYRLwa9oeZvC9YZ4mTk/X46ePMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dHB2aBZP; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dHB2aBZP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZrxJd72xtz2xqJ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  6 May 2025 08:38:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3F82AA4CF31;
	Mon,  5 May 2025 22:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4CC4CEE4;
	Mon,  5 May 2025 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484719;
	bh=s61Je2PkceIhRzOL/l54+OairdWxRxRQmN5FWDJG8AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHB2aBZPeYHN7WNgQXX/g0IOKS9l/2k4+aXwSWjvWjTxgVNsm2Q0OQYm7XLVHCAmL
	 tMB6T0ttVwH1ZB51vFb7Y5eqK5rPPCzJrszvn7J31QLMr6ZjQGC5NkZ+LvSX/mv9IR
	 tkNHIatjVns908YquXKvClXK53GXsItrQIqCXdUdb/EMkbkEFuNJ50pCKIoagChMHn
	 ckVzn7JKYX/PBx+MXQlbpUxWk85qHjzeKUxt6Anq63zNcuCVtT2cccjh0dv20rngub
	 2ZikM7xDAhWFMwCbc1Yvu0FTqdLWhla0MmQXpJuD7r1z7Fi0/hycsEfItna0yZenY/
	 S1qJot7r0lIKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	chin-ting_kuo@aspeedtech.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.14 626/642] watchdog: aspeed: fix 64-bit division
Date: Mon,  5 May 2025 18:14:02 -0400
Message-Id: <20250505221419.2672473-626-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 48a136639ec233614a61653e19f559977d5da2b5 ]

On 32-bit architectures, the new calculation causes a build failure:

ld.lld-21: error: undefined symbol: __aeabi_uldivmod

Since neither value is ever larger than a register, cast both
sides into a uintptr_t.

Fixes: 5c03f9f4d362 ("watchdog: aspeed: Update bootstatus handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250314160248.502324-1-arnd@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 369635b38ca0e..837e15701c0e2 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -254,7 +254,7 @@ static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
 
 	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		idx = ((intptr_t)wdt->base & 0x00000fff) / resource_size(res);
+		idx = ((intptr_t)wdt->base & 0x00000fff) / (uintptr_t)resource_size(res);
 	}
 
 	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
-- 
2.39.5



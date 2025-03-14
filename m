Return-Path: <linux-aspeed+bounces-992-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFFC282EC
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 16:02:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDq012LJWz3cWN;
	Sat, 15 Mar 2025 03:02:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741968177;
	cv=none; b=nCh54IKgLT14NitVKIFc/7WeTe5MXvav+JykgiXgrvGZy6km9lqEWfy0ASO4cOpAMmEvk/nv6HcvZB8mRrxPH6NCFWnJl9lp80Sb1DJHXqcxf5X9w/LxzFgTIVP0nGlfUhyq+8f2OH7NCWyv3FHl2pHrlMk3q11WUvBjQM161SgtKU620O1GT/As4qZYUB0JptuQJtbTOLbmNWNIgovy4X+a6zOxTPYGXCI8BigKzJkn1pnSdDeW+Kd2hJndYGlMBA24kYkZYOAih3X/rbv4Gh/a58PV3C5uSnQnASRZHrmTwGQ66Zrp+KV7eTU8ergFU/LHU2tkHtRdP2ph5uJP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741968177; c=relaxed/relaxed;
	bh=lu+QUDsHnKE/Syu77Ecp814Qglbn8gBdxsQityr+Uto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xqmcz+tsMTPp4Laqh3YzU5zir/N7UysFI2kl2xhzVDktV81MJfvUXymTzkc7Z66m4f4cWIwRxQhgVW89i4Ov0lf8oc/MPxYMhF8VYbLMW+wtF2SE4MqWoVcLQpzhQvpOpjkNVUtKAAuwQZehVyTvpGqxJmumfPoxVj0oTJagulrEhxT9lBxrmgSAbwiiRfahG45xpFzikVrjk7yb/c8/qV9inf4e6XAvQ9zzMcU42LIslLnDibi9JSDbLiRwXSUh9YHHRm/26+meIyOBxetAkTTrmiqNaUgHABAE8ByoRVtC/zUtdBrbfA7Dc2iyK0q+dcL94WDDm1sRppYMdog+bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NwAIwXPA; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NwAIwXPA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDq002gq5z3blH
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Mar 2025 03:02:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00C195C1D1E;
	Fri, 14 Mar 2025 16:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CFC4CEE9;
	Fri, 14 Mar 2025 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968173;
	bh=2xfK40kbAsq1KvSui06/jpf2SUEyYwHkDTzV9ntlS0E=;
	h=From:To:Cc:Subject:Date:From;
	b=NwAIwXPA5LFcIGfs/bRsgeS29k96CBCEM5nbbzJuvRLWiyQYt3rykJ48fbgDzQ4h+
	 dK5u8r9V4Ee5/y1NQs8aHLSzT00O9fYt03Ryl/fN2Oj3OMa5XNtYYNt9JJ0muwTSdR
	 /MXZloiB9t3j0LdunViaOvQrids/JmMppD1Q9DdA+L7qM1Mr/lKS63K0FZ294Zgg+e
	 n5VWtTs9xkuvnxnxouvylTWiPpD++qr7929bLwS4kxC38MLOgLWTRQPorjIPZjTYY1
	 2dClBdjtIEOBybXRJhhp9zobqDT6wXGMklWdgHYkfaq8adhrbHNM+T+wwGfJIwgk5n
	 /feX1H8EpT2Mw==
From: Arnd Bergmann <arnd@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: aspeed: fix 64-bit division
Date: Fri, 14 Mar 2025 17:02:44 +0100
Message-Id: <20250314160248.502324-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures, the new calculation causes a build failure:

ld.lld-21: error: undefined symbol: __aeabi_uldivmod

Since neither value is ever larger than a register, cast both
sides into a uintptr_t.

Fixes: 5c03f9f4d362 ("watchdog: aspeed: Update bootstatus handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 369635b38ca0..837e15701c0e 100644
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



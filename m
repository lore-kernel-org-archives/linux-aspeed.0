Return-Path: <linux-aspeed+bounces-191-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A917E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 12:16:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8BK95GGwz30Vm;
	Thu, 12 Dec 2024 23:16:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:4000:6:113f:0:1ce:1ce:babe"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734004394;
	cv=none; b=cswXmfRtOETg42Ji8/KofSSl909sSm+jAhRHrYWAeaPdRXRAvTEXnfUxSxWOWHoeXGZl1fjg+0AqVo8sAWGL5P4davbWTbpmaXj9ndAKUt1Pj+TMjEEuLNJPojzQ6w2b+LJAGfYEyIyazcdNICzeB1HUrGOWrnXwjQAaDXMfjNLzCO6Q1w+OUO55/I3+UrOBnwR6SatPMCuE9y7bthDS2BUqRAdOI58kjao2nnqrwDfEBQeIif/+pm0mDz5eIidVUiZLvh8P7UsGfTnsk+iqqOCfk3AnWvwZS1zzOUjRoNKl/yHHpszwuM5VokyJE7cqflpEOlPyvgLF9Zpie6klNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734004394; c=relaxed/relaxed;
	bh=GJEoBlS/FDGmCszmF85IMpGIY2VK0IkQn8AcG1hX5b4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaA4iZO3PrE3PZUXQYyPGXEc4iaTTJlEUXUSJ7KDQWarX0DkfvgpIFVULrPfFwjaErxJ61QZfkccvO2kG+eowc5AUTckg6L8X4Rcc4XxMyXmmJ63f94JD6a+OYJz/jaKwL6EqAsQIQYBo5LAaTix8hhNq4AG2oIMrUjidXYL2xOXQ631TTur4QWy9ZtFQ5XBQmyaRfs3Lc1+RTOg5mfWP8//yfD5AR3KadVJAFRp+hSQZTk8YcHivaNNDXaqUyHQcs2PNQKW6UAISXTuuAlgi1Ijtq51eMC0wJer23Rp7i9ln0FahCUSRFok5mSvVbksyALSQkQnvDVCCPwBw9dziw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=zankapfel.net; dkim=pass header.d=zankapfel.net header.i=phil@zankapfel.net header.a=ed25519-sha256 header.s=2024a header.b=vBBy0Mlw; dkim=pass (2048-bit key; unprotected) header.d=zankapfel.net header.i=phil@zankapfel.net header.a=rsa-sha256 header.s=2024b header.b=myhTvdnV; dkim-atps=neutral; spf=pass (client-ip=2a03:4000:6:113f:0:1ce:1ce:babe; helo=zankapfel.net; envelope-from=phil@zankapfel.net; receiver=lists.ozlabs.org) smtp.mailfrom=zankapfel.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=zankapfel.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass header.d=zankapfel.net header.i=phil@zankapfel.net header.a=ed25519-sha256 header.s=2024a header.b=vBBy0Mlw;
	dkim=pass (2048-bit key; unprotected) header.d=zankapfel.net header.i=phil@zankapfel.net header.a=rsa-sha256 header.s=2024b header.b=myhTvdnV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zankapfel.net (client-ip=2a03:4000:6:113f:0:1ce:1ce:babe; helo=zankapfel.net; envelope-from=phil@zankapfel.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 1340 seconds by postgrey-1.37 at boromir; Thu, 12 Dec 2024 22:53:13 AEDT
Received: from zankapfel.net (zankapfel.net [IPv6:2a03:4000:6:113f:0:1ce:1ce:babe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y89pK33Htz30Th
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 22:53:13 +1100 (AEDT)
Received: from zankapfel.net by zankapfel.net ([5.45.106.173]) via tcp with
	ESMTPSA id 6rlJ0Kh87LDhBzgHayDNZQ (TLS1.3 TLS_AES_128_GCM_SHA256)
	12 Dec 2024 12:30:35 +0100
DKIM-Signature: v=1; d=zankapfel.net; s=2024a; i=phil@zankapfel.net;
	a=ed25519-sha256; t=1734003035; x=1734262235; h=From:To:Cc:Bcc:Reply-To:
	References:In-Reply-To:Subject:Date:Message-Id:Content-Type:From:To:Cc:
	Subject:Date:Message-Id; bh=4u5q3iNWiKTEWb5hmFX2ihyKWr/q1tuP/iJ7YDhn8ds=; b=v
	BBy0MlwkxEer7jbyODcWDO37TYsb95V6uDlHbG39t/MFcyDxX4cSJOmlKItQtguqi5tbW3AY7fXiO
	ciNvpQBQ==
DKIM-Signature: v=1; d=zankapfel.net; s=2024b; i=phil@zankapfel.net;
	a=rsa-sha256; t=1734003035; x=1734262235; h=From:To:Cc:Bcc:Reply-To:
	References:In-Reply-To:Subject:Date:Message-Id:Content-Type:From:To:Cc:
	Subject:Date:Message-Id; bh=4u5q3iNWiKTEWb5hmFX2ihyKWr/q1tuP/iJ7YDhn8ds=; b=m
	yhTvdnVd3Nzn9vAxlGnAfYZy8CHNi0b8OPSKjYNDqZim/p2alcP0QuMuxIMpDUX8Sm0wolDYrh0Gh
	/pvT4LU/9SQKqJMCnK7E1JO2CkCF99Qhm/nd985FOec3zMPHcmaiXZS99GKYn7BebLrYlUpPrlw/i
	arfSPUDplXMGUYfJ/v6/n4rOPHEgE0gb0OkEaMJR33spu8XbMP3HRt9FTelbf6X/QXux04pf0Pw+D
	fH9GUHGMyHuTXekYBZqhhsfVO90u2PfAruqi6R2afumO7eIiBUm/8C9yEHN1UjYN89DUHCUcAOsV5
	hECNuxe+c5E1G03s6iwpg4e+aQ1rMPkuw==
Authentication-Results: zankapfel.net;
	auth=pass smtp.mailfrom=phil@zankapfel.net
From: Phil Eichinger <phil@zankapfel.net>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Phil Eichinger <phil@zankapfel.net>
Subject: [PATCH] watchdog: aspeed: replace mdelay with msleep
Date: Thu, 12 Dec 2024 12:30:14 +0100
Message-Id: <20241212113014.1075414-1-phil@zankapfel.net>
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
Content-Transfer-Encoding: 7bit

Since it is not called in an atomic context the mdelay function
can be replaced with msleep to avoid busy wait.

Signed-off-by: Phil Eichinger <phil@zankapfel.net>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..98ef341408f7 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -208,7 +208,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
-	mdelay(1000);
+	msleep(1000);
 
 	return 0;
 }
-- 
2.39.5



Return-Path: <linux-aspeed+bounces-1161-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661C1C36018
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:11:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcjb0911z2yrl;
	Tue,  8 Apr 2025 04:11:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049506;
	cv=none; b=JgHNni9V8lbKcLbvDtmHwVEILfJLGJyYV9VyXwZGCYWRIgRkx9hYGo53T4VHHmI3wlLVN4druqlpKVMm8qaFJvayNrgCjZzT58rfowtLgGJm1PYp9gAD2HArFllU0MRj/jgNEL54LrSF8olSmErTQv5izW/fdswrISGrbdsqe2dxkeL49DoXUmc2YAPUTb11mBLvforEDZZL3iHfek6WIL1OzH4ryAY2CHVKvdetlJdvVMFhSfGU0iQrujs2XO1G2Bn1J3nj72Fk1kLmCzbc3zBglUdvACJksr/OdIMn9QF92WUcm7SOEnZxVmTWV5Y05SypTIbOvI2IwEZAhTMmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049506; c=relaxed/relaxed;
	bh=cGSukBRzmg8n0+9cjuObXUH/cH44qlXadRu6k+17x6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcRI9Gj0v2zRCYCil//hG36GgzbTJItoyK4DZVwYvQYFW1pqzvmhk8a1OP4A/0bcTb2Vx2JkXQMEU2Yx/piOgx2fQ3mA5iaLHu+ewo/ruw3WumD+Ulh3msfIcn9ejVhXQF1dgNhUQMeM2vZqR7CMFxAUTClW7sOHtHqmjg2Fm/fKnVWd+cYqYBV14YFt4lTgY4jJOUZIToaR1kTR9MM3ncBQiZa64d20kpisIeYrYiefd33yp0sv832rhwR3/Gmqz9xGyroSr+JseDQPY/4+H8w/4jPkrOp6FpAC9qs1YsBlaHZbUjRn9Rpe3cHd6NFaToAVn8+thA2pfIiLDsZ7bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=id44oJdB; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=id44oJdB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcjZ1CXpz2yqy
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:11:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 73F59A484A8;
	Mon,  7 Apr 2025 18:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918E1C4CEE7;
	Mon,  7 Apr 2025 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049502;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=id44oJdBgOQF86LPDEiCyCGFB1qCcMT3d1hZI68gUWH/YfNLqHv+eo6wDhHLqTfc1
	 zvHjIMoK92PZK/JNSs/SRM/b/0wPyrBQP1ovbwKNi4CBUi94fU+JhueJIQ+8uadgCr
	 sfj8l4C0IDemViYL/o2L09bMrbOPP27804tx0C1Snv8sqW2mQ3KloUQAyxl+Q0zH6R
	 VGlMQmJBW+5z/Xv3UghlnSjf6tKJuDigc+sXv4VfNaXE4YltoZXCEDq2F4qr2WWkAy
	 A5oOZocyMdW/fZkwqz8nYCP7y3WNd7XOJNaWDXZaRhC/N7F70Eqh/p8XeTW5CS9osc
	 xWkrONzo44COQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	richardcochran@gmail.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 20/31] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:10:36 -0400
Message-Id: <20250407181054.3177479-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 8c75f3e6a433d92084ad4e78b029ae680865420f ]

The variable d->name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://lore.kernel.org/r/20250311012705.1233829-1-chenyuan0y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b799..a09f72772e6e9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.39.5



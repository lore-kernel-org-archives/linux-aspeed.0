Return-Path: <linux-aspeed+bounces-1167-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E89EC36018
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcpD3Jh7z2yrl;
	Tue,  8 Apr 2025 04:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049748;
	cv=none; b=C8fmEj9EgbOnEK8uhMG7gDG4TIkNMPOk2+FiXy4tsUJJJtsTc+tZm6oa3f9Cys7UTulc1ZZUwKybFxfQPFS2Ti+tool4tdK9J/Gw4pSJB86MgXVqnIAyEUcSJ24s8WKMWZYMrjRINYSs+tQnpcvN8gWU6eNF3p8d+LHkfmgClTRnONBkRun1QSKDPlszoga9lywOANEkCynkpGzcT651s1R7vHthxvM+65ECgpFWGDwxDWKmVEGiTB82HDfju6MNZM8DU6LKnUKiVZcwg59fyDOI9wgPXglMTsFiFynXFElSRouP6ZqzyV6SA1qGFwLViX+VrADqWjfutd136zeCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049748; c=relaxed/relaxed;
	bh=qqdO05o8i9/QOOI/IEIMoKVY2e0jYkwrLvfoaCsqNjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHc32Xz65RcJOvmT0sXFpDFtNjwSdSw3DVspIS0OG0Q8HTfae9lzomEh0Eb0YqgZvRE6tshk33czuzDZBa3tkh7Z9f4PBh8uOgbMrT2ZzpilMzsoYZVi73K9BwtxI1AD1SA1bWVSkTvRGuKduKLGP6XtF2hogBSASHOhQuAlm1GQVCwH8+TKTeiEn8CjdmtOvV+vI2+d5l4Xql5TTCycUJ+7NvUY+nX4Vrkkn/PF6Tsvfu5JpZruZkU8152yK7TicrCI3xRoqQGf0D1AssRoPP2S6VUFQXfRTsp4JtLgzQe+3hCPjOI78ftWVDO5R/vMtW1BzCYZ5OLJ9FARn3fWIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ftQIQVyz; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ftQIQVyz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcpC6FQQz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:15:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DBFEA5C5554;
	Mon,  7 Apr 2025 18:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C98DC4CEE7;
	Mon,  7 Apr 2025 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049745;
	bh=ojmiIKC5JoIOY5ncsM343Ilta0QjoLb8LQTtRAMq5Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftQIQVyzGt536oXaO7gh8Odq9U85GV04hk2FXfqtDG6dy12mM5wjDKlUN+nLTdRWa
	 enNvRrOnDbmFaG8ZuOvGBFkjTlJOP9u4pVJEgQWT55T00nE+b9tal5LTvT1V6gVZ6w
	 d2TMzVmtZWBPOIxOiG7LqtqU5n8GYBEAF1/yvo9B1haC33k729ZRRog3qDXhZr5m09
	 Mg81iFCxWXG6K1pIbIyClp6ZTq0A//2Ve/nbPyQBmb4zVrVQblNbATjyJbYU/FXALG
	 1wy9BwUwB7cSfv4GDZ9AAd6j219w2EDEgJ7Hlnt6OlLBqUv8UM7lvwDBkZKSIBZQx7
	 Df6tDh2epdNAw==
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
Subject: [PATCH AUTOSEL 5.10 3/4] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:33 -0400
Message-Id: <20250407181536.3183979-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181536.3183979-1-sashal@kernel.org>
References: <20250407181536.3183979-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.235
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
index d268306a7bfee..92755a2fe4ff7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -543,6 +543,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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



Return-Path: <linux-aspeed+bounces-1163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ADAC36018
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:14:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcmD5VN9z2yGZ;
	Tue,  8 Apr 2025 04:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049644;
	cv=none; b=g30SNmeqPpagS0V0d81FacWVWYSEesM3R3y2pkBKCHGTC/Yelg8k9JK95MpfgBQuz2m9lma2dhAu+CZIgX5znp3D4d0cUH2GKa9zeRV0aZfiK9EUrGhyRJFDaBidrU4D5xFN6WTF1DVIcyTKNTwWbOLBPTMbOoyjHeFii7KUEpqWDekSqp4DXKoGxmSmUK/p77fSXi8JdnQ6vPPCeU3WXHqxsF2tAIKZRE8qdVkXm8VeWWMhEBM2LK9n5Or3i8ChX/7EsqzxINU7Nqand8UNhErnrUTEZCmdEmI2QVJcryQfAOPxLWsqoVWgtVqQMvdSKxq6suJTI/Ky8jfmAEpaog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049644; c=relaxed/relaxed;
	bh=cGSukBRzmg8n0+9cjuObXUH/cH44qlXadRu6k+17x6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6vp7TDpkAy4CJYkCpvYAW7g8dccB/fuKrPbHL0A0AUN/7Q/0fKz7BoNlc9lnmtlN4b15xlKPO34cwKQz7WJBqXxOIbqQrU4BnLEvGm+zyWTc25NddT0znVcL9qXUCZMvCHbldWdHsIBevgiFmR3CuU2xEz8btxoBZSyOxMnye3rX8P9Zy9OwMlh3O+XIjwJDgI4w9BZ5yDOiYBJYG4d8Agk292IVyUNma/2VUZQsKYWdQcGF5xqBnLveBgS34ULNH7gOnTxFrcdrVl0BPLhg+1sYCyAArFH/sTMhINexQ41MZMUZZymbZSXzpuTU/ij8yXCmn/abc27Twn7CpNkUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rxU8YSAD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rxU8YSAD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcmC5Ddlz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:14:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5755B49FBD;
	Mon,  7 Apr 2025 18:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A01DC4CEE7;
	Mon,  7 Apr 2025 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049638;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxU8YSADFs8rBmLZk7+yLUEcRKBgcdQ58Fpvb1R52gAJu7qqdUpU4Phx6BwxNKtQN
	 f1+QoyU4fuJLTs3m+qh0ZcqVJlXbSRBc9d7aMRtX52qXXAuHa3JZ7QzBs/BYmdD5Ld
	 DtpUF9Mq+bLr/Hm5c0kBJp/ErNzuR3tHLv6FQO27+1LOSYqa093W6QXC/P63wcS77u
	 kzI/t7jX4K1TMmpEowz7q3nRr1z2OOUTPMVxfGjMqyy0azdz53A5IKVtFU/LrVyrSa
	 afxpi3K+MsTR+reM4EDq7y5G/uIBsG5RZ5doWGdwV+JWQB/Sw1cyR+FoKcP51Og7kR
	 OdTZy/UF3yPSA==
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
Subject: [PATCH AUTOSEL 6.12 14/22] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:13:24 -0400
Message-Id: <20250407181333.3182622-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
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
X-stable-base: Linux 6.12.22
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



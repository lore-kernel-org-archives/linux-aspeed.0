Return-Path: <linux-aspeed+bounces-1162-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A91C36018
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:13:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcl22Z7Tz2yGZ;
	Tue,  8 Apr 2025 04:13:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049582;
	cv=none; b=iV0NiXsxMG2lSEljeDlNliGtsqkidsZqCTnV3zdqTSKF4N1zFazuuezXIsKqWxNXtgKToZo76wv+taJqqmEqm/CiPcg2ZR2V7o1+BOPKESRQjdUh5f/PlC6zWMKKAAqcRawlUxY26B5ccDiYHfN0+lzIxbROVrN94xb0OuLelG9hPL3oyy8T2jzhGaCy4PHKx+qcu/1Wm8BhquTAng0rHOCczNhcRR8FyYf1NwgoY4cPgnB16fKs04I1y+5ifzkk7iuskwITjW+f0ZGpOLl6gkKIWh8oV6D/tYrXE34Wz7MXg7+cN0tSoD93S6EiVYKe+duY8ZYxfWNFdY9A28tlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049582; c=relaxed/relaxed;
	bh=cGSukBRzmg8n0+9cjuObXUH/cH44qlXadRu6k+17x6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=do5h3erkCw8Tw8QKoLp5KLIlGbEMq69DcqckV0RHgBb/zRjGKyaqC2wMb9GQHcY/yXDNu/ngA9exT9cvLM6Chkci75QdF66LgqhQGLT1N56RamHQuZ8O4LUHKaoRL5gyzROjHwEY6NXugdrFkCgqu5Xwddtts+TydOx++P385RueTtMJS+BiRnoyvFcPhD8uzvfPSkWRK9wJGsrbdkZ5JraxFMyR+CaPvl5ZHL16MrUxPRcUsPNpp/z7JNQXnJWwsBzyiIzVWRfhokI5U/cmhlAPzXYstqA8YF6O+yHGzi1VvrQAcRRYJguZ47okATiOEmgnyPE0a8z6qmSYukNAZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JX7xthFK; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JX7xthFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcl14RL8z2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:13:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 872F6A48450;
	Mon,  7 Apr 2025 18:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F16C4CEDD;
	Mon,  7 Apr 2025 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049577;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JX7xthFK7yQFN3HXFZHFZFmUFAdcZWRaGPaRbR0JNQe4NRXcYZ0Zp5LffamXeiky0
	 YdKE1P8r9qfOZ4UYmV9kGouGqSs0g0RSluDqqChFSqOzfy1P4vBYifru3iNGnlzhhV
	 6nyurJRdf4mAgjk3ldiaLlNKL9fVCRigYqwj67fdohZ/kv+Ws4IjNjKxC3fbKJQJw0
	 PkcKdf5viakPWY3FbL4UjsfWgDvRLaUFfdcm72ioLVbzInXokosSeEHGFNLzDNa2eT
	 Ndcj06nVv2L7J/vK/nWxVHLenQAKXb9USZawsPilpEgU91x04XN45kAIFAYshR9SjX
	 MK9SUJAPaXn0Q==
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
Subject: [PATCH AUTOSEL 6.13 17/28] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:12:07 -0400
Message-Id: <20250407181224.3180941-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
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
X-stable-base: Linux 6.13.10
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



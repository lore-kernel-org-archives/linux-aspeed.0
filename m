Return-Path: <linux-aspeed+bounces-1165-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D5BC36010
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcnS4qynz2yrl;
	Tue,  8 Apr 2025 04:15:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049708;
	cv=none; b=SIkPLM57ha7eO6j6n2m/7tMDdxWn0DEv/GkMVBzXV0lNtX0+ghtxq5saJlqwVe+ylasRslnUn50PsWVkBsHxv2f7QNV6vY4swUFIiGJ12xH8Q8FKz7FSCspu7TT7SYzahwY6NrIfLEt1LjrCFwRwjyjNejEyXKSGDdJz1s8r83TOXvp/1W2YV2xa5ivNI7bgQq+s80XRkemXtRiykAAQcy4MGQVGQ6BCRiTOTv3x4T+wXwvEoE4VQgns0UW2d19UuZAHUB0U3rVtFuF/EBWIPP4S7CnmTc8f8SBWiKlAPX4/reicK1izzsUaWpQ5rqAh1GS8huE4xYBR3L8SV7X48g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049708; c=relaxed/relaxed;
	bh=Lxj6yNnJBi4QVZZ0/9cezFhrxRssjeKepNLI50uV6nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8fXww+oFhPXNB+ptEWj6DHh/X9s2FrQmJh/JB9WoTEc2Hu3Xb/RJ0yZWHrPZcrTRFdjuIBd1nbvCy/pphyMlDRb3iNdsHZ1WGHfo1zoVuDFQiON0H+y2my1DwxnRvz0G/TgrTZNoGVL+QBfE0P38oSijVPTnh3Hlkgqgsbifz8km0GLrvFMMUjh3kruMeiZ/kv2VIhK9IEQjBahnmXZ5WDb7B4Jt8dWU2WeI6gnxADSOOP8zzAhY7SH2gk2iTeC14jPqWI/d2tkYsCeUocZfjvDgyk0XFbpss6qvxGn9OqH5xLO7uRLj6z5Dask5WSGERp1Iu/v4Px4wU15W0X6mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lsGfy74I; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lsGfy74I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcnS0cdyz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:15:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9591E49FBA;
	Mon,  7 Apr 2025 18:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E4DC4CEDD;
	Mon,  7 Apr 2025 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049706;
	bh=Z5ZlPmDMTP1xihGctDcUIJglsi5pe1J/GU767msqbr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsGfy74IQYwnlgSuGF75Kcrk1/TqM4CukckmDSbW2oEzS0n3YD1Lw8kfsPeFKhqrJ
	 ar2qaSr7+kVYx+PScZ51hyqcyFyym1kjMOqHxAeoG9kuOf2b9uD9Jec9q8OpuB+5z6
	 BJVzUJOf49i2Dr/SIIAiHOeA1kPTiRdmxpkwvqj+tIcZ5b+VsfGUt3F7TKSooB2CPr
	 OiBaKmjALqo40/tnPHyim6RYoNfwr6PlJJkQ+mtzazbZfuttsHOP6eQEqf5pmvSS3b
	 5VtF4LDPfKq5VUTkofAReXK3scDz6Aoa5+qZpT98PCXtdHS/iKpcc6H1w1f/E5V8iM
	 qd7RwFOQTcBkg==
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
Subject: [PATCH AUTOSEL 6.1 08/13] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:14:42 -0400
Message-Id: <20250407181449.3183687-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
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
X-stable-base: Linux 6.1.133
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
index 4f3bc27c1c628..73664a123c7a0 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -549,6 +549,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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



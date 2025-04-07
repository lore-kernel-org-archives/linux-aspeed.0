Return-Path: <linux-aspeed+bounces-1168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7520C369A1
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcpV2Sxxz2yrl;
	Tue,  8 Apr 2025 04:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049762;
	cv=none; b=n9KBofwzjP0n8IzxdEqGBGR7jTKM9h/3jZ37/OjRkA0JjMlKnFYOTdssi7FN5vH+HecTXAB4jiXzovSYqb8bLqL/ShTR0+JxAsuB0KtJ7pz7oxMdmfDS+2ZkXM7TcqKiPVKLGxA0B/TpU/ksmMeWsYWkRwjPZwxpQJdWDnn3R/O7RUwKlah8JlikotjQhsFGwTIPnFg5JBgMh4f589f9vFPD5OwL9N9FiXIk9WmBtvfljA14Gl/Q8nU7fn8+bw8JhsUjXMZaopwz41Qq6kKWCXvq2Zz/jXh16cngF750z7S/PgOK7CDFg67k2fpX/DDLBeE5rvnyu8P1op5sO1nshg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049762; c=relaxed/relaxed;
	bh=CKl8iRi7t2S1UDs2dRmpXhJRCp/W8560Av18KRMEXdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgMaRgTfmfnCLLeiPYauBKDQw/Q5C3ufc504phmEImdQcCaeDH6dcpK5am5AVEsiayNgVUwpqaC+6c5ZPF653LZ8axTKWJn+yS6dMmJ1NnmipAhn5u400cuzINRrS4UWZ4lcQARuuMqQBsgx6QwxfIlLeA4f5feiGEDHX2hKkkrh6ju/uqqd+iMXrWd8kxF5T1EVuWSJt4CN4B5MBKsO5yGngyR/9151dpERJl19f0thRt0KLqryHB6teCcYpvjVzBeL89QORAX6ez95D6dd+maBnsvdEQ2ZTmYPK1hvl/ucaRvnJJXNwHC8lmU4rSjCXxBgctuiejz962x17m5t0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhHBcldp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhHBcldp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcpT5TByz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:16:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 626936116B;
	Mon,  7 Apr 2025 18:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B4FC4CEDD;
	Mon,  7 Apr 2025 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049759;
	bh=k13xiQCaT/GS6dWcuXlaBInjqnzPmqms2Dv69by3/rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhHBcldpetwj+Px1tlBUuWitjT07SZP+IoP3R9vvpPEOWbLi8eKgSyPqXXjDd99d5
	 SD1kdDcqxtHEt8+TKorNtwYKWKztXuIBgxmfJqtKWgTtNO6n6a+r+uFOgtZr4k8hHP
	 V5vGz/SdpNfX2wGjsQAdADsYL/nk+5uACGIOqYngshyIEhWoJXKRrCjiMYHyqmic2X
	 AcbNGhrZNhRjnp4ErPrGyD2eZSEJzynZRWYb3hYkrapgqx0foxf7BffNp5cETvDIzZ
	 Lo6AEiw378Xfb7aX22M1HJocqeS37bitc6+d6P22TXh33hd+BPQFuq2oWqwqYJLFDn
	 EM3urwhIEDsOA==
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
Subject: [PATCH AUTOSEL 5.4 3/3] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:48 -0400
Message-Id: <20250407181550.3184047-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181550.3184047-1-sashal@kernel.org>
References: <20250407181550.3184047-1-sashal@kernel.org>
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
X-stable-base: Linux 5.4.291
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
index 4008e7a511889..89d7d3b24718d 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -542,6 +542,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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



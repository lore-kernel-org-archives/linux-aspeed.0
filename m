Return-Path: <linux-aspeed+bounces-1166-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C24C369A1
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWcnz4DqJz2yGZ;
	Tue,  8 Apr 2025 04:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744049735;
	cv=none; b=hJ4SvE++9Dvf9b3gzh6Quysg7UlqdBABndxQyhdZs31eWYd2yELCFuLvV0T2L9QtcbqtGMxPZbODEtZfpMTwBFlBtZlBwc52paOl7YIQS+txC6Z4Q4U6/mZOey8l0I75FJv7tNVJ3Q05eumrLRb9Fs6/0w2i0XbxIgTg4csLyQZpTDAirZwzAHJb54MG+OIVCyLbjYPxphH34wW3ECB0s9ypSWYCBdFdZHbvBpKc1PER2L0PApHwRzn5FXQDx/7Vj7PUbDO99GKTbemPN6iAJ2wN009C5AoeE//ZTqtvDO3U9EvljIcRhsb++as/JN14eVYo6Z+LfZqeZTxu/CPPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744049735; c=relaxed/relaxed;
	bh=N/PvIqoBhOks4pI9/14blM+cqFT4WQ4VRTCjC/QfJ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5pPqCUOTh0XKTMVy57DDDEDUYpJNGYBFdhL0Bch0eY9r3kAGzgM6cD1MLhxb5xj4qBqJJPk6tXqF+dkv51/N/9GAykjUQkY2v+kIrGcEYcE/bFroFv7OLXFQj2ACVxn/s++kPYPqTgRQc6aKdbg5FPvNCX80Quhf4EuqG6K32iE1zt6xLaCsO45mRy7SKTPtmfg2Bi86O2dJtVMW9hXXmVV2OtWdKZPKncJyceBl/3mYnDcP1xTiO0VsAPoDigT6JlqOiYiXzI98mSnOGrzJTMfHh1nXqmd7eN5JnCWS5MIRrAJbkpILWiboxDcYoDwJWvDWMGr60SF7LrUZ52N1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=thAmL8VY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=thAmL8VY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWcny6y9kz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Apr 2025 04:15:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CFB6D61164;
	Mon,  7 Apr 2025 18:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B0C4CEEA;
	Mon,  7 Apr 2025 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049732;
	bh=9lnZvdYWucsD43LgxrIBgPkhCQuCm3u66wDOkTVnmIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thAmL8VY6DYY8a3gSfFzvB4C7s8tzb1EZ8zpMLNfNFsoW4tTdaGwP7THjwWtVKzfd
	 DmdabyBEfi1gHz8VYgvkPgpGWRJ77cDqskzcLGstl9hzTHV8vykSX2kzUmnD+KEZke
	 dBuxjWdeVluOLkWK4Trm2p3wuZznFGYIqMlAmrfJBoH3kc56FwvI5IvOji6F+Rt4vM
	 pcGR7Aic+MeRvqhUAVzak1cc2W+THHhw8AtqxG0QPCiCccPeYobfhVuo9df/qbtWQU
	 UeSyXle5pH0Ulpq09a0BPVJFTnsIq0jIHcChn/lkr8JesvQAgszyN3TaoqEp65OYoo
	 F74+fCPU7UBMw==
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
Subject: [PATCH AUTOSEL 5.15 7/8] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:13 -0400
Message-Id: <20250407181516.3183864-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
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
X-stable-base: Linux 5.15.179
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
index d918e8b2af3c2..c5f7123837751 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -538,6 +538,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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



Return-Path: <linux-aspeed+bounces-980-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB167C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Mar 2025 10:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBq612MJQz2ywR;
	Tue, 11 Mar 2025 21:01:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741656444;
	cv=none; b=DPKkFYpX/WW8UgYWQ6sTb6t8sdr/3XSXLZSKfek7Ug4kteKcSi8AvnNIMOYGsrYwMX9nfMuX6IW2oeMNKF9RYLhTIxH6ZkFJGQQTaGmXaaMLzxWtvnOKEpATzOy/Nld8ftQafONM6f52Ip3h7qbpPcZ8q/+2YKd1pM4YE3pRl8XYpCelDj8h+aqKxCsNNw2Mz7BIeHqcoz8hjP4wF9RycfSdEPvr/p0eL0srYeNj6elGJx3k6EqgtCqLESVsi62dG2cWWCa8Thk0bor7vVFkABmW6KlNjBVfRW+3rsx4qLS5tbF6rsFaupCLXdD2lI5Xe/NpEFw0AL900d2xP5Kjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741656444; c=relaxed/relaxed;
	bh=mYu4oax/thewz4e+p/abSxr+bcjcos4iMdBqH/7SF5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWzhyiGTXZFniSKsv/arV1w9U6Fb+dyQK21jI++FKMZKUJTNdZt/3Xn7M8h2+IptL+dG72AbPqh2mS/9FY5ZjpKDyIuxhb1u4PAVXKf29J2KXoz00HoRNb1VPpMIekoAgmuargRVQVYeIgKZjSnsfR44YAo//NPmEfo9BuGtX6OPId7CF02uRAaliGhhWPxsEfg9w6dcYwY3Wrx4yzYoJ3EmFXp6Prhi8nccE98kVNSFkJCsQM/GG6lsmeMMxDPvXb9fS+5CRVOY4bGCfla/30lWqBKVCyPkiE4lFN4X0wNUFq8MD8XjWNy6fr2hkvy26CJSqLV3kDdc9YPkKkh0JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DAz5gzGR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DAz5gzGR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBbj72S9Fz2yGY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Mar 2025 12:27:22 +1100 (AEDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7c0ca5e6d45so60938285a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741656439; x=1742261239; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYu4oax/thewz4e+p/abSxr+bcjcos4iMdBqH/7SF5g=;
        b=DAz5gzGRwPfFpRUj1U1GmzLcuCnn2whDOtKvsxpYPvglhgv0auNvqRrr0Bdcuyb7hB
         aX6pGY03lmHkPiNII4PxdlS3xIYiWfUSt53rpzOD6ZFva4YFSjnXlss3FnC5tdZYDpOx
         KfMPCrBIBIQcqlWHBEbq2rE7LvYtwxzI1A16CApWzp6yx6HzuOnYPXzwzifwkn22eY9o
         pgG3ghkzMxrc4eumxJhbpIUNqIm+6XexZJjRY840wzyiA3RMZ87yHlfPzIpjI5LC6uCy
         XrKVk8Q2+Mctg/Mv2T22xcrlqpmCABYWaMELcdIFcqNgX2SEit+IG7JYQTAbNcTtAzj+
         1nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741656439; x=1742261239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYu4oax/thewz4e+p/abSxr+bcjcos4iMdBqH/7SF5g=;
        b=jpDS0hMgFwptsrxV01VIMGXdPJAZTcIcnXd5s8OTVuOn0E3Cx7GK6dV2LfCs2WFh23
         izN7eOymBJAaZhoeyN30Z562taChi5hvIn/7XLHn0nojiTvhH/WVzTcEs44VoGey4LjW
         rBTKViBAhrG7UhAE+WWc9DQw3wngJcNKjX0TCHo4NeB4oe7XYZ9RzCGsv8Mcs2r9j2rM
         nL4MdtQHTzmI/+sWZXQc12L/eYpTa3tKLpcOcBWrcB9IJOmMdyflTBlaG4j4FuAUCRjK
         txvOQYVx7d+t3HnwJt4/vZvoacGXKAkPCmGWg5BbTvyHKb3I00scV+p+5L3lC8eUKmZ4
         r4bw==
X-Forwarded-Encrypted: i=1; AJvYcCXfKMIaxrtzOD4j7SZ18UMKtD7JHRtrJnNsHvuT6Btu55wO4WrnYASjnQBBAgk6OakFkfUNNRYgrakpD/c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1Ij26016R57wDDcdxqnDhdRUsRr8PV5D4fVZ2QkzB5G8/lobw
	y3MpUR8FMM8vFRHzhIduZLb+gAqT+lNE28d0FyMWiBjXcgaqePo=
X-Gm-Gg: ASbGncuDElfd4GOcxJoCu9mzJkCJD7JbzFxxbziOGt80fTHdMpbh+b3AtJPPD5FdFrp
	GvUZK4Dt7srH+/d4tsWmPagw3gIUMW1V0oZy1SDLETQT6SPbsdpBHbUHV55o7PfHEJHIc11G8Oe
	EU/AQhMpevy+QbFNpVq4f0kqAVtHQkNJMaaBvdMeYLOG6b5Fs1O/ofV6EQC/u8fqh7J95z+g8oF
	18/NTlgBVUqlHbjKjC5ezl5bqs439fb4ApzB522zp1oQPsqwLO/DekwC7T4aWpGDgItT4kVjFQ5
	6NdxAUx2nf31FjDumy59mzAEoth8io0d0H71m57dxA==
X-Google-Smtp-Source: AGHT+IG1lIg0zhgXXdip9xAmm17KRNm/AUw5DrBkAQ32s9Cq80PSZ7xrsQWtT87xxvnN7LcqufT+vA==
X-Received: by 2002:a05:6214:d06:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6ea2dd1e540mr10215056d6.5.1741656438961;
        Mon, 10 Mar 2025 18:27:18 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a2dd6sm65178346d6.61.2025.03.10.18.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:27:17 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon, 10 Mar 2025 20:27:05 -0500
Message-Id: <20250311012705.1233829-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The variable d->name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..a09f72772e6e 100644
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
2.34.1



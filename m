Return-Path: <linux-aspeed+bounces-1173-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C847C369AB
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqs44Psz2yqT;
	Fri, 11 Apr 2025 11:09:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333753;
	cv=none; b=oivABsbwbk/A260VMd/dqSXLPL9qxkxqwZUdqbe2FR6qPG4QG5HLyB0y/qaFQdbEVFy7/WGZdkYRj5pEefKvGXcqridrk6sgmkDsQDPiFo65mtsHemV4Y3wiQXKtNIIBnMePbIZODSC6CzMl18bt9OWPCy9lRTh6sa2TDg7JWZEZ00EQZR8bPAaphuXp8PBHV8G+6f3wdh5hVJ7oE8E0WyhVbtOluVeVPX+/tc7lICwTeLw1NtOdlQEECig3VvWCIwt8x70rMjLoD7YZsb4fDJnI6ss0/VF2A32VXEmcFYn+E5bm99yr+UJA/vJrNzINHj/4kdFERnoZtXFDkTrKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333753; c=relaxed/relaxed;
	bh=ABw4ARhNQAkd4rlXFYixFM0InLDEdXfdXSG/4HG1QLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErmGf0FdZ1FqpNmdgdFVzTav/9r4bN1dCqyrkLX9DjP/Su2Cdz25z/fU1pYfJRIqd7iOyNVic9d69KdB3lT/7lWu5s37DJgzxPuKBQiYu97GeFNJrzJ7InpWmlS5t8w+1N435eEVGY63Q4VQFQzlQytUCHRLQYGJBesuqKz1A1rlTgj5U/D7Ip3xPDJcFU0vdykTA4V2CBg1WJ5s+ksRAxM0Y1HNxSxvlHHAMoH/E7suS3535rxM9IxV+nRNKjp3ZM2/kWoG5qntmS1YnU2n9l3mEi34eSMRiJ1d2ARVbg58jXGXzlbMIoYoVZ+bZ0kO+itdv5h3DkvoACDP8IvWLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=So5fjgqt; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=So5fjgqt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqq2Dtwz3bkP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333750;
	bh=ABw4ARhNQAkd4rlXFYixFM0InLDEdXfdXSG/4HG1QLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=So5fjgqt9a9pj2mC+YdxESJ/ZFNZh4U8IMB+HEFP0wC04D7yukXU067Ok9Fudgw5m
	 I/eFeoUIFghXlhYObM+Q0OFIVkjRMLYNiu2/zlSSBu0rnT5+AkmvrCztE7AF2i7Zw5
	 do7euB8rxbndWNAiuvpLeL807qtoFuGMPdPKWfjbpQQIiH4VUR44T2fyDXmZ3g7Rdp
	 pzlUl7giYfvNYNWQ9kxC1H7WVwzwln1zHX87DRf4BbF5qbLa4qEzyyvMxHJN06w9Lg
	 YHZO5UtF2UHjq5jitMgrBk8vBnDhj+T9jKTp1rCFPr8YvrhJUP3ufKJtUftKgK3aep
	 a9802cCCXkNWg==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 01ECA7D714;
	Fri, 11 Apr 2025 09:09:09 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:34 +0930
Subject: [PATCH 4/7] soc: aspeed: lpc-snoop: Constrain parameters in
 channel paths
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-4-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Ensure pointers and the channel index are valid before use.

Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 28f034b8a3b7226efe20cbe30a7da0c2b49fbd96..6ab362aeb180c8ad356422d8257717f41a232b3c 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -182,6 +182,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	return 0;
 }
 
+__attribute__((nonnull))
 static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				   struct device *dev,
 				   int channel, u16 lpc_port)
@@ -190,6 +191,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
 	int rc = 0;
 
+	if (channel < 0 || channel >= ARRAY_SIZE(lpc_snoop->chan))
+		return -EINVAL;
 
 	if (lpc_snoop->chan[channel].enabled)
 		return -EBUSY;
@@ -252,9 +255,13 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	return rc;
 }
 
+__attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
+	if (channel < 0 || channel >= ARRAY_SIZE(lpc_snoop->chan))
+		return;
+
 	if (!lpc_snoop->chan[channel].enabled)
 		return;
 

-- 
2.39.5



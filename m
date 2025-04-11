Return-Path: <linux-aspeed+bounces-1172-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29366C3601E
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqs2rvwz3bn4;
	Fri, 11 Apr 2025 11:09:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333753;
	cv=none; b=mOU33jsqXP2GvHJmS0KVJo6sLFe/bcxzlU5gjbA7jF5qCRYUWYQBoj1QyH/2TIFQ7wip4POzi6X/SfXyHoet+d0PpdqaWDQyF4J1qZGrnb8a812DoY/D9btbA+osQkgQeDNOEKRnGOdEOzvWl0oSMTT/bEZe68E4eKvSYhFHm5rj3vSnkvfdTS1YMFvDF1Gy5rAhs6eWtDP8hAgEBmTVsh3OmKYN5zTQJcEiA3eVG+1WdNpLSHCRClpIgTKenUiR8wOjwewY/SoeKb6zgokf/a/6NWPggA8ClVIw+vmJO+6fCKnNpFwA7QOPptYhnmu5ZqN3GHsFPBfU3GnMGdGCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333753; c=relaxed/relaxed;
	bh=hnlplJMrlaC0dMDphlz7L6UrksHDLVz2lzXrxKirevo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC4VW5rGh1vViRYwWLuXPFuT9FdlQtvmdWwg1HESwGfL8174SR3VN9E6wloh1ZBPoVtYBvjf7gIbZ0ZV4X7PrP/vjQPsBVSWlVrLsQnwtDfEbt3GMFjPq+wjk0ii10GIQOoNPjziXntKHElnnzQo7TorkJn90PsRupnjMFWt4qmDaEzmYK0yuwGGr+9DZ2735e4uPCupjIPk0UZoVvhjkMBr2DbxPvHJ4aQNzx0oWVa1GrpNFD62xS8td0VgdD4yAjzDuS+fwI1YBc7wdmUwh/j6nqttJO5XOZGl6DJUes2ghgbmsKRp3PU37hLNupkZmFTH/0yoC3qI2goyNmBrdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BLcxJ+QL; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BLcxJ+QL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqp1m0mz2yqT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333748;
	bh=hnlplJMrlaC0dMDphlz7L6UrksHDLVz2lzXrxKirevo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BLcxJ+QLELrze4REYr90Q/cG0vzVyXSOZ3z4M8SFXbh9M+CsbEEgDjcznKmzeWLAS
	 1EBqwvzDyEehnzXHXtNScVMwfoYTrofIivVW/11368Do8nQo1qW72byMhpb24LIbYb
	 EF1RcSl22u/vuelr9vkXViZv7Ir8QcnvhnP5a03oxtLj8yppk22MJqyeYNehkStU/c
	 FDNWfxoEzJvCqe8SuLjuwkZZJmcosjxH1dH+sBWY0M1h+wsUMb4QPijgoUEpaUlFej
	 /1FAEx5XuTRS/g8RBQ4GbzLbov9LbwWo9kIzM6ONztVJCDN5y/kbFn3jxHWMwCJf92
	 /UyqdHzefeObw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B97DA7D70E;
	Fri, 11 Apr 2025 09:09:07 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:31 +0930
Subject: [PATCH 1/7] soc: aspeed: lpc-snoop: Cleanup resources in
 stack-order
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
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-1-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Free the kfifo after unregistering the miscdev in
aspeed_lpc_disable_snoop() as the kfifo is initialised before the
miscdev in aspeed_lpc_enable_snoop().

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 3e3f178b122615b33e10ff25a0b0fe7b40a0b667..bfa770ec51a889260d11c26e675f3320bf710a54 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -263,8 +263,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)

-- 
2.39.5



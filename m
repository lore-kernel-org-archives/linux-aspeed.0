Return-Path: <linux-aspeed+bounces-1471-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA7C71155
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnh2KJ8z30Vr;
	Mon, 16 Jun 2025 23:14:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079640;
	cv=none; b=Evw3YXSPDnU0/4ifDIfPAHSOZdKjSQFJPJMTZKhn8jKuqLcDGT9s0HchMBNNK+megNUvtTZMnspTyGW4NeH66yL1KYwh1JlIHuosyoprTPFPc+hZizGSUxVcwPqG5VN0D9wIKZ9MAzf7fpcXB630yy2hN8kVSM+lcat7Qe8PRD/ad0r9ftUO2wWWrkHdvg0smm/FA/dyYmNLW1ted5cD7DeT3TtVwTi6TK9csna1tDQbeuiSWTzv12TTMd32kFBKBiSFnHZQ6y+DdUArhWIxOTFcQKu0O6nEr0y2OFF1yLJ76adIZsioGuOcCAYSS/OVtwj8ELYsJ/HV7PJHieaQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079640; c=relaxed/relaxed;
	bh=YNOjnLRACDOPWRZKVVKbg9U7d4b+QVB/orVEDglJFaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hG6JpgiEZ52LWhs6BgBG88qOTvBVl0w2lvInqXxNKWiNiF052DYG/nulX7/Td39cGEXP9XHxmyhUZ2tz7bpci37MPqTDh7qngublJQBisunMYM5oZL4P4u0tPVCjioC/puWWpHIwsxscDYyfZwRRnj9ZnG3sP5bpVcegK99XSXSoXNtvOa/psMVpH5ucsBj4zcfhgCEcsQJRxpQgnlgRCbmYlR7mbwfKnmgg7TTT/jzPS0Jm++m/HoiWRklfdMaDfUxczymLsPOD9rX88y6ufTxXyfPNG5z8svCoj/UAaCyIdzXLTz1ZmkgO9ceQXS+dBAruFe4Nm0nL9/b50gKQKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MTxP81ve; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MTxP81ve;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVng2kmTz30RN
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:13:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079638;
	bh=YNOjnLRACDOPWRZKVVKbg9U7d4b+QVB/orVEDglJFaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MTxP81veaxRXticdcirQZoVeYQf/6K29Oc8GVg15i0BLTrSDSCYMPnnBUkfjOUgNU
	 CsLtsKhqBFpBR6Szbov6sVSjZFzCvrU4AC8UwmvBXMF804+500fjOwzqlHQPau3pPh
	 0+AXXvj4F1/BNPMJo3I+eD6pMT5syY/Amujjm3goVLaxbIVCypU3ehCNQTDbGft0Xj
	 PdnL957OzqylE/UwX9P5AbnYdbXkNbRr6BC3pqG8tWkKGd0fbAmmuJVNmpVit2gkQC
	 3cbLtHQXuRZf46nXMVaHtQPc5LaEDZ3Gkh46GZXZveQ4g9BTdOKGYgIvYVPR2bprHB
	 RFw4Jbf/9Kbhg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 837D668818;
	Mon, 16 Jun 2025 21:13:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:38 +0930
Subject: [PATCH v2 01/10] soc: aspeed: lpc-snoop: Cleanup resources in
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-1-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
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
Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index ef8f355589a584d76bfac2b130ba9965c9b06ba5..59c18afa649cd672f54f947066f468f2a78c0d5d 100644
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



Return-Path: <linux-aspeed+bounces-1174-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24E8C369A6
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqt72dtz3bnJ;
	Fri, 11 Apr 2025 11:09:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333754;
	cv=none; b=FebgnF0JZzIKZjCiP3rEASrTzrC8XXMqMOwd0xP6kK7onzAYc7uPxhF1LaPLwJC0wiZd6jTMma4snFGiXCCUOikd8ZbucEntIC0a/qC52WWO3EtBIZXQoYuK6mVjfjtSBCy8Poe5oGTKm/jpR0pjDaEqj7FIsBLLIFuzP3dBC2jcve/IavHnHaINV0Ros02zeOIqybrO6rLedd9mLOI2jsS9bwKM6hXkocegSR7T3qOHkY2BqR3510B6VLEWl40JjFi7xqePxpqr+q5vTYwLZjyFTeomC+DasftDWow+xLdL3Hv5QHhZK4j/zSpOCIQ++QMqtN09axqFsW0pWdvvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333754; c=relaxed/relaxed;
	bh=BdcEfSnP4+tv/vsPgvq3tc45liclW2ZxqOGrHE4nuw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPgayY+ButhxVqmyVNUm595yp6VUhgj2cE1SMlaStYy/yy6IGpMNZ+v4zEgjB6omYV/TLVAstKt7OYCm5yxNmRTUBLd2Y/d9XBc8X7B291B6koR1Qeq7TyVqqTA2/7688qCxxxpPzH9N0Z0AKJCQMVM4FXX8W9DUsT8Dnb7GiEy69VNT9CXa6tVBRhV7VHLq2f3LUZMJ3JXJN4/8vP3Z9tF20Q2mKlh8fyKGDYn87G5CHoCUZFpdkFJxZDEgJh90HFr8rJjsbaLkRn37Igo9RVN3XNcpARMYtlRIaxzdhM5/eF5c8wC6IrwgQwhan15W+P7Ztv/MXR3qqPa2Ei7XLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=keDpANHK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=keDpANHK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqp2nLVz30Vj
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333749;
	bh=BdcEfSnP4+tv/vsPgvq3tc45liclW2ZxqOGrHE4nuw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=keDpANHK5Ihkfq6mIdraefIFVCXBZmQaUdK5Fm8TUYv9xq9zgg3c81wcxXx4LOEIU
	 2OHOgEqsATY6Jve865aE91SfJAU2hNcGkXLPFyRh9+nsaUJ3IWdJlyXzfiC5efcIRJ
	 beJRP6TqpVl3Jnx4Kja1zIVh4+D7t5Kbz20yWFhpPfPdaTI7MOtLu2ypM5EHh0HdPj
	 lgUHUuKOhmHsvJ0lox9ylWR14nK7Ss8nWuFmEG1Xy0NywJcCfmrHdRlTW6Ku4TQdUb
	 0j8P521B/ZwEcX88/axCjxsw49SgFChKEVLLAI09l/M7JM789vmSZ6I/PuS0ftp6ov
	 4wIS31AIIXigQ==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 77A017D710;
	Fri, 11 Apr 2025 09:09:08 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:32 +0930
Subject: [PATCH 2/7] soc: aspeed: lpc-snoop: Don't disable channels that
 aren't enabled
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
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-2-64f522e3ad6f@codeconstruct.com.au>
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

Mitigate e.g. the following:

    # echo 1e789080.lpc-snoop > /sys/bus/platform/drivers/aspeed-lpc-snoop/unbind
    ...
    [  120.363594] Unable to handle kernel NULL pointer dereference at virtual address 00000004 when write
    [  120.373866] [00000004] *pgd=00000000
    [  120.377910] Internal error: Oops: 805 [#1] SMP ARM
    [  120.383306] CPU: 1 UID: 0 PID: 315 Comm: sh Not tainted 6.15.0-rc1-00009-g926217bc7d7d-dirty #20 NONE
    ...
    [  120.679543] Call trace:
    [  120.679559]  misc_deregister from aspeed_lpc_snoop_remove+0x84/0xac
    [  120.692462]  aspeed_lpc_snoop_remove from platform_remove+0x28/0x38
    [  120.700996]  platform_remove from device_release_driver_internal+0x188/0x200
    ...

Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
Cc: stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index bfa770ec51a889260d11c26e675f3320bf710a54..e9d9a8e60a6f062c0b53c9c02e5d73768453998d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -58,6 +58,7 @@ struct aspeed_lpc_snoop_model_data {
 };
 
 struct aspeed_lpc_snoop_channel {
+	bool enabled;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -190,6 +191,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
 
+	if (lpc_snoop->chan[channel].enabled)
+		return -EBUSY;
+
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
@@ -236,6 +240,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		regmap_update_bits(lpc_snoop->regmap, HICRB,
 				hicrb_en, hicrb_en);
 
+	lpc_snoop->chan[channel].enabled = true;
+
 	return 0;
 
 err_misc_deregister:
@@ -248,6 +254,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
+	if (!lpc_snoop->chan[channel].enabled)
+		return;
+
 	switch (channel) {
 	case 0:
 		regmap_update_bits(lpc_snoop->regmap, HICR5,
@@ -263,6 +272,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
+	lpc_snoop->chan[channel].enabled = false;
+	/* Consider improving safety wrt concurrent reader(s) */
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
 	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }

-- 
2.39.5



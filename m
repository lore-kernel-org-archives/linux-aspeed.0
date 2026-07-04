Return-Path: <linux-aspeed+bounces-4353-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19676C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSF01pgz2yft;
	Sun, 05 Jul 2026 15:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783167894;
	cv=none; b=QVIJFbPFe+Ucm5ERWpdttrHgcdNV4NwbJBuhDBenA2JiM12jHE8cdsQMrCCqfqQVgWd308l81MrGL9QW2R+9AL93uzCUhRYj0K/uQ+BHIC5VJSvHrbjVzr3ugQ+zw4ANnTRdiOTe4mefVM9nRvOEdKCbHXU6tmjvu9f9t5QIt3bl3/ukAwGuB3xvzKDzhH7Ls0F3DGTgwgXdXl5pLl9LMiUcEIj9UCUFaP1tyV8qyYy9cXkeXHiSW8fwqA3rw+x8hI12eXTcjGSqNmHLuRkB+Os7/CgXw/zJ5+UlrRK4HZRaptLYjHWviCyVYj94ZGPglAaQjBxhoOIxtWPQEYROlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783167894; c=relaxed/relaxed;
	bh=YGUzS5EEk9oYgomVDxNFYWtSRReq+dhqjF31HvR4HL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1Kb9F3zFa42UZQm8c0aJzmi9V4gHCVVGd3PwKKHCnfu6KrroU97P/9frEFogU7VEe018KQNN0hp+toC/CFAKbPYL0fTQgA0D4W3CC8q898mV2u5w8PZZMr/6vADuvZ36d5VWZQ16TxhJfs47Bj4exgiJbSg/TDy9fzXs9dNgr8WJk7kAbKDUPjcncWe7Cce0KzxiatCS08Mvtm1HzU9Pye2PTNP8JTRyVWx0dsejU6wJTXZn2CtVEv2gaIF6hhmuYZ5fv7YswbXYKahScZgCdFb7vFEWt8lTB54LxXOQ/F/wxk8uwzz8j7ODWLRCopNCYjszKeVLUd1gfqsi3qbdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsqZF4Ls6z2xPb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 22:24:51 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABniN+M+0hqMhbWFg--.11476S2;
	Sat, 04 Jul 2026 20:24:44 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 20:24:42 +0800
Message-ID: <20260704122442.85499-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABniN+M+0hqMhbWFg--.11476S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45uw1rurW7Aw4DuryrtFb_yoWkAFgE9r
	W8W3sxWryUCryq9F12yrs3uryS9a4Dur1kKF18KF1FvFWUAr9rJFWkWwnIg34UJrWxtFnx
	ur1DXr13Cr42gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUBT5
	dUUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has an OF match table wired to .of_match_table, but does
not export the table with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
information is generated for OF based module autoloading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the platform driver, and the missing module alias publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index 0191e36e66e1..b4b521b5ddf1 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -582,6 +582,7 @@ static const struct of_device_id aspeed_uart_routing_table[] = {
 	  .data = &ast2600_uart_routing_attr_group },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_uart_routing_table);
 
 static struct platform_driver aspeed_uart_routing_driver = {
 	.driver = {



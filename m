Return-Path: <linux-aspeed+bounces-2535-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99770CCD193
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 10:17:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqrw40nXVz30Ff;
	Mon, 20 Oct 2025 21:17:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760955460;
	cv=none; b=fWaudwMd9jXQC8VPAZvV/ndO2OcrN12ej2ci2nYeyiRI3ZxVtQ0AQzQlT4Tecx4dXLQbFvjnySVeUXurEOdOjW8TC6Fi4GjHOaWH0KmzIcwHz+SiUp7eE5KQ6YG7FWX098pGUcHw85nqB18KSXLgh3h6BCIzCCQcQv9X2+8rXS66d5SvSQ/SousW8s6yY5ajlkJaQqHniMVTrzpmVDgU7eEkp98pfC9pgApYAY0n0E7isN3cPTJnTZLm4eZltIb08u5hpZk+iWsIKuuYVXbMw1YL8EQZUTMmZLl84xeoxoS7CDq9uomsyPE3LwJ6FVFPLENkiq32a/5ZtuoJEdfheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760955460; c=relaxed/relaxed;
	bh=tBfnaIFfXFUyw9gmo9JBhlQPED6cDEu7l8Hb4rXpNDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFegjO58X/o4AFWtqWM9LnwoYYQLsmUmjI6XzSlqFaMdcFpXRwvDybQB9FnL3Tlq8qTyXPOuriXpsmXCKOJ1pw0EVmSjK61aJkFVDzLPcgCtEcds8w2H5y437KRrEg2i8rNnTvT52LAAjx9MBxQzCsE8N1rIkN88pjk6AewuoozZJjf6wByXvTh5bxanVVY8SFQbWtFQ9vcnfgkSfv1HzTfduke3LCXZVEQV7NlD4oGfchxw7pjxRsbsJwTVh8yI0EAPXMon2/1Q5vSDQ18A3dHmlwa1rZW6iAg6rEq6DgIXoQqmfHBbrFi78JCjQIWeIW4yBbGCkx4ODw7P86uJbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 352 seconds by postgrey-1.37 at boromir; Mon, 20 Oct 2025 21:17:39 AEDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqrw30sVSz3000
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 21:17:38 +1100 (AEDT)
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADnPaDLCvZoHdfdEQ--.2307S2;
	Mon, 20 Oct 2025 18:11:23 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: neal_liu@aspeedtech.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] crypto: aspeed - fix double free caused by devm
Date: Mon, 20 Oct 2025 18:11:09 +0800
Message-ID: <20251020101109.1030-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-CM-TRANSID:qwCowADnPaDLCvZoHdfdEQ--.2307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18AFWfAr4DKrWUZr48Xrb_yoW8Gry5pa
	yrJ3yFkFW7JF45GFWUJayvqF15J3y5t3yagayxG3W7X3y3JrnYqFZaka1jvFW5AFWkuF1I
	yF4DJr1UuFn8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVyDUUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4BA2j12CK++wAAsn

The clock obtained via devm_clk_get_enabled() is automatically managed
by devres and will be disabled and freed on driver detach. Manually
calling clk_disable_unprepare() in error path and remove function
causes double free.

Remove the manual clock cleanup in both aspeed_acry_probe()'s error
path and aspeed_acry_remove().

Fixes: 2f1cf4e50c95 ("crypto: aspeed - Add ACRY RSA driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/crypto/aspeed/aspeed-acry.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 8d1c79aaca07..5993bcba9716 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -787,7 +787,6 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 err_engine_rsa_start:
 	crypto_engine_exit(acry_dev->crypt_engine_rsa);
 clk_exit:
-	clk_disable_unprepare(acry_dev->clk);
 
 	return rc;
 }
@@ -799,7 +798,6 @@ static void aspeed_acry_remove(struct platform_device *pdev)
 	aspeed_acry_unregister(acry_dev);
 	crypto_engine_exit(acry_dev->crypt_engine_rsa);
 	tasklet_kill(&acry_dev->done_task);
-	clk_disable_unprepare(acry_dev->clk);
 }
 
 MODULE_DEVICE_TABLE(of, aspeed_acry_of_matches);
-- 
2.25.1



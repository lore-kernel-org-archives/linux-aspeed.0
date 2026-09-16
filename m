Return-Path: <linux-aspeed+bounces-5015-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4369DC88E77
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 09:48:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlDbH1W5Vz2y2W;
	Wed, 16 Sep 2026 19:48:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789552091;
	cv=none; b=oyfv086RWFYcy/ONoRjLovNqgnuI4ALvpbSE0yElaw7g0M51rW3agkr4vYT0DYdYoArcbpvJOvVPjPwOiUDOToV5Fi9YypMF/tkru5HduQaGvrzXIly5l/gAzpmHxdhYtUR+ivRHSbkQzYSCq1csGL2e4QW0iqxP4dNB+x6zpiRMHaByeDP7RSHAV+rrwml0hSrkvpQ68SIDDd+cd/EgA1vMaLKCWOWBtT5ZDPh1ZIPMOew0IuoCBvwRwEZDxOFWKP6ovzeHHkSgWz86XUZKzeQZp90oq6NPAoKIt3dsBHLQ8RvTG1FCaxFrw8mXVtURW7XLK1TbS5vnqJkoIONKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789552091; c=relaxed/relaxed;
	bh=A55i9BfJHMidgmc8tK5EfrQXSsHaTEHchuqr258s9DU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DtoalqLjTavJzjsq8BtTwRAgwQk3pQBoekeLXXRvM0HKTPuJQqvfkTxXeQjFG699PRBAX+NfHH8R5qD8ZZwDO2N+Ttj5Sq651jKqt1a5NtM1gqmvceqL/MGsz40WNfC5F9pby/mx+VD2fyGyTvsG6mbq/Dgxoabjdto7QZThgDV661OgBcuVvA1gEaPhcKsooD05yLqUEykenrEoZQPt6gIi4RBaYpmaAGAr7FJ7omHIGX3wyv00IJeefNtCcXZl586+0O/xDooeTU5FCSAoQzsl5whg5aaOix2KKe5CmO/g3quRjhTSCanwPjRqXAv6RRi66/wUA89kaL0xctaTEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 500 seconds by postgrey-1.37 at boromir; Wed, 16 Sep 2026 19:48:10 AEST
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlDbG2KSmz2xYh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 19:48:09 +1000 (AEST)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkDeY6pqGorgBw--.1498S2;
	Wed, 16 Sep 2026 17:39:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alistair@popple.id.au
Cc: andrew@codeconstruct.com.au,
	eajames@linux.ibm.com,
	gregkh@linuxfoundation.org,
	joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-aspeed: Fix of_node reference leak in fsi_master_aspeed_probe()
Date: Wed, 16 Sep 2026 09:39:14 +0000
Message-Id: <20260916093914.2005582-1-vulab@iscas.ac.cn>
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wkDeY6pqGorgBw--.1498S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4ruw15Ww4UKw45Xr1kKrg_yoWkGwcE93
	W8uF93JFWUCFWkJws0yanIvw4qkF9rWFyxKrZ7ta1Sg34UZrZ8JFW5Xrs3Ca17WrWxJFWD
	Ar1DKw4rGrW3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqPpSecAAAsO

In fsi_master_aspeed_probe(), a reference to the device tree node is
taken with of_node_get() and stored in master.dev.of_node.  If
fsi_master_register() fails, the error path frees the master without
putting that reference, leaking it.

Put the device node reference before returning on the error path.
of_node_put() tolerates a NULL node, so the earlier err_release path
via opb_readl() is unaffected.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..7c7f30c2b8e6 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -640,6 +640,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	return 0;
 
 err_release:
+	of_node_put(aspeed->master.dev.of_node);
 	clk_disable_unprepare(aspeed->clk);
 err_free_aspeed:
 	kfree(aspeed);
-- 
2.34.1



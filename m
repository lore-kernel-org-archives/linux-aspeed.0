Return-Path: <linux-aspeed+bounces-5159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF035CA6015
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 04:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1D5v6q8Nz2ynZ;
	Fri, 09 Oct 2026 15:14:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791519283;
	cv=none; b=bdAoeneo5VqOhZl8IIbJ17vgNm7E2EWsk278Mr3gduVyhR2TevJiMo177F+tocB6DezTcKk7Y226GoFL56IcyIbsAiA8IahgcghkUV5NdafelHTdCDKdTxuQpEQNpUIdzFreTLUVjHDiBGdr6rMjCNujIccagWEtZ3ShEfMNg5v+ZCevuVl2M7c05BXTgU6TDMFUj59SszamyKB152OQWt8KUrPfDgro2ZYkvIzXMXLz4EyGrq04EyIVsObNrQIiSuLmXS2LJWisJGKUu/OMSoKg4jqfC0lkjTVOHDRzZPahdSDYynu98R0ZvUD0saucAPlYryDXhGqQGp2doXD6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791519283; c=relaxed/relaxed;
	bh=iaR7ye7e54dzT/PblXMczFnbDZoSyGAO6czW4k7MpSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7g97VZJP9p4iy3FSeS5gfZbc4Cs0vw1XFMm/m/yy0KrUVd8lEsMvEYcO4wo1Yr7bBdD+M6rAkYIgXi8Ir2Yuw1AK1kn9/zN3p7glBkGlJ8GhGNBa1zMUNyAraqTBwWKqvJrCsiXSF1CBIR3Kq4zaMgE10O5+NJTpPSk8lK2+J/7MbQ/SYRo2gYEBhscrltRg36XcwRNIdxtmKxijecWJNoLeqsMxSxRDJYEwEyMjExpA8nZwZ45NCrCfz49hrjCyCab6f2xEhDnIHk5As8EPICUeVS5+Hh9pz4UgV+NYcsHFqQVUYbPfV8QXNNDzPtHXG43mo/odsq5zSGT/C4FZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1D5t6McQz2yTH;
	Fri, 09 Oct 2026 15:14:42 +1100 (AEDT)
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXljQoashqx4wbCg--.48197S2;
	Fri, 09 Oct 2026 12:14:32 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	"Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc: linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: aspeed-g5: fix device node leak on LPC compatible mismatch
Date: Fri,  9 Oct 2026 12:14:35 +0800
Message-Id: <20261009041435.3096107-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:rQCowACXljQoashqx4wbCg--.48197S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1fKw4xAFWUGFyDZr18Zrb_yoW8Xr4kpa
	y3WFWYvr13Jr4Y9rW8XFy0gayaka1fXrW5Ca97K3srZFnxtryftw13KFWjqrs09rWkA3WY
	qF1Uta4Durn5Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07b8kskUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQPA2rIJHz+tgABs3

aspeed_g5_acquire_regmap() takes a reference to the LPC device node with
of_parse_phandle() and then returns -ENODEV if the node's parent is not
compatible with "aspeed,ast2500-lpc-v2", without dropping that
reference. The function is called for every pin configuration, so the
leaked device_node reference accumulates on such systems.

Release the node with of_node_put() before returning from the error path.

Fixes: eaffd32bea0c ("pinctrl: aspeed-g5: Adapt to new LPC device tree layout")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index b0cba0f3e17e..6ab3ba89bd54 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2652,8 +2652,11 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
 		np = of_parse_phandle(ctx->dev->of_node,
 					"aspeed,external-nodes", 1);
 		if (np) {
-			if (!of_device_is_compatible(np->parent, "aspeed,ast2500-lpc-v2"))
+			if (!of_device_is_compatible(np->parent,
+						     "aspeed,ast2500-lpc-v2")) {
+				of_node_put(np);
 				return ERR_PTR(-ENODEV);
+			}
 
 			map = syscon_node_to_regmap(np->parent);
 			of_node_put(np);
-- 
2.25.1



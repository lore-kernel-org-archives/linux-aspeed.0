Return-Path: <linux-aspeed+bounces-4877-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C13EC61DE2
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:46:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY80l68dXz2yCs;
	Mon, 31 Aug 2026 09:46:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788095174;
	cv=none; b=ODTpsgacFQ2RL7G2NTvg7+J6ojsUxisTdpEsgJMoGLiWwx4acvWIwWC4zuvHdL61fJrlAndlqAxwGwneZzINe/Ok41GPYVc/EnH+IDSPJqOuySSOR5ZL/4mTvOqgAjKTt29orUJga5hSueY5GWdUzElE+hOhuXVp1s/w7vxTOANzd5VNVksULe6Yww4ZdaPW1/VIuyzpvB6TYisnlUTqFMXqDC/HlK4Yl0gMgy9fKriw+q8EgkPFLJ+mT2Lspphwa8pgAgWBd2mr307UZgDq4VLMgy4RsdsWC9yk8mX+/OU8SKsIYAjI10Dw2mClRa0lnZLHY80IzHn/3ssbYWmGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788095174; c=relaxed/relaxed;
	bh=jKB91Fij6drewQFiv4G9toC8JIKw8NtMNFmKj8lVYwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANO0HNwHOfiYU7HDwegKMh6mURnr66pIlAiW29a3yB1yobwKxWncppU+7aEV69k58tH7yJCcyPRSDlJ+N1//ntA34cYcC3gVQz0qbUfqw7m/pTaMJs1wNmTxaB0+BCsvq8ohY6hRQLBVMYd/pPdcE1a2Vm8DMZ58Aa+PLSuvJKkGIVSU9ICt7QgZZ8WsjBNJzixpFw6l6ZY8KCBfgzwfkaoN31F2CLmTNHlnn8slIXzInsxNZgtp6hgFoZsZj4SsD0KF+kMyVovPNucruHfisMCW92oVbfYrWCHPAE++jiGWn9UTU0lL1SYa+mF/cyr/Gs9VkUHQu9TruxjduSJqzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXsnd5NXpz2xT6
	for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 23:06:13 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAAXGzm6KpRqe9GaBg--.26886S2;
	Sun, 30 Aug 2026 21:06:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: aspeed: propagate reset deassert errors
Date: Sun, 30 Aug 2026 21:06:00 +0800
Message-ID: <20260830130600.560-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAXGzm6KpRqe9GaBg--.26886S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DGFyxKw13Jw18GF4kZwb_yoWkCrXE9F
	1kW3ZxXrn8CrZY9w15J3y3ZrZIkF909F1kW3WUtw1SkFyjvayUXF1DZr95Ar43Xr12gFy7
	u3WYvr4fAwnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

aspeed_i2c_probe_bus() initializes and registers an adapter after
deasserting its shared reset, without checking whether the reset provider
accepted that transition.

Do not publish an adapter whose controller may still be held in reset.

Fixes: edd20e95bca4 ("i2c: aspeed: Deassert reset in probe")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a26b74c712061..bf29719bab1ea 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1023,7 +1023,9 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 			"missing or invalid reset controller device tree entry\n");
 		return PTR_ERR(bus->rst);
 	}
-	reset_control_deassert(bus->rst);
+	ret = reset_control_deassert(bus->rst);
+	if (ret)
+		return ret;
 
 	ret = of_property_read_u32(pdev->dev.of_node,
 				   "bus-frequency", &bus->bus_frequency);

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1



Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E9606A32D
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 03:59:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKBWw5WJKz2xHG;
	Wed, 04 Nov 2026 14:59:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793764748;
	cv=none; b=AsqvPDsnI8x2iAjbTcpTzMbDDTsx/Lb2b1s+iOMsIQU7NOa8FvbK61Yl/IehDqu9V6rjzq56+vneF1a5j806VleMeeXVwU4YRfi5VT6CJXwanOn80YhR9yXedIy1wMdg5srybk/4irz//7qxWJ3cPolyrH4XflG5VQo3pz+ZejSiiSIK7TZV2wS4ZZd8XoNAQ88m9nlvE7jgayW/ZN72h4qWxIlKx8SAmLL87BDnJ/oRT9IVcYS7trmUYqbecyV2DRe/LeFBur1KLUQL4BR7OxeN/Cf8ELyygMkQvigsVockCiNr5bQzg1SKWi3egHY/1qASRx6M6xREDNwvUsDs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793764748; c=relaxed/relaxed;
	bh=SO36a9ub9Qx/UKW73LBbXZKVdS501hGyizN5TKPiU5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OtjrStdnsZ6GzOezrFULrh4UZ+UHfOZviZJit3mokzPA9NksyUB80ORQGytxAU729TQS9fz9sdcfj1LyLbtvYwuZAqWq16wM95b7/4qnCvpUSu6sEbcMWJyM2dz+rnI9pO++SlhO4R772kNDrs9gLiHa5Im7Xltc1KfpYud1Kk+zjg8KOMgGuvAEMMwKrS1pvgpJAe3nSVqmNgd3zc4amXqd3hLLbcaLa0MvWWrMhWkRupKtpXjIHKx5yUuKmwbB3wugeGAODH0AYINlwTU/Uo0X1GQemG0H8/LazySjKHWUVB8oVnst+hEnE8ne0XMMqD+8rPJHdpHyeXuMo5kScA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKBWw0500z2x9c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 14:59:08 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 11:58:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 11:58:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 4 Nov 2026 11:58:36 +0800
Subject: [PATCH 2/2] gpio: aspeed: Preserve the pending G7 interrupt status
 on control writes
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1628;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Fnj2zvHZ9ECX/p3mEpqFA6hScNcf6xsh2LB1gDUZzP0=;
 b=nImNT7EHh4sK2dh50Xr8PxvYhqt+V8ubRfexjyIzDbgkEfG4NiobJ4sjZ3lCDSEWYoMlbtNTs
 f/8oBGptk7fBi7v2A+6wjh+ZNQGytcEIKQAVLPCnybfMuwWaKKhGMO/
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On G7 each line has its own control register, and its interrupt status
bit (bit 12) is write-1-to-clear. aspeed_g7_reg_bit_set() updates a
field by reading the control register, replacing that field and writing
the value back. When the line's interrupt is pending, the status bit
reads as 1 and is written back as 1, so updating an unrelated field
such as the interrupt enable, trigger type, direction or debounce
selection also clears the pending interrupt.

Mask out the status bit when composing the value to write, so it is
written as 1 only when the status field itself is being set to ack the
interrupt.

Fixes: b2e861bd1eaf ("gpio: aspeed: Support G7 Aspeed gpio controller")
Cc: stable@vger.kernel.org
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2482f2ff735d..6e834e83915b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1168,7 +1168,13 @@ static void aspeed_g7_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
 	u32 write_val;
 
 	if (mask) {
-		write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
+		/*
+		 * The interrupt status bit is write-1-to-clear. Keep it zero
+		 * unless it is the field being written, so that updating any
+		 * other field leaves a pending interrupt latched.
+		 */
+		write_val = ioread32(addr) & ~(mask | GPIO_G7_CTRL_IRQ_STS);
+		write_val |= field_prep(mask, val);
 		iowrite32(write_val, addr);
 	}
 }

-- 
2.34.1



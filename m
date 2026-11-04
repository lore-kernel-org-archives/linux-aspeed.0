Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F78606A326
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 03:59:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKBWt63z7z2xDD;
	Wed, 04 Nov 2026 14:59:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793764746;
	cv=none; b=gXuTyuQmXcIChpivf1W/fz+FB++BVLloTc3DIayAxe6LcrWsrTV2gbqOldr3I88/q/ZXRDpl5QGSkaUIpdiaI+uNoay61DnijvmsScBkuOw/t2OEh/tuTuuiWo5yk68xrPqatn2hgp5mmRiiQAVIWVgLFRXAguPoOoMD6nETnqZhqzRUNlhqv2yLAWuFOf/0KJ5cRJ9VBOJLautvYH0Dor72byjbMN8Lw9HS7ihcpiNm/oPty2rxoHMwPA37KQKaoZUbK+5KjmnF+O7nAfTZXeHqaTcMg6LyIeOmVSWeVx822kyvSu6BWMrg333Oj/3S5DlYfl77qzNSXDlpKsOEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793764746; c=relaxed/relaxed;
	bh=QWbjlLOr+8hkpwlUSwLszIplc2RXylAKoniq+0KkMAI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fC6QALYzLaurSnUfKPkQo0Jkb3hkUrCP319D/rUgqqgFn5JwG1T3VVvuUrGO1djfU/ZRZD/VJtSXmHlY5NWhxuxl4+7vvMH6VdQACYiSDRc7dwwX1hdbq36d49cl8+kxth1IERY5+QNHEKSinfI5PMAqH/5ovAiNwX22rQCevw6yhnITjLc7Q+dqAipcFXGioVb2/Axms0gWjkgvIaogq+/lTCQxQ72bXmnRzpDZ9SDLm7undYlXXkDEy3DI6XsLWQChwzhw86R2t1RtfQJX3C1d+rwTNC5ycx0dJLRhJuUlzaS5zNInVM6RpjzOynBopo8e2nfX2IVNIWn3xRX8MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKBWs42Xgz2x9c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 14:59:04 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 11:58:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 11:58:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH 0/2] gpio: aspeed: Fix lost interrupts from
 write-1-to-clear status bits
Date: Wed, 4 Nov 2026 11:58:34 +0800
Message-ID: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAGqt6moC/x3MMQqAMAxA0atIZgOmFAevIg6lTTVLWxsVQby7x
 fEN/z+gXIUVpu6Bypeo5NRAfQd+c2lllNAMZjAj0WBxLZLRaWEOKHVHPdxxKlL0hpzlEH2EFpf
 KUe5/PC/v+wEVUbMRaAAAAA==
X-Change-ID: 20261104-gpio-aspeed-irq-status-1fc21a4edfcf
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>, Aaron Antone
	<aae@amazon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1310;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Spxhcm05RN8n5Sh9TZW9A+mV+AO88j/EoIbdaSDAC1Q=;
 b=8g/Xu7pU2y1fekmgY5p4e8m8VTtBLtTYoqVWdQqsYQcNcbyBEVhAedQYqRNqcERFOBFSADxdx
 TTpXNzDJzH2DlwXjM5x/4B7aOHlLrSzdi4D7Qkn8sa3pN1cll6XdZ9m
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Aspeed GPIO interrupt status bits are write-1-to-clear on every
generation, but the driver updates them with read-modify-write helpers
that write a pending status bit back as 1. Each write therefore clears
interrupts that have not been handled yet.

Patch 1 fixes G4 (AST2400/AST2500/AST2600), where the status register
covers a 32-line bank. Acking one line clears every interrupt pending
in the bank, and an edge that latches after the handler has read the
status register is lost. This was observed on an AST2600 BMC with two
lines of the same bank toggling together at host power-off.

Patch 2 fixes G7 (AST2700), where each line's status bit sits in that
line's own control register. Updating any other field of the register
while the line's interrupt is pending clears it.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (2):
      gpio: aspeed: Clear only the acked line's G4 interrupt status
      gpio: aspeed: Preserve the pending G7 interrupt status on control writes

 drivers/gpio/gpio-aspeed.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261104-gpio-aspeed-irq-status-1fc21a4edfcf

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>



Return-Path: <linux-aspeed+bounces-4515-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CDCC44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 05:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4jzn3pypz2yQJ;
	Wed, 22 Jul 2026 15:51:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=57.103.68.94
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784698784;
	cv=none; b=ZaDr2UdZllEovCX4AdIG/WX3pdqcJm6p/e2M3kUKtFVq4Q45cr+nuyfMotq5BZTlfINTMtFgP/i9+7vVm4t1r6rFCQfQudQBpVCIvqyVtLtgRx/htD8SnL2OVe9AcOeaBRnPv76Zrb5YTo1tzeqMrGf7idehtKnPQMa6AUdWXix2ttW31aUwfHGS4HEPDjhAcMNqUXHthZlzqglbd4ZlxclGuCiQMKoyXUuPcZBLztYh/gfV1UtbBpZ2EghavUVoA9c5lqKVHEKLukN7FgALbPpaijZj5Y7rXn8GZSojol0W3S5mNXBbt6p+bPpYTdjMU6bAxF4jGTjRvs5yTyzxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784698784; c=relaxed/relaxed;
	bh=Rjd3OYJXvVUB836JkPfsptYMzK6SUIE1DBVNBT5xJ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIA7EQj/dQ9In1pTNxTl85N2nrVcWP3MAKfHW4eTQbvdFTLWg0vM1jbzyyswv9myeuesqT2Ucb7jgyLiUBhlKN0tNxYof6CgJskv5qIoBhzaxs+IErrsNEnXyOdhQze0JOCHE8kzI561Fzz8F4Gxwgfnmp+WM2ambEwqQuw6EK+ARY6cKSwuJ1pc55cN+sdEzDRP6onEGZoch6VLb7SzElcjCA3s6BSXB5JMUr/WC0iEijT5m2iPKnbh6RAuxxSyjpAAGzvxoh8EGVBU+jNxmGTXeSBTFnSjHGOWxOSEcpBJYiSVSbVVDbpsYF5rjaT8J21OjkwkfGJatfc9MoevkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=L5cSVSxR; dkim-atps=neutral; spf=pass (client-ip=57.103.68.94; helo=outbound.mr.icloud.com; envelope-from=michael.pesa@icloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=icloud.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=L5cSVSxR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=icloud.com (client-ip=57.103.68.94; helo=outbound.mr.icloud.com; envelope-from=michael.pesa@icloud.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1800 seconds by postgrey-1.37 at boromir; Wed, 22 Jul 2026 15:39:42 AEST
Received: from outbound.mr.icloud.com (mr-2001h-snip4-1.eps.apple.com [57.103.68.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4jkQ6KWyz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 15:39:42 +1000 (AEST)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id 9DBBA180016B;
	Wed, 22 Jul 2026 05:03:03 +0000 (UTC)
X-ICL-RepId: 019f8834-b567-74bf-bac7-ccfb693b6d82
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBAHVkPRQNJDVYCWw9LVxQEFVoOXwpXHBcIVh5WK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUGTV8OXh8EF0YZVQRHHl1WXh8ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRADkoBXQJbAEQKVgFUD1gHRRRJHgBeCFoRXBQdHVIYUzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784696586; x=1787288586; bh=Rjd3OYJXvVUB836JkPfsptYMzK6SUIE1DBVNBT5xJ7E=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=L5cSVSxRP3M8kkseEPf1RgIi0TeB0IE9nFznP2UtQOYztdkgYy718XXPrfWNNtxFBAqydtY9RSHbgS3jPX9ZDTv2LFBbtnrhdWv/zP6N3pKRBo5kfBQNd5B41yNe5B8dBRvyx+Y8wfv38tyF2ogBTba3jHDjmxwPuxr63/z1ishF6wEZ4lJxjG+O+Dlg4DURc1VtBwaSUuPYIwe60TiJJc5ilvjr8oyejTx3z/YZ+5/Pl2un8sJt3gKJldgPMV4BVBjJW2yWzeySaCbOhJZ5/Ey/11WhKfltoUyvqI1Ok/eKpgPcCBVKVV5CMvLrauY5NGWWDjmkZ9Q5m0++RNjAqQ==
Received: from toolbx (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id 67AA21800184;
	Wed, 22 Jul 2026 05:03:02 +0000 (UTC)
From: Michael Pesa <michael.pesa@icloud.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	Michael Pesa <michael.pesa@icloud.com>
Subject: [PATCH] irqchip/ast2700-intc: Disable all interrupt merge banks on probe
Date: Tue, 21 Jul 2026 22:02:43 -0700
Message-ID: <20260722050243.298355-1-michael.pesa@icloud.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-GUID: npz9HAn1uUggcMmIPu_WheSA3FZLkeQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0NCBTYWx0ZWRfX6CgsJjbNu/Wq
 k17nMTbNz0+foW+37Lm6ZYjHqCeAX7Deuet3Fev30zJ39jawzMm9B/ovGSWQAAWwiE9X4tR1cCO
 6niWKpDM1k+09/7lRkS5rmn/4YNz6ku0Wc+YxJok49ejFx4k5HTsNRcc20YbUUuRFMoZe954K7T
 wvzq4aEiKBDhY2nCYLZ9YfjwkNnDX83YkH2GIVGPlqsXOphYPj1C+FALCshfUxMzM+8bAau5Qtk
 fLJOhEf0Z2o4+qH1ZVI+4vuj8Jokb/6ao6beHihl5Ha+uDSwZMGl2Ju+OHmYQNLV1bU1RcMNQdn
 e6uFQTkhfL5tlXt8LW6
X-Proofpoint-ORIG-GUID: npz9HAn1uUggcMmIPu_WheSA3FZLkeQC

The INTC0 interrupt-merge (INTM) space has 50 sources at 10 per bank, i.e.
INTC0_INTM_NUM / INTM_IRQS_PER_BANK = 5 banks. This is reflected everywhere
the banks are indexed: the aspeed_intc0_intm_routes[] table has 5 valid
entries, and the mask/unmask/eoi paths compute the bank as (hwirq -
INTM_BASE) / INTM_IRQS_PER_BANK, spanning banks 0-4.  However,
INTC0_INTM_BANK_NUM is hardcoded to 3, so aspeed_intc0_disable_intm()
only clears IER for banks 0-2 at probe. Banks 3 and 4 are left in whatever
state firmware configured, which can leave interrupts enabled before a
handler is installed.

Derive the bank count from the source count so the probe-time disable
covers every bank.

Fixes: 07825e41519a ("irqchip/ast2700-intc: Add AST2700-A2 support")
Signed-off-by: Michael Pesa <michael.pesa@icloud.com>
---

Notes:
    Tested with the ast2700-intc0 KUnit suite (9/9 passing) and boot-tested
    on QEMU 10.2's ast2700-evb model with the intc0/intc1 stack active:
    probe, hierarchical allocation and the merge-interrupt unmask paths
    behave identically with and without this change. Note that QEMU only
    implements the bank 0 INTM IER register, so the new probe-time writes to
    banks 3 and 4 are not observable under emulation; testing on hardware
    where firmware leaves the upper merge banks configured would be welcome.

 drivers/irqchip/irq-ast2700-intc0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ast2700-intc0.c b/drivers/irqchip/irq-ast2700-intc0.c
index 14b8b88f1179..5db915570f48 100644
--- a/drivers/irqchip/irq-ast2700-intc0.c
+++ b/drivers/irqchip/irq-ast2700-intc0.c
@@ -48,9 +48,9 @@
 #define INTC0_INTMX_IER		0x1b00
 #define INTC0_INTMX_ISR		0x1b04
 #define INTC0_INTMX_BANK_SIZE	0x10
-#define INTC0_INTM_BANK_NUM	3
 #define INTC0_IRQS_PER_BANK	32
 #define INTM_IRQS_PER_BANK	10
+#define INTC0_INTM_BANK_NUM	(INTC0_INTM_NUM / INTM_IRQS_PER_BANK)
 #define INTC0_SEL_BASE			0x200
 #define INTC0_SEL_BANK_SIZE		0x4
 #define INTC0_SEL_ROUTE_SIZE	0x100

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.55.0



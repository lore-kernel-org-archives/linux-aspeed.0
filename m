Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFD606A32A
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Nov 2026 09:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTKBC20F7z2xlY;
	Tue, 17 Nov 2026 20:26:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794907619;
	cv=none; b=gqpGTJN3X8A9RmMy65SmYKyA+ntr2m4LK6yq6osHsT2dLdMWZZOGi5OpfNAKAWa8ENALhAHIX9LsaQbxV555B5Q4W/bcu0BCVfBOvKhQcIuIUvFqqZA4ncMlxahI8d9ffrWgKgRtTa3BzElTlthusIpduKrmDNP8BeXUQ0KedY42HQFwOXMdpav0VBpoNVUJv5m+Bu5y0EarPjDCoGTWjBTwO4KE5EFHdMidMX8o5DvCyiGR3nfaiE57Ejnp6N1yWIxTmQiD2KcVYI+aeblC8SGCmt9e4mtxNQr/ycOE37pYrFZPWakwp6HA7Lxhd6OwY0/BuH0I6dFYb9lOx55WTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794907619; c=relaxed/relaxed;
	bh=UU8LnXWi7SOAhTu8hL9ezXqRNkuSckzICbco40F7TEs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=djXAwt1o7r5Homae8iTS6ZluP7WrjL3+hlwUfVYss1rsoU2kP+IXAfEuo/infPDI/y8YZXEA4ZUBI/rGvmWEsACixkA+J8tqtFlfgphze+Vo+IbY2Csi9mYW82+Q9amD5SqIlb3LLhycZIYI0gaH9P5ogelE7e4VgdDStYrlMmJCioumHERJq09mKNVo19HKcyGBd7x8F+vyhsVsHUeA2heex4PuLOlemYBAEL1XN0yg9uk0qhRgyjIUjxk81pxXm5h1L0zMOi3hxNuxlZctLNXO/xvXJKkBvu+JdhdsT8QIUT5S4KJyt6yKDYvZZ3dx6924KbXWtshA0GDmm0AYvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTKB96zxPz2xNT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 20:26:57 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 17 Nov
 2026 17:26:39 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 17 Nov 2026 17:26:39 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v6 0/4] Add Aspeed AST2700 SDRAM EDAC support
Date: Tue, 17 Nov 2026 17:26:37 +0800
Message-ID: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAM4d/GoC/23NTW7CMBCG4asgrzEaj+O/rnqPikXiGTdeQFCMo
 iKUu9eBqCA1y2/k5/VdFB4zF/Gxu4uRp1zycK7D7nci9u35m2WmugUCWrBoJFMbpedggQHZJSf
 q08vIKf88Ml/HuvtcrsN4e1QntVyfAa/wGZiUBAk6BGTiFoP7bMuFma4c+0McTmKpTPgmsVklV
 hk9+a6zQRtvN6V+yaDsKnWVqDkwYeoohU3ZvEkNq2yWP5EN2qSZ3LY0f1IBuFWaKk3UKkVDqYn
 pn5zn+RfnAueLhQEAAA==
X-Change-ID: 20260625-edac-8e960e02e7f7
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907599; l=5749;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=ST0L4QPW1A8R34qKK1TI0LPc6bCG1Beinf9ovjbd4cE=;
 b=0SRJVt7ZmBC3Kk48RuhvVrTUu8AjRUM3jdXjmq9yLv4Y3n1Ltz0AHac4F6ITY/Iews1TY8kpV
 LZmztnzXsUzC80YDO21bEqBnCHNUl0OaLyZAZi28DZqDZTrFpQ6IlMS
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ECC error reporting for the Aspeed AST2700 SoC to the existing
aspeed_edac driver.

The AST2700 memory controller keeps the same overall EDAC programming
model as the earlier Aspeed BMC SoCs, but uses a different register
layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
Rather than fork the driver, the existing code is first generalised,
then the AST2700 is added as one more per-SoC variant.

The bug fixes, cleanups and AST2700 binding from v5 (v5 patches 1-5)
have been applied to the edac-drivers-aspeed branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git, and this
series is based on that branch.

Patches 1 and 2 rework the implementation to accommodate the AST2700:
patch 1 replaces the driver's private regmap with direct register
access, and patch 2 moves the SoC-specific details behind per-SoC chip
data. Patch 3 adds the AST2700 support itself. Patch 4 is Stefan's
step-down patch, amended to leave the entry in place with me as its
reviewer.

Claude, an AI coding assistant, was used in developing patches 1-3.
It drafted parts of the code and of the changelogs, and proposed the
locking changes in this revision. I reviewed every change, and the
AST2600 and AST2700 test results are in patches 2 and 3.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v6:
- Rebase onto the edac-drivers-aspeed branch of bp.git and drop the five
  v5 patches applied there (v5 patches 1-5). v5 patches 6-9 are now
  patches 1-4.
- Patch 1: use a spinlock_t rather than a raw_spinlock_t for the
  register lock, as regmap did; the interrupt handler is not
  IRQF_NO_THREAD. Patches 2 and 3 follow.
- Patch 1: drop the __guarded_by() annotations and the context analysis
  opt-in, and assign the register base in probe without taking the
  lock, so aspeed_probe() no longer mixes scoped_guard() with goto
  unwinding.
- Link to v5: https://lore.kernel.org/r/20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com

Changes in v5:
- v5 patch 2: register the ECC interrupt with request_irq() instead of
  devm_request_irq() followed by an explicit free, and keep the
  interrupt number alongside the driver's other state so
  aspeed_remove() does not have to call platform_get_irq() again.
- Link to v4: https://lore.kernel.org/r/20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com

Changes in v4:
- Put the bug fixes first: the two fixes became v4 patches 1 and 2, the
  cleanups v4 patches 3 and 4, and the bindings patch moved to v4
  patch 5 ahead of the AST2700 work.
- Explain in v4 patch 1 where the grain value comes from, rather than
  the warning it silences.
- Drop the Cc: stable tags from the two fixes. Neither meets the bar in
  Documentation/process/stable-kernel-rules.rst; the Fixes: tags stay.
- Merge Stefan's step-down patch into v4 patch 9 (now patch 4),
  keeping the MAINTAINERS entry alive with a reviewer instead of
  removing it.
- Link to v3: https://lore.kernel.org/r/20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com

Changes in v3:
- Establish the AST2700 interrupt mask in the driver rather than
  deriving it from the register's contents: ast2700_set_irq() now
  writes the mask outright, masking every source and unmasking only
  the ECC ones, and the mask is established before the interrupt is
  requested.
- New patch: add myself as a reviewer for the driver in MAINTAINERS.
- Tested on an AST2600 with CONFIG_PROVE_LOCKING=y; injected correctable
  errors are reported from the interrupt handler with no lockdep reports.
- Link to v2: https://lore.kernel.org/r/20260824-edac-v2-0-c8d8bb693586@aspeedtech.com

Changes in v2:
- New patch (v5 patch 2, now applied): free the ECC interrupt before
  the mem_ctl_info in aspeed_remove(). The interrupt is requested with
  devm_request_irq() and is only released after .remove() has returned,
  so edac_mc_free() could free the handler's context while the handler
  was still running on another CPU.
- Acquire the register lock with the irqsave variant in init_csrows() and
  in aspeed_probe(). The interrupt handler takes the same lock in hardirq
  context.
- Move the dev_dbg() of the interrupt status register out of the
  raw_spinlock critical section in the interrupt handler.
- Opt aspeed_edac.o into context analysis in drivers/edac/Makefile. The
  check is opt-in per object, so without it the __guarded_by() annotation
  added by the same patch was never actually verified.
- Return IRQ_NONE from ast2700_dramc_isr() when no ECC interrupt status
  bit is set; the handler clears only the ECC bits, so unconditionally
  claiming the interrupt could livelock the level-triggered line.
- Tested v2 on both AST2600 and AST2700 by injecting a correctable
  error with the memory controller's ECC error injection; each is
  reported as a CE with the expected failure address.
- Link to v1: https://lore.kernel.org/r/20260812-edac-v1-0-03992edea297@aspeedtech.com

---
Ryan Chen (3):
      EDAC/aspeed: Replace regmap with direct register access
      EDAC/aspeed: Abstract SoC differences behind chip data
      EDAC/aspeed: Add AST2700 support

Stefan M Schaeckeler (1):
      MAINTAINERS: Step down as Aspeed AST2500 EDAC driver maintainer

 CREDITS                                            |   8 +
 .../bindings/edac/aspeed,ast2400-sdram-edac.yaml   |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/edac/aspeed_edac.c                         | 385 ++++++++++++++-------
 4 files changed, 273 insertions(+), 124 deletions(-)
---
base-commit: 65d0a904696bae7e99a2c6eef61d4df03bac025f
change-id: 20260625-edac-8e960e02e7f7

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



Return-Path: <linux-aspeed+bounces-5061-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F066CA5FB5
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 05:15:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvjt40pKbz2yTP;
	Wed, 30 Sep 2026 15:15:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790745324;
	cv=none; b=ARQVmzUeR+dE+jLiueLAfEfKkUXRgZHlvHP7hF9ePoMAcdpX5vepBdTtQozC+BFuGWRAiywKaxf0qlqTYp89/6uknMAHH0kUL2WthSMWYrRPVUxRgGdoCMRqF7woW0qG9q+FkmUH38qYQE9ba0qRSWsgXlbTAvkntFzWt2rC1cl1GXCJr5vstZRjeYRT0JQwxHKELaKFkG/3BtJj62qa9yLrbgMrk7lihaHfE/CjhtSnN94FxLGA9xogZIkgzewQh+JnH+yQPuc5kFDCprQbVDPI7cN5p5vDwdkv4gE4jY0cT7m8LJ4aROGuvbb0zsds1lA+9seuHmmQ1gWDijjP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790745324; c=relaxed/relaxed;
	bh=eCV8x99Y4s5JRUYegYrdguYjFZI6TLQkUsdUpUbbKdQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=aPU5G5h1wCotKyAmYHdepvdNhip/06CiArvRi+M57fVIbIC/WFi20wLpEQzI3CjM5ec5QYrTh95BUa4E97l8Y7ANTISqZaLZ4plfV1Rs3aWceR1o1IvvsL22jYVn6RVNWxbd94OzN49YOumJtKfGAO2S7ybuGJpj84oyFoObTg37rw93LKqv3MpMnFiYBoEOqfmo+a5bxWLbU29FYGsNaUzuTmE6zB1Ti3rPRlKVTYfHmL4bMG9BB9+SCKymkO3E9LwOy7CPvdEetpPuSKB6ZwKIKjqy4qQLEQaAZA8ZBQWCQdEsEJfmV411ZeCL1wBXuJ0DrUoW1/EtHJol8Xqh3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvjt25bc8z2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 15:15:21 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Sep
 2026 13:14:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 30 Sep 2026 13:14:59 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/9] Add Aspeed AST2700 SDRAM EDAC support
Date: Wed, 30 Sep 2026 13:14:58 +0800
Message-ID: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKavGoC/23MTQ7CIBCG4asY1mLo0FJw5T2MCwqDZWHbQEM0T
 e8u/Uk00eU3meedSMTgMZLzYSIBk4++7/IojwdiWt3dkXqbNwEGggmoKFptqEQlGDLA2tUkvw4
 BnX+umest79bHsQ+vtZqK5boFZAFbIBWUUcaVArSoQdUXHQdEO6JpT6Z/kKWS4EtCuUvI0kgrm
 0YoXknxV/KPVIXYJc8SOCq04Brr1I+c5/kNMqHP6xEBAAA=
X-Change-ID: 20260625-edac-8e960e02e7f7
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790745299; l=4479;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=pfBHQqwY0FRL/vJkTp/4D4cyjGIq75z45FRzsyOMCj4=;
 b=NlbSINSUFdPmrseU4+qeJZJMs8z7w+3jpAyrHyDJXqrB0lPNiAsyFVEs5T6CThxJkuzNQK6nn
 s3bBZ3S1aESD7cumxTunaBz8ruEGykldYe6PgIZ5YzSDIQsicDujohb
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add ECC error reporting for the Aspeed AST2700 SoC to the existing
aspeed_edac driver.

The AST2700 memory controller keeps the same overall EDAC programming
model as the earlier Aspeed BMC SoCs, but uses a different register
layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
Rather than fork the driver, the existing code is first tidied and
generalised, then the AST2700 is added as one more per-SoC variant.

Patches 1-4 are bug fixes and cleanups to the existing driver. Patch 5
documents the AST2700 binding, patches 6 and 7 rework the implementation
to accommodate it, and patch 8 adds the AST2700 support itself. Patch 9 is
Stefan's step-down patch, amended to leave the entry in place with me
as its reviewer.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- Put the bug fixes first: the two fixes are now patches 1 and 2, the
  cleanups 3 and 4, and the bindings patch moves to 5 ahead of the
  AST2700 work.
- Explain in patch 1 where the grain value comes from, rather than the
  warning it silences.
- Drop the Cc: stable tags from the two fixes. Neither meets the bar in
  Documentation/process/stable-kernel-rules.rst; the Fixes: tags stay.
- Merge Stefan's step-down patch into patch 9, keeping the MAINTAINERS
  entry alive with a reviewer instead of removing it.
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
- New patch: free the ECC interrupt before the mem_ctl_info in
  aspeed_remove(). The interrupt is requested with devm_request_irq() and
  is only released after .remove() has returned, so edac_mc_free() could
  free the handler's context while the handler was still running on
  another CPU.
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
Ryan Chen (8):
      EDAC/aspeed: Set the DIMM grain
      EDAC/aspeed: Free the interrupt before the mem_ctl_info on remove
      EDAC/aspeed: Clean up whitespace and include ordering
      EDAC/aspeed: Free the mem_ctl_info unconditionally on remove
      dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
      EDAC/aspeed: Replace regmap with direct register access
      EDAC/aspeed: Abstract SoC differences behind chip data
      EDAC/aspeed: Add AST2700 support

Stefan M Schaeckeler (1):
      MAINTAINERS: Step down as Aspeed AST2500 EDAC driver maintainer

 CREDITS                                            |   8 +
 .../bindings/edac/aspeed,ast2400-sdram-edac.yaml   |   6 +-
 MAINTAINERS                                        |   2 +-
 drivers/edac/Makefile                              |   1 +
 drivers/edac/aspeed_edac.c                         | 426 ++++++++++++++-------
 5 files changed, 293 insertions(+), 150 deletions(-)
---
base-commit: 5464985e42c04e335fb30e38fbc409c997db9bec
change-id: 20260625-edac-8e960e02e7f7

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



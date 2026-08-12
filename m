Return-Path: <linux-aspeed+bounces-4682-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444BC5B56A
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Aug 2026 05:49:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKcxG1z0Dz3brB;
	Wed, 12 Aug 2026 15:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786513730;
	cv=none; b=aGNgI5gCa7pfPizKrlySUjG/xOiA1t6ZOF2R8xiZCitFsoYVhGLNKL2IEH7p4dPHFqmJAg5LtSsk/4k9J4KQXEZ/9yGeRS7sgi3KvND8k3U5MqGGqHQCD308NIw/XIicZ/bR4oto9ODgzSi8UvxMsNNGxtnI8kv2kkuIjyyBk1g4zuV3+3o04fQlh7VuNRV9n8VoISIxM4yIAacZ9Twj6AGdrmpHYpvCpgXGdScNj72e4ZoQRDPRN0pBvSn0frK4y2HtzTPtRKzTukeqPSHQ3k3/ZHhKw6u80IKJi530rCcFwLxUAtlQdAqizyjx8vOOCAXp1qZsve7ml/9+XPQWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786513730; c=relaxed/relaxed;
	bh=IHxOT7Wnk5xlww8xoI2HTvhglRQOBXxqoCb/87tWt9U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fABp+X7eo6oI7bVGmOAcVSGviR9mSQ4cmmhlyt84Kmw4Bd02JNKwF65V6WL1T+VYkVVEZi320azBKHo7vdRkrU9k+qiku9tmg4ig2VWTo1Hd//6/3jRZ12CO43/6v9a4iWwOcR0/MpA+CkTXUlgXbjIe9qN3PEXF7ExgfPO4or/9F3FHzS0iFgGl40MxhubwmIRh7lIvArugJJeecnbt1vzzoec9z4tJ1A8dQiui38Y3ETiv413STmo0q7LFIw07mQSt4ucsYfO8c3BsEbI9KTBjK44V8AP/Gp5AnD6flHl6J5SjFsjG9SY0pl3q9dva637G0wMAuNqfSZHlw8V9eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKcxF0nHyz3br7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Aug 2026 15:48:48 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Aug
 2026 13:48:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Aug 2026 13:48:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/7] Add Aspeed AST2700 SDRAM EDAC support
Date: Wed, 12 Aug 2026 13:48:24 +0800
Message-ID: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIACgJfGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNT3dSUxGRdi1RLM4NUA6NU8zRzJaDSgqLUtMwKsDHRsbW1AEd5t41
 WAAAA
X-Change-ID: 20260625-edac-8e960e02e7f7
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-rt-devel@lists.linux.dev>, Ryan Chen <ryan_chen@aspeedtech.com>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786513706; l=2810;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=iJPKTwaUlWXTtq4FbV7av/iGgAlKvVcOixKOblgP5dA=;
 b=8f8TR6x2H15qSiqX++8gKE+a9Je/bBd1L6n9u/sgQSTtbIArgdPaAHdk6laBU+hjZSQmTcY57
 azS13RCOuQuCI7Oy88hLQymdCWjELJqj4v/KXCeoCPAP+yPyAFL8hJ9
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add ECC error reporting for the Aspeed AST2700 SoC to the existing
aspeed_edac driver.

The AST2700 memory controller keeps the same overall EDAC programming
model as the earlier Aspeed BMC SoCs, but uses a different register
layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
Rather than fork the driver, the existing code is first tidied and
generalised, then the AST2700 is added as one more per-SoC variant.

The series is organised as:

 - dt-bindings: document the new "aspeed,ast2700-sdram-edac" compatible;
 - set dimm->grain to the controllers' ECC granularity, fixing a
   pre-existing WARN_ON in the EDAC core on the first reported error
   (carries a Fixes: tag and Cc: stable);
 - clean up whitespace and include ordering so the following changes
   start from a consistent style;
 - free the mem_ctl_info unconditionally on remove, dropping a NULL
   check on a value that cannot be NULL there;
 - drop the regmap, which serves only as an MMIO wrapper here,
   in favour of direct readl()/writel() under an explicit raw spinlock,
   annotating the register base with __guarded_by() so that the locking
   is checked at build time under CONFIG_WARN_CONTEXT_ANALYSIS;
 - abstract the SoC-specific details (register layout, ECC/DRAM-type
   bits, memory types, write-protection key) behind per-SoC chip data;
 - add the AST2700 support, teaching the shared error-reporting helpers
   to report an error without an address for its single shared
   failure-address register.

Tested with the memory controller's ECC error injection on both an
existing SoC and the new one:

 - AST2600: an injected correctable error is reported through the EDAC
   interface as a CE with the recorded failure address, confirming the
   regmap removal and the chip-data refactor do not regress the existing
   controllers.

 - AST2700: an injected correctable error is likewise reported as a CE
   with the expected failure address.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (7):
      dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
      EDAC/aspeed: Set the DIMM grain
      EDAC/aspeed: Clean up whitespace and include ordering
      EDAC/aspeed: Free the mem_ctl_info unconditionally on remove
      EDAC/aspeed: Replace regmap with direct register access
      EDAC/aspeed: Abstract SoC differences behind chip data
      EDAC/aspeed: Add AST2700 support

 .../bindings/edac/aspeed,ast2400-sdram-edac.yaml   |   6 +-
 drivers/edac/aspeed_edac.c                         | 414 +++++++++++++--------
 2 files changed, 268 insertions(+), 152 deletions(-)
---
base-commit: 5464985e42c04e335fb30e38fbc409c997db9bec
change-id: 20260625-edac-8e960e02e7f7

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



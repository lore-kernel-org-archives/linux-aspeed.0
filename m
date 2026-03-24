Return-Path: <linux-aspeed+bounces-3745-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A93F532C3
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 01:59:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fftWL3tBPz2ygn;
	Tue, 24 Mar 2026 12:59:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774317550;
	cv=none; b=OS8yfC2Oda6AeIQJsEhshtA1otzFrZ37mNPhQbMdr0MFEju9iyx2q+fpMDqcPhpC4mfOheV4rdjH/ST+6LLD8tK8kHY/Rj7KPUafBLCFUxpDPXCas9O0SnWNCnW8+pBkoWwRSRAV5MpvlI/1DSulnjwjMVJ37CDy1OHCCutrzlfoi/WMp2GmViYQCprkbyuCS/vfS4ZZKRHCLSBn0wzIrHRWch94x3xhrIO87Se+CPcXqfIpGvW5MsHNxWfW++74xe5dMtnorQTr8TpTfODRV9a0QBMe/llG0hnAGi+I+JNsKKNKtleoTNlbbPnjKFZhetVDswzQNK6TPoGZ1FE2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774317550; c=relaxed/relaxed;
	bh=ysKeGPLGoMvsSOdA2nFLi64P47/oXrE6wLV5RO4cccg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=RJx+EjIr3F2aAIQy/RBsFi0Ksqjb8p03NTCpuiOFBXbjJNKXIXKyvySlPILUh8YbwMhJAiXm6WpgxvPT3HoAa6qmleIhCexX0WOFocA9Ixa0UZfrmFbCTCRaRoZMiHCdURCLzQXMonzmtwBI5pNe0pQxOdIck/rPem+gDnUNhyBWF7P9+lqjsowvdP73ng2ySk5jtGmkXTXQr/U7Akzp8FAbvcZJZQ6nosoSm+3ck79APy4TVag6jPWN4wCTM06ZdfP144PirnYGFImducGSPfsNfkodlOygvDvP1a774VHIlKmBKKjHvMZbFcERHdd0Ki9CW8dj+X5CyxsXJZjQpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fftWK2bXVz2yTQ;
	Tue, 24 Mar 2026 12:59:08 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 24 Mar
 2026 09:58:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 09:58:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/2] Add AST2700 support for aspeed sdhci
Date: Tue, 24 Mar 2026 09:58:48 +0800
Message-ID: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIANjvwWkC/22NQQ6CMBBFr0K6tqbTQqGuvIdxQdupdCGQljQaw
 t0tJBqiLt9k3vsziRg8RnIqZhIw+eiHPkN5KIjp2v6G1NvMhDMumQBBo+2Mp1wqK0A5qy2S/Ds
 GdP6xdS7XzJ2P0xCeWzbBev0uJKCMKjDYgjJNK+tzG0dEO6Hpjma4kzWT+F6t3yrPqlAaHJOCS
 dB/VbFT+WdVrKuiqirdOFkC/KjLsrwAX3pCLBUBAAA=
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774317530; l=1402;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=s+I5YSEbSEp+9lLyO9dsRxjOmbpDSxZpMfJMlwzBGoc=;
 b=a7xnHWdVNI/krXJBx3hH11kYaVE8muKYxv6Wf3hCjTob81jwypfIeCC2h4DsAuZZvkHziOWLU
 Efiylyt6Vn8AmJChl8js8qr093Quify2cGDRzgJ3gCdQC5E6qgICd7V
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- 2/2 rebase git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  next branch fix the conflit.
- Link to v3: https://lore.kernel.org/r/20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com

Changes in v3:
- 1/2 Add items list const for ast2700 ast2600 compatible
- 1/2 Move if/then/else block after required: (per example-schema)
- Link to v2: https://lore.kernel.org/r/20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com

Changes in v2:
- 1/2 use items for ast2700 compatible.
- 2/2 use devm_reset_control_get_optional_exclusive_deasserted for
  reset.
- Link to v1: https://lore.kernel.org/r/20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com

---
Ryan Chen (2):
      dt-bindings: mmc: sdhci-of-aspeed: Add AST2700 compatible
      mmc: sdhci-of-aspeed: Handle optional controller reset

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 41 +++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c                 |  6 ++++
 2 files changed, 39 insertions(+), 8 deletions(-)
---
base-commit: 50d349cb70cdb6db352dec114e6381a31870b4ff
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



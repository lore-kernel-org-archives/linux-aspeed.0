Return-Path: <linux-aspeed+bounces-3736-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6223D58CBE
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 02:07:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffGlN0d0Mz2ySb;
	Mon, 23 Mar 2026 13:07:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774231647;
	cv=none; b=j5OyO+LTje5tz83MLnzT8N8IGrTHlOLoBnQUJ6+KBQVn+R1K5i29RtGben8vZnuAcByNLPNHxp95PXW9gFSny8irXSPpX6eKRkl35xDc5QYQfs1mqyfmXtiLdzS6au/6mHH6WkGBuouEWu5r+gPTR0hyAMKP2g4eGAB8IyzPbc6ntDbZPYwy+N4vG3He+qwo7pu8jZb0Yxlw4xvkdw51l1NZ3bNg3iTyXJVHVMxgO5YPr8JqMSXIdmVEdyA+zhpcPTEArRWCyX+xd+qeEyayoj+7WNGz/MEBNFFsMumVefpX6vKxl7jzFrX1p0DvkunfKebDJvqycFWHAHyAcZn1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774231647; c=relaxed/relaxed;
	bh=NkhJEyh5Uzq0uhuV70a6McEFwh3uW6CX6wqiiT27roA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bPFzfZ8GRKFreAG4ZyvFmWDtzCMsuiW5jRcLAOzrTCr3Yixln1+4Em6cwAvZQRJvl5Z5xsQ0m8ogC8gDEFFsvqc+G8meIA6EaZqK8EjsB68rRTpV6S3mAP8R7xqSTJrn7+sDAcXj6SKgjztd9CUuBuAMDDTpqf3JCjqAHFLNDVNCk+RFsbKXxkZR5vS+ErJ1gBWQEVymo72DLf+O49nU33PPBIYlFoRcqpglq9bNeavZqUq5ROX4H9bttJOol0NiLUieE/QsPUKVbLvfuJzTyMzvAB1keP2tXpM4oxRO4Zsu6iCdvzfOyl/QqYJFTgpl+n67+javSR+RenuS5/RxBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffGlL641Bz2xd6;
	Mon, 23 Mar 2026 13:07:25 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Mar
 2026 10:07:07 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 10:07:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v3 0/2] Add AST2700 support for aspeed sdhci
Date: Mon, 23 Mar 2026 10:07:06 +0800
Message-ID: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAEqgwGkC/2WMQQrCMBBFr1JmbSSTQGpceQ9xkSZTMwvbkpSgl
 N7dtCCILt/nv7dApsSU4dwskKhw5nGooA8N+OiGOwkOlUFJZaRGLXKInoUyNmi0fegCQf1OiXp
 +7p3rrXLkPI/ptWcLbutvoaCQwqInh9afnGkvLk9EYSYfj358wJYp6lttP6qqqrYd9tJoabD7U
 9d1fQPxWzSv2gAAAA==
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774231627; l=1190;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=uo2bg2NUBtc2eG09kK4x0w8IEuMmJWwOMwtRMs1f0gw=;
 b=DOxpUJhUWPvZiZnyDHwvUlKbEHWZ0XJsLkgoCaw4ZSon8wUAM+MOZJN6bpCF2VGLLUD6Fo0EB
 1PAoHFwvhWfC00P66r4r+mBQXAlOCRsZE8HrwDEFMHSi2939qpxPv4e
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
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
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



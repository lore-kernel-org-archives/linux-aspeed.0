Return-Path: <linux-aspeed+bounces-1334-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71EDC5B543
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Jun 2025 09:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGjgp26Ttz308P;
	Tue, 10 Jun 2025 19:10:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749546646;
	cv=none; b=Rq7h0OLp7khiMDYmPUrkln+58RJcD2AieiCIOYpwI+Hw/HYnaNb8uSvM/FxWumDQAnMZM//f2KJXTcCIvxVZZklEAPL1I2njklNTmQC2cUDxoOpk6+R9VwBS+NwnpWrVQo0yMRypsizIpa2uWK/CyW7Z5fqe9DiioZ6Ayd2kCc2tr4BZjYeUCOJNmz/1iOOIgTtPu9fHKiCVD6L5ZTZkLQr3XkVVwxQ3RBRYEI2R2hAsZO16suG6vkWR4f3u/TBa8ZFjQ4D7p+wtgjKERBgRkP5/czcMg1MmgJff2aWIGtqnXJSk8iKdUdatGxN+ztSvhmAS41AuEnu2kNUDSlygyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749546646; c=relaxed/relaxed;
	bh=Gv+zahbs8IPSx2cl0TxAt16Mq1IAkTSeydYtH3d3Mf8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IMwBiyZJNfXry+gPIm1T8Q9+cs3kLjDrE7z3cF6eaxkUBatmFAEI0QqQC5O9SDi1sTNlDKd5rb9KZFnYo2gExs+LfQgLpZy0+RaQH/oMe8tScvnW4UvkHtDJ7NDyMhupjhAcDubU2OVY3T0ORNvByhD2SR6dnCNvrFoziWgKrb5DTh8rkDSlEvqm28V2Dyih1jiGQkAD2Y5Q/oJeH6CXpiYH+I4hvwQdHFRfchES9csnEhaY3x8D8YLHbdEeNAMXmbNkiP0cN8slZ9FBW5ErM5Ef/pMlTecw/X1VGnHdmvuleG2w1g1ahRIElJo66GSqFkeYtz7iEqOZfvmHFO42CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGjgn39K4z2xjv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 19:10:44 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 17:10:27 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 17:10:27 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<jammy_huang@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Tue, 10 Jun 2025 17:10:24 +0800
Message-ID: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain

Add mailbox controller driver for AST27XX SoCs, which provides
independent tx/rx mailbox between different processors. There are 4
channels for each tx/rx mailbox and each channel has an 32-byte FIFO.

 v2 changes:
  - Correct document
     1. Use 32-bit addressing in dts example property, reg.
  - Update document
     1. Correct error in dts example.
     2. Drop description for mbox-cell per suggestion previously.

Jammy Huang (2):
  dt-bindings: mailbox: Add ASPEED AST2700 series SoC
  mailbox: aspeed: add mailbox driver for AST27XX series SoC

 .../mailbox/aspeed,ast2700-mailbox.yaml       |  57 +++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/ast2700-mailbox.c             | 226 ++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1



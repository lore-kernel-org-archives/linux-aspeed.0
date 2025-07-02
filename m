Return-Path: <linux-aspeed+bounces-1602-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BE4C7EE30
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 01:20:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX2Bl2ZvTz2ypV;
	Wed,  2 Jul 2025 11:20:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751419215;
	cv=none; b=TKAHqF0dDBGHacWIoxHuuLK40nkUQec+EMqKjaV7FjMqbskUaceww9QdpaAKDS06q0/4TAvLZ1I5/kDI8DOTrLcCotWVzmYiU8D0ZHvSooEhMrAgfO9wSCzEm99lWGkqlpg9RFnTfMgcvkyFLO8jKMu/iNnmQyhEVGPydyUyAnRJ4IZRaoL6eIfXc4+CflUUdMI1pjtMK9zQm0D9tgJ6QO3OWzn0iH4Wg+PKRG7HOVMBn3obl77jaFAWAMurhzxq+MLmncwt9o4uL4GW+jGGAJCcRXpXiJPxCFmhDSRL3KegzmAkJc5s0dRosbf453CFFWlqONgmHHqBtYnN3SxHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751419215; c=relaxed/relaxed;
	bh=u6KQObNwn0sowCzXSALwvamY4V5JIf3mdfLsDzjj4yw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUltbnBH/0CjqSuunIAjXxBZhxQgtEUfELiA+H+6VntC/jsCv/LO+wmOXIJkUGpTvUq2RdL1St2aGFAZYUpq/kr8jwcFAUiC/mtTqpU40ZTKEMDPoiZmE49f+jyOclmE3XpJtL7HcEftXNzS1vwloU7wqxqizXbNrv4TcMaUMbZmeU9hfLVFUZvoGjLoCkgqsayzFSk9F/TN/BBzhI4ywsNkDnbBaE6rGq4m9RBK6lQ95y1/uJdt4MEATPUaGOda0JLVEocvbdroi4G/VESU8uF8mRc5bwmYwSTKOJMJYEysJ/K/J7XzHSFpsV2n72miElpBaOaKXm4brwecYX8wtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX2Bk2PJRz2yQH
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 11:20:13 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 2 Jul
 2025 09:19:56 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 2 Jul 2025 09:19:56 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v6 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Wed, 2 Jul 2025 09:19:54 +0800
Message-ID: <20250702011956.47479-1-jammy_huang@aspeedtech.com>
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

 v6 changes:
  - Update document
     1. Update description to preserve paragraphs.
     2. Update for property, reg.
     3. Add reg-names.
     4. Add 'Reviewed-by' from Krok.
  - Update driver
     1. Use devm_platform_ioremap_resource_byname since we add reg-names now.
     2. Update error code for ch not enabled. 
 
 v5 changes:
  - Update document
     1. Separate reg from 1 to 2. 1st is tx controller; 2nd is rx.
     2. Remove 'Reviewed-by' since the patch has changed.
  - Update driver, no functional changes.
     1. Update since there is 2 reg base now.
     2. Refine reg definitions
     3. Add spinlock to protect registers
     4. Use bool as return value for ast2700_mbox_tx_done
     5. Rename variable from drv_data to dev_data.

 v4 changes:
  - Update driver, no functional changes.
     1. Remove unused variable, rx_buff, in struct ast2700_mbox.
     2. Remove unneeded cast on device_get_match_data.
     3. Remove the usage of writel/readl_relaxed.
     4. Improve readability.
 v3 changes:
  - Correct document
     1. Use 32-bit addressing in dts example property, reg.
 v2 changes:
  - Update document
     1. Correct error in dts example.
     2. Drop description for mbox-cell per suggestion previously.

Jammy Huang (2):
  dt-bindings: mailbox: Add ASPEED AST2700 series SoC
  mailbox: aspeed: add mailbox driver for AST27XX series SoC

 .../mailbox/aspeed,ast2700-mailbox.yaml       |  68 +++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/ast2700-mailbox.c             | 240 ++++++++++++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1



Return-Path: <linux-aspeed+bounces-1567-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78197C77B7C
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 07:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRtr11Bw3z307q;
	Wed, 25 Jun 2025 17:34:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750836881;
	cv=none; b=aw6YFi2vk8awEYI/dfki26MblcLAyyHFanIcutmO6whWd6BNZZPHB2dmZ+7i6ompqZet/0etydfpqNLSfvbE6YvebkYCl0eQrG+FPT0dnXFf76SirTOCRMpSfcvku9F7kXxcnLZwNmYtXKJsJiXGaSDMVhr6UpVsaC0uM+2CithJ0DdhBpE7IEjFR5K91t5UPbxbDxM6mIQSumRfrALwK5wSRSSezL2+90HK6OsxPfA/nKZOGtW6YJo23b8UKWQZns2DXoMQ07PQc9vyGIqxZB7tqssoNzL6CFanuFNzBjnlxKFvXuaywN7aKT5WnplBriou5qKZe4eF1gCMI26P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750836881; c=relaxed/relaxed;
	bh=1gNKEcLEPiaqY2uONOkUMKMnnKDh/RCLIi+xzcp7dCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVUxBIm8VTDvWgQSkPk6jK7L/8qrQa/jlsolXis08fwcEZMk0cLHjL4S5wA5rXWnamVXh4AnFEVA/sU5F5pUa3wyS40yfhyed7QF9ppislA82suoIbjxC87Gbn6qy/QdnZjA63kw0gUBi6MahjrdzSHjaVYnZCB8iK4gdW8j9YX15wqrFskwO+P6r5IIVBYPFM6XcNFzxKS6nMckOJ6i+tKrKHCe+O0SahaFqPGb8SlaB3BfCuR6pAA3ZUbqjp/mQuzmW9n48nl92jMRbjalW3PrwJhIt6jLUZIw/d/L1+jl2S3xruM+hHa1FyopfJd/lCcpa02ZQH0Tn55qNCEvPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRtqx5DPBz2yPS
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 17:34:36 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 25 Jun
 2025 15:34:18 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Jun 2025 15:34:17 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Wed, 25 Jun 2025 15:34:15 +0800
Message-ID: <20250625073417.2395037-1-jammy_huang@aspeedtech.com>
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

 .../mailbox/aspeed,ast2700-mailbox.yaml       |  60 +++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/ast2700-mailbox.c             | 240 ++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1



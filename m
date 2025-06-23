Return-Path: <linux-aspeed+bounces-1537-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2055C77B7C
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Jun 2025 02:45:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQXWP2jqtz2yDk;
	Mon, 23 Jun 2025 12:45:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750646737;
	cv=none; b=FyXETuRBa1UBs0bkzQGpY9jCptmXHqd+wwNOYNtSMMvD88/AIipig6CBOaIoSjB0W7fe6yKAFpiJFaKJM0b2R/fNAQomcXtP3hOIUPrtVRcPC6BOEmZS1AffoGDGIKVcQT52o2qzyl+Ydavr6R+0xnPbjgSfRYc0eiUGziZQM89AxiBaefzSTMGg1PrNCHeB0as40nst+q/fP2UGPK1AnsML3kUAhNjtGopnMes8/DNKow4UQ2GC92JiR8zJxdKYVk6hewi2H7KjtG3/2Osckau1BK9x5nBEVw1FJ2uzsh653ArCLyPYKEupeWniOR11gmv9qxdV+e23Y3B5Pfggpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750646737; c=relaxed/relaxed;
	bh=WFlOvk+lUwrPU/k5vZ64DLEb/Wg1i9EU3JNSHIAhOZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeUF8qZDXvSy4vSOYZIG+IY37yfYO45eqNLsGQ6knbyFeSrCEt8guMxOtqJiLmnu+UN0nOpcTL4Kxw/w6lK/P+RfKaK0VXTVpjetMU8qxJWzGpGClNXX6vRsIIfiOE5uJJSkORI80AfEbFQZ9pVVdF4hZBUFFXFkMIDEtWzClMu0A+XtTNpvN5RS6z1wbqQjIUVFKyG2jEjI8evL02x/0I1klWD8rRu59AHvauMuIdzvh1I9IpmF581qatSlx3BKjEQ7jZ63jG6+gWSk9SFPpoZvOPLp5FnqgE3JK40CWQ+Cp/EkZZQmguw4sfq0IqtOTM2sGm87/SMbUo4Iyey/KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQXW76J2Jz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 12:45:23 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Jun
 2025 10:44:56 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Jun 2025 10:44:56 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v4 0/2] [PATCH v4 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Mon, 23 Jun 2025 10:44:54 +0800
Message-ID: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
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

 .../mailbox/aspeed,ast2700-mailbox.yaml       |  57 +++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/ast2700-mailbox.c             | 230 ++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1



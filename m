Return-Path: <linux-aspeed+bounces-1303-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0FCC5B559
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Jun 2025 12:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bC6yr00d1z2xk5;
	Wed,  4 Jun 2025 22:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749041779;
	cv=none; b=lpxeBHoCSrKfr27RAKAI48+XAPnzLrS+HHx1Dt3dr1lIzYGRjOrAX5A/O2nSl0BdTZK2Exzf6ClkhXx5kgXlQxm6yzyYBwrWa+x1BgrOHY3R5FTG6P2QNDsyci0kW8PXy5Jl0fKmq1Aaf1Mo2OjvBvGiSnljW4oseqRo+lP4dIlSRi8jyHn4tw8rylCtzAgzMV45Tv2G2yp7lp1iSSbv3h+W7BIuZj5q1nxDg8hpG6M0XHaxgPQMd1RMUOfDEVIjVa2dFzDHGEW+lVTWhG2PGLZbqXFIMJpGoKv6CLaFh+YP1w+Q62Zsy4d73UG8c4Tg6ttxCwJ0gyV07JYQutFkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749041779; c=relaxed/relaxed;
	bh=rXVlxzeojw7iOC4WymSBymtSsXrKuEFJvFJ9jv3V310=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXH8nI3018DFDLkT3YdSPr+FpSpE8BUoqDmZIO2nAOD+SXuWwF9yxU8FLUrzGKWb2tQbcWG6IhrB+PkatVqvN1hzP0SUeKgL4RoZOdRTsO+tF2gzCPbPGGpDnsraZBbgfp5WWrv6HeR8QcH71v1tnkDl2Lvs3AO9C6QmnEw8v9NGPcFvVxt7fZeyKqLno65RA+h8BHv0DS5hRLENJ53FaoZbDLy48pgRLVjEGBLQFWRprm5PoaSbpLchARhgWzmA8PagAFvxps5fpaoKQdjLt2dV+XotoXAG0RyAQV9mbs8/rISgMvILa8A689/DO5nosHOdbDFcudQvWw3JIyCFDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bC6ym63NNz2xCd
	for <linux-aspeed@lists.ozlabs.org>; Wed,  4 Jun 2025 22:56:15 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 20:55:58 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 20:55:58 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<jammy_huang@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Wed, 4 Jun 2025 20:55:56 +0800
Message-ID: <20250604125558.1614523-1-jammy_huang@aspeedtech.com>
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
  - Update document

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


base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
-- 
2.25.1



Return-Path: <linux-aspeed+bounces-1291-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A6C5B559
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Jun 2025 07:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBNKm0qfMz2yKq;
	Tue,  3 Jun 2025 17:55:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748937308;
	cv=none; b=T8Sun5BnggnY1ij3w/rE8+RfEOvE3K1jNzEmRszFh/BCO8PR87lNmYy4Bd+c86/f2tvWLSMRDp1Q4uaes1YO7mLhJjA6SeV0Px2CGo7E+wMbqUOFLeRzqDPF+f5qWxOvqlSkMb46Na08jff6NztJCDsaRnVJdgps7LttzmURUvUtfsMKiA8hkBth0WJ8HUqGLjkZj5/XJHF44ddLA/AgVIelQpaLbHQ/uaf4Yp7Yga0zDiZ2ddrTTXi0y/Il/03Wp/CHmuafniz3kPUBvNg8+WF+yLn0eiea4+yFAElnyG43J461MUIvPks2Bo0ifC58HqUPUtg9QgTewrEcgB0rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748937308; c=relaxed/relaxed;
	bh=0/mlomkWWAMkLGaATUDeMQq7Uvz6lsXQYJEhldMqm3E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cncyKWw4X0BFefB/zgSKDEA1eFg9r2g6p7BRvL5T/lhBGt2oGXMlLKXUUZcnwyczS9U9pEPJxvkpS+v5GoHh8dBYjXyua0sxDp864SJoLiucF3DCh9Cgj35NkmHSPkmVDl4Hxb0HUR+gmlwC4iTGJPXGP2UFclNbtATREDSu36askF3f/2TvsP7PEJE3aSeLSmFlEpBPVg/E0RuaDuZvOYyhCkUbRHXNP+s1yjlfm+YZr4Nq8IDyaKlBJh19tJ3tA9gaXq9sViFc3OA1axS46UFd7H//n3WHsqR4w+omFUS4kR8ZmkyeTw+e0bjw9dAjMuzMmEIYkCffDZSqp4BD3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBNKl1rcxz2xDD
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Jun 2025 17:55:06 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Jun
 2025 15:54:50 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Jun 2025 15:54:50 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<jammy_huang@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] ASPEED: Add mailbox driver for AST2700 series
Date: Tue, 3 Jun 2025 15:54:48 +0800
Message-ID: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
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

Jammy Huang (2):
  dt-bindings: mailbox: Add ASPEED AST2700 series SoC
  mailbox: aspeed: add mailbox driver for AST27XX series SoC

 .../mailbox/aspeed,ast2700-mailbox.yaml       |  61 +++++
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/ast2700-mailbox.c             | 226 ++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c


base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
-- 
2.25.1



Return-Path: <linux-aspeed+bounces-972-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47364C28B2E
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 11:49:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBFXr6fdpz2xyG;
	Mon, 10 Mar 2025 22:49:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741607340;
	cv=none; b=iWPY2o5VpaunpT6UQBC8RDZAsXxDJg+7JeSQPA+oAvpGC9aD7MQGImyh0GbqCiV2JDJ48HR8OrnBwBUWnc1cIScU3BUua6lR5xhJ+v2T7F4DRUxvW9YN9dvFkPX2efijJcLrpvT+9OhirbgwoAMfUJABsDf+G04gEzp5inTH2D0LTZPHVtQatu+c9LnM97Ql9MsojXpyVVi5pxECy518U2dwQJ7pXhQuLUM14RFDuVuREoxxKNjf2ux/aeLiHKFlL5NteJdHC91PPVni1uvW4QwE8lwhPAOrhK2/dYZBHqfa1geahTzS6YsprdYQk/je501JeHeR/IcA1TYzKXrDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741607340; c=relaxed/relaxed;
	bh=fBgOMPb3sMFF5C54e/DJlgrPzxkt70PrHbFBpQ39Ic0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CfwHRkxcFdZeOArKKdkzPpMXBjnS6UNiIJN1ZH3cFvwS8pbOk6QiKzNZoXMgfwcJDa1bgUjRsTODud2pcnxb6eNkAv+0OWBSpRIZIUJE3262htnIXnwTASHziON2Au3bj4pAOUq16PQg4Ey8M+1Xgr7b+D18llLHTF8uVbk2NTXL6/tNsoq4dDAf27P9klyfJB/oBJENBRzklAX8ij57ucqPZyT/2BxtmewalNFb1250KrFzaeAoSo7FsMiVdmPNN3mDcsCNQ2VDAyDiz/3oyxDuZlQhv2+lNtHx7JwZpG8puNLdoH7TF4XryJUtrMFqtGAnpa1bvOBbx9MEV7+OlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBFXq747Vz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 22:48:59 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 10 Mar
 2025 19:48:40 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Mon, 10 Mar 2025 19:48:40 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v3 0/3] Add AST2600 LPC PCC support
Date: Mon, 10 Mar 2025 19:48:36 +0800
Message-ID: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

--
v3
aspeed-lpc-pcc.c:
 -- Add ida_free and fix the dev usage with removing some debug messages.
aspeed-lpc.yaml:
 -- Add description about the pcc-ports usage.

v2:
 -- Change driver path to drivers/misc

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  38 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/aspeed-lpc-pcc.c                 | 440 ++++++++++++++++++
 5 files changed, 496 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

-- 
2.34.1



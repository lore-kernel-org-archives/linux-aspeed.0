Return-Path: <linux-aspeed+bounces-753-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAEDC021AA
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 11:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxLXQ45wYz30Ds;
	Mon, 17 Feb 2025 22:48:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739792934;
	cv=none; b=iXy7GJ5ocDBFoCtp17CddhMiiyJuCSlOnG0yye+YqJHaV3pXlEbUbiU2gnuqNBlGhErP3Y+6qOCg1bTSpZ7NJU8Az5KlzLTDgdiMX6ns5etv58gzi3T0BHOWkIKObigUBcwuNcnkclmeeDeSi6z0UvlseEcdaZaIQVgT2ikgdsQCIVG+NncuSK/1Z+y2nrSl3/J8ZDYuv3vm6m8gsMTbB4eg1kFQ6MF2JUdJ4VKB3MJGtxv8gr8c5HNpXFFp8a6O2Frtag3unJfQcAN96Iau7BPZR4MnCcW3ACEU9CuxlnEWhsmN2vuES/Z6iNCvVQWdzbdakqcKgeDZ6dhMtN8kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739792934; c=relaxed/relaxed;
	bh=l4Bav6E8flN9mO/0zokohJ0f6CGE4NuZlgv05XM78nk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LREYToJLS+2lQnUpowrlCx5DPSrMyk7pNSjNGrzL9/BnD4YrtpD5EmDerak5GQLGZgUUpxG6qSJFDdrDqEAXbn3ZFRyWu2d2tHgCLPm9m9eZ/yftQEHyYViKVOt4Gm3pACg7/W34nRGESBQESqbXvEqqo9/NIBF5utArdxHLOpSqoHft33yfp0wXDjqiVjffnCGTtQZye94IVBQj6T32mHRpI1mDZvfHo81tZumzzKgBDPwA3bGjH/+KFosb9+ZHBd5fv5NQl669lcm2mmtt7/47447/Aw8TtxVkzptW8PaZy+UKEJH/pbgIUstePoz+7fmJzECHuQ+EJnoRdcIWRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxLXP3LQwz3093
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 22:48:50 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Feb
 2025 19:48:33 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Feb 2025 19:48:33 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<chiawei_wang@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v1 0/3] Add AST2600 LPC PCC support
Date: Mon, 17 Feb 2025 19:48:28 +0800
Message-ID: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
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

The AST2600 has PCC controller in LPC, placed in LPC node. As a result,
add LPC PCC controller driver to support POST code capture.

--
v1:
  - Change pachset from 1.
  - Remove properties in pcc driver.

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  36 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-lpc-pcc.c           | 439 ++++++++++++++++++
 5 files changed, 493 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-pcc.c

-- 
2.34.1



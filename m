Return-Path: <linux-aspeed+bounces-37-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CF3D13592
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 02:48:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcHrc5rv8z2xHx;
	Mon, 28 Oct 2024 13:48:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730083712;
	cv=none; b=SxH6nKn3Jara2ikbXxPFpQoURNaIi91Y6be/8m15ahkpTqhrR3DP2ZBYdnt6O71k5tQmt97/vG+rnXiSDtg7Y3EkOk/zZVLE2xfhA1y/Zi2+8M8zTn8MJqD/vJ775vNMFnXpiMK65oe8fJV8EzsAWun7p5VqDHPCiscKSOvUoiG8x03adQWz+m2M47f0TyH1YsLKNdqs2MxwRvUbjpCEsHRUPvf8C8OflRuZ2OgN8/ZkUWDR4N/WD9alapO8Yg5wXo1SjkXKcqdSWw8iSqA8ZRwEvEYVAayyTIz70hVAteHRVxVC8NZmM/8shqrJdB6N0osGIgWy/gWDCjcyJMdW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730083712; c=relaxed/relaxed;
	bh=G7BiSP+LYgK4F52ldHmNN6aZ/J/wObufvAK63ZXAtZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WoP+47mXPCzd1duzfT0MVfG3lUSfIcDE68nLE1MexWR8HDpxQCXImkoyEwrf8DU3R9Zpt6PEUuRbTxeX6hcUWIWnm0721hIikQ0s5KjEqCjRTb320udmn61NrJ/J0QGEsGbjVQ/MsJTp9HpJZQgrzwjwCWwfkdNH49ili37mgJryLisBbFBDDh51Rt8wv/dh9IN9KyfcXb+2lajKOwvc4ducdam1QL6XcUWc4QcXLpWQ0ZTK95rhEULFH21+MgkZ1vziYXrn8kK7sN+6/lq7KJrZeALNSA/yFLlm/I27tuM64ZlpawvZrdBCeo4tyJu8qmRvKKc2z6Z3Ijk9poQNjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcHrb34Zdz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 13:48:30 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 28 Oct
 2024 10:48:13 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 28 Oct 2024 10:48:13 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v2 0/3] Update ASPEED WDT bootstatus
Date: Mon, 28 Oct 2024 10:48:10 +0800
Message-ID: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
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

This patch series inherits the patch submitted by Peter.
https://patchwork.kernel.org/project/linux-watchdog/patch/20240430143114.1323686-2-peteryin.openbmc@gmail.com/
Besides, the boot status modififed in the WDT driver
obeys the rules proposed in the OpenBMC.
https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-update.md#proposed-design
Moreover, WDT SW restart mechanism is supported by HW
since AST2600 platform and is also included in this
patch series.

Changes in v2:
  - Support SW restart on AST2600 by default without
    adding any dts property.


Chin-Ting Kuo (3):
  ARM: dts: aspeed: Add WDT controller into alias field
  watchdog: aspeed: Update bootstatus handling
  watchdog: aspeed: Add support for SW restart

 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi |   2 +
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi |   3 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |   4 +
 drivers/watchdog/aspeed_wdt.c           | 149 ++++++++++++++++++++++--
 4 files changed, 150 insertions(+), 8 deletions(-)

-- 
2.34.1



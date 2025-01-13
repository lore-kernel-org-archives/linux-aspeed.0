Return-Path: <linux-aspeed+bounces-443-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E3EE7719E
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 09:38:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWnHW3Lfyz30Pp;
	Mon, 13 Jan 2025 20:37:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736761079;
	cv=none; b=SeU7MBhCuvUEz6WYLNHyOuFWJFo+dzCO9NTv30Iv2hLJZIqyjDWwpApM/Q/ivrYTCUp0Aa08Ahn0/YLfnPvfAvRt8NqAcFSZUXTXsngNU7MvjRdjEpGt8RXgaHQ/U87JU6npTv+LI6Lk2wuyVT+7pgeENqSxZsG1vJ15zg7R07B0Tckk7DLDwQNuZZ/BnybdIwg//kqqReXXjbWcRxlD7iTVs92u0wd5lV3qP8rNP/tt81QhNYfw7C4qK2LE+ppeTj81lEiHnu2WeqAbIwaPPVO55SwkO3WrnUXXsSVNN4OE3jh+1xMNbcjFPBbJ2yWCFtIncJT6NoHzBHA/G96thw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736761079; c=relaxed/relaxed;
	bh=xe5wMoct/kmwDf2zKa7aZzdKTC4p94nSDuPr1vWOIWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRBywa+el8eZbVdw5KYAcMLD1d1ZxcmExTf4NB5jxHlyftmtelmQXMAPHGpyTeNRTxdYyIeU8H4Aj3/BD9s1koH/Z8QvG+LWtDgzhvpOVuZWGwTqnR4IYiukDeYFBpQOjIA8DsqMMusHT0iHde/DOkxT7rLfHI83oHX3vt3SYgPEjFTyY8aJ0oRYyBr4+Vftn2R1vh1CF20M4wRnusmzrIZRqn1ourjX6s3AciHs2eD/rS/fW0+xASfNup1tGWgFFY+MTLr+6fJCC2a/j403dU7vE/a95XpnUxYFbrTITJvXl9CUu2QOLIoETuFtv5YMym00T4TqWIoALHVnltq7Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWnHV0KDWz305c
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jan 2025 20:37:56 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 13 Jan
 2025 17:37:37 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 13 Jan 2025 17:37:37 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <andrew@codeconstruct.com.au>, <linux@roeck-us.net>,
	<wim@linux-watchdog.org>, <joel@jms.id.au>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<BMC-SW@aspeedtech.com>, <chnguyen@amperecomputing.com>,
	<aaron_lee@aspeedtech.com>
Subject: [PATCH v7 0/1] Update ASPEED WDT bootstatus
Date: Mon, 13 Jan 2025 17:37:36 +0800
Message-ID: <20250113093737.845097-1-chin-ting_kuo@aspeedtech.com>
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
Bootstatus mechanism is reconstructed to the latest
architecture and for all existing ASPEED BMC platforms.

Changes in v2:
  - Support SW restart on AST2600 by default without
    adding any dts property.

Changes in v3:
  - Get watchdog controller index by dividing register
    base offset by register size.

Changes in v4:
  - Update the commit message for updating bootstatus
    handling patch.
  - Rename aspeed_wdt_config struct to aspeed_wdt_data.
  - Create restart callback function.

Changes in v5:
  - Remove SW reset mechanism since there is no consensus
    about bootstatus for SW reset currently.
  - Correct the method for clearing reset event flag on
    AST2400 and AST2500 legacy platforms.

Changes in v6:
  - Use resource_size() function to get WDT controller
    registers size.

Changes in v7:
  - Update commit message. WDIOF_CARDRESET flag is
    used to represent all WDT reset events.

Chin-Ting Kuo (1):
  watchdog: aspeed: Update bootstatus handling

 drivers/watchdog/aspeed_wdt.c | 81 ++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

-- 
2.34.1



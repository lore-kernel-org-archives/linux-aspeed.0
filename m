Return-Path: <linux-aspeed+bounces-434-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDBFE77188
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jan 2025 08:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YW7RD1sQpz30Vf;
	Sun, 12 Jan 2025 19:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736669544;
	cv=none; b=AdMF+EVNZ/3i7LdxU8LK97/szXTI4a3l7JTWX1J6KmIid8B70FGgu6EZaBDYpZO9QGcHpqmniTTYd2Cllq9JKeCsZhdScQsidmLNC1MkITvRwSyOekcZ5exgWEAtozACcEkCcejVx+UQdRnBMKeNhxN2p6nDGprw1q2hTOk/3+PyoMJh2VL5IBrqF3RXGUVlmev/Ornt18QZsu+Vqn08COKnMv5BuXHaYEMDTO0Abdb37GpCjwp0VpRRw9Qj/7poeQJNvRcC3hA/EKld24/qE3ALAam5tXmkhTrrfqTTMOqrw1lvMT/sUn83EDwj1sHi3ds8NecSA1IIPYjJrPU1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736669544; c=relaxed/relaxed;
	bh=LgRdPljWoyhKBeg2+nmUA9S4hUTN+1iPTVbpBCPsk+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFgjcwzMFfws5zHmDJVgBIVi34rLkj9ObjNormpaKwIS/RIYenXHkxaszxN6sKYBsbQn0/ntdhBzH1UsN2f5OUwQYKlelW7V3KnSDSXdmP+3+8VoL9aETnDhzb4+c39ltEUoIOITeUwR5oa4K4SqkV4GV7xWoFtC1sNCPl8r5DCSPhmttkC27N2eGhNeqh7I4qMPa8FanR0iX4PpQzmoGOvaGLRV8+K0PfIvxsLvQTsoWcF+jTAF0oiy8jaFKRtcMGO5RJWP05xbe5dB9xWFjk5MzauetLwNb1yUinsm2hRnaQjshO6FG43axHHBbveYCNMBuXd9YluU+y1gKM2Ysw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YW7RC1JKLz30Vd
	for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jan 2025 19:12:22 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 12 Jan
 2025 16:12:04 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 12 Jan 2025 16:12:04 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <andrew@codeconstruct.com.au>, <linux@roeck-us.net>,
	<wim@linux-watchdog.org>, <joel@jms.id.au>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<BMC-SW@aspeedtech.com>, <chnguyen@amperecomputing.com>,
	<aaron_lee@aspeedtech.com>
Subject: [PATCH v6 0/1] Update ASPEED WDT bootstatus
Date: Sun, 12 Jan 2025 16:12:03 +0800
Message-ID: <20250112081204.263216-1-chin-ting_kuo@aspeedtech.com>
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

Chin-Ting Kuo (1):
  watchdog: aspeed: Update bootstatus handling

 drivers/watchdog/aspeed_wdt.c | 81 ++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

-- 
2.34.1



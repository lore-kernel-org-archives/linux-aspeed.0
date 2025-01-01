Return-Path: <linux-aspeed+bounces-313-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C498E7718B
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Jan 2025 07:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YNLNg5qlHz2yvn;
	Wed,  1 Jan 2025 18:01:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735714899;
	cv=none; b=duQohs2El2v349qU3fYyOp2mIS3Rr1ZQj6Lk2txOzWCqdjV7rtpp4q9TskWShfMAc6flPO4ZSxK97EOqibdtASCipC3hi1I9CJm5WCdYGv8t48qo6oG5NVAmBhRVFpdztPL6lmDcHop57BhLZegO8JT7Fce5ow+ib3qyQ4m9JSCkhPGE4MLzUCZIv4wrZbFhxNbGtHcROYOsHif42vemY7AGO+Ixdolj/VG+d66/JgF+0bfQc3KJsqtwRCM0j1nxTBIubhrZwoIR3TuUB1esNxE5L98T+Z7ClLK6o8JCbTV2g4aafVyRvc06E+7S0YhDyO6u4lvjjIWYrg1D/UYblw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735714899; c=relaxed/relaxed;
	bh=fYojANO0jZk2dkL6S2xLZf75tzTY4jMo+7ufgg/5CgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdGwe37F8Mms3G756mSB0XLJjSc+NSACM3IYmFsWb9cnPsFdFRklFlm88qWN+tZKvruKMVxErRW1dlSQi/6968eytSWU2hrAm25GZ39Nh5ohj+rrisRDeRs2svN34s0FqHlTGSDnPP2qmGy/4feT0KSGFrBJSo1gTMhBpRp/JCf4m8RlPZw3izmlp8ahUv2IF48dUCvO4whxYJhwAmGW9aInFeTOTDQRqCOCE65TU+C/+2qk5tndUO7VFip+2VvqU320RJAYQ0KKMmI4qMg/K46R9Q0RWWI5bpCyJX5khjmCTWRCJSRB1wzNBv+IV9z0usD+AXx1eL/5Y94yeU5HHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YNLNf31Tjz2yvl
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Jan 2025 18:01:37 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Jan
 2025 15:01:16 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 1 Jan 2025 15:01:16 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <andrew@codeconstruct.com.au>, <linux@roeck-us.net>,
	<wim@linux-watchdog.org>, <joel@jms.id.au>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<BMC-SW@aspeedtech.com>, <chnguyen@amperecomputing.com>,
	<aaron_lee@aspeedtech.com>
Subject: [PATCH v5 0/1] Update ASPEED WDT bootstatus
Date: Wed, 1 Jan 2025 15:01:15 +0800
Message-ID: <20250101070116.2287171-1-chin-ting_kuo@aspeedtech.com>
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

Chin-Ting Kuo (1):
  watchdog: aspeed: Update bootstatus handling

 drivers/watchdog/aspeed_wdt.c | 85 ++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

-- 
2.34.1



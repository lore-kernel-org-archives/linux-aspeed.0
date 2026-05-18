Return-Path: <linux-aspeed+bounces-4054-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30BCD4F52
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 09:57:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJtWq3WzWz2yFP;
	Mon, 18 May 2026 19:57:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779098247;
	cv=none; b=kxoRb5ojo+xwVr4egjpScIJyKXvhDc1F97XTD2RePBMcGkVT4R4sxn0uPxsA2pchwut0wVM+uX6sCEDNkPyrGSxDPjj6hjXmDUyBsg99XFmwpJpo3g6xIpIjDScI79PxwS6ZsGeAVbwlSRRRKNg75Rk/V1U+cVfp7ihxh28tKDyJ9hVChNYdIWAgoLlweBoPueRAhkj5xweCgzb8WVmtBfE1bb6cS14cqDB1iEXsd6byz0cw5Jy7jCPrh49DGxxmE/+WtyXfrLSNA/RCqH46/e/qEEJsU7g+I48fFzzKoeEkA0xLSVYvvzj0xmnV3SwNM4rtpyB7Ymy24/3iQ5FVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779098247; c=relaxed/relaxed;
	bh=ftpTpUPuup/zc7/H1kJE7NPrluIIdzjmJzVnVd/TRfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=au85nz9ZcunABu/LFpT7eta5M5NeZJajA/3rqsoXUpM3UDplt88aW2Avy3vFm9sZ7aVlGuZr7Bj8fs8HohQNSS5zjvD5rNe8o8QJznosV1+JoYdq8iAZFCgYdNWH5W42v/ftIkCpvj1kVB3vpqZLhC9NfeU7bHD98t8Zk9MYws1pPnjJ9e8Q+Q3izcPKXBP9GzPsy3rA2GNW/PSn/WYLF3o+hw1WRmEoXHvCOtjNso0zHKcTFxvY8o35wQ0l21Ek8TmTF+wME/jCFYCpzVLvuvz5GhOZmpRowLizTl6Iiz2/UVBVdAwx27SigIdbOg7pYfiZbvl1+A2emYfJBU1kUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJtWp1zGNz2yDs;
	Mon, 18 May 2026 19:57:25 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 May
 2026 17:57:08 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 May 2026 17:57:08 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH 0/2] spi: aspeed: Fix __iomem annotation and VLA parameter
Date: Mon, 18 May 2026 17:57:06 +0800
Message-ID: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
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

This series fixes two sparse warnings reported by the kernel test robot.
The first patch fixes missing __iomem annotation on an MMIO pointer
parameter, which also caused a redundant cast at the call site.
A VLA function parameter warning is also fixed in this patch series.

Chin-Ting Kuo (2):
  spi: aspeed: Fix missing __iomem annotation in output transfer path
  spi: aspeed: Fix sparse warnings for VLA parameter in calibration
    helper

 drivers/spi/spi-aspeed-smc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1



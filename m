Return-Path: <linux-aspeed+bounces-4116-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09417CD4F3D
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 May 2026 07:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMGmQ0LyFz2xSN;
	Fri, 22 May 2026 17:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779434197;
	cv=none; b=O7wfq5xB4NCBZKrbhchWLLArXt7i46cp+k1NxrIWfzCfdunjSpYZhsA68XtsKatHvJ/2dSpkKt8zGI2ichH349S3nON2f8esQ+JJ8HKZ/KqWVXd5tPypxIOIYsMIapEzea2XEsO+bmF+rah+VQy5CkXANwR4mD1gEhdpB92bm0aOvVO+/1eGf7+ChyPC5BqcqCzUHYx7hendfsElxmDx1qdtoqgVghzZMZrlg5AZ8mkLuUhPUW+007isAuLAmLR1qdDlFQTzHY1k5IFbsZZnoCjMLm51AIgmVYcNrXg3N7U5+Y+f5HAVoXONyqrT1iHkoM65uMVq6+U3rrO+PNNicA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779434197; c=relaxed/relaxed;
	bh=vqEVtc+uhqyRZSMr4I20ikMC6TiX58Bd/7jTlBDcGyQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLK6JxOj+wMehQ46AzZ12FzcP6LnDVKI+hC/LZsZa9EjZ6aH2OZywyPrBPeMYHtcLjqEIrcgBr4cPbW0Adxe6mMg5RgfM11afx/rYEfEGzaZ30jyIKcKsYL2zcwsQHAHFVX6TEUR2OvdIPKKrB4OVa3QIvOSueWaIge1A4qF3+XDX9pevj/MZ/5WTpGk6oCrTSNhWngTN8gQEVzKy5Gq6u0AGvHklsVbyp7PIyfu4wgO/BkmJAOAY3P8/1JVFAqX912W8tUO5kNV4nSrJcJHjHYQoEZzpZdW+raq+4Aye2MWV3nPTCMg/X/1DhacBYzbaPaNKk7XbsnT6AiLADJF1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMGmP0bjpz2xC3;
	Fri, 22 May 2026 17:16:36 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 May
 2026 15:16:21 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 May 2026 15:16:21 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<david.laight.linux@gmail.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 0/2] spi: aspeed: Fix __iomem annotation and VLA parameter
Date: Fri, 22 May 2026 15:16:19 +0800
Message-ID: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
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

Changes in v2:
  - Add parentheses to row-major index for clarity.

Chin-Ting Kuo (2):
  spi: aspeed: Fix missing __iomem annotation in output transfer path
  spi: aspeed: Replace VLA parameter with flat pointer in calibration
    helper

 drivers/spi/spi-aspeed-smc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1



Return-Path: <linux-aspeed+bounces-2049-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263EFC8303F
	for <linux-aspeed@archiver.kernel.org>; Tue, 26 Aug 2025 02:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9s2R4Wj1z3d39;
	Tue, 26 Aug 2025 12:25:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756175119;
	cv=none; b=kyRmL3i4Wt1z6tCdb8utWtA0f1V29vt747JtR+6QI04dzm1kFpRLKluwnY4CTY/Otax4mrf6tmKTV3mqKJJjunsRPN78VlPJCvw5xyp3OSsLFi5CeZcltVMiuhxtI+CbPbk1Z4QN7TxMxOdwk2A4QxF5O8ZkGA5mfm3yJyo2vxDt7PMgYHUNfo+Qki6U7d6RCgI/F7x2Mpi8Foxj8gkvoaNRJ4hVnbzRUOMTu8riUEk4NVY+A5hckHr+f+QJZCqFw3Yz+wMjQquTm5rGvXSOmFsV0vNkoe1qjk4OZFPsTGCG2yzWHsYeKRLmKYoe3jf12oPa5vKL+uxhGiJoID0bGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756175119; c=relaxed/relaxed;
	bh=H6Qc+az4zBlNHfSiEiCFH3BNqC5b87qNN9H4yISVKn8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GciCPJfdg4lyGcCLyhSJTmXfZc77CQtshfRhqFkzUDEaVx9RxwSyZ9ymzFrve3/E1rKJv600DGZGLYqlTg491XiB9oLB5xnEM5btAhrNtYmdHpa20ueRT6qMstf/p4kt0W6J3jicxHjvpBBtmp16jRd7WY3PPo/KH6mN1YjV14K6ctkz3LA0pnruBz+UxI27IMuD1p968bpF0iJU2zM1VvuZRBLWXd+Zd5EZJGTng2ImArVJ8gwj8RU/Bk4F3qDPtqSZIepB3Z8PD9UGvHK0UN3g15LQ/HHvLBFlKjgaRkLTHo+N9Yb411M0MlESs3zcn66ZAPTxJKYyExDDQVz77A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9s2Q6p0Bz3d31;
	Tue, 26 Aug 2025 12:25:18 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 Aug
 2025 10:25:02 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 10:25:02 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
	<andrew@aj.id.au>, <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/1] media: aspeed: Allow to capture from SoC display (GFX)
Date: Tue, 26 Aug 2025 10:25:00 +0800
Message-ID: <20250826022501.2354799-1-jammy_huang@aspeedtech.com>
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

 v8 changes:
  - Add check in aspeed_video_set_input().
 v7 changes:
  - The change for Documentation is moved to a separate patch and has
    been accepted.
 v6 changes:
  - Replace aspeed-video.txt with aspeed,video-engine.yaml.
 v5 changes:
  - Remove dts.
  - Add doc, aspeed,video.yaml.
  - Simplify aspeed_regmap_lookup.
 v4 changes:
  - Use scoped/cleanup to make aspeed_regmap_lookup simpler.
  - Update dts
 v3 changes:
  - Update for enum_input.
 v2 changes:
  - Update patch subject and comments.

Jammy Huang (1):
  media: aspeed: Allow to capture from SoC display (GFX)

 drivers/media/platform/aspeed/aspeed-video.c | 195 ++++++++++++++++---
 include/uapi/linux/aspeed-video.h            |   7 +
 2 files changed, 174 insertions(+), 28 deletions(-)


base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
-- 
2.25.1



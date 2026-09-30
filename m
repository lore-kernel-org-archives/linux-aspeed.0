Return-Path: <linux-aspeed+bounces-5062-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF87FCA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 05:15:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvjt50Fppz2yn2;
	Wed, 30 Sep 2026 15:15:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790745325;
	cv=none; b=B6FIZNukulzxLojxPOvEiQfUF5obFZmMH6Al5uBuWixb0iauhqnBKvQf3MGqvbmY67oNNACxqTzAr+hYbAQff3Jv9IKGyXBgbft1vSVsyF4k32p7JPrDF3ofLvPFK8bPx/ddjqx80T4cU3q5Eq5p5U6xJMRvUSzMhu9VDoNRrp/X19b7FK/FZ8tLMCvtuyLY677RrfXhQr9sB095Ucf/SlMuFIanpQL7AHRaW/e9h0WR7psU51J7i0oMeO8enyLqaCiuOlYR84oJEQtA2s+qmsrtS+SutOdOHuUDNz9jQFjqYv3NRATWNdTh1s5ZTz4Xa10UM0Xn86qqbImuZ6eMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790745325; c=relaxed/relaxed;
	bh=xq1JLdoTMC21GchqZzbboOTemAtawiyGvXi9RSRs3mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DdjwxWdU/fdGzlEKcmzlwcHCmpiRPSSKmImT6NbbjR85KgnQK//CRkhIBsGNU1HtauTv5+juhJ7/vykcneg0ezTmp6ME6U2jCSWf5dCBZjHANlIrUezaIi6si0hW6J63gXkI3OlL3V+22waVj/PiP1LNm2Tr8Rb6rQ/c//OEtM5TvXhOT0ceEcIb6sdE/9MS1il4ip7zbZBTit9LCnkSkSyb23zh56Y35GNpYGTz4vhm3jSmHHoWVJxXgduoioqziWxuVXZu0iF8VrppMtzjABxcWMN3u87zbv3RogC0j751Q8ACqb3TAulhIRUZBSfUxAFzKVwWGbdspoKQsJZrqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvjt42Fqtz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 15:15:24 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Sep
 2026 13:15:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 30 Sep 2026 13:15:00 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 30 Sep 2026 13:14:59 +0800
Subject: [PATCH v4 1/9] EDAC/aspeed: Set the DIMM grain
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-edac-v4-1-c2e526f3ed79@aspeedtech.com>
References: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
In-Reply-To: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790745299; l=1202;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=3jMs/G66KFFfPwaucwRCSemgPoTboIC6tZoHaXof+m8=;
 b=sRf7TWL5EgGoyjxkzabJQ3BR3KN5+/hZwCavoxzhzcEykUwr4FbVallHrx6UpntmLwGpvb6tl
 +HF1wFm18J9Dk3vFfnFkIuQsSx/2Xn0ydiJAM2Hqq1CYB5SeTP6w60O
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

dimm->grain is never set, so every error is reported with a granularity
of zero, which edac_raw_mc_handle_error() warns about and substitutes
with 1.

The controller records the address of a failing access with 16-byte
granularity: MCR58 and MCR5C hold it in bits [30:4], with the low four
bits reserved. Set the grain to 16 accordingly.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v4:
- Explain where the grain value comes from rather than the warning it
  silences.
- Drop the Cc: stable tag.
---
 drivers/edac/aspeed_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 6e069b255595..83d60414f89a 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -266,6 +266,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 	dimm->mtype = dram_type;
 	dimm->edac_mode = EDAC_SECDED;
 	dimm->nr_pages = nr_pages / csrow->nr_channels;
+	dimm->grain = 16;
 
 	dev_dbg(mci->pdev, "initialized dimm with first_page=0x%lx and nr_pages=0x%x\n",
 		csrow->first_page, nr_pages);

-- 
2.34.1



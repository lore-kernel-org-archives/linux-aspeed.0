Return-Path: <linux-aspeed+bounces-5001-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FF2C982C1
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 05:31:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl6tW4WWGz2y2g;
	Wed, 16 Sep 2026 15:30:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789536659;
	cv=none; b=MG74lB1OZ1jo45RYmR55mytcPvnYnriIYcqyJYan7sOm6HGR+DFeHTDs2+oen9gFEK2YASo6OOWrKaqEYXTs8at5LGsnh8yt5RIwPThZicXp1g44yi0TwwItBro2mfyAusZoen5f9DzIUcC8JSRSDH19+ln0eXVQDnQa4vIg1Hk0CN1Y2a4BLlYTBWwzr6r1MGkbEAYOpFH/DOQnBV2zuc4DsC1/g7jtfmmIiIXjdsD4fVT3C2d+ZtUpcfcEdHl7gzY0gkrAlozM1JxH2PZ7LTTuPN5JP4MgR6R+DuSucNlEyk0kG4eBUDH1g1L/kDhz9cn4RIFk+/JKkEtsFoMb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789536659; c=relaxed/relaxed;
	bh=N6OJ989F/+0jEE5cnJJECukQ9CjEfoUAMRDFiLpoOLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dHZy6jwTlNJgkBZZ6IZlnUkLtzi8JMvxgl94bWs28sxk8L5xYKjNobpHEVGS9+J7zOzMbHZuhZVSLkMoQwGNA7E+uvF8Md6IqVEU2tp7xsppD1R9LSUYNx4g5gyqq/uzGPJB8UgIHVblJg/Wwaa+ElTFXZPz5xXpdsT+esL14W4XAOtckJRRkP8ss4R92p5qdor8OkOYscX6YLUL7QLQ+9jpy4eqpwzXTichvymzid+0RQr0MvqqYmTHI0vdGRqxGNywyTNluXrDtp+23wEr9tpgfid5r8noizn03cJ1/o5m9hfIWWckX0tVutJWGtmNpXDaJsMfWW/iu/Ob4qjzOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl6tV6fQwz2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 15:30:58 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 13:30:39 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 13:30:39 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 13:30:39 +0800
Subject: [PATCH v3 2/9] EDAC/aspeed: Set the DIMM grain
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
Message-ID: <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
In-Reply-To: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789536639; l=1310;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=HAKuO93Qq40zQKSxoIqd6AgYapN0t/tUgR+0VfcG6gw=;
 b=k8peKwOmXOBFuHMQSK0ghXR+FYW/m7H/6AI2VzTrrO1sXHEl+b9KuvUGFHf/KFg4o9x+4jo3D
 tAkcYH1/ijECed9CA9sU6/Zj//DxFYpe7ddb6IbXhi2e+4P31sHPnu7
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The driver never sets dimm->grain, leaving it zero. Since commit
3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
edac_raw_mc_handle_error() runs WARN_ON_ONCE(!e->grain) and forces the
grain to 1, so the first ECC error reported on any Aspeed BMC SoC emits a
warning splat, e.g. on the AST2600:

  WARNING: CPU: 0 PID: 0 at drivers/edac/edac_mc.c:924 edac_raw_mc_handle_error+0x4b4/0x604
  ...
  edac_raw_mc_handle_error from edac_mc_handle_error+0x364/0x4a8
  edac_mc_handle_error from count_rec+0xdc/0x124
  count_rec from mcr_isr+0x110/0x1e8

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: stable@vger.kernel.org
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



Return-Path: <linux-aspeed+bounces-4827-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11015C5DF9C
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 02:42:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSwF70r4Kz2y2c;
	Mon, 24 Aug 2026 12:42:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787539371;
	cv=none; b=Qze3DWxhMHQb2KEOowNb3X9rW4GG3aJPCa4namJYMRwkNxextVYGELFjfEOqCotLXoCpn32ZEx+QE3M7GsmjZttHH/uwl+OjA3VjwpDy+gqBG+goKDZ2cWFqn2nY9TbiQGDCq3bv7m3RF0X2S087cnSmLH2N//nPPLu/3hHi8/oAIfkvRD1t7lPJyjbF6kexqX0ythfRHVkX8BlIDDsJuVdJkSPrk3Yauz0DFFXjRulpMC4uGZCaNrnphxjRvWyj1Rvm/Pjmks6EgrtaZmnFZn3JiorX9pQquCaxmt3riwTsbBvuLUTHYXju7JFZxfFX0dHP1I+DrbGwN7mrb1V06A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787539371; c=relaxed/relaxed;
	bh=N6OJ989F/+0jEE5cnJJECukQ9CjEfoUAMRDFiLpoOLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BfEGfcIXyre9RjZ3sFSxr5dhA+/yaskdhaJHw11HaEv5RVp0Xu+HyOjqtBopjjCtDU3R0JyQI3ZyZDIsj/Qnoq5dNMOVQKYxIeeiMAtyB0+nlGkZnCDmQG+HTv2prsEzVfRzwAG1NC6AhtQTaCdHg5CPsmxxDuinFV/rmX+ybnsUuY/J6JPZ+4FX3Q4byDzhLmU2ooAatL8adk7Cb4UD2E3Z8sRyNO/fer/ez9+rouoi+bDtZ7Q2/EcH+EOguQaGd9FYG0ieiSJiYJeM1uimm0LUqskFmJ9nNqj1Hw056wIIBFMI03pxA97xZ13VTpGY+Hs5XOWO3TBe8o1MFqQpgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSwF62vxHz2xmk
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 12:42:50 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 24 Aug
 2026 10:42:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 24 Aug 2026 10:42:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 24 Aug 2026 10:42:29 +0800
Subject: [PATCH v2 2/8] EDAC/aspeed: Set the DIMM grain
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
Message-ID: <20260824-edac-v2-2-c8d8bb693586@aspeedtech.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
In-Reply-To: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787539349; l=1310;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=HAKuO93Qq40zQKSxoIqd6AgYapN0t/tUgR+0VfcG6gw=;
 b=pWMGHcJsIcNVW6fGk94Ijg8TINjEYsz1FD6Ls8QarH71DmsGHNYs0v+MeawD+m42IUSfAQtqJ
 Rx6vngxHGfQDWICRK+3nRef9Xsm4UkjhAOQp7WRYgmaaN6DkI5RH2vE
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



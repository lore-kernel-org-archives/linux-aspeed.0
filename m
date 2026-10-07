Return-Path: <linux-aspeed+bounces-5142-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ADDCA5FF1
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 Oct 2026 06:13:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j02r42wwdz30Cj;
	Wed, 07 Oct 2026 17:13:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791353620;
	cv=none; b=Aei866ObE+9w8AM64iD2dWtK4D1dIn1ttyKDmWOmpenffXlP2SS1wdtRP8xkRv2O9be57XEBUxnT47rXiBa1zyx+ZSyJDq9qRx96Vh1FVydoOSA8X80sWyDBSjYkJx6YKIluE+58GKG80tnvOOkR3NnQLrKOPHYTWVz0N0T+2/7lQFcmhcYu7UmQmoQZBmHEhnhVCVDm9t7DBHwhBvNC1gX03CcajBmiT2kvDq1fMlQ0+OSFS/ZpMGHC1bPFDQk+ka/q/nJRhLhXdPxzHpt2+pLsmJHz5bd9FvJOcCT/9OYuCEcW4pLmcSq3GaJIB3TKbOLiYP8dQgcmI6oUQoV48g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791353620; c=relaxed/relaxed;
	bh=xq1JLdoTMC21GchqZzbboOTemAtawiyGvXi9RSRs3mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OSUw65XOc+52stdqdqgCFXlTEu6Bh6vCFWrFLRko1fnuKDKVsw7DyAHK7YEr+TELtpiXJiyhlVAyfNaPpDD/VNWkxYACikXiY4VrdOAJ6gjXewiECFKy3pCJ9A/dA5iNEA8hmqza1sl2bd3Ry1cEFOQ4Drgc48z7OeR5ABqSOb0qXLxkJyBfOsxD2z4FKn5HIyK3UlhWGxXq/QJ8IZCMXrLatxr+NvW20jhYPN+YsxIkm1ii/8xi3dEYIqjUn4RTcKMXuyJWetg+oo/tUZ6rrLHEi+I8FWVSuQeFWRGWTqa+eaNhGfHKOSNbyC/HzsnG2ET0fIlL91Y7zen0xyX1eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j02r33qFVz2y8f
	for <linux-aspeed@lists.ozlabs.org>; Wed, 07 Oct 2026 17:13:39 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 7 Oct
 2026 14:13:19 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 7 Oct 2026 14:13:19 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 7 Oct 2026 14:13:18 +0800
Subject: [PATCH v5 1/9] EDAC/aspeed: Set the DIMM grain
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
Message-ID: <20261007-edac-v5-1-5c31fc5df4cf@aspeedtech.com>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
In-Reply-To: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791353599; l=1202;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=3jMs/G66KFFfPwaucwRCSemgPoTboIC6tZoHaXof+m8=;
 b=8klxYhALNIcnDU9rxQgLlX9iXKR9MBdSBhZHUokJNMoK+eXejvdeJxtynmt4GKmgt+fsE7FqR
 3SVr0rsitnWDb+jFvsZIxHTl4F3s+24zSZ08p2wDa+TWOey7Ap0l2xM
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



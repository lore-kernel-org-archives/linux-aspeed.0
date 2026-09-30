Return-Path: <linux-aspeed+bounces-5070-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5607C9830E
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 05:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvjtF6RQcz30DK;
	Wed, 30 Sep 2026 15:15:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790745333;
	cv=none; b=N3iV+gB1wQl1OLOJNOQOIU5gDU+NsJsrYvKUGPYlYFX7SwpL9YadcrfyriL9OLUUCgc0foADge3NUWbamLxN1WuZyWZjWoetdj+afUcbH/sYPDasVyngNaI/mAStw45QsNTl4YwAzNxZbdBrGQjdA0mXU9Ou2UuLFh69gJODysS/FWPNrbuMgpQOY08JKAf2+qmbKrq0fiDUlJw3o4HbNrwI5Hl+1/JYsAPwbVUaBjzkI1EHA+LI2U73KpBMG/aUsfdkKpMUAOA4VcWBX22v9e4LTG62J8X0b9+YjpPyDBV5f+cxkjS8+32J5NgspZk57nh6dgLwULxAaTIhzCFrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790745333; c=relaxed/relaxed;
	bh=/X2m62a78v/3gjrOVXpAmQisanBIpSXgnWT0Pnie/eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oVGV/1WeigBVq65ehGbdRvl0uZgUqSBg287trkGfrqGCsqtmnIvO2YsVR8JNViIZ8EfESKIlurSxOS7lriKYJQy3s7AceLPjoI+XW3+1mSoWXNRFbIPJwxAhNAK6hkde9RRh8WBa0IqlcbtjPqqfxrW7iY5w4kjlxdvrr4zRbsrXQGkusgUCyCBw0jIABtZBznTiCfZ2cUeOZFoCl5N6nUrCqS6fTWdXebY1jwyJ4nZvrXCjGVmEvJHjepOwnM0DzMU5mwVRtl3o7KOuJfGh9JhM2bVBjGUGHFVG28D3sKiv9BlLp8xrSh2s6gmdEWbWQnP8WXCL0gN2+gjDilSOqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvjtF06SKz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 15:15:33 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Sep
 2026 13:15:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 30 Sep 2026 13:15:00 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 30 Sep 2026 13:15:07 +0800
Subject: [PATCH v4 9/9] MAINTAINERS: Step down as Aspeed AST2500 EDAC
 driver maintainer
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
Message-ID: <20260930-edac-v4-9-c2e526f3ed79@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790745299; l=1860;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=0JAwcCSCddvZK+VJy0ySr5E6GGqKRb6s6URpXuDAV2s=;
 b=SRW3DY/LBt8IbrnG7P+7riWOpQaGuOT3/0PIom3r5pFRAH36Lisy/enbx/1uc4QeqgS2+fxuF
 VPnGrKlRwU9APVSN+LrUJdyuOv+cZpfndUasx6xHg26KZ5cHDL9CVtF
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

From: Stefan M Schaeckeler <sschaeck@cisco.com>

I am stepping down as a maintainer for drivers/edac/aspeed_edac.c and
Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml

Move my entry from the MAINTAINERS file to CREDITS to reflect my past
contributions.

[ ryan: keep the EDAC-AST2500 entry and list myself as its reviewer
  rather than removing it ]

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Link: https://lore.kernel.org/r/20260920225846.4039017-1-sschaeck@cisco.com

---
Changes in v4:
- Merge Stefan's step-down patch into this one, keeping the MAINTAINERS
  entry alive with a reviewer instead of removing it.

Changes in v3:
- New patch.
---
 CREDITS     | 8 ++++++++
 MAINTAINERS | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 091412875a66..28e5b274bc28 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3655,6 +3655,14 @@ D: I2O kernel layer (config, block, core, pci, net). I2O disk support for LILO
 D: XScale (IOP, IXP) porting and other random ARM bits
 S: Portland, OR
 
+N: Stefan Schaeckeler
+E: sschaeck@cisco.com
+E: schaecsn@gmx.net
+D: Author and initial maintainer of the Aspeed AST2500 EDAC driver
+S: 2253 Anna Dr.
+S: Santa Clara, CA 95050
+S: USA
+
 N: Eric Schenk
 E: Eric.Schenk@dna.lth.se
 D: Random kernel debugging.
diff --git a/MAINTAINERS b/MAINTAINERS
index d413dac5c8b3..2001466fd6da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9283,7 +9283,7 @@ F:	Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-cont
 F:	drivers/edac/armada_xp_*
 
 EDAC-AST2500
-M:	Stefan Schaeckeler <sschaeck@cisco.com>
+R:	Ryan Chen <ryan_chen@aspeedtech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 F:	drivers/edac/aspeed_edac.c

-- 
2.34.1



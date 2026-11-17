Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43C606A329
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Nov 2026 09:27:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTKBJ18Fzz2y7p;
	Tue, 17 Nov 2026 20:27:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794907624;
	cv=none; b=dBKtW/E3i39nxVV6xKHe0Blg0ibbpkkAegJIUj0UjnW+sY5VayJXsh2HJWPyEez6L1Nn1Fwjfgxm5pobHurAVVGJJW6Cki4G4eAAAbxc1yQMriclgBYGx3KacG3g+jgMYkY0iJgeMZHw2VprRwyefGE8rEUpKirwjhzczJYuMSGkZAg4rKhiI0ZQRGHdoALR6iJxd2nqezLKq7ZqBSIlw+8eQGWlBiHdsXEPRI3bqL0TC0Qw4xPvulVjkuV9siBu73BJxETDRRJjNq6F5Fg4zIbA1sB7vjmIrWbEqzgLydAJs3oOJ3N7570yQoPi3wxoFB/hksdDGUjSPoBcO4CM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794907624; c=relaxed/relaxed;
	bh=tCNcpdYzS1h9z75uWV4JWMmPtilPLs2wyFyWlzfH1ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mpWXsoc7Ug5N3DQf4I53HtCdmqVwtw6BhUe5jQIaypdP0EoVOFzFvcQETQ8k5xsenFUAnR+oVOwOgyy1tj1PSFHWe+kLTodKsjR1kjpQFXPCFxo65D0a60TnzFBZaeSwE6KvxC63So2/MO8DS9Zw3c4FQf67G6AUst4CJKJEHudm4M1HzEwL7xOCRFP22p9IVkXO4m6j8/vpY+5K/42fi+jELeqQhEZj002p4u3j+kcFkkmXluyR5ic3uLxUB9ft8Y5ssdraXRrC/ouDKeFTP2y+/f+LJB83EOarPJJSFSDQy/OgtY25OpVBH8pSe/nrxAyJyw6+O8hfdYQTN6ZELA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTKBH2Khjz2xNT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 20:27:03 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 17 Nov
 2026 17:26:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 17 Nov 2026 17:26:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 17 Nov 2026 17:26:41 +0800
Subject: [PATCH v6 4/4] MAINTAINERS: Step down as Aspeed AST2500 EDAC
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-edac-v6-4-a2a747b95c3f@aspeedtech.com>
References: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
In-Reply-To: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907599; l=2944;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=G3PC/QkgRIYDVHFsxEsU/LG3WHjKg5hH8g0SdTPjZw4=;
 b=KMCJnXPhve+kYZ2DEpKVTeP88yz8bHQQ2oNWm+Tsdn2iOFU7AHBCeaG+NRY5VT99nP4Jva8/K
 bxwD9zb/AsZDdNMWMe7KrRJoH0cDAqGE3FCBerM4Iikv3O5mpa4k5Bv
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan M Schaeckeler <sschaeck@cisco.com>

I am stepping down as a maintainer for drivers/edac/aspeed_edac.c and
Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml

Move my entry from the MAINTAINERS file to CREDITS to reflect my past
contributions.

[ ryan: keep the EDAC-AST2500 entry and list myself as its reviewer
  rather than removing it, and take over the binding's maintainers
  field ]

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
Link: https://lore.kernel.org/r/20260920225846.4039017-1-sschaeck@cisco.com
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v5:
- Also hand over the maintainers field inside the binding, which
  get_maintainer.pl reads directly for .yaml files.

Changes in v4:
- Merge Stefan's step-down patch into this one, keeping the MAINTAINERS
  entry alive with a reviewer instead of removing it.

Changes in v3:
- New patch.
---
 CREDITS                                                           | 8 ++++++++
 .../devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml       | 2 +-
 MAINTAINERS                                                       | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index c6c7b173b064..855062c309fe 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3696,6 +3696,14 @@ D: I2O kernel layer (config, block, core, pci, net). I2O disk support for LILO
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
diff --git a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
index 685b6815f293..971d4c862fe7 100644
--- a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
+++ b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Aspeed BMC SoC SDRAM EDAC controller
 
 maintainers:
-  - Stefan Schaeckeler <sschaeck@cisco.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
 
 description: >
   The Aspeed BMC SoCs support DDR memory with and without ECC (error
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..323b2f90536d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9607,7 +9607,7 @@ F:	Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-cont
 F:	drivers/edac/armada_xp_*
 
 EDAC-AST2500
-M:	Stefan Schaeckeler <sschaeck@cisco.com>
+R:	Ryan Chen <ryan_chen@aspeedtech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 F:	drivers/edac/aspeed_edac.c

-- 
2.34.1



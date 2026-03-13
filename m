Return-Path: <linux-aspeed+bounces-3648-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945FA106FD7E
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 05:28:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXCgh4gdzz3cJk;
	Fri, 13 Mar 2026 16:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773379696;
	cv=none; b=Ya6JlxrUTXVS1Cfw6fjZmE/WzTyr/FK/ETPnFwS2Ll+ReEfKznaVHwSJhBL6AQmrdMpkLiewdkHFq+z7RfENoeQrxxNkmaKAZFEN7ILB94OOLbRgpkD1RM8nHc71gMdYtyU8gwMzrsJmoplGoiv15Hls+I4ZfWV9NANof/qYP4SCc64P1HENCbCyVEU8xpJzsM5KhI3dq1aiTkMBlBCewIMNXcIMBiyshsc4XueYpNQBwMeRvbvMsgpdzTxfw31nDjRo4D6i0kVS8TSF6wuaBjq06zUc+JxeAkgBNKxnCBBeGlM7ypMkI59nbxSiCTsVn0EOVsdPQqMw7X92Zuj4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773379696; c=relaxed/relaxed;
	bh=IXtnoRotPROYOYKxJSTjckOFDlJ3Utg3vHGH+uXFmpM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=KRwcaxGI3yiBZKpxYcm9pWv/w93R1N8N8VavGd+DmzjFh2TrHFSt2yJHJC8xTeei4N20hFp4R0vprjSPVFQrpisNq40ZhGdCYRX1hdtbga6ZuDfu7icEB6PIemQVCWG1bM8LP4Tv2CXYjXyCzpd4p34FMJrrxcInsuVbXtzPvJhYsLrRX4rcBuKQ2pCaivDMP3n7gheE422CxqYG7J4o09YJ9sUSdfWZY88KUieGunXiUFARXfHCrnjzBB6tlm0W7K+0ZZacizrlKFN+KcgRR+mkZVJSoP7pWj1wSYAu9+xgY686IlNTjn4FfKBfxXMdOa84YV3jDnBBGcvZ/cY8EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXCgg3sppz3cGM;
	Fri, 13 Mar 2026 16:28:14 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/2] Add AST2700 support for aspeed sdhci
Date: Fri, 13 Mar 2026 13:27:55 +0800
Message-ID: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAFugs2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3eKUjORMXSMzyxRjQ8u0lKSUVCWg2oKi1LTMCrA50bG1tQDY/8O
 hVwAAAA==
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=705;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=SB7CAsVDuvC/UzUyKBRMDViK4RWtIuE3C0YGThbJYq0=;
 b=Sz8w6I60BX3Vi3i6P7kBBwzTQn0pfRzJThSD8zp37uZ+jJVimsrLjFNIOak0m2xEst+vT2F/N
 95Y8AtIXkKEDQuF/Bwnobj6YtdVzMRtuzaTwuVCBBZe58KT3vWTrK/H
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (2):
      dt-bindings: mmc: sdhci-of-aspeed : Add ast2700 support
      mmc: sdhci-of-aspeed: Add ast2700 support

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c                      | 11 +++++++++++
 2 files changed, 27 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>



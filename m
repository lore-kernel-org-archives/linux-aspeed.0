Return-Path: <linux-aspeed+bounces-2398-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA01CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Oct 2025 08:37:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cgqJ43YzRz2yrm;
	Tue,  7 Oct 2025 19:37:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759826228;
	cv=none; b=JAosn8P6sd4Zgu/39RCB8b0mXie3+qzqo8mBm9rNAZA4P8ZVtD//YhpgFY1lDEmPOoDuXyLoqgMPEnkEtX5F7i4RW9qB71qxzYo06ftPpCyaYuJgt9fciVM/+mY7yzYLitvjx/j29ulKMJrPI6nwri7m9Sbx99LXw6K7eL/Hl1H1OhkBEeaPWVG9M5Z6EZz5jEOKSehHu8EZWCYpJDs3uV8UTmz1Gadc2xDajpa9dNt8BC3iifAoxSHojuJ34Ay8KgkQrTOuOHTU//8rUjwKlimqn1BsbCX1ny6qfcyOIBetMIP54eS0/xHjebYEj2m7bDvJOzYWfL5lrWk0aHiVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759826228; c=relaxed/relaxed;
	bh=Dck1va/eGadxAFdg/gijOPpFVMRz2tdp7YlK569suxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3+yRc7+EZqsQ0VEd0VYBBgm4F5Chs1yDpFTpgPAgAZYIbYOeG1wfn3zmbmb9NwKnVz49teQS1MQ0XmrKNhGX4cDMyDXC5rZmyV2cF9F5WIOAEXH538ErfxUBjJGgPMtViC7P/lrLmNBdYZA9FA/9aydpE9dof06wx7paFxXnz+EauYXjo0j09wJjiwNwfJaPwvM5U2SnT28EMtsAbvrqPQ4hT/ro6FpUeDzqvGFgB/HovJBIEkyWFQZ6Fpe6kEdPM3pxggurFI6vrwBhOfTiDHIHglFZ1+pJAqFzCOTZpb7MG212tgC2ja0kyVUYzFgmkwTyj4d447J+IEkhRi1+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cgqJ33zFtz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Oct 2025 19:37:06 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 7 Oct
 2025 16:36:50 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 7 Oct 2025 16:36:50 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH 0/3] watchdog: aspeed: Add AST2700 support
Date: Tue, 7 Oct 2025 16:36:47 +0800
Message-ID: <20251007083650.2155317-1-chin-ting_kuo@aspeedtech.com>
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

This patch series improves the ASPEED watchdog driver to support newer
AST2700 SoC. It enhances reset mask handling to accommodate platforms
with multiple registers, adds AST2700-specific configuration, and
updates the device tree bindings accordingly.

Chin-Ting Kuo (3):
  dt-bindings: watchdog: aspeed,ast2400-wdt: Add support for AST2700
  watchdog: aspeed: Support variable number of reset mask registers
  watchdog: aspeed: Add support for AST2700 platform

 .../bindings/watchdog/aspeed,ast2400-wdt.yaml |   8 +-
 drivers/watchdog/aspeed_wdt.c                 |  31 +++-
 include/dt-bindings/watchdog/aspeed-wdt.h     | 138 ++++++++++++++++++
 3 files changed, 169 insertions(+), 8 deletions(-)

-- 
2.34.1



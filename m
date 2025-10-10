Return-Path: <linux-aspeed+bounces-2413-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF497CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjfPv0L99z2xQ0;
	Fri, 10 Oct 2025 19:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760083410;
	cv=none; b=fJqnX3rJlKBapa0UPOkUT4jjRjoNctofSYRd74nNRlY3MqvhShHYu5g1IB/SYFNQ6TjhoROIggQGaHgJiB1M72hhEFxzVd4WQjEgmT5lfppgI0r3sdiiU7X/hqXQh018y5H3tkCBxXOJersbIu4BgGHQU4WwQ7pgZQ+qE96zf7Wbq/b1Qn+Xgcgh2M1mAGpJ59F5Fcz+WieNzzUar/ez1J6wBLU7hQPghk1pkD36E/oB+d7xOmW4sgjMXPReClaekb+ZxVP9K31Gk5EU3u1IMgmt7c1HUoo1XhsMJv3KT4NA6cN3gWXWrMwi5nhpLUtvSOM1iCWYMyYz3rZaj/q8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760083410; c=relaxed/relaxed;
	bh=JMk9hcJAy3ZVMhG6YSM/xH04IxQZbcaAsPWvqEY86e0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxrxeXIR4usBqrHtpOHX6NfbhXwNIf/MP464ZHRFbhj7RJ6nhy2EFSUDs5Jltw+fiq7d3zEiO4tpXuKkpL1WUVksdk+EX+XLTFubxGmpMAYmOegEjcK+5/e8dVvT1hASmHjXVt45ksQeAUhVHPH4YuXkquQa1p+F/vUSyRPE/tpVRwh/k3RTJSlo2oKEXByvN0D+gGP6Vb5rIO8W0/gKbCOAwpitHmGuJG2JSZqUErH9pmQNnjBzTnb+1PYUaStYNcwwEacvwebYeNIeHcQdmWhF0ndWnr34jm//s2TNJcVGT8rnqIE8drFSULr0LraI+pc65plyt8lkodiQgouo4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjfPt2XRgz2xK1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 19:03:29 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 10 Oct
 2025 16:03:15 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 10 Oct 2025 16:03:15 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH v2 0/3] watchdog: aspeed: Add AST2700 support
Date: Fri, 10 Oct 2025 16:03:12 +0800
Message-ID: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
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

Changes in v2:
  - Removed 'num_reset_masks' field from AST2400 platform configuration.
  - Simplify 'if' contional statement for platforms after AST2400.

Chin-Ting Kuo (3):
  dt-bindings: watchdog: aspeed,ast2400-wdt: Add support for AST2700
  watchdog: aspeed: Support variable number of reset mask registers
  watchdog: aspeed: Add support for AST2700 platform

 .../bindings/watchdog/aspeed,ast2400-wdt.yaml |   8 +-
 drivers/watchdog/aspeed_wdt.c                 |  30 +++-
 include/dt-bindings/watchdog/aspeed-wdt.h     | 138 ++++++++++++++++++
 3 files changed, 167 insertions(+), 9 deletions(-)

-- 
2.34.1



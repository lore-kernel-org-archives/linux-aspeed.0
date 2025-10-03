Return-Path: <linux-aspeed+bounces-2389-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB9CAC5B8
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 01:59:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdBfY68b3z3cxn;
	Fri,  3 Oct 2025 11:59:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759456741;
	cv=none; b=YdFkXqUdS0OG0EFIwI2H9r2VHOSMGXfKAH4ziXQJNemq4rIqtjjQ26qiyoSiLqhQN6ENE8EpVoFuHDdvpKFF7h46qzsCLRIIbbfl7TH2FSJCAGOnp8KcosRFU7+WkqME380CdwybjXCcmCU1mqaEYzyskjPw2qRdNAhsGP5hY4HPHrsMmZuV+lMhzYQibKd6KDk6s+SM+5jioIKNstZQLScKa2/zBcVG6Htg19ONeGkyejTyqw7+Qs8vhBhLNmaUuPcMuvSTZzRyfdvcMYJj6+/2EpZP3P8rxpCmanLwN/SGzVKBngxlIfGjPV/mAVTT9/swHEQRFJKKSV/42Up3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759456741; c=relaxed/relaxed;
	bh=6e66eEW12onx6EDljKtOSazUXDVJ2aQXuZ6H7WvYQ3M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VncQMxA/sfukptwZOgl5cCw/p6tbX702DYRnA+FBTfP56+CPisG3hYmvmmSHIOOZGKMsWIGWcurMzVPvDhqya5FR5rCyRls5xsyho7D98sE5yhTfCy2ISP/UHkllOBUPu+BfJoz1G79Q2wxprIg/v0yeIr7vURcgHt0oui+RyI4a9SzkyjWm4Zth37uxuRkY5+3CIimQRzbo2MEY4jbJ4kp3QqEK4vkcB+oLSmyPJq0zCoO042pMo8K0qZL+JrVbHYOPSFCjTvsQAA9vBWQ6VUNVHAe/bNfSzVVisssA9Yjw6ObecX4VnWKb0YcKcgmdJT3KHaFn74lmzfIAMud+Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdBfY2gWsz3cnv
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 11:59:01 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 3 Oct
 2025 09:58:45 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 3 Oct 2025 09:58:45 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: aspeed: Add VIDEO reset definition
Date: Fri, 3 Oct 2025 09:58:44 +0800
Message-ID: <20251003015845.2715538-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
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

ASPEED clock controller provides a couple of resets. Add the define of
video to allow referring to it.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2 changes:
  - Update index of ASPEED_RESET_VIDEO
---
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index 06d568382c77..671e5a476eae 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -53,5 +53,6 @@
 #define ASPEED_RESET_AHB		8
 #define ASPEED_RESET_CRT1		9
 #define ASPEED_RESET_HACE		10
+#define ASPEED_RESET_VIDEO		11
 
 #endif
-- 
2.25.1



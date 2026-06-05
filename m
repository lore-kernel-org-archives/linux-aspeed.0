Return-Path: <linux-aspeed+bounces-4189-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DDECD8C89
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Jun 2026 02:42:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXMyv5cFmz2xMW;
	Sat, 06 Jun 2026 12:42:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780639246;
	cv=none; b=b3ZM4cq4QcbWgE7KtNK4wWBnTwMx5MchcAdM/UG+an+sAmv8m3LXULVFUhmnAL4FODlYsfbCWAy2/Xq+lVTJBZseQuPDAuMTqPHeuoD6QriQGvVSD3Ea4wl5AJaFbDM+U7PgTCEoOQ94axwcEAfKDHd36Z3VzOvtIdVZ69mPhoqJ6h5nSR40SDcpL3kF9n7RdIJCIInzSUzDgczQ9RHe4ZhlB3h+rGalrPmgHcNXoT01pn6Nk6BX879pwTPSqMQUUi+iHnndjPCrgHIzhwsYxkEbm503Wsv/4VjTDgXnMw9mPqmu1muSlelWQc1mjh1PFIgl5YOdQno3Y269Xy8PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780639246; c=relaxed/relaxed;
	bh=GD2Kr06zQNFkIwrVrOalWnuCkNJUXETOOuvMASHG1wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhdhQmrKWtNEmySbH9YAO6eGCxSMJ0YuQA9m8XrLwkSDO7dg5dv/tZ4DZTgL/VBV0Frt6awxhO7+t2g1m+KR9goUDI0wCy+pDm9Hb07bN28ENzIhq5x5+gOfGAFAvWN/CAKX923KRHQRKp/ChRY0I3X+ODj6Cn3mm/alEGDCB/K0TOz4Id5/qIetuACjUPur70xDrknCro+CrGsMwozYuEIaVPq9kxnnAK5A7cx9ss8kGcCYR5WW5/g5rU9JAF+Qo1XuPP73Uhshs2beTYiiSTMGeKHPtqKi8ZvY4iq4573abMx1l5vU0cqLRctqWoguNQavyVtruxV5W6AK8wjZHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DbmCziOv; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DbmCziOv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrQL3xh6z2xnK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Jun 2026 16:00:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GD
	2Kr06zQNFkIwrVrOalWnuCkNJUXETOOuvMASHG1wc=; b=DbmCziOv5IknDVlK99
	daj1ffrq+HwEfO5hUp3zaUPHJ4mWsF+C0X1NdDeCRGSFmnlioqmZ+X+YV/rurLl9
	mBh+mTkxRqhtKkkPog+n9w1wGobIRA0raergS38laMxKw/+RLEz+nlQ58ctS4w4i
	6LLVuZ74B58zsqIPOawbfVo34=
Received: from haiyue-pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXkGE7ZSJqxsLwAQ--.65168S4;
	Fri, 05 Jun 2026 13:57:18 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Jammy Huang <jammy_huang@aspeedtech.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] ARM: dts: aspeed: add 'resets' to video node
Date: Fri,  5 Jun 2026 13:52:43 +0800
Message-ID: <20260605055712.118501-3-haiyuewa@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605055712.118501-1-haiyuewa@163.com>
References: <20260605055712.118501-1-haiyuewa@163.com>
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
X-CM-TRANSID:PCgvCgAXkGE7ZSJqxsLwAQ--.65168S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr48Kr18WFy5Kw1UtF43Wrg_yoW8ury5pa
	y7Cr4kX3ySgF45t34UGFyDKr1DAay5JF4rKrsIk34UXry3X3sYqr1ftrsag34UXrs5uw1S
	gF1xXr9Fqw1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE3xhJUUUUU=
X-Originating-IP: [116.233.237.18]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbCzh+L9moiZT+z1QAA3Y

The aspeed video (be compatible for ast2400, ast2500, ast2600) now needs
the reset DTS handle specified, otherwise it will fail to load:

[    4.809494] aspeed-video 1e700000.video: irq 57
[    4.809977] aspeed-video 1e700000.video: Unable to get reset
[    4.810341] aspeed-video 1e700000.video: probe with driver aspeed-video failed with error -2

Fixes: e83f8dd668ea ("media: aspeed: Fix dram hang at res-change")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 1 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index c3d4d916c69b..1547e28d77e2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -242,6 +242,7 @@ video: video@1e700000 {
 					 <&syscon ASPEED_CLK_GATE_ECLK>;
 				clock-names = "vclk", "eclk";
 				interrupts = <7>;
+				resets = <&syscon ASPEED_RESET_VIDEO>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 39500bdb4747..793570ca2518 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -296,6 +296,7 @@ video: video@1e700000 {
 					 <&syscon ASPEED_CLK_GATE_ECLK>;
 				clock-names = "vclk", "eclk";
 				interrupts = <7>;
+				resets = <&syscon ASPEED_RESET_VIDEO>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..3adf48987a17 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -428,6 +428,7 @@ video: video@1e700000 {
 					 <&syscon ASPEED_CLK_GATE_ECLK>;
 				clock-names = "vclk", "eclk";
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				resets = <&syscon ASPEED_RESET_VIDEO>;
 				status = "disabled";
 			};
 
-- 
2.54.0



Return-Path: <linux-aspeed+bounces-3579-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBF0EB3640
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 23:23:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPw352b44z3blr;
	Tue, 03 Mar 2026 10:23:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772414276;
	cv=none; b=cLRfC9BhGKA6PiuUfdVgwTeXQllk/JNjUSnGMA6cuP47/x+ZejYJLiCxjZPCGKoKVCoek7m4cbvNPepx/ox3mAh/6fOBHOmwhmlohBiwNdoY8Z6h/uOcBG/70ibytI+L8cKrou8w1aWy9ieeVASlBLr6r7OwkzRUNDPXEHToWBZUo4aWSVt2d9etTHVjGNIvyVk1wYu8/A2VWJrLAPiUwEcQak22olYSMo1n7g2zP16KyaDDU06T5uWojFdU+ZPELMT3UkLmNnUPX7Cte2NKAfwCr0PTlGDec3jF2QLZrgfwqdnH5Lt5IFiqCt/zq0MQsq42NtNvtWXNJodzBPaR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772414276; c=relaxed/relaxed;
	bh=fMwaBvqdwYCjJQBl60E8qyyHxhDXj5rHW+g0XPefEf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/Mj2uSxi12jqe8641onQVirURKi/13LVPPwqUks8Gy6eRyU5u9ZOnKWLV1uJj3jBuNSEsG6z84qwB7/q7Y9okmJP3lvqTl4R+Txzljq59XLtanJMyaHarZHa9zbyxXW5FN6v6hC2FJHKHZtq+1m/j2Ac8iuW8hkaCYw23egvO7aSED0eMsd/Cno+1ZtKMrhGtHMaxv/2XmZVqC2FNLpbaS18vmgmWw+MqxWLKJqytK3oO3vNTara51Dv9aI+uY2gh0G0LTlAG+kCnGQWZv2uRxCVw419aKD2bRARN1N7S92O0CCHhoAOxvxXVfR4aeJ4x7KmTOMhbIjyRIJxbSgkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYi5EIq/; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYi5EIq/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPLdv4z08z2xNC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 12:17:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fM
	waBvqdwYCjJQBl60E8qyyHxhDXj5rHW+g0XPefEf8=; b=qYi5EIq/ksoq9K+9lh
	ObDrsAS9VavUW3mHISZqo6tHuQhdDGpOYJmCP+77HveSohuaq1py+Sl42Dt2v/uc
	8FET4fTUF7cdyM+gKt9qj+flSi+Y/u4s+GEBUyJx2ESCGw/Vp+hK3iMemkOneKDJ
	E3j/oHMr0pg5H/JGBZPV+BVRA=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHyX4F5aRpmz8NOQ--.15911S3;
	Mon, 02 Mar 2026 09:16:56 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jammy Huang <jammy_huang@aspeedtech.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] ARM: dts: aspeed: add 'resets' to video node
Date: Mon,  2 Mar 2026 09:15:01 +0800
Message-ID: <20260302011651.94682-2-haiyuewa@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302011651.94682-1-haiyuewa@163.com>
References: <20260302011651.94682-1-haiyuewa@163.com>
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
X-CM-TRANSID:_____wDHyX4F5aRpmz8NOQ--.15911S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr48Kr18WFy5Kw1UtF43Wrg_yoW8ury5pa
	y7Cr4kX3ySgF45t34UGFyDKr1DAay5JF4rKrsIk34UXry3X3sYqr1ftrsag34UXrs5uw1S
	gF1xXr9Fqw1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEYL9UUUUUU=
X-Originating-IP: [116.233.47.41]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC7wj+ammk5Qi9hwAA3p

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
2.53.0



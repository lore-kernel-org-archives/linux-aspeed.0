Return-Path: <linux-aspeed+bounces-3565-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED9EFD0072
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 00:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPKHs21qbz2xR4;
	Mon, 02 Mar 2026 11:17:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772196169;
	cv=none; b=cA0MFKlD4c16RmNoR7PMUbogMPLoVbdNDO6hGrf34kpEHzz9ut+BIshjfgQU+gvJsVhvdWJfYUyLgjJ9pcBTlMciggLxmzn1VvBb+PkLCYrDoTGYrHWyvoPEV2v+l98D09rhmLB7K5/PC7wWsvJ22/NgJlZmaFen5xK95uWV+hok+jS1gGuyATB3SHfucCyUlY9U0eWbDvhOjVSG9mtFo6qj625OZ+mnNdBeRTNOXsAfXEuVCiqPvcL6xEb5MObfAprZRtdBEb1LBVDIludj4vzVNrmg0xItbLDvVHCUXNjRgDCDMuaPmm985kf5e82Fd1cIeSBZqM/swqy+XghLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772196169; c=relaxed/relaxed;
	bh=NXTTrP09ok8P1ADALF0SM5UyW54TzFEn7w+8c0zTzDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J54qQtzK3jPCvC0RVi0PgrAR8Zkk4nAVZXBPSd4qsi6vX7Fbpn4BLz4hI0SV+4ShNyaRPkNsigqPPMePZK374GHXm9xhDlqwSVsyJkHtbYZ4Th5xd3K7Qif7//bWcVqUI7obxGu4faUZQynS8ZTdpzMnTnMdUK5QHahHlDjv0FSQCIrsqTmz9NEB7OuaaLSy86aHSixwOwNzixZAi+AF3NgZPG9XybyhYpL2m19y+OvpzwP97MZjCDQ/il3exAqh0pb+veLRwX+P4S7s34MiIclCD/2P/Ib6NFKSFFiTf1sKBK9HWGm5vsVtDdDbtVLUx/X7JucyYMuFGACz7jfDHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KZvqmy3m; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KZvqmy3m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 164 seconds by postgrey-1.37 at boromir; Fri, 27 Feb 2026 23:42:44 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMnzS3wKfz30N8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Feb 2026 23:42:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NX
	TTrP09ok8P1ADALF0SM5UyW54TzFEn7w+8c0zTzDU=; b=KZvqmy3mWTikNkQyaz
	q9CZknh6ZVkKzVdWMH0Z/djgs5syMgzsZUtcH1SfhRohy0uAMYPdTD+S+Lr88GBV
	ArCknp5cNn4fskWfepxhVLgZCmpyGpyWRQri1T9Z3e5EM8EN+rZ41gG1bGK2EO1m
	ihtJCUtCvkUe6D4krGETxHvhc=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCHdgpQkKFphei7Mw--.10871S2;
	Fri, 27 Feb 2026 20:38:42 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-aspeed@lists.ozlabs.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Jammy Huang <jammy_huang@aspeedtech.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list),
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v1] media: aspeed: Fix driver probe failure
Date: Fri, 27 Feb 2026 20:38:24 +0800
Message-ID: <20260227123837.70079-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.53.0
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
X-CM-TRANSID:_____wCHdgpQkKFphei7Mw--.10871S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1fKF45tF17Gw4DZw47Arb_yoW5Ww48pa
	yUCFWvq3ySgF45t34UGF9rKr1kAa15JF4F9rsIk34UXrW3X3sYqr1ftrZaq34UXr4kCw1a
	gFn7Xr9Fqw1kXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_sjjJUUUUU=
X-Originating-IP: [101.228.113.192]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC7xL6ZmmhkFLb7wAA3f

The aspeed video (be compatible for ast2400, ast2500, ast2600) now needs
the reset DTS handle specified, otherwise it will fail to load:

[    0.000000] OF: reserved mem: initialized node video, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0xbb000000..0xbeffffff (65536 KiB) map reusable video
[    0.377039] videodev: Linux video capture interface: v2.00
[    4.809494] aspeed-video 1e700000.video: irq 57
[    4.809977] aspeed-video 1e700000.video: Unable to get reset
[    4.810341] aspeed-video 1e700000.video: probe with driver aspeed-video failed with error -2

Fixes: e83f8dd668ea ("media: aspeed: Fix dram hang at res-change")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi   | 1 +
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi   | 1 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi   | 1 +
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 4 files changed, 4 insertions(+)

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
 
diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index f60fff261130..7b9b80c38a8b 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -124,6 +124,7 @@
 #define ASPEED_RESET_PCIE_RC_OEN	18
 #define ASPEED_RESET_MAC2		12
 #define ASPEED_RESET_MAC1		11
+#define ASPEED_RESET_VIDEO		6
 #define ASPEED_RESET_PCI_DP		5
 #define ASPEED_RESET_HACE		4
 #define ASPEED_RESET_AHB		1
-- 
2.53.0



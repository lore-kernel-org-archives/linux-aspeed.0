Return-Path: <linux-aspeed+bounces-4310-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DCCC43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 00:03:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpRMG2FvSz2yT0;
	Mon, 29 Jun 2026 10:03:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782538110;
	cv=none; b=IeTi8P7WjljYf91i21k04UnOGn8vRNNUZn2QJDpkAwogSDqxtw6LEjbEJLV348+gBQGvYfDkt5qRQTCDRFqM1ZyjC/e4w+GamnHxOwXrVzU8zzCiWMJBTf1dEt05EeOvkigZJc1CxRmztEtXSG/Q7Eu9a8JgyCmIbYxKbLrFWA6rFmf26TKMzEEnP20vACvnNBqRJ5Idv0MWf5yKr8cfbfdUytFZc2NBku3Ku5P/T2LmdBrLS6H1D5yw5+HFZp31gN79niHQvSxQdC4PlFGgMGTWik+fmXgZUZwsqikQrjmgfyFbgcLhMZd6LKYzhBYPb9oACQssv3s+skiT5nTEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782538110; c=relaxed/relaxed;
	bh=SjDo9zkPqh5G3a4cJVEabwQF/qW3EfvDIzwridmYrhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuQjmlhUbKsfEzRvcJ9dWiuVSCUpeQR+VYFP/99HStBqVxT5mE439eRPsa4h68MU9qLbHhD4Q7OTPEzV5OvhplbeDOc3zZGcAD7hzLmaQECS/3wEWDbxAWVeZpQHQayvo5WcRAJcyQNmTzFSJ8Ba74ENCfCRaQVfBxZDufKKzsvg8u9pZWNNtXNJMpXxhcPUcnMIGdoUA+egar5eOlQLb5QS8Gy5P/cZugENWtcCU0lDbt28r1mDqm9z6oN7occ/cWe5+6UsW1VqzLubdVGueCItERXE7ZTxn2uu8TYjzpx15vjTeUAhqewSJ8nxtmfsftzhRxW7UTwlrArK7j/nzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TCkjbpfR; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TCkjbpfR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnLfz0XSGz2xVK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 27 Jun 2026 15:28:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sj
	Do9zkPqh5G3a4cJVEabwQF/qW3EfvDIzwridmYrhk=; b=TCkjbpfRH/7tLfUjmQ
	qzbCkOInafayZdvaCXmqft3mb286eZg7/1lTSWRC1pQdBbu1flSG7PRhq1WgEIyM
	FAoo4nzx1vL/wSIHWAbg8wM+LENOBProUGbnROs0me2vuPTNOJAE8VHriVp1U+AX
	90hIu53qkfUfBhSdBpOTQsKhU=
Received: from haiyue-pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXCwMxXz9qZPylEg--.40725S2;
	Sat, 27 Jun 2026 13:27:15 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: devicetree@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Haiyue Wang <haiyuewa@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] ARM: dts: aspeed: g6: Use KCS AST2600 compatible string
Date: Sat, 27 Jun 2026 13:27:07 +0800
Message-ID: <20260627052708.172918-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.54.0
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
X-CM-TRANSID:PigvCgBXCwMxXz9qZPylEg--.40725S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4DCFyUZFy3XrW3AryDtrb_yoW8AF43pa
	909aykX39aqw4aq3WDWF1ktr4kJ3yrAF4DK39xAayUJF9Fg34IqF43tF4xKFsrXr4kuwnI
	qF18CFyqqr1DWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRj0P-UUUUU=
X-Originating-IP: [101.228.92.86]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbCzRRPumo-XzQRUwAA3Q

As the commit 2596f6b93a60 ("ipmi: kcs: aspeed: Add AST2600 compatible
string") does, change the AST2600 DTS file to use kcs ast2600 compatible
string.

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..774d5af495fb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -585,7 +585,7 @@ lpc: lpc@1e789000 {
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				kcs1: kcs@24 {
-					compatible = "aspeed,ast2500-kcs-bmc-v2";
+					compatible = "aspeed,ast2600-kcs-bmc";
 					reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
@@ -594,7 +594,7 @@ kcs1: kcs@24 {
 				};
 
 				kcs2: kcs@28 {
-					compatible = "aspeed,ast2500-kcs-bmc-v2";
+					compatible = "aspeed,ast2600-kcs-bmc";
 					reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
@@ -602,7 +602,7 @@ kcs2: kcs@28 {
 				};
 
 				kcs3: kcs@2c {
-					compatible = "aspeed,ast2500-kcs-bmc-v2";
+					compatible = "aspeed,ast2600-kcs-bmc";
 					reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
@@ -610,7 +610,7 @@ kcs3: kcs@2c {
 				};
 
 				kcs4: kcs@114 {
-					compatible = "aspeed,ast2500-kcs-bmc-v2";
+					compatible = "aspeed,ast2600-kcs-bmc";
 					reg = <0x114 0x1>, <0x118 0x1>, <0x11c 0x1>;
 					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
-- 
2.54.0



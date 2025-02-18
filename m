Return-Path: <linux-aspeed+bounces-764-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF4C021A9
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 03:17:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yxl8M6FWKz2ykZ;
	Tue, 18 Feb 2025 14:17:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739848675;
	cv=none; b=IxDQxHDhFlMJP32M3OH/eXhPXO/5YjpSttsc2+EQ6G4Cf3TC70VY7o1AiDgJfmnd2DiTZlz1ah3od+nvdvOU2xWfCN06DPraYuizSTly/uA5YRWyrNAepZxyX+vbGF4tJ11yox/PiBq+834zLFANJ5jZopq+ZyVUjYxR+uGKxzyN6Wzcp5cf4IFlwh98PwbEoCQ99nDYSExMasTBG16Z4I7aHaG4oEf+s6nq0Iwa1iSgfiFtFegMsxNeRHr8d4DzAswXq0hrSJ0t3wrsgW3YFO4N1Ce+pbWzmd/C2qHa7vl2oi9OD++rw7QcnSOUarhqeJZfuNqjHjuq3lRr1uNmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739848675; c=relaxed/relaxed;
	bh=qcI8nIfaXpTXXB2w65+9gPwAA9jaOdswF4r0vXF6+pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyjjog1n8LYqD8M1ipz2+2P1BLwbhJMgmPCMFbmQnjmxmIIPewDsn8N5nP+qFwBfEzWN8StgGM+jD1x7aSZhw0/MI3w3LteljP1mHwRJ5X2NdHIgVJge1n5Imll9HodhELZLhFTR7dEXzbI1zB2MHiNuLmBu5S+VbB9dbnjnR7iavZMD7IaecyNF8rBcJl9MdkZAwA/q/7A1TQ2avh+9DhA623FR2AbArfValH19KAP4OUqvpuNVYzJM3OkSP31VfIWFi8tKbz16zPdlO9rtRzFeztQpWjGMK6qZrbTM/iiMhEijlzi73SofSIrPrP2R0t4oc98LY6SxGV26+oUF/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VOj0ha5Z; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=guoheyi@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VOj0ha5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=guoheyi@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yxl8M0FQ9z2yh2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 14:17:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739848671; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qcI8nIfaXpTXXB2w65+9gPwAA9jaOdswF4r0vXF6+pw=;
	b=VOj0ha5ZgWDUXmYhhPQ8C2sUYJYBUwsC4aLe77L3HOKfFclP36tbaI+OkOVc/jlgrI4L7L2dFZxhbYDddaldvd3ptBhWU9Q3jAlNU4fIIRz00rrSrLh/2fgXGcMADuHOshsWtg9UERY4BNqZmdVU3R0BKWBpyjdJtXNE5Eu6FWQ=
Received: from 03382176d5c3.tbsite.net(mailfrom:guoheyi@linux.alibaba.com fp:SMTPD_---0WPk8Nyz_1739848648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 11:17:49 +0800
From: Heyi Guo <guoheyi@linux.alibaba.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Heyi Guo <guoheyi@linux.alibaba.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH 2/2] ARM: dts: aspeed: aspeed-g6.dtsi: enable IRQ for watchdogs
Date: Tue, 18 Feb 2025 11:16:59 +0800
Message-ID: <20250218031709.103823-2-guoheyi@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To finally enable watchdog pretimeout function.

Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..ef7ced285c44 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -538,23 +538,27 @@ uart5: serial@1e784000 {
 			wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785000 0x40>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			wdt2: watchdog@1e785040 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785040 0x40>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			wdt3: watchdog@1e785080 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785080 0x40>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e7850C0 0x40>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.43.0



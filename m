Return-Path: <linux-aspeed+bounces-2076-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7AFCA0FF9
	for <linux-aspeed@archiver.kernel.org>; Fri, 29 Aug 2025 21:13:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cD9wn4SfQz2yfL;
	Sat, 30 Aug 2025 07:13:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756502009;
	cv=none; b=hTNe/qny+xkaUyE+8cvq8hDB5iVwZq8zF7LifIXmIbU8TeVhUtZCX/nGct5MMd7mynbHGoFt3BrfNeEZkhRWqHRuBb0B0Y14Q8L0kGroLrsNaWfMYSdwZ5cjUvNVmYX1nJYW51ZzJBz61jZAg6Ra8CLdtIIUvhL1OMbnG837u8v6e1YWuK4j+Z8uFyzyb64cA3MTOZ8sqNBsPxC7uCHtlu1u0bT6ILaSIMMKfZVuD26xuq6UkbcAmawyJZaPawfEKVjQQ0GVt+A2YdNArI2ysvNRcife9l8Rq0yZvYOQk5kbDKZVzrLki7n0D1pNHGvKE4purP2SNUlOuIhg1X8POA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756502009; c=relaxed/relaxed;
	bh=CpNW+UpYRuDgoqyyFwuwIoZVC63FH8kw8PohDDp4+kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwY/uGepV4QDJZG3EBaDiU0eZPmPMNRRUmVFdi0vkyDVa+PUCgv/8qDI6UcQfoNEwr72P8fZ/cYgPZV5PYX5fLl/FZu9eTubLXcsWHfOaYqWS9rGYi+mQqZOmOqwa5GGhNulDfMh6167HRVMmH11G6lMwqcC5NildlV/AOlS4xBLL0NupH0NVLvjJ8JOnazNuJdZW4eetNfVBVmggCzcfIovypwxu/cAvWyA5T37BUpQc/k1Fh+vv1gRCc+OzjuZ7nX62wIbajpG3ieOnblA1cC+un7RnJGnVaex09vYxeUCq4CyCwAwfHvnxWGHa+sgvV6ev2JCTcCkWkPqnl/muw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aqXMinr0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aqXMinr0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cD9wm6Pygz2yMw
	for <linux-aspeed@lists.ozlabs.org>; Sat, 30 Aug 2025 07:13:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F3EE60142;
	Fri, 29 Aug 2025 21:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADEDC4CEF0;
	Fri, 29 Aug 2025 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756502006;
	bh=JZ0CWieAD+hPk8tcHz5WX7FBAOxPPfeaj0F6aTNx4zg=;
	h=From:To:Cc:Subject:Date:From;
	b=aqXMinr0mzFFf3X/Qxc61FXYoalDlBqS+T9E1Unr43Jv3nAytC2tYjUPS8H7H6aVJ
	 GOOcOMlX0CXlYaFGiD27NXRr6HQ+SPdQtw0AWMhcAsTraMdIqeXvwt7wyAbxCUvIN0
	 Yfl4/n2cRQ25OMuhUDPlqNL5ICChxRmnh6CY5k70wMMb6ZrK42UyVCUsEJjV2NnoEo
	 YNJ9OFyNjVmn0mEL4PF5QprtjxR9P2jDbL/y0UA/oQ65w6ScBRIiajsb0shF1ITVaO
	 SjJ1Ix36+X83Zpk5cDCNdUhLYB4cGUQf30kfNc0U2n9TO3FefHDBroMbaItRVUnR3V
	 zrlPT9+9a6G9g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Drop "sdhci" compatibles
Date: Fri, 29 Aug 2025 16:13:17 -0500
Message-ID: <20250829211318.1335862-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
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

The "sdhci" compatible is not documented nor very useful on its own given
the various features and quirks of SDHCI implementations.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index acdb6ae74b27..61983feb2a4e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -662,7 +662,7 @@ sdc: sdc@1e740000 {
 				status = "disabled";
 
 				sdhci0: sdhci@1e740100 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x100 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
@@ -671,7 +671,7 @@ sdhci0: sdhci@1e740100 {
 				};
 
 				sdhci1: sdhci@1e740200 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x200 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
-- 
2.50.1



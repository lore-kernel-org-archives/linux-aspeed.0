Return-Path: <linux-aspeed+bounces-1869-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D692EC87FCA
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcY2vNqz2ySY;
	Fri,  1 Aug 2025 08:12:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999965;
	cv=none; b=TE23WRwfUuNK+1xi4AuvRGWR2vNHpDe96sbU2o4dUOXaWS3sFOXxtZryb0//Sb9D25WDDp17iZhyyHdXRvz2ABmZB+3TTUSSaocW1REUIOPFs1eXxgmb51FTikpia6fjscfkUjYzf5MSuNqmn9BhB/kbpapewEZGbFsEhNRXCqR6Y6v1w36odpvYtULKcuvBE90/jSpK+MvyrI6tpFi8AE4t5eF8VjT99CclNcMo3ud4EsfWWb1aPsP6AHJsu601jKALJAaQ6tdpiBjdumt1F3EB4+2/6mBPkMV6GmKCVEjVtrKaICP7DWJwv+mnLMu5Jqut7uh7CRWghDHT0DEISA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999965; c=relaxed/relaxed;
	bh=Y2NGcQHepQEbDwK1/helvLsNzofswCWPbS6vNwKd9Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV+vCjiN9s1zfAuOLNwg2sKESdWAU+1vUCw2sa0XnJSIhhy9JScI3ffoK6akieOy/univBfnLVtTqvB68TuiiLN9LxuDFcfoOCcSXEXYVZ81PNKBvas2jepqUnJGEHehpbs32Pdzuz9Y/LfcXCx8XEQ4SqED2Vp0qI8OwlbDGClTb8EP8AVq5+v60Qpantt8Uc4+7O4qMPZPYuMeGZdeGAc+/p2BCovXKVXrNNNWa3qhUCdUl8lE3gpfap31QGqEtkAPuANuOAxwfEHWKzldW0m1SWgA/5nVlt/Q/O+oGMfwbj1L7YUtgwRAmrcBhpFBVEXJmAIwwmXH3JQn/ZFblA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r8+yQ7J9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r8+yQ7J9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcX0kn6z2yD5;
	Fri,  1 Aug 2025 08:12:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A44D6112C;
	Thu, 31 Jul 2025 22:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA040C4CEEF;
	Thu, 31 Jul 2025 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999960;
	bh=cfyyeN6Mb/ojJhksgCO4DWogxFkAIMP5MsCuIL3s2YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8+yQ7J97MSgjECdZIEpPz29v94q0XLnMmAmK2wKV/FeSbIh3sAdiodOLVBHToGsa
	 JyE7pZIcE2Ub9FFFAZTd6zo7jKpRSLN+0dJVSoeeR9IA8uiclLH99KXbDgwCOa+L9c
	 zR8d2LIhi089je4vkNYTVcG39wWMQSQT0atXVG09MCB8IBLeX2+dlc2dU4kCiyMeAM
	 MDZiTuwsPs9csc/aiQTANOSooPHM1VbPYrvNKdJadQ5Ds+UWUMEnCU1gogLjfl4QsL
	 KuC59InQMObYKalpvPNkwqKwDqLffkwDooCVXzA9uIxkmhMW6vDZfugLL+Lwos32Hu
	 QvYjfh2eNYuaA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:18 -0500
Subject: [PATCH 1/6] ARM: dts: aspeed: Drop "no-gpio-delays"
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
Message-Id: <20250731-dt-fsi-cleanups-v1-1-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

The "no-gpios-delays" property only applies to the "fsi-master-gpio"
binding and not the "aspeed,ast2[45]00-cf-fsi-master" binding. It
doesn't really make sense either as the timing is controlled by the
offloaded firmware.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts | 1 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts      | 1 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
index 78a5656ef75d..f42254ba6aeb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
@@ -57,7 +57,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
index b1d0ff85d397..e5b8d07e7622 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
@@ -80,7 +80,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
index 24df24ad9c80..2180fa9b6f24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
@@ -71,7 +71,6 @@ fsi: gpio-fsi {
 		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
 
 		memory-region = <&coldfire_memory>;
 		aspeed,sram = <&sram>;

-- 
2.47.2



Return-Path: <linux-aspeed+bounces-4630-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF5FC56205
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:58:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnS03KQNz3046;
	Thu, 06 Aug 2026 09:58:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934995;
	cv=none; b=dKIlzDQdkjxlimOyXJPRKR1Aw1O/z8Ypf3nu25OtMFODoIw1qi1ONbaS1Iq0vrb1GzVZU9uxMlSsblSKaXbZvvTsIuNEytJwWpc/0mrMaUliGFtVTAp6hySuNPDu/MMhG3cY/Pg+ul57QwVVfnd6YAU1suPPu99MBzyAgzcdLGOR9rZtCiu1UNzqz9oRhgUVO9XXjxY/QiwFznrtaTB94qyeaTjgvON7VJfjIhPAxsjNze/ot0+5JpWNjtU6NmdyputgEeerrix5BUNiAoBnFaovv3LoEZW2TaJ/rCalq5j/ZJb51BoCEcLMaGxbqD11C1gr1nWfhqr9yZ0i1CFgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934995; c=relaxed/relaxed;
	bh=d0tywJCfbOhm61+aKB7StJw/Wnlb1AmUDCDWwg2YRD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAqep+3+bnkIjxAu1Lfz+xFK6wKra681nk0cb8YytDE3k5XDP4/JhyY/x0Fp0a6mSFf8jeCsAe29PwAUqvm5OHPi4TNVfvAZwclH2xk/+dHWouP3uBsjrYvqAwA9x0p1PLvMhFenW81TkkK3EX1YNfNBR7IX8fGVpSZrTM/OwSj0APwG+8/qRYxgCYgUIFsIY+Ifv3eHsRccfJW4sogce77A5Z0mk9U4AUhyNcF2eAr3okRvejArqPAiGISdoUa/0hJ2Cv8sVRiSD4FgXR8GQArVZCY5up/LCGcjvaiHkxHrB0RgY1XdEG0TwehMxd6DmF6z4Yl9YdqitjxuoBxA4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eWqxjPCj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eWqxjPCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvk6PH4z30B0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 41D3243A6A;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E649C2BD04;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934989;
	bh=LdloDJM8DI8AB4ZLQsP/+vZzjiWKgFCiLWLBMA7iRMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eWqxjPCjwCfgR/epli6oVNNb/qBgurRKnG61rPed6+cNt7L/dr9Z8+pnPQD5UJL6E
	 01SNxuHOmj5fxEGa9Ip2EVYLTUvCvBSCit4R4tJKXKRyex+1Un7VH2P1HdD/T/FfU/
	 h2V5/hP3C/CkCm61TvoAJa1rUllapXYRKgtHGUzlTVm4avFViBo9KbdshM8WwKk3PR
	 pT49Xa6XkhP8984wDU8lWYaqCPKFiLBXPLRaRfrH1fU5Bek/Puy/BNanNC4ujzj6gc
	 jwoRF1BDuWCGs6R8c/6WEdZ6hlz+xNt/DUF9LLUuVbPQw2k7Qn6HfrlGoq8WqzaE6F
	 dggNI0Ky+oATQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09059C56207;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:33 +0800
Subject: [PATCH v4 05/12] ARM: dts: aspeed: anacapa: Add additional EEPROM
 node for SCM
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
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-5-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=1250;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=NAF+xcmhfBdWvCk+Ea9KmPCdarcFxDgMq2cQBYIvfaY=;
 b=wpqf0DC+1LYoo74qwFuJLHClCkzNFOqzu9etJpRAXMv19z6UtEFsANYU7piTdC53+d2rvOpU9
 ELG5mCU+j7QAQmdgL6n//ZCOtfQ4pb/yTyh9KNGmWK8vfT0Xu05wZ9k
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

The SCM FRU EEPROM I2C address differs between SCM revisions:
- Rev B uses address 0x50
- Rev C/D/E/F and later use address 0x51

Add an additional AT24C128 EEPROM node at 0x51 on i2c9 so the same
device tree can support multiple SCM revisions.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index 4a6ae7c6cbf8..1901a325c72c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -8,6 +8,20 @@ / {
 	compatible = "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
 };
 
+// SCM
+&i2c9 {
+
+	// SCM FRU
+	// | DC-SCM Rev        | Slave address of eeprom  |
+	// |-------------------|--------------------------|
+	// | Rev B             | 0x50                     |
+	// | Rev C/D/E/F/above | 0x51                     |
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+};
+
 &sgpiom0 {
 	ngpios = <128>;
 	bus-frequency = <2000000>;

-- 
2.34.1




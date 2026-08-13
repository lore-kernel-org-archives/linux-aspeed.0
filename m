Return-Path: <linux-aspeed+bounces-4713-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C653C5DF67
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7G1D6Xz2yv9;
	Fri, 14 Aug 2026 10:46:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622407;
	cv=none; b=F8Mxyrt0eAZZDtICAa9WpJJ7qkfp2MJRBspDRqFqYc3n1Me0/W0xMDkyDHbTFBBusTokBGvF04Qq5uRZNHBxJfhk3Kk9fI00MWFtyi6QdinTHBeFsNYmfpmIfICnBgh/YwXivHqleETORy106ArZv+VdgDGMT+2SKLUt/iXZStsrPTfCB10cFo1VokittNUf6nfSVk4nI4sDwJcdSMWFOIzOM6REOf5t4GUHWcgqfkKiimmdPhPDuzEUSmgg11AxMsv2/7Yh4621GNSf6CWdJ+oQK7U/nEDcLUsDVtl8yZrXeVeTauyYwflE0OSBIeeOqr/9BP/uHsvSegTMTp8p8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622407; c=relaxed/relaxed;
	bh=X7+46xUhDdpJ5WOOvhru9CtiWKcPRuQPn7W3aBJaaKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiY6Kpehb8aKE4jHD7PydKlO3laVHBfAoMCmV2o2/hgenNmwhmjlfvk3kbYJ1x6S4qk/YJQ3tw/vy26e1NrStPiGztglX4d56Z183bPwrfsXrrpeGl7Owd8DfeSNYuW8Dc6za2sWh/tfqltkwMxjAcTcsJJOtkBgcwgHYzrkyeG5pkaKbTm7Gp6TVuORVwQabqzYVFHi7e/QwzPU7jsv9/z8DiWbNLQZiMVomHD8W2AMPnRxLSVga7mhMP/RDoxiubkomzEiJ/FBhQNNtI6C5iqCrAcWUEdQTpVloMcEP76Q/Gow44S9jfR1vymx+CZ+6AnQ/AF6Ef3DOdj42FxFaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mV9ZD6KO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mV9ZD6KO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP776kG0z2ySS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BBFD60A69;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A92B0C2BCF7;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622401;
	bh=QuSGcF61AVWkzhKL0jYfDHaSvxefEdFczuPQKJ89HbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mV9ZD6KORpZX3aSre9b73YbK5k3GbWTd2UbuLiYJ7or8Ps/V8z5rQVjXPTmPxEp2f
	 zcctvfeaVzeetgQ+romqdBE9j4/ia6RfZDioB+0sPIicz5ma4uQPH49bbp77fDs4VE
	 23i3kvhrsvCTGCeSz9sLGm5mfPU4jSCjksVnIJs4/64m9IrU8+vg36VOaH9+cawZaS
	 /O4P10T9Gq8iKWjw5YxKpd1yDVYRQz6TjECyCU8fQCJmu6ERXErDOwykjkeJ3soHl0
	 1lYr/Nyadt+ZZ3APPXsyNyhR0b+h+WLc5vEMoVgAGTQOGaiw1ERuJDvfd7ysQ8xx4i
	 Win88jo8o1oqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA88C5DF6E;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:44 +0800
Subject: [PATCH v5 14/15] ARM: dts: aspeed: anacapa: Use default SPI2
 memory mapping
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-14-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=819;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=oxTF20CYiA7RH6T7z/fDB4EwQ1KdT7fYEEX/g/uzaW4=;
 b=yqV5uqb6ufRzAE5RQBXJYWysUIhzgVy0VSJP+HK2eco3jzvaBlc5EzKqNhmEsySCR4W0wyfZJ
 +muB2m33F5VC6z+kLptDpOQkx5MBIr9Br537nLY+hjPowEzW6s4nKP+
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Remove the board-specific SPI2 reg property override and rely on the
default SPI2 memory window definition provided by aspeed-g6.dtsi.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index f27ec52f9d56..d613b5b9d6b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -1062,7 +1062,6 @@ &sgpiom0 {
 
 // BIOS Flash
 &spi2 {
-	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
 	pinctrl-0 = <&pinctrl_spi2_default>;
 
 	pinctrl-names = "default";

-- 
2.34.1




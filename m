Return-Path: <linux-aspeed+bounces-4705-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD063C5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:40:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk0N2Prwz2yrW;
	Fri, 14 Aug 2026 10:40:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622403;
	cv=none; b=SwqSzm0owvbJgsyrF+jkJcgAKfnLwxF3qsUaKt1zLdHaTh45Gplg1P1f8j4wufoaO02TRDXIYvMPwQ1JqNGd2CWp0tgGJdzkpDrX83lugJLT+OTd7NMBbaVEfgL2XgEBMW9BbGfUeS4bgzhPSZL4416/gTs4B4XK9akp1DokbVx8ud4n1wizMLzIkPLOJZuBYLP1OZ7Lc8lIEO+qJAT1/wJWHqufoqiB6hx2Y8t1tZDxf00GIDCY9UAb7xf5l5tKP78x3aTmF7fPaz8f6Tx28Xz+lwe7WW3lUMJ/kb1GxLxwsShxi8lVD5myG0M2Zj9vaARMtS53aFmffnw2nAjjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622403; c=relaxed/relaxed;
	bh=6dZeeWW4zswGFXRIdcHQCGueQ0cZnamc2cT7yvBaiNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LekXFWZLF1muf3FROubWjEpHkpL5afe2zIK7/qVDXro1x9uncQV6C4rxQ4wYoYx0OlMCOdYJD1Q7ux37M8Mz27OaG503hnNFM5iFK6wyCyF7tL2Uw1CJO+IVQIwRMP73RyT9329Wjx3qRD3EY9CIOLJMeQ/FBTgSv+e3LuJ3A6t4ZtrbnKeD4OtegdzqyHcUiEzpFY3ai9vGQOd/iOHpH18q3cOQCFS2R3a7affc2gqTjv7hCAs0GiPObAINiG8ps2iQgkacrLbB2UDyDfQ2cGr0ssdRXiZ6bW7U7tk2AgkH3dPb+GvxLw8f/nYse1NX9Bq4ijgZq2mrxAeE80Z35Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PefcQlh6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PefcQlh6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP762TZSz2yjR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A0C0844060;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC72C2BD00;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=FoLZfGD6uyaU5BQXg5Am0hO9ZEAWctWsieG0YVFNjNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PefcQlh6zJF3yqBV7Pro1oH+U96FS4z8irsFo7cGWB0KYbEJW9XnQq0Iy2Y0p4vER
	 23VgKDqIzIx/sGicoE7ArYXblLXemamjRiziUV2W2F9cIR8RvAEm8TgvWfNOrnHB0+
	 CdET7ijOCyrLxxw9vMME67nhYjx4H8uGAMSQeRe0f7k6WLstVKeszeNldKxM6+0vRY
	 oa1JX6zbbNXFefM1xwcOQwvYOH1ZqTi0tOeHKQrQds+H1aE033GOnJreXE9fSDznva
	 7q9NL952mfbKwHuz/2zmuUtaf9I4PCfkUwowPwIBJ4krlauxoN8naK2sIAT28e8wpJ
	 SXycH123+c+aQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052BC5DF69;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:36 +0800
Subject: [PATCH v5 06/15] ARM: dts: aspeed: anacapa: Add eeprom device node
 for NFC adaptor board
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-6-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=854;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ogPWoxlP9zHHWVbVILynjOOXZGqV6RgIxVGA6kDFSUc=;
 b=Xzj5DalG+aiFRpcfA+06+fcwnTU8Td1CoS3EF2nJ5pr8VMxHJSPZM4kgMCqrGfQel1OgpTWXY
 m6bbLJwFz0HB/09rm20/yqzgZ50lBUxpVgIiwp7Djc447ulFCRvaS15
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for NFC adaptor board FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index 1901a325c72c..c7bffa7c6557 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -22,6 +22,19 @@ eeprom@51 {
 	};
 };
 
+// MB
+&i2c13 {
+	i2c-mux@70 {
+		i2c13mux0ch7: i2c@7 {
+			// NFC adaptor board FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	ngpios = <128>;
 	bus-frequency = <2000000>;

-- 
2.34.1




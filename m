Return-Path: <linux-aspeed+bounces-4168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045E8CD6E5D
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:53:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVSL63YqWz3brx;
	Wed, 03 Jun 2026 09:52:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780406708;
	cv=none; b=AYq6lAawR1AfQOk+RtnP/FisJ+RPZ/9lXP2HvxWlUq08AtRuAhUK9z/D+DqZHBJpgfpgVGKWo0Xrz8GpQigj2jfnwAqWT+hW7eFJSq5UJXIF1jFzlivGiWJ4znG9W6sctzz8FzlOhzq/HJiyHi0NdRgF3q+xyjDoQ2lJK+YCK5sS9pQAIONnuH4mBsRNeBGi9VYINfvKXpncYWfzHUMSiqSrHvnePwaz6ymToZ2+LNBaxf2gemZgdkEcpeHgYIMSGGivXPAW/Sv2lk+KR1B8IDMG0J9u5Q2j+ssqO0IXF5FD3pTR7KsotJ9jLMX7p6uhrOzt6Qgf5kRbkzlnWM0aBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780406708; c=relaxed/relaxed;
	bh=6zK3xk2yZo53VPvYzSpZ2PWjU0ZQuUZEgekgDa8WCxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b08YBf6vTnvZeunm+A6D2VbFNiF7nAoeXzOyUfBqscm7pEN+6Rc0HIapolL9uLNCxUGd/Al/FcJZXR217riaQ4Dlc4aXK932+13uS3wQffabNArgb8Y7mRvttYbxKDu42arJ38qg5fkaPr/rXMMAhO4v2YMT2fNftKAaTf+U9vwIKJC7CgWlxpdOHCYVuJNBWouD70n6+sEeueBJdml2ZcskmQwdu+JMR45357R2dWafvwkf+3bBcnvS8zvWwJl7dTLHxVR8213IikxEYn0JRbZPeT6q/oO83BV+ch7oIUQRuWJ5aH6D8H4WVyYqcOOCUSsZw5mBRHrQ3u/MbR3VJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSmsgLwc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSmsgLwc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVBQW3d80z2yFK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 23:25:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E1DD8445C8;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C396BC2BCF6;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780406704;
	bh=EjotxEbMB+szyjtOIRNVh8lq/E3vDcvELOmiSw0FuEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NSmsgLwcyb8Jga/Le8HYzEuPxeHnWmLT+6DhHWI+Ol1ceSN0T9AUskv60qLN+uWqg
	 BXs4QS0nPQ+HbGsttNqO9cUr4FVdr5+lYMWlw2PtOV5VF8sTtemhpKwoiRo7TJHQba
	 pziqWp4UT7yQS77mXScqVexscDTxH6zZl0JRazeo9UnZWcSwqU8fThp+tHwRaHhv+H
	 b75PKTdt6xuRyisCznystZG+7ADJJBTnV2Nfcv2gXqyAkxrpcLeVy0nMPggE/1SMOU
	 F7V5plg5G3E/aPpDnp2qNzoVf7EmJQQR5qaGioJCsrYeZqlClGvIukRli3uS6r44Li
	 OtMKlYGK5leqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC404CD6E64;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 02 Jun 2026 21:25:00 +0800
Subject: [PATCH v3 5/9] ARM: dts: aspeed: anacapa: add additional EEPROM
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
Message-Id: <20260602-anacapa-devlop-phase-devicetree-v3-5-7c93c5df8d9b@gmail.com>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780406700; l=1254;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=JNSi9zvNDBr20hXdrUAD8fki2+glqxRtqyS9+sPSXtI=;
 b=7qxVVc2K+G5UI7RLH/zsUDCta5GZfv382bCspCgoqEXC1NFTk4UV8+rp/7akLxMJBUw6beR8J
 YHOFQJ7QH3VA1Irad2bjEVXXMo63pmsj4OgcJGlkoeFXtghTsEcOGsd
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index 9314ee493c61..1d2f46e83be8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -593,11 +593,20 @@ &i2c9 {
 	status = "okay";
 
 	// SCM FRU
+	// | DC-SCM Rev        | Slave address of eeprom  |
+	// |-------------------|--------------------------|
+	// | Rev B             | 0x50                     |
+	// | Rev C/D/E/F/above | 0x51                     |
 	eeprom@50 {
 		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
 
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
 	// BSM FRU
 	eeprom@56 {
 		compatible = "atmel,24c64";

-- 
2.34.1




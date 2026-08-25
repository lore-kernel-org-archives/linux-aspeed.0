Return-Path: <linux-aspeed+bounces-4859-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86579C61DBD
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:16:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4tj0FFZz2ybK;
	Wed, 26 Aug 2026 10:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654924;
	cv=none; b=kzvzaRu2skp/DI4ZphTxwUsbtvfUEkoaDQAA+tVAUW++3/hfxwYVNX+RhhL0eUgo5HmlkbyXKyJbUeBFc4NcIAEtCwKUaPIu5pWe+qryG45SrzZsJbBV4hOBbWZWzB9xvY7uLJffbu/XRJc/cz+imCuDIxBLgnOW8pRpc9w1ULZ4EvBsLFBro6bCobUGALWmAFVD98DTLFeR6OIy0shlzCcMXvVi8OiRIHFy/nK0dunJ7k8DqH5jVAvmqc28Ml3k5mtsIX7tLdfu2G+gGV2440zSTr474tqURruKKy3n6cX1Bmm4K8+zlcvDyvBthUzGq+T9uyZXSnHKYmIAm4nL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654924; c=relaxed/relaxed;
	bh=BNtgxBnxtR7jtl9YL2LKSwYhSH3qspaVlCZnLRUaWyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9rvTOddrXzkS+Qhk0vDKpeyTDMfKi35r1wF2SkYAt2CphaQEMOQKBtj9U+xBXIBRVxc+7Q1kwaw+mbTbJ53B1n1BEttL5H1LLGlbUjEv2FhsfoC44raTQUxBWE6U4A+ZEfnGFxCrpJjklcq8m/cp4ovL7XcIzXWOMsXD5CU2vSWjPE0GZ5ECVhfUxiClYhu3yVOgoDaoKH7uL+rHT96njGCiE9mB6Am7gFwBk4G1Frug3dUfYeieMzoqpY0LdN9rj3Rz2rx5Hnu8M1wvnm03QQP7DxbnU+rWFJBJSalak5ALNw5aHlqh8tARp68qqMgXW3zMbyR/yg80u82bz+r0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i9XvgZsO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i9XvgZsO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzH6Bkmz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C7D344E9D;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 535A9C2BD01;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654920;
	bh=wAwBTsf3GkIlrHwbVtRdn+g/x5eJ9jnUFDqj54HbqqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i9XvgZsOzRwVgbl4s0RN+eeMo/VatgD1nDeMLWst42HtLlcmGa8Uuz1ZJhRRX3mIm
	 uxV7jFR+cq9TAyFGi5kxtqWYo/dSMzRshcFonTQdy36PvG238uIZ6ZcC1CnL9OkdcB
	 h2CKADzv8jio5Q4J+lC8+WTyiVekEvnonuB8ytmA/sx5jmaEH3kQYJNpsYaNh90pXL
	 tTrZdop9aSi+a5tX4G8q7x6BMmDtJRfQjIdiX/Ld9FznDR0EsTlRUky0XqfG6Fk1Ev
	 ZtuI8IlF+9ab41dVgivnSqwvOIlkPGbnq48Pt0W4eqlx1xgWFQnGg7TUY0Ol3ZAtxk
	 b/b5qA+J7s1mA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F66C61DBE;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 18:47:46 +0800
Subject: [PATCH v6 05/12] ARM: dts: aspeed: anacapa: Add additional EEPROM
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
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-5-9059a2a279ce@gmail.com>
References: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
In-Reply-To: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=1224;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=6bqaYqKHlIwRPbR4gPkyIhffT51cOaBU7ByQ/FJQMrw=;
 b=XMu0Lx/noo3Yw4GhiYGV3uBQBVNQwxetTW3BuNLfMxGfGVAjhSLlcpJ1GPO/6ErE0vg0SL8e+
 i8f/ZdGC4EgAUpb33SHEAvvzThzQk2Ducd4TDuZjNGdmY992hmkH7GZ
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
index 075ac39f369f..d2b4855ff1ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -8,6 +8,20 @@ / {
 	model = "Facebook Anacapa BMC";
 };
 
+// SCM
+&i2c9 {
+	// SCM FRU
+	// | DC-SCM Rev        | Slave address of eeprom  |
+	// |-------------------|--------------------------|
+	// | Rev B             | 0x50                     |
+	// | Rev C/D/E/F/above | 0x51                     |
+
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+};
+
 &sgpiom0 {
 	bus-frequency = <2000000>;
 	gpio-line-names =

-- 
2.34.1




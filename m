Return-Path: <linux-aspeed+bounces-4915-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99483C61DD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:16:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNYv4tHFz2y2h;
	Wed, 02 Sep 2026 10:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264947;
	cv=none; b=Kumfxf3Sj3LxwqE+cz6I0bw7VWrgDZepCg92pXJbqrh104xECQi513JuXNL6KfDaUFt9eLIj279lLKKHUT7oO/2oMSz6egDTXw6WhOcqnBe0Rcz+l0lIFOv0Lq9zzdySlazPzf5g2eYdvtP0N5OUzhYkhzz4xEh+bNt9CF6wyfubZ2dLDpVPlH59wyylfYi1yiiDp13BpqEjIvD9fsNBDxShzkCMHTiwWLcXjUYPoA0YeXyh76NZTkgobyHhmhr1DOSV4UaD4KoydTge3Tq1EE/kyTkT12ArofTePDweS2KngN4wzgAgPchNhKn5UMsVvukh6ZC1MuYjLqkEz+ly1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264947; c=relaxed/relaxed;
	bh=BNFGinQI2xxDQSHsVslGyftcgPlDSK5olqCUv4EtRWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFUZG8YAkylT7TrszDL96UTBWFcz2Uj2Nbp3j8SYS3+6ZXzQFivaNgLXnF8nm4IAM6PffhbGm2tcyUkBHG8WHYaelLnELoFocwxszplvbxezHI+h/+fG2nSRYhRG/5oVO8Ca3/dqGufwE+KswxwAVn3NEdpUMpBjo9BICmW6yDmqG5Ah4cw/v5gqmXN04daY8Z79+bxZcyirEHixzqEy/GM8uDoaniqvmoYag9M/JkNQRWDwHphpDthbyhQITuZF5O9Lb+erztclkVENqKOWSDK/aUmezgVg6jqAuifwZcVarLhUumolQDJtGRoM9NfPD5FJIBcJxw3Ytc/hn0bWsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pooBuwYF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pooBuwYF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZT6jPPz2xGt
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B76360A5B;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB69EC32782;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264942;
	bh=nLtePXYENm7NHGSWbCsuDcLkBfW5HOLPz4P0eN7JISM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pooBuwYF+3uhA/orhnYs7yb4I/U3WwmcfYZXXbCj9/emrIHguFFRt+1DrFqXmilhf
	 omdqR7LoDDjj+ovDHlk+EDHihc7UvRXUv0WNRwP3MXDYhIsAWculTF9CJNlzj2ftHG
	 5lb0Qph0QIMSlUD6T022cdXCLkWQWGCWQOvEt5EB4tqRUGbM44FpoZCgXiOA7Hznj7
	 Woz3FhQz2nAAkqAx7pvsn2OpFFM80BBu7fA4t++octG7kHkuZCkbisbQJOQX2Ll0gf
	 MXncZ3nKRAWKK3i2Cd00FFD0uJiXIciBFr6fVDwQue/f0wKKkwsgxMJaRXRQmqppXN
	 4FCYm2dVE6AAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2FC624D4;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 20:15:19 +0800
Subject: [PATCH v7 04/11] ARM: dts: aspeed: anacapa: Add additional EEPROM
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
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-4-0bd71d2e0105@gmail.com>
References: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
In-Reply-To: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264931; l=1234;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=GjfjnpwE0tmhDKN4idVs7q9lvt+oOtXIm3xFGJyXtAY=;
 b=Xjyj/YLgnxmwvUG2EhkLAICBwMcmiu0PNukR8Dn+YySCsoeSBHer5ExcGt1nrjDMqJ4Kkndn2
 UATSXoO6RtdDHgZj+20c2BxO3mekWoae7CTzBwAXuf04gjN7lJrXQtT
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
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index be7f17ad5f8e..77126418a702 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -3,6 +3,20 @@
 /dts-v1/;
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
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
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1




Return-Path: <linux-aspeed+bounces-3508-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A30EE9461D
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 23:06:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f90fz3mQKz2ydq;
	Tue, 10 Feb 2026 10:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770603967;
	cv=none; b=D1RfIj4CQB9BKUP4UIaj4WYS+zE/zjkVpWVb5fvqUfb4SIg20+YzrlYK1DqBJMQWly12rxaYhofhUpkHFgIWBTq+vJqUVh/lHZ+P6x8s0hFaLm+TV+ipTr0Cv+FX31INYp0LhnYgt59oPtwYDxY4qydp2x27ej+XdxsmrTIvWyRp+C341xa/WVoL8xynlKKyAzHHe0bebC3q8eFHrGvNLd9vPJNte/CXhBfDM+0nHODNQJkGdk57kJsZHwnmuRvYvgZ9Z+qUl44EQI/dksBzyso8o2G9NTYEExO/fWxdCGmYA7XvllvRpLf6BWTqjgVMOOKMvIB1gURYPlCJaXVGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770603967; c=relaxed/relaxed;
	bh=W04FKCAxLhNFy3iwSX/rSfkVv6Uymhr9kMr74RcYrSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G1DxNpZblCgnop0hxWbVH4+IJXk0X5re4DyLrCVqpTVuFxtBV8EjvtLQWu026gPlVb2a5edDQhFR8wf0YY9/Rvv12v/3OLpIrsBsraD44O8PHVvQ4T+1fziSdXjvsmudC9G9lMhib790eo9A50yUgMklTiwaY/N6NNMfyVrC5jWToficISoiLTqIUiMrSdPXP5WbUFoB9zilRQNiJaZOM+9pdYFQ9agDvXIu2g+HeQ0HgJehh6y/YL6cBauECXNBTfCLK1dR5V71DsTAUvCcQQrHvRWjMzLsk1USPq++vVw+HwT0qwp6P1YkRWYe8O2VEA5AGdsGZHjU9Rjh6QdC3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iOjgjMJL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iOjgjMJL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8T8G174gz2xLv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 13:26:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C7987600B0;
	Mon,  9 Feb 2026 02:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74B29C4CEF7;
	Mon,  9 Feb 2026 02:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770603962;
	bh=8FNcFMom+IQpEysPGE9C9NRqh6IjFoqhAG6EdKXGcmU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iOjgjMJLTXGgtRIyHRiPlhacB0NWJjGddSIVKVYhIz++j1oeLQBwdspz5Z+tQY7i1
	 ArwBPPrdmtiaUurrysIgelccH+hpp7eoV3IpC4zm6f1vLngwwwL61deJ2G+E5wvdj0
	 ty8gfCvp2ZMiezH1wHFKqK4DOhDhm7/kedcRKnNERzWqAaPZk/p4GnajkfyBj7bgmR
	 55+tZiCAHhEvshKGOZ5Hg1B/Hg1ZV8vCk9u2jtWvPZLXRjRTMv84qdqwWnL0VA2HRA
	 oAw8SCe7nnziRlE/kpgtwleYzThuEJSlHbZoHDC318ngI9pxebx66c/k9mSjol1g9T
	 48SCSIH97UAcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA26EF06EF;
	Mon,  9 Feb 2026 02:26:02 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Mon, 09 Feb 2026 10:25:59 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: add NFC device
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
Message-Id: <20260209-add-nfc-device-v1-1-748d1a98b2b5@amd.com>
X-B4-Tracking: v=1; b=H4sIALZFiWkC/x2MQQqAIBAAvxJ7bkElg/pKdFB3t/ZioRBB9Pek4
 8DMPFC5KFeYuwcKX1r1yA1s30HaQ94YlRqDM240zkwYiDBLQmpyYuQgYofoyUeBFp2FRe9/uKz
 v+wHAUqHJYAAAAA==
X-Change-ID: 20260209-add-nfc-device-eaff14b5d5bf
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770603961; l=1030;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=fAioY0/uBa8OFcIA56wyA/W2gJNy1rdRQAUCDykPe7E=;
 b=he7DbyjQeooaxxeK62Gnonp0ve5OOlWEu63CG4Dw+dnDtFlATMjIVxFTXipgfGB1C+smjB4Bh
 ojMR4pX3PcvBYSKqdYCsaux087oN5zOjEO1cODH5RIkYk7ZYMO2Kn4B
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com

From: Carl Lee <carl.lee@amd.com>

add NFC NXP NCI device support to NFC tag reading

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..7349d25434e6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -802,6 +802,16 @@ i2c13mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			nfc@28 {
+				compatible = "nxp,nxp-nci-i2c";
+				reg = <0x28>;
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
+
+				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
+			};
 		};
 	};
 };

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260209-add-nfc-device-eaff14b5d5bf

Best regards,
-- 
Carl Lee <carl.lee@amd.com>




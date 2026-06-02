Return-Path: <linux-aspeed+bounces-4167-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA85CD6E5D
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:53:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVSL45BYTz3brD;
	Wed, 03 Jun 2026 09:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780406710;
	cv=none; b=WYlivLmOG1SjrMT8WTjBIyTHw2/o3GfyEWJIcylYfw860Zp3DjheeZUHN1/PubKXKPdIOfQT0GS+UAoDgc+aWu5rEito7MCNdG9ezGgfZshHiasin79dVMn1HMhxxtGbgFEYNDO/DZ626m08L28gA0rHrQNsPVmcBFx4/9GE3N9BUnkd+8eULrXaOwvJkDXexrRxy/7IVFRPmG3e7/hgekXV/CJA8JkAv5fU37QqRGI3DHHeFf2Nt1svvk90fhkfKjOFdqrmskCq99bPjHuC5rLyXeNNgKhuJjfOBDgqqHC1pvT80n5QGw60CfJjRZ1nTYXl0TUAkGiK/kZ0eQCSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780406710; c=relaxed/relaxed;
	bh=z8rCmjVhRLE0S2TkpRZErRcljPxkEcd9q6l0uI+ZoBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct5wFc4gBciRT20E2UlKj/l+j9lU4xU3GYj1SwCBbi0vAMZXa00UuJ/UoCsPsVpwoOSo4l0AVjW3Z0e4TdQU2Ibl3Z9WdpinQV1WR7rc8XiZD65kSXQsWx1U7yqN6jynPfCBMVp3SM3krYo02ivqQMyg0qwu7fAaX0BMn5kAd58x7s7aREC9cgM7LtTQ+x98WjV2b+unM/OD/MHgyNj/HZux+FZH6z/1BnV2hxkQjZQORPoq/QF0F4YZdvCm6EQS0V0S4naHAgEMmBqo2+Z+IhJbGw6QC5zWOBGG6g2Ywq2srS7ouGKqvpT35lckK+lPOXtDmkCtN1fennxvHTcgpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tXJ0Byt/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tXJ0Byt/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVBQX07fTz2ybR
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 23:25:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01B2D445D8;
	Tue,  2 Jun 2026 13:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8C27C2BCC9;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780406704;
	bh=3ed5WDh67ZmrdDMWAl2i4i0yB2nF51yxl2zoDD6sv5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tXJ0Byt/PHQPE8/FDCvAh8mTP7xPSEdTrQWIEiQOKU54erj8Yg7Y0Cjtm3Mh1/7VS
	 OZu9ft/f5M+cFVu1pYshTZsWShIPDUNVTH3SMvMVlkmqeCWP6ZoHBcPzFFpWo+p9Vl
	 BHIeh4vEYogQfWOe8h+dNvq94HOGIDmXA8gt5vMG/yynaNLDU845WTSfFDGJq/Fqau
	 yMVR/qqjOPJmeySMDoAPVkHW6dq3lJQnKWKN/h/1qph5kYDhDjPFqWF7NrKlVbWMuG
	 pc8vQ4Cz3Ec8Z59BBUdEVEjuX+RGAuKhdebgAIBzbzhyN0Xg3N5sSUUATapVPYmcWD
	 4FeKMTPl9HPBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17AECD6E57;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 02 Jun 2026 21:25:01 +0800
Subject: [PATCH v3 6/9] ARM: dts: aspeed: anacapa: Add eeprom device node
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
Message-Id: <20260602-anacapa-devlop-phase-devicetree-v3-6-7c93c5df8d9b@gmail.com>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780406700; l=743;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=D5HvAIWQSyP7NcKoy1Ha10lyJBsgyfKjuJ5CFfeZIDI=;
 b=QzyrVnxSf99t5YiqaOWqpNMfQmJ2V9skDS/JmOyMUIjlrZY/oeUKnOYWUbvYjnjZP14qVnBTi
 NfExFhYHSPTANDJRe4FuM7FTnhTE2uwlvWWG54UMmvrMbFXfL8H8IPd
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index 1d2f46e83be8..c703d64edfae 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -845,6 +845,11 @@ nfc@28 {
 
 				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 		};
 	};
 };

-- 
2.34.1




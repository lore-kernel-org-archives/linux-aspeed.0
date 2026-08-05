Return-Path: <linux-aspeed+bounces-4632-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B3AC55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnSC554Pz304x;
	Thu, 06 Aug 2026 09:58:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934993;
	cv=none; b=Y6AQ+y0+9GN+4woDDmpbD6boqno9RntJKP3lrZt6ND1D5qZAIskXgTTbGjmw8uvI2XeS+V58o5yV+BPc906SgjxwOAvW0qvIFOQVMmGCHod3dtOOIXUEyTUxQoKmXws02Ce5gOlqxZfRyebcWZHRpkwnPQFNIFWAvlKnbu4LMFfLbteuogDAQ5DN6LJSr3rF6E6OX1plGfwPVtiYLxDlK7fyPn8qwRFGNLzbVwQhz3YDFtsOJiL4dU4tCBI+m6hzJGCWghqkddSYgq9s5bTEPePmEWS8OFCdnQ294chrEFJQ9SFXFmFSuE0RwyWlLdxXnz9AhuDMu+TAKRMJUKzLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934993; c=relaxed/relaxed;
	bh=6dZeeWW4zswGFXRIdcHQCGueQ0cZnamc2cT7yvBaiNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co78yAwSMfcLr8bvaVcn0Q8BaS+D+NACxTjCCZGqNgT7MYOZ6RBBU0iRuMI0p50EMIOrc3sZ1mmzLNpazMyR0HuQRh5gRpLbwNC2ev+m7nOzLLhjVwY/bYvM6Haxjxg3fysLlioOFfCqnVFzSFaUg6bC32JoeXClk/+l93ysW3m5oJ0XwgjOaNNhhfsOgMiS/Uwd5+TMx/2rwllT9wj9f6t0wSJLEmh5jYD/ykDuVJ9jf3wtnqBf9IlX2jnsEyPKNayGb4xkXIA4HUGck2DiRzbTQLBsObila+sE0mqAhhob5Fk/xOMoYOgBwS+pREYgCM8gp8bGXwZF1jzQQVHI6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dr8Gu4WR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dr8Gu4WR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvj1jr8z2ygL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 51FBE43B2D;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33DC6C2BD00;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934989;
	bh=FoLZfGD6uyaU5BQXg5Am0hO9ZEAWctWsieG0YVFNjNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dr8Gu4WRgQgVNIAIdD55kno1nIHZsnfEwN/jsJ96Gi4W0GuvK5S9xO0qh9ojRGnrW
	 Xnj63vmpgabGaZqpdRoFSD/tK1XvmqfJfJ1lE1YdQFWGFdMIMIDV0AXdc3/k1V/Xh7
	 c0Y0zlGn4tYHCg1OdkSG7cLbTnhCA0M0sSQg3RIxhNoITl8mga8CZNi9DFC21roaw1
	 uqtxyfeMPkFPJpmKEBBG9vA7V4khfhe+dE8vJ8u4RgbsXGr5PiNW8rp92YVKL6jtSt
	 0F1U1FrwwjC6PO5q0eJcESnod9KljAxyYeXkUqB0Hk7RiQfZxOfPOR6i8JhvXoUhHP
	 PFGZBoLnxOkEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8EC55ABF;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:34 +0800
Subject: [PATCH v4 06/12] ARM: dts: aspeed: anacapa: Add eeprom device node
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
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-6-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=854;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ogPWoxlP9zHHWVbVILynjOOXZGqV6RgIxVGA6kDFSUc=;
 b=/z4nvmSJvhRzs0g+CPh58slDGf0C8IT4bhg5QND24yWyfa8GVxhDS4CFvka3p6F+TTW1eybjs
 Z2vhqivCuPSCR1JDbutj6KtxGU2P75NaPgrUYmlzNLMRZmSQbl6XRCj
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




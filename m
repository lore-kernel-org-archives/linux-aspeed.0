Return-Path: <linux-aspeed+bounces-4701-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A6FC5B572
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLjzd1f7zz2yrL;
	Fri, 14 Aug 2026 10:39:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622410;
	cv=none; b=EQEE7OwSsvO58YsbuBkqx0iA9xoapU5fwWIKTLA1dvWAFF8qQYfbMEBH+qyD0xMEkM4qx1XiklbalauRJ3hLfCGccSxM6HllqyZC7CyKvRzBWr+SoBHiXVNBLd9zUDakEjKn2qNXp8MQruBaDuhZxjpDfnCUhXVar5FRej9HEKHNelAtRZgaBjpMQKKchkNQuv+EJdmJD2JMKrWP8nQuxfMV+41TYigQKCkEdX1uqEDSbm8XTDtVDaWr6fJ3m+3XqP9gPzzzUJiG99SqveYVrI7euHFY0jSAWZTQeUPjjJnL2bOr1voHzPnRoFnYTa3UxdQforhlPStX2TxQbjHKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622410; c=relaxed/relaxed;
	bh=d0tywJCfbOhm61+aKB7StJw/Wnlb1AmUDCDWwg2YRD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkkgcmcbqOtTRlsP0DWVWvb69RsHZWEGlUDW5T+SZ+Mv2AX7er50gFU7UpK51m2HA8vQW3w5DPaOeGScVRBmBIhNZAkQxZr7Ee8XLTo+lDqHtO6+JpWBA8ltF+OOgX5QzgN1jl+Gaj1l+2B4hicm6aE0lh5N1DQVTcptste9IPJWXiPTay3rMTzUn425jWXi3tgMK50sQxMA8ORhT4SpJN1vrv7LzCgRIbU8xdmi9xmonDSXWuFcCXb+115L/t3jjkvRdf8zlOQy01XGUP17cnof6eJPhWehr+jLdEr6nT3T69AmICzVE7z1FxAGr7fQXNiB3BsejOqX54pADG/mgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PHD4+8iY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PHD4+8iY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7C5ZW6z2yqf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BB59441F4;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14EAAC4AF0B;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622401;
	bh=LdloDJM8DI8AB4ZLQsP/+vZzjiWKgFCiLWLBMA7iRMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHD4+8iY4g64WfA6GeqgD2dm0vqsQA/8sYXhk/vVU82SO1QyronzXhDyAVV6Ky2eX
	 7RtPGAyT6dTkiarhtwQABKOQ0jt/GJmUcd3irB8VNtsom8tHpt8meyHe/vt+36EbL6
	 QI14lFHb9qk4i+XjtYuR2z6r8d7JPyI86PszjaesIaK2hwGTnBAeMd7xkvX74Cj+ry
	 SCqmD5ynZRDwH0KiBooGtlSsFAa/umAl0K0D5BKs/gG13DkogXDHkGoIJRfB0n6rYD
	 4QmiZQkD3YsEvNkWgfqXZn6YGPM51HPff8atlxqnBeHr5La3aOIx8wJtAwUwIVWNqr
	 4MIjavFY3mxZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A5C5B572;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:35 +0800
Subject: [PATCH v5 05/15] ARM: dts: aspeed: anacapa: Add additional EEPROM
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-5-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=1250;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=NAF+xcmhfBdWvCk+Ea9KmPCdarcFxDgMq2cQBYIvfaY=;
 b=GHwHvs4ys0MLQH953QcqjpV0BvokVUy7o0nAOQbdm3qoZx99LemxUR3/Xq4QtB8pqC9EY7EDN
 /RpFy7xbMRECJ40iZUiEavkTN83q8+x9aduHyCXZl7TNP1u1n0hKvEO
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




Return-Path: <linux-aspeed+bounces-4712-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BACC5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7D55szz2yrw;
	Fri, 14 Aug 2026 10:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622410;
	cv=none; b=fA2XLgRBluvNE/UC2WoiHbH7TZE7SOTTkGUoDyPT146NI7gI6p5S5+vc5uZJpLmo+eUycTrzh0mXK+jkHrKzJkjk+jQGynv4wg4WD5j/ZjKiteBjxHPIsXF2HZwQoNBvJwDyV0gqlrMyqT66QuYJLLcLwMgNCHFMZR1tIydUhAwJoMijs6XlSyDCZMShUoyZZ2MBmiuGQ7aMu6qkm3SZVfQfVZMFWl1ZtFIgDRHxJRrNvUTrAKJ+CBTl36HWFaYlTO8tC+I5qO+IuGZjXpkrZu9GyzlPGsMgsfQLW8vniVx6bLoliq7I+6lxZSw3eiipoWX2dvbnWTifTOLpbqZU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622410; c=relaxed/relaxed;
	bh=3VzST7jI+crG+U+3bP9Mjgzj/O1j6+AHiJn91Rlyca0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9PVzuTgiDf9U6B+mtwwQ2TewS9LXHGa3ywf7lcxbK88Ig736aEmzqYwjWWRThZ0L7FY3grvdlXiUVSqet9d+8A99GpjwTRTjWh8ibj8t8uMdcPrsawti/hZmD89oDmSJpTxqK3CoNWXunBdv2UM4mq8yytIqRIPMzE3paatiY9aMZWL7XjEirukdBqqFc9/L+Y22fMQjG1olBRiIsVmFewXDANDNSsJYI9lcmvYtjeViagOM5Et/VghSYimG08f9R7XyorUaUYsrY17Gg96STTtEtsBgrtEdB8XQRaSb5TnEABn7i+MediO0TrXt3DONGsAeNshSn3BYtAZjx6Wqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jIuftnYb; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jIuftnYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7F2H88z2yl2
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A1EA44DB3;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE39CC2BCC7;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622401;
	bh=uLvqSnLxFTr/El1MUjQjU5tqTpJ5ohRAn7CKilpJxCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jIuftnYb97EcU4lSittDbG2omUlz++SJbnX7RSS4N+MRpMbe9WvyOFi3HLds+nZq/
	 zLUH2p4CUOa7XGD5806qyBP69SgNdc4WHL9XFkRkKBZUGn6vDq2umTvYB+xo1CHGPF
	 2CI0C2UZtDHRob/r/JwJr2KsQDBi/muBDDNcGqurEEsxq9NjjS6vkizIJZO3Dgm5fJ
	 bVPTpB6fNie/e0GqiyPwlPbH8plita48zovkKzKd6sApGjPvXeF/AADvV2yo5mqvNA
	 gpm3NtSTgLx5JLphAnAMoxBdcNwRmI5z7pXLevWVsjUG/IKXUeTLfw0RuGKvihBJVL
	 AfW1gACuqQPag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631DC5DF74;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:45 +0800
Subject: [PATCH v5 15/15] ARM: dts: aspeed: anacapa: Remove redundant vhub
 pinctrl-names
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-15-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=708;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=wZdptsf5KZoTZdsrUVb6bffHaz43HHnvSy2YjypcUzQ=;
 b=MNt1Xza2YC6AF1CLGYg5+fmVk3XcUzlYvu95056SM6MqhkXzcaRkrr1IQA22bjZap3PORfade
 w/MHSUsshQbCLMjz2y0SW7ThkUYvZHr+3ilQAmi6wMoioflnFU1XQyj
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Remove the pinctrl-names property from the vhub node since it is
already defined in aspeed-g6.dtsi.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index d613b5b9d6b0..039b016ae06c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -1106,8 +1106,6 @@ &uhci {
 };
 
 &vhub {
-	pinctrl-names = "default";
-
 	status = "okay";
 };
 

-- 
2.34.1




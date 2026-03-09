Return-Path: <linux-aspeed+bounces-3631-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641C0FCA191
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 22:50:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVBzq5RMyz3c9l;
	Tue, 10 Mar 2026 09:50:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773026985;
	cv=none; b=FbeVZTWaZRfUyn1xGPBgqnxcsRkEvnBb3wHRB4LCImFJ9RkhEKspIoKAkVAfyj+9UFsgjA62SE/KA9aO2SCCbAqsklwgxPtv8uNhL9DIcqPVcr1eocPpXi486WbvUneLcxqSgpVI9cYbaQP2aMYh3wWnvgTGAFZq2StCc4t9/0L5ZPUEk10v9/f1rAMGX5xlD1PjlM5vlymxM6FGUDVhTa8UbdfG7M7y76hj19/0gIQHYKPWu6QPV2GudLpsctO+c781oIydLJd4XuIKqNyCj7vxlK/ioVvIfvFrJPtnWIsvYBYFxTngNTszDvUjEaMNl9tvWM8ti4uSI7s/H27CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773026985; c=relaxed/relaxed;
	bh=JLBDSc/qArG4gyDHuMh0dfrINi0JDhK7HO9pbAg3ye4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqYIbE/FqCsIHEDlOXDVMvvK9+kqsAwjY8XoQQj4vxLyAEk2nKVOVyOfTWMqY2hM1hPkYcvo86LrTaDbmz1OKhjJUe47dhipwL53UKYq8VZ7zQch8MyZPE5vzwSZ4oBj/IzgjMWr0W/kc0ok9Z4yzdocbi5o/P12Sg4oIL0XQ/USb59L6O5W9u8NAY7UVV/nR0D1uheJhoXz41yTfp+JGIR8JL8uGDqOA7lS0yFskBb5x2lwitGUHwJX2sJ11gZ4zy4Zzosty6jia0lfpWpsjmmvIEb2NFA1NGrmo1KIoR/ar1dAsneN7x76i6XUOyqkfMa9ssz1Y3D4GiEILvohPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LJZZ3fJ1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LJZZ3fJ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTjDn28kJz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 14:29:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F6D860131;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49392C2BC9E;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773026982;
	bh=VXVNmCClSvOwGpmi61YhHWESdYYhdf74iA37qmcxNDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LJZZ3fJ1fzhlMwc3mByIv+IenATWisW3tyGnJFlqSfme6o5dc3Y8UE2iU0bCQtXOV
	 RLf+feLAwBn4KDL39NotG8FR/8ZEWpU23cdMWTFnW0mDLwou8i9DRpLah4EaaqsZXs
	 2P/keSAq5JJdvyrLP07qkJHtJhpcwPPDg3fPK7jtqC+36JymuuVgCVBBBKb/NegUBT
	 TcKylZSoFc9HVlOWIJjqigTQFKv+3/zaXkE6OEcc+5wy2Pm9mSIfN1vseAMw0U0agQ
	 dsGcEw92S8Oh1mC11lhk3s897fc5MPZBdu8aYquNlTpHnDpk+YbVG6+IZfibLvUlWg
	 HBffZqXMM5OaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3572BEA854D;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Mon, 09 Mar 2026 11:29:28 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: anacapa: Add eeprom device node for
 NFC adaptor board
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
Message-Id: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-2-45092310e0e6@amd.com>
References: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com>
In-Reply-To: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773026981; l=774;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=D46maPLCWSRhTgMfwUROFSf7IKYisSBqz2ghfKsQhBw=;
 b=hpjKx7Eau2uIwosBxKKNezj3WUOTJpS7Yy3dVZ3PCMzUp9UwtT5YxbTEWxVTj/+IJQpYSVmns
 Ht0/v19zq/hDXnBtIDGAtDjYW2OPLHcqCt58fD3cUJvvbI+JsIjXeTU
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for NFC adaptor board FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 680108b00664..e1dc13cd3cd2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -820,6 +820,11 @@ i2c13mux0ch7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
 			nfc@28 {
 				compatible = "nxp,nxp-nci-i2c";
 				reg = <0x28>;

-- 
2.34.1




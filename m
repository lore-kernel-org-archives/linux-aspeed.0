Return-Path: <linux-aspeed+bounces-3629-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0021FCA19E
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 22:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVBzf1KsHz3c8W;
	Tue, 10 Mar 2026 09:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773027989;
	cv=none; b=ey0Wer+45mCiRARv6t7Rvy/nsf2Kfaz0LHwV2KnEnzB8cr7ADI0Rks4zC5VKb8dRlvs6ZO8BLhrcMqhlF14VI+L09yHuoEWD/7H9Loh+7IZwPQ3lkAtNThvxUwIDYLSO0nXQIe4q4QL7vSbIafGMeKtvwnc2mxsUBiam5LZ4nG9hqyzkaZC52ixxMhSKIpTEcDSUd3E8yqOvLCqNpMPmSujvTLCkZIZbLWJmgAP7GON+Jo8zCLQCb520BkY/DbZYA6ShNBLe8xenFKZisUXQTanJVGvcrvzv/uDthUXY4R9lIheJdRJ/FwTbNMqBQXoJ01RTtCc3ZIvRDijxKNxm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773027989; c=relaxed/relaxed;
	bh=sA52qrXzcfenfeGOzgFUA8f9DpEVmjszboj+PTFMw7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B7/6DyJz/catTiDp2vYpyu6Qq72kHLyzHDMK3xzTgXMIDDwlPE64fa5FxgUB2hhCZJKoFTLxSFZE+Uy8PDKrEqsKV9GqHd77ijw6vtCitc6bc2Jj0o+QdmwJ7YedOy+QDtcUi59R6F+ChWpwYoW2i3OJX8kJdsj5GSlK51Tx3G9h9/SOI2IvgQD/daA1r8e/x3baP2Jm2MdJmsc7Nq4aPxHk2IHZNqh42qy6rmcZRe0aRvvfJQYLxT9CJ1SjsKxJTP6Kn2KBicAH3VVZFpOu478JJCaX9sGVpxUQvXJz/HI6XgT2WCT84zAJXLmCR/irwUjspcW3r9GwRoBFBxSWGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CdeQteGm; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CdeQteGm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTjc41PYHz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 14:46:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D36E600AD;
	Mon,  9 Mar 2026 03:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFFDDC4CEF7;
	Mon,  9 Mar 2026 03:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773027985;
	bh=1IhSqdUsmlpzA1CB+FcAASjNKWK/YwHGfbAD/QtT1K8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CdeQteGmrqEvJnO9ae2KWJ3HftTY50UNrkCWXTK/dmjZZsweW3ou9cMEMFQsyrKIQ
	 dwe6TDSpa6G5ZENg/veo4M2IE3L6RYJ98u2Om3b8XICONw1H98iGboYB0fGOm7J0LV
	 8coVYdKoVKj8Lhktu5h7CarMERWIs7AUx4gTnUU/TogX+DHzgQfxdXxasu4Bte8pTL
	 OhzTBg2DaEGAHfUS5Ya1eHZXbhB4MBaI8Jkg3Jrk8AMgE1DlyX0DxyqqtztFo6DU/R
	 P8m95YJOQ8XPke1ENCEprT2G9PhUrpP33otbTrerEV2eQjFMXQXPAR20jOM6DO0M/3
	 yPMkpX+clJ8CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF1EA854C;
	Mon,  9 Mar 2026 03:46:25 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Mon, 09 Mar 2026 11:46:17 +0800
Subject: [PATCH v2] ARM: dts: aspeed: anacapa: Add eeprom device node for
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
Message-Id: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v2-1-91c7dde4b79d@amd.com>
X-B4-Tracking: v=1; b=H4sIAIhCrmkC/52NQQ6CMBBFr0Jm7ZhpkSa48h6ExdCO0gW0aQnRk
 N7dyhFcvv+T9w7IkrxkuDcHJNl99mGtoC8N2JnXl6B3lUGTNtRSj5wWdFtGzlHEIa9sOTKycyg
 SU6hv1VhBVsyTkOG2m6DqYpKnf5+pYaw8+7yF9DnLu/qtf0R2hYS3jnrdKhIS8+DFXW1YYCylf
 AFca4/l3gAAAA==
X-Change-ID: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773027984; l=1346;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=4s2WZE7z3QJxXI/iwi/VjWJKQZJpdVWFD4P2EAdFysk=;
 b=NpUojOD+pYSQF7vSOrQb0hN1vZm56HiHxHGz+afcDYeGmB1rM7LVBDX2hAgXGEKrQpaX8Lhot
 4rC5mTqDpcECGWKDsWLyuIEAngdgoTW/wK9VHefT7DqR8dA2EJBgn3y
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
Add eeprom device nodes used to store FRU data for the PRoT
module and NFC adapter board on Anacapa platform.
---
Changes in v2:
- Remove PRoT module eeprom commit since it is already included in another series under review.
- Only include NFC adapter board eeprom node.
- Link to v1: https://lore.kernel.org/r/20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..69c41532fdfb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -815,6 +815,11 @@ i2c13mux0ch7: i2c@7 {
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

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b

Best regards,
-- 
Carl Lee <carl.lee@amd.com>




Return-Path: <linux-aspeed+bounces-3824-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2086E10F930A
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flklh544dz2yVt;
	Wed, 01 Apr 2026 10:26:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774944156;
	cv=none; b=ao5VNFX318wlBB86SJnAe0jXlP9bbuNvReKFijeersy88/+dAYKloo6Lhq1X790dgVEhkNSBIB3UApX8HPHEqMejpvLALH5TE7TnqXI6NUNqCzOcSUjXvCGdDWjjgaagTtIQ/wPbtYaLFBs4OY3uOXKLdx7vgKRRlmDPivG1+MMLx1wq6SkFvFQqbmdLKXRkULh09WkI7kU78nybGy2jZHDRwwKX1HbL5XgiYHxFQj8PbQQdUhlVPD26O915d1FVetJ304pH08/P4T3VHh3PZIZQD7GVJcddKDEtaRSk6VxVpKpEoSgeRSjA4vupxCz4jcGCWGoYXQw33nbU7ACItA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774944156; c=relaxed/relaxed;
	bh=4+Rajdgs98gDiyqfvDa5F4qhl4LCm3l64nsMUlhxgzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YCvB8AkGeFvHidOpyDQikTe2FpZKI7mK/Vj5mpUj1oGrWvzuUSDEYtiiAxmgKABv3FqDmYF9a0HTj7ONMpwbZWkgovqZXWiF0cgJfyhoJonYDXBayOPuCdwrkivgqUmh4lFZCx0MRsEq6YEikBK9fPpNxCOEZYxJgs1Ro3ZCIgWCSzbNiJDX6Zei4eQs9ZH4M/+zQ76Qap9mzhqpgHXQze/4ljltfHlFqZvcEfcbTcfmZ8wWqQ1I5fUKH2tj1323QrcznzY9fagwodXKWcM+UJoerD3oGaQoLKJlypl6sXJ2/Tyma3i/DJbl+R2Wxg+2SC1TR93VP++qFBhsMYVgxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jCKeezCV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jCKeezCV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flLFR1HG0z2xSb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 31 Mar 2026 19:02:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53E1C60120;
	Tue, 31 Mar 2026 08:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01E7CC19423;
	Tue, 31 Mar 2026 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774944152;
	bh=PHDS2VPVRfSiE1Ru3nMVenx5VOLgrNd57TaF4gFMkw8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jCKeezCV7gOu8EsUna52MOAbD/vJd6+TOoiXmoWUVdUwQgQlSB6e77O8yhHFpGo6W
	 98/nqwfP/inkJf+50mikcI3Lj2ivG0kYl7uIbh5s/ETVIqPike6C4VyZzAVbR/cR9R
	 pg7KSc0lh+bk1z/HMqrA2Yvb6xkzE0WlFEISgQQ3j/Oet7jPC3T77+S3YmQTtpxTLk
	 C9Hd2y0FrqFuqFcudJcKWmio64F4totGu3+uJIn1fnHOQLMGyO/ilk1ltchMQQpUJs
	 hl6uqrHroubCY4cZVzGnMbQxmbDfrtYGHwrfLqEFkpFf8O2k7hTnrSCjVy1y/cfm9/
	 Bas+84KuZ31RQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB251FF60D0;
	Tue, 31 Mar 2026 08:02:31 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Tue, 31 Mar 2026 16:02:28 +0800
Subject: [PATCH v3] ARM: dts: aspeed: anacapa: Add eeprom device node for
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
Message-Id: <20260331-arm-dts-aspeed-anacapa-add-eeprom-device-v3-1-2bb2226fbb4e@amd.com>
X-B4-Tracking: v=1; b=H4sIAJN/y2kC/52NOw6DMBAFr4JcZyN/+Mipco8oxeLdBBdgZCMrE
 eLuMTTpKec9aWYViaPnJG7VKiJnn3yYCphLJdyA05vBU2GhpW6lkRYwjkBLAkwzMwFO6HBGQCJ
 gnmMob9E4BlSIPcsWTdOLopsjv/znSD2ehQeflhC/RzmrfT0RyQok1I202ijJkts7jnR1YRR7I
 uuzWg0KrHIdEdd9Z+mv3bbtB6vL7to1AQAA
X-Change-ID: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774944151; l=1502;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=tK4ZlqqLdi/4bQSFXDH6JCKjm/zDadASdjOjaR1GT4A=;
 b=SaG/KqMDLIxRikW7LI9c8QOG9XIn/wzre1v8BpnxvZL8oSWTfadp8FR8SP4Lf7sUfnMLULhG0
 NjbP5yWI7GmC0NzJJoaRnpZ72jo1n6xtViWE2VC6hqD6/Q/kYVsRVaK
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
Add eeprom device node to store FRU data for NFC adapter
board on Anacapa platform.
---
Changes in v3:
- Fix node ordering to follow ascending unit address
- Update commit message to match actual changes
- Link to v2: https://lore.kernel.org/r/20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v2-1-91c7dde4b79d@amd.com

Changes in v2:
- Remove PRoT module eeprom commit since it is already included in another series under review.
- Only include NFC adapter board eeprom node.
- Link to v1: https://lore.kernel.org/r/20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..57fd81e931d6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -824,6 +824,11 @@ nfc@28 {
 
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

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b

Best regards,
-- 
Carl Lee <carl.lee@amd.com>




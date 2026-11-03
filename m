Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226F606A324
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=NR9fwCpe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0ns3h3Nz2xlw;
	Wed, 04 Nov 2026 07:40:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.25.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793738433;
	cv=none; b=NxpxG5ebPAV2mIUjf7Uh6iupwC9HmN46hSKLCOwMcv2SthKUlq0guLIwZoBC+nJkzaOks2kZ9o1nKbFLVu94XD1GtL55fFEUKnFehpzA5aXC925+3iQmS4OoXq4YGhVc6ZXIICXOHHr9K6yL8nfG+7mKj2siPfu+g43QmX2Ccj0rLDMB+DhSt9XnJvGITI8DX9Sb6Pv5fjQP3d+OOmg5zKNDRIx1di5/IipyzAMSuRmtkTRYZStpgKhNZs5wL/RW1+taOQoAhls/sgHwZ1Idab/bKTP+a9adWejp3kdjAzzQ3O5GBEda31jreBrPG+EPlWj/R0N4zGA9aJ5msgkemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793738433; c=relaxed/relaxed;
	bh=gviGI+/aVfXi8KK0fmiJUHN9/SwDPBwhZYFY667FLqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8Ztfckb6DRByoeabwrbjHOjDk5jEPP390baOa/l7mIfqKxa2Z+bhb5sfL2NPii6DDu6cvZKv8urqTjgNmBpL9nfSd/tHfNvUXPSKpJIqtKyUJrudfUvKRkXEwM/ooGC9wL/vBvI7FxmJZprWg/SMRq+byQPaAF2J92QiL2/tIo6NJY7vbsJzTimeWSuWZdlBnYiXXz74SBALSlqLbL9Ws0f7b8dqwwuOsMSHDSZcBQbkvlmRm3HYdGCCAx/TDC5oILuS4o/mccwnusQeAPeuT/cyZR3/PszhqwgiU48FtVLSdeioo1g2yFh4WtECTiioEJK98DiUu/sGxMsftGC7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=NR9fwCpe; dkim-atps=neutral; spf=pass (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org) smtp.mailfrom=rnplus.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=NR9fwCpe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rnplus.nl (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0nn3F4dz2xjM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 07:40:28 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 48E7E37978A
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Nov 2026 20:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrlREvmUNC89 for <linux-aspeed@lists.ozlabs.org>;
	Tue,  3 Nov 2026 21:33:46 +0100 (CET)
Received: from E595 (unknown [185.10.157.158])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 56C7B379779;
	Tue,  3 Nov 2026 21:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1793738022; bh=2wkTu59kSxoO15eMfM57RBq7UEe0GI/tQEudoKg9A2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NR9fwCpe44g4hkPId3bcDP97wwZb0KOba59eFPlHCMMc6PnTI+zQGQ6k8SSGQYqlv
	 2AmPdVB2LW9JAwDeMnffsnch0krk/qIwu8L9RhH+iYD9Sm4Gn4jdnlU/3M0Bbx8zXm
	 q+SojoJuIcYda3h6l1Dakp3uZvKCI8lXrdak7V2g=
From: Renze Nicolai <renze@rnplus.nl>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Renze Nicolai <renze@rnplus.nl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: aspeed: x570d4u: Fix fan tach channel assignments
Date: Tue,  3 Nov 2026 21:33:03 +0100
Message-ID: <20261103203308.54789-3-renze@rnplus.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203308.54789-1-renze@rnplus.nl>
References: <20261103203308.54789-1-renze@rnplus.nl>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tachometer channel numbers for FAN4, FAN5 and FAN6 did not match
the board's actual PWM wiring, causing incorrect fan speed readings.
FAN6 is wired to PWM5 and FAN5 is wired to PWM6 (not PWM6/PWM5
respectively as previously assigned), and FAN4's tach channel was
off by one.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 7d27833b761d..6e7e3e7ec101 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -320,19 +320,19 @@ fan@2 {
 	fan@3 {
 		/* FAN4 (6-pin) */
 		reg = <0x03>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0b>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
 	};
 
 	fan@4 {
-		/* FAN6 (6-pin) */
+		/* FAN6 (6-pin), wired to PWM5 */
 		reg = <0x04>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x0d>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0d>;
 	};
 
 	fan@5 {
-		/* FAN5 (6-pin) */
+		/* FAN5 (6-pin), wired to PWM6 */
 		reg = <0x05>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0c>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0c>;
 	};
 };
 
-- 
2.56.0



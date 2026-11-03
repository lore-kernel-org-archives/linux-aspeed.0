Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADA606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=yacQ7jHi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0nt4RRPz2xjM;
	Wed, 04 Nov 2026 07:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.25.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793738434;
	cv=none; b=dWs0r/COGGXSeprUSaAHx3V4qTb/s14hcM1cvc2Vey5EXgfoUhvIylcDDTWTCnldFJE994rL6SwIHOlwFGdlfLcANJG/82EtWcDjqa6vtEv5y8An5wA7lqAhfxvrW/NqDRhcq9NVCMBhlJtRGPQtBoxfigKfibsTYT98usAxi505Asr+9CGhYtrL7OlmOT8aKBs/x4xH51G/5qZrj9QoMrI5/LKdumm9EFRKaXR+hOg6h2cgqA6chPAIpq/5kjx3rVA+dBHJLT3eiabqHAwro1MRwKyGb3wv4IkNQNFYtzkvYps2hpZbnRouhpkzd38iECUyivtcmGBZh2iHGfZJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793738434; c=relaxed/relaxed;
	bh=g4710mBwVYs967K4QgLDYfK9fIoxHjIzWDjvzQBbfyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDusr2zAQDd3EyrGd1ywvoh5bU1/5WkGOsOWbU8zf7u3mhIvmqmyYTA9/bOY9X4CGOx6KlQ1wvP2bnkAywt9PRDEy3MRrDqYAskrmhEKxQgH9IrcSovTZUojHc31j5VBwfX1W6a3Yv8Dmyh802RH5km9j+z8bajwgl5GHzlTvSowH6H0IJY41E5HHjaT2a8vroVHV4LEDJKL7NAUHBdcd0DmSmlO2BDZpFmt5Sd8omZudBUx6P0XGBLWG3GxahPfdR4Kwlvx3DhJPEz6lbhizXCSRngplTeH0E1mhFrc3U7k4VuiLYi7bMoCzKLSqwlna9Mu0JsHMkLacSuRVtkpDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=yacQ7jHi; dkim-atps=neutral; spf=pass (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org) smtp.mailfrom=rnplus.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=yacQ7jHi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rnplus.nl (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0nn30Jwz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 07:40:28 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 02FA937978F
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Nov 2026 20:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTQyQtVNl9D8 for <linux-aspeed@lists.ozlabs.org>;
	Tue,  3 Nov 2026 21:33:46 +0100 (CET)
Received: from E595 (unknown [185.10.157.158])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 3ADF337977E;
	Tue,  3 Nov 2026 21:33:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1793738023; bh=KQcSAMUy4mMylL+vIJL0oe+1qrtpcizOgu4lI9jmLEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yacQ7jHivL8PsuyI1WDkxXn4tspokbJO8Hq5MtcItZEAOTmNgB1lrkVlGbx6LO1AR
	 FesrC4ttYXhRIwoAuWxCphIVxLbh3f0SrnymVyqKgqj5MxP9h3mHDD4OnO5O0OvUOZ
	 odp0g6diFx4d8oMPoy8OjDGfGHaSiClCLxww7k6I=
From: Renze Nicolai <renze@rnplus.nl>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Renze Nicolai <renze@rnplus.nl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: aspeed: x570d4u: Give unique names to MAC address nvmem cells
Date: Tue,  3 Nov 2026 21:33:04 +0100
Message-ID: <20261103203308.54789-4-renze@rnplus.nl>
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

The eth0 and eth1 MAC address cells in the eeprom's nvmem-layout were
both named "macaddress" (differing only by unit address), so their
NVMEM cell names collided once the unit address is stripped. Rename
them to eth0_macaddress@3f80 and eth1_macaddress@3f88 to match their
labels and make each cell uniquely addressable by name.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 6e7e3e7ec101..fca14320829e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -233,11 +233,11 @@ nvmem-layout {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			eth0_macaddress: macaddress@3f80 {
+			eth0_macaddress: eth0_macaddress@3f80 {
 				reg = <0x3f80 6>;
 			};
 
-			eth1_macaddress: macaddress@3f88 {
+			eth1_macaddress: eth1_macaddress@3f88 {
 				reg = <0x3f88 6>;
 			};
 		};
-- 
2.56.0



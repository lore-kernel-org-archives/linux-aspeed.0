Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B799606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=Jsn76HXz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0ns3f9jz2xlj;
	Wed, 04 Nov 2026 07:40:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.25.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793738433;
	cv=none; b=H14+cEH2p9QPrgjGqsmJCjYoW4d0ptHH0wQ7aiRybqQObPfJoG3pRSifhKyp9+IttASliKe1wp/sKiJ/h8b1/pvHIgSOgqWZ2uK6ez7BNb12n4cXw6qFiEyXpQ/UHp6DEqQoMcKZXl4eR6yyP/HIz9AFxcTdlEhPJoumMGOVq3uDOJFNrcxezXKmJmXkSyPuTEPsnBGzqc1iYo/1JhsrAoTtuPbDzAEagAK9ej8hBijIVwaS4V7r5NzUItijLNfEe7tAbZB8go1btbN5BhxB9kypIOwmzC9V7Mm8yJxpcEybFkgyNTaklU/jDcv4M+0qz+86r+9CqWiAJo2Kql6BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793738433; c=relaxed/relaxed;
	bh=IpTAQdRgdhCJhb1hvxDKWghah7aGv6NZyMkxYCZ92Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q77jLAUsDSR1ENrLZfofA1yKvI+/TFWAm5md4D+1tU8xecH0lKwQMQiLdCpjccZ6uI06eU9HaGANjkakR9QmaCnC+MarsD0tG7ptwafm853C3ehWw2zH10MYjzUQo8RzEJiAvczKqQ0szM/6cPxPTMgGzd+/f3sBhO91R6WsKhLh6IJEONaTBcME8ItdgTXIn4n/YrSHzii25lVKfTHlHej3T+9ldNGdeSYPXXQomYEZJEVwT0T9jD6NM0U7Z9j/HCqzek0Ys7Lr0U+L3Tawhisba/CWOq6t28qI1NqlEbIRmMFLQ7+mB+WystnwiL9WnvFt/mpZzshU56dC4zNVog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=Jsn76HXz; dkim-atps=neutral; spf=pass (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org) smtp.mailfrom=rnplus.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=Jsn76HXz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rnplus.nl (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org)
X-Greylist: delayed 397 seconds by postgrey-1.37 at boromir; Wed, 04 Nov 2026 07:40:29 AEDT
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0nn2kD7z2xSZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 07:40:28 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id ABF83379794
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Nov 2026 20:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THYZblAi3-ef for <linux-aspeed@lists.ozlabs.org>;
	Tue,  3 Nov 2026 21:33:47 +0100 (CET)
Received: from E595 (unknown [185.10.157.158])
	by mail.rnplus.nl (Postfix) with ESMTPSA id A6BC737977F;
	Tue,  3 Nov 2026 21:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1793738024; bh=a4vWSx9rLNvabRu3vIDBn7/4YymkwBrYWvlKnKwfxas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jsn76HXzv4eFOOwgUbSQIOLIMAQKaYgXoVJs1tbb10Zi16awRA0nzypxAAuD7oPf5
	 ErykmkbQDhlSf/z/v3DVS7gRqu0J7U3IRopvcx7d9Rmlkm3cXH5s5Of3IlzeiAKXBS
	 LxB5ravxMejTgXwNveef187G1bdaVUpEVvS2l94Y=
From: Renze Nicolai <renze@rnplus.nl>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Renze Nicolai <renze@rnplus.nl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: aspeed: x570d4u: Add some GPIO line names
Date: Tue,  3 Nov 2026 21:33:05 +0100
Message-ID: <20261103203308.54789-5-renze@rnplus.nl>
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

Several GPIO lines used on the board had no gpio-line-names entry.
Name the NMI button and control lines (GPIOA2/A3), the BIOS flash
chip-select and LPC reset outputs (GPIOJ1/J3), and the hard
power-off control line (GPIOAB3).

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index fca14320829e..0089845a6f0b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -79,7 +79,7 @@ iio-hwmon {
 &gpio {
 	status = "okay";
 	gpio-line-names =
-	/*  A */ "input-locatorled-n", "", "", "", "", "", "", "",
+	/*  A */ "input-locatorled-n", "", "button-nmi-n", "control-nmi-n", "", "", "", "",
 	/*  B */ "input-bios-post-cmplt-n", "", "", "", "", "", "", "",
 	/*  C */ "", "", "", "", "", "", "control-locatorbutton-n", "",
 	/*  D */ "button-power-n", "control-power-n", "button-reset-n",
@@ -92,7 +92,7 @@ &gpio {
 	/*  H */ "", "", "", "", "input-mfg-mode-n", "",
 		 "led-heartbeat-n", "input-case-open-n",
 	/*  I */ "", "", "", "", "", "", "", "",
-	/*  J */ "output-bmc-ready-n", "", "", "", "", "", "", "",
+	/*  J */ "output-bmc-ready-n", "output-bios-cs-n", "", "output-lpc-reset", "", "", "", "",
 	/*  K */ "", "", "", "", "", "", "", "",
 	/*  L */ "", "", "", "", "", "", "", "",
 	/*  M */ "", "", "", "", "", "", "", "",
@@ -114,7 +114,7 @@ &gpio {
 		 "", "",
 	/* AA */ "input-cpu1-thermtrip-latch-n", "",
 		 "input-cpu1-prochot-n", "", "", "", "", "",
-	/* AB */ "", "input-power-good", "", "", "", "", "", "",
+	/* AB */ "", "input-power-good", "", "control-hard-power-off", "", "", "", "",
 	/* AC */ "", "", "", "", "", "", "", "";
 };
 
-- 
2.56.0



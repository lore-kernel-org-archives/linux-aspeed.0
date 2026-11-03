Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4C606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=sKmCYXkY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0nv01lDz2xdX;
	Wed, 04 Nov 2026 07:40:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.25.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793738434;
	cv=none; b=H4DGDRLWn9eHvbyNyOrdh9rkULt+XM4RilSdTT5lXxy1tXY/m2ppstGoBmRNkUjPCV7z3KcVlHx5S7ncaeng4MQIipRMnddIa3OLCXZm1eRUlaLazFnLMLEyoTZa5dSpG2X7NzekX4xO5w1eyHbYJ0IW2JRrQjB2GRjL/rCxI3F13OMrfJWoH1BdxyMiHN+AYC8r1TlBl+ReivFWGtvd7+lXOlnf11VHh7XiB3oGrEyj1S5WW+TcmrwHBrH9bTuOqRk6wIXy/BvpnNslMIV03U23hUZ2f7SDscKhrFpjKZCcAcr2nHhhOzCoq2Te25IZSyVAMgIHsFJlLhG50x+JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793738434; c=relaxed/relaxed;
	bh=MwHtqe686HLLhg33s9GZ+hUKCHbjkbGAfCD5MLRkHsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcQRd8wcVw0wdlmvKhtGYyo+SiBcjY1ZKfzb2nBTZLVjSpaP9n1BJ2WCKIIpPJQPufRPLpJLj1ALlpUg9/tgPvy6wkJAg5/p1F2kl9oCKYeGW0t8hY9qI68osKevQzhJFyGllvbI/LH6KLH00JmVVy0D6Y1Mgz3fgVz99yEYSsTF2h7tHJpAF9SzN09hXjsH89S6TgljkO9SmnRyldA4CYo2WfkbwgyuG9Ob7Sevxb3aCmJ/9RM22VIQAzdoc1qLUKbyu2V7XtjC/1jBwUXmNliGuqL6Epi8wpj08G5ms7g4TTDlVoYDbnBz53bvfoBmqYDiVG1GQH6xkgzLMFJiPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=sKmCYXkY; dkim-atps=neutral; spf=pass (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org) smtp.mailfrom=rnplus.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=sKmCYXkY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rnplus.nl (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0nn3ZnDz2xlY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 07:40:28 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 12DA5379780
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Nov 2026 20:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qvq7y09XGkZA for <linux-aspeed@lists.ozlabs.org>;
	Tue,  3 Nov 2026 21:33:42 +0100 (CET)
Received: from E595 (unknown [185.10.157.158])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 45CC737963A;
	Tue,  3 Nov 2026 21:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1793738020; bh=dZ4MqU5UF2diSUFxnmeqIV/vngMvCegRDFqFTjout1g=;
	h=From:To:Cc:Subject:Date;
	b=sKmCYXkY8tZ6nSXpHUqoJ64JTJxCtzSCMqPqL+GYDRKYpp5zRKtSTeRQXXZlVx5f5
	 ofj5qRnZN0zZjdH0xCRfiXOub5URoOaht+YxgNzLb7sqXuFcveqUBrl7WrSfVbO3zw
	 BfG/42nLc+bVyu2D7RD5aKyDHcixKKtl5VHgxN+Q=
From: Renze Nicolai <renze@rnplus.nl>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Renze Nicolai <renze@rnplus.nl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ARM: dts: aspeed: x570d4u: devicetree fixes and cleanups
Date: Tue,  3 Nov 2026 21:33:01 +0100
Message-ID: <20261103203308.54789-1-renze@rnplus.nl>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A handful of independent fixes and cleanups for the ASRock X570D4U
BMC devicetree, found while working on OpenBMC support for the board:

 - Remove the w83773g temperature sensor node, which is only present
   on 10GbE variants of the board and should not be instantiated
   unconditionally.
 - Fix the tachometer channel assignments for FAN4-FAN6, which did
   not match the board's actual PWM wiring and produced incorrect
   fan speed readings.
 - Give the eth0/eth1 MAC address nvmem cells unique node names, since
   they previously both resolved to the same NVMEM cell name once the
   unit address is stripped.
 - Add gpio-line-names entries for a few GPIO lines (NMI, BIOS
   chip-select, LPC reset, hard power-off) that were previously
   unnamed.

Renze Nicolai (4):
  ARM: dts: aspeed: x570d4u: Remove w83773g temperature sensor
  ARM: dts: aspeed: x570d4u: Fix fan tach channel assignments
  ARM: dts: aspeed: x570d4u: Give unique names to MAC address nvmem
    cells
  ARM: dts: aspeed: x570d4u: Add some GPIO line names

 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

-- 
2.56.0



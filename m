Return-Path: <linux-aspeed+bounces-4884-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74065C624A4
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYVTr49rBz2yCt;
	Mon, 31 Aug 2026 23:39:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788183584;
	cv=none; b=Woo201/ZGQfxXORWBr7eoDssca0jGXHMPiJroxT+mbOZrngSTmqK56TEnFXmDc9gNDv9vCojxgDiSKbf4wabc38lKne+v/kRrTsgVGqEu/eTYaW46FMN97NI9Udf88UOEcs6FX/W6HUzQkHpXxCZ6JqI2shdORz95kZ/DLhWQEcF2R2sATedzerQW19H/yjnCKO+Y7EGNq/U8A2J+sqUiZ/tDf5P2y7Oy3PtXZlK4fkLUmRtaJRhZ4eUZkiYu+QINC1FmuMTOms3UekSP/Kpuwh2q0DbvdW3wmYpiUfJQc+VsEaJfLmaLHYDbVeUReMT6mFVEblxfTiRmr42Dec8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788183584; c=relaxed/relaxed;
	bh=POKu3l4J7SVpxZDF4dEniCQk73PmJkpAFR7IIuhZ9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Idj+WGSntFBkX6CeMkMEkUK91S8U0Hi3HgSUOjjDn+GTEWl5KmUVW7LJfNtYTuluSWuiwHNyUdp2Om2IjzbTzOyuLBz3uvbf8et/9uSRI5nocLRm2xHG4Yu5NTHsyIC+u1Qa8h7qArXJ/+L2Ih5l3DJ6DCzEzotVggkMVMG0cf+4XK7gp+BEQUYfU5lvsYULKbVPJ0Ko2bEt3s5a/Ln8dQme0FIMnMGNQ5mShHAJZQsaybogNc6zEZZDlbg/73EeTgdmLkD3VYbi4dKFH8OHOSO4JXu0TM081Oa4WcXkb0U8OkrPHF/Tt1f0x64NWWthuLsaMgibln4muVhw1Qwa1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcDWIs45; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcDWIs45;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYVTp3zNgz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 23:39:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F33E740210;
	Mon, 31 Aug 2026 13:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35C11F00ACA;
	Mon, 31 Aug 2026 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183577;
	bh=POKu3l4J7SVpxZDF4dEniCQk73PmJkpAFR7IIuhZ9CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YcDWIs45EMJ+xSjVT1oWgKlQ3Eml2bz7tt5ur3xZ9uQKd2CRI+Gh59b7er1BBQ3dB
	 /6fSRCtW3mDMyZ0gO66avsnGLOttUrEL0mEQ9RNSSDxxQIeHc0uwnBFJm+L6N6XVS/
	 /HylCMU+I/GGL+GxbvIkC5aOwHlzPJwdob4CmOgpnC68Ihk9qugD34snVD2V9jeiSc
	 gaRVZDoPPuAvYZg04vojQMD3uzksV3T2qLoXr0SJH3dmG1ubRWrbKSQ7qP0MCFimUZ
	 TGFqOT/sh9O/fR2gicIa2OSb+CCK4Ue+5eNJUSlBP1CvKAdStjW4GGwdQwHADBG/SF
	 o+5VGCoGZc2DA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tommy Huang <tommy_huang@aspeedtech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] rtc: aspeed: add AST2700 compatible
Date: Mon, 31 Aug 2026 09:23:27 -0400
Message-ID: <20260831133314.4125787-179-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Transfer-Encoding: 8bit

From: Tommy Huang <tommy_huang@aspeedtech.com>

[ Upstream commit 3319cfeeb8c4047026f84df045c438f7bbd338a6 ]

Add support for matching the RTC controller on ASPEED AST2700 SoCs.

The AST2700 RTC controller is compatible with the existing ASPEED
RTC driver implementation.

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
Link: https://patch.msgid.link/20260601-ast2700-rtc-v1-2-15d4ca46500a@aspeedtech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background searches finished and match what the earlier analysis
used.

The `b4 dig` lookup on the real commit (`3319cfeeb8c40`) found the lore
thread and confirmed this is patch 2/2 of the AST2700 RTC series, with
`5e7f746bc106a` as the companion DT-binding patch.

The stable-branch history search shows 6.18.y already has substantial
AST2700/G7 bring-up (gpio, mfd, irqchip, reset, mailbox, clock
bindings), but not the RTC compatible or `ast2700-rtc` binding yet.

Verdict unchanged: **YES** for backport to this 6.18.y tree, ideally
together with the binding patch.

 drivers/rtc/rtc-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index 0d0053b52f9b9..8f5b440f8c0a9 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -111,6 +111,7 @@ static const struct of_device_id aspeed_rtc_match[] = {
 	{ .compatible = "aspeed,ast2400-rtc", },
 	{ .compatible = "aspeed,ast2500-rtc", },
 	{ .compatible = "aspeed,ast2600-rtc", },
+	{ .compatible = "aspeed,ast2700-rtc", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aspeed_rtc_match);
-- 
2.53.0



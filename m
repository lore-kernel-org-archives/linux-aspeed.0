Return-Path: <linux-aspeed+bounces-3431-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41AED1951B
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Jan 2026 22:56:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0P6L3zHJz30Pr;
	Tue, 27 Jan 2026 09:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769374854;
	cv=none; b=lc3M5ZZzOOY1nvLJ0EMPtphrc16dkafmYt4xPCvwmiVKOWIxsf1IR6HdXodJkb3GsqtRAv/hHpGKt7+7sw8Qja1rncTboQ26MX/aL3uJSjYFjS9CYTWlNljIlTJG3xkptkaDKY2c937wM1HaB8GH1EDVNtMs3nwaZyyhnnnnzwOJn8edmBUEVDQ92vfqCvSqGBXmaRrFSC3mQ0Stk46v6HIqGpMoMkY6rncBwv6rrMraAAZM641+dLHN8xbnMu4MweB6P4rTlpjpSjb+Q+VHbshdooBANi/fHSthFZNqmpWcV0QvXbjdF+rpcMfB1rb8U54ebNea9VNiNphqjsNoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769374854; c=relaxed/relaxed;
	bh=7CeTj49j/suD4Rq67+orfSKtDdidAJEZzga/o+6BRCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HCZslfi6Z95JRvkGgeQSnoPPPaPrEZTUlnxPD30X84AETNP+pIEvaOVOadaIRQOCJMTwTjJxknN0cS4W6wj3iUD3N/bpeBNSUQBed4cqCgh2P1nAfy0hAu4qqMTvSW2gi+DIZkDBJPF3ozTVS5q9ml3NYb3bTnRCWgPqwY2n+xEsBk/2CfHn7iISUh7rFaoj488c6rPiV774J7najdf4AKGormab32AKITVSAxb1Zw8ZtPxfkdsZoLTnHHTdN07nzYEiWbecfUjfogyqKuggaroFKaLwiEVk00vStyCZCR7w4ce0k6q8sARyrOJTPlopl3/qrFzWBnNiMSMV/Yidog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jal0bwsM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jal0bwsM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dzkbR6svSz2xJ6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Jan 2026 08:00:50 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-64455a2a096so2944049d50.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 25 Jan 2026 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769374848; x=1769979648; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CeTj49j/suD4Rq67+orfSKtDdidAJEZzga/o+6BRCQ=;
        b=jal0bwsMntm3YiN4gwuSWAJRSQMruFvERvgic4H4r7AAtvt4M+//Rz9/lwe/zt52oG
         goMqYzdtrcctohgShJkJMFE57k9MDOP0VzCF+zRtLuAvtXoBXB3oBr5AgZBd/2w5taxN
         OxriYe/iweJcqE/he0GYuJ1bEMUWLLrrpwRSOv2npd/Ub9+YphrYasx2eG6eIY7O9IUN
         y6fqFszJPTXt2EZYgN8WOpVyqll7wSgCX8Evd79Vrbk3cDSlmdSw2nl+Ei8fYx9yds8M
         d0VBM1t5z9H4ucyzEwfNYVbZ0RsAIjZ9+kIwEpllz4QsC3zVDgOVCEj3H005XDP35QoU
         2cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769374848; x=1769979648;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CeTj49j/suD4Rq67+orfSKtDdidAJEZzga/o+6BRCQ=;
        b=r7t5gd0t94DoBv4QwrD2QNmHXznFl3RFLsRSd9dN8zDD6K5xyfvG+YHw5eIkrni7mu
         q+BN7swkP9pNbR1quDs5HIUaKu7CPpL1kYcO11sBTqSTZMm1IioB36Zi41FtMqSrO007
         kErnAyKVEfCXzX8j0aR/Jg1MWqxY7nMMy7/1lQRM0D1UAErpATAmviqo2kf8wdJ770ys
         0nr26QQCmPB91w2UTpt5hLC4cvrwqh/zR4lY+LboXlboBDf7h3jBiSkD+TtkFaPxTXAc
         s75imPXrUEqEanM7ZRaHjSMh2S20wP5XKi1pz3TqcEdpaDQAjpsyiAyOYzAe/ymxKOZu
         m1VA==
X-Forwarded-Encrypted: i=1; AJvYcCU5F67nBqu00976FYxh5FCeBxtTenwBxlTHbwfKmYQQ3RTwk2KoWjvclZA7lHVG9jyBwIbiMhlpCQ0IDpI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7W3mDQ0R45V7s/tgcddyw3HSBvbg5z0aOrSw4fQ5DYiAmnEQF
	7+Q/AekrnEkqtwQQnGhZ+NQ9PS5dsiNbn+0PcbFbaeYHP5qlvXoHsT9n
X-Gm-Gg: AZuq6aJGsvOEa/6n6qgryBvrRDmd7QWqSxtF0Ge7t8J3o94HdMfDQa2MPCs/5UjFa68
	zoGMQSNSdxILAkx0pYbmtU/8EDLpekFvh5ngXbVdXEmgbe/OilTVeySW39ROKDIXv3D0iFyVvFU
	fEX81CpWgvGxbTv0lt/I4HjjtEiuf6YFVFw9o9xSQTOi3+yMxGFbCvnqz5S1VQmRYEory+GmhW1
	y/zI2009ScO5Na2JQLDTF1wUoZ37qBLXbJ34U/cNplgJaBhVOK3xW7ecYEnDcXCHrMTIXRsorj8
	5qBok6q0w3M8vVSFCUyraOOSUbmcIpOFK09L4pu7vv5/tTt8QW2UrA2v+v4TaGCuu+BvsTvI72z
	UXRJdQIV7x9UC1Kc9333+fjuLXbI3M2k1MWWwO1KpmJJR+8rBvQQIzs1y8OEOf5L5THZWLBHIWY
	P+UD+k
X-Received: by 2002:a05:690c:64ca:b0:787:e3c0:f61f with SMTP id 00721157ae682-7945aa0d1e0mr41109317b3.57.1769374847540;
        Sun, 25 Jan 2026 13:00:47 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-6496855d65esm2518183d50.12.2026.01.25.13.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:00:47 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Subject: [PATCH 0/2] Add device tree for Asrock Paul IPMI Card
Date: Sun, 25 Jan 2026 15:00:37 -0600
Message-Id: <20260125-asrock-paul-v1-0-956085a4bd06@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAHWEdmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNT3cTiovzkbN2CxNIcXdMUgxSTJEPTZIukZCWgjoKi1LTMCrBp0bG
 1tQBmdGMnXQAAAA==
X-Change-ID: 20260125-asrock-paul-5d0d4b15c8bc
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>, 
 Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Adds support for Asrock Paul IPMI Card [1], which is an AST2500 based
PCIe card that provides BMC functionality. The supported functionality
is similar to the Asus Kommando IPMI Card, support for which was sent
previously [2].

Supported functionality includes UART, Booting from Primary SPI,
Networking, KVM functionality (USB Gadget and Video Engine), LEDs and
GPIO Power control. Complete BMC functionality has been tested on an
OpenBMC build available here [3], relying on this kernel branch [4].

For some reason, the Video Engine isn't always
stable when the host PC's video output goes black/changes
resolution, resulting in a hang and a subsequent reset of the Aspeed.
Applying this patch [5] from the Aspeed vendor kernel seems to fix this
issue. This doesn't require any changes to the device tree for this
device though, so I think it shouldn't affect this patch series.

[1] https://www.asrockrack.com/general/productdetail.asp?Model=PAUL
[2] https://lore.kernel.org/linux-aspeed/20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com/
[3] https://github.com/Genius1237/openbmc/commits/asrock-paul-ipmi-card/
[4] https://github.com/openbmc/linux/compare/dev-6.18...Genius1237:linux:asrock-paul-ipmi-card-6.18 
[5] https://lore.kernel.org/linux-aspeed/20251124-video_dram_reset-v1-1-9d37229e4ec5@aspeedtech.com/

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
Anirudh Srinivasan (2):
      dt-bindings: arm: aspeed: Add Asrock Paul IPMI card
      ARM: dts: aspeed: Add Asrock Paul IPMI card

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts    | 131 +++++++++++++++++++++
 3 files changed, 133 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20260125-asrock-paul-5d0d4b15c8bc

Best regards,
-- 
Anirudh Srinivasan <anirudhsriniv@gmail.com>



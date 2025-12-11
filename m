Return-Path: <linux-aspeed+bounces-3093-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB90D41C37
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 13:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRv4p2WZpz2xSZ;
	Fri, 12 Dec 2025 00:46:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765460778;
	cv=none; b=HVC7ElGROk8bUAJ1mYjZD+kGqKMiKLaBYaxx5tBbDUHwdyOpX50h0/6sKdV8xK23vK8Oj4+ctqGFpNChIW0fJkRZMYs4IyeH0jxLwnCe44/gf0mO7H53F2VPsk94+R2kZBmsHkFTGZT6dzihlMem7mSfjoGYThEGa/VgVVf5R84WFl74AUVcc0gTnOR3Vp+UkMBnunz2xvuJTStpDpe5WF1ubAwaAjwA90oOX5R8a7eVPp5bq+22dfwrbs2+99aVzvfYDLZ81S1pG6e/XLxxzPr9feBDqmzGL5kOguKIS1x35esWpksLicwhldp2XjZAvk9G5G+ht5fb+AxWvjuihA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765460778; c=relaxed/relaxed;
	bh=zA5C5PNW0/uFa37xkLqcgZ6/TZ5xC7fDMBu4P7YKTz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcxyv9ZajjvZgEtM/xvTnAmNCr1U+U1Q4Qsr2lMPLCGrOt2OB5Uj6e1CAWM03NpEPJYlkBqLzBR0u83nwDmWRhe8D3LMtRPbdxt1Y+6Sp1DgnpeXPGHf1Y9IfaVDBoSjFoZZZfuedJLKmb9vF/rNLeYXPRFVR6bdN7gKqea2wqF7Od282RKOXXTKIFMrfLo/8qBZ4w5gWKsf0k7DDrKxCh3KfopvBC4+yz4+4ulHnL5mbMfpSQTGQahzqzps7OwxoxWdNQPZreABwmySyVOYFJ8kHSfafiA3BX31ai9nk8htV46mYvVM8Iq9QyWg6Hmr/oBKe63cYvYreg/A5eaUfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=o82a1GFu; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ikPmmeRB; dkim-atps=neutral; spf=pass (client-ip=202.12.124.156; helo=fhigh-b5-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=o82a1GFu;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ikPmmeRB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.156; helo=fhigh-b5-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRv4n5bVYz2xNk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 00:46:17 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40E477A0140;
	Thu, 11 Dec 2025 08:37:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Dec 2025 08:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1765460262; x=
	1765546662; bh=zA5C5PNW0/uFa37xkLqcgZ6/TZ5xC7fDMBu4P7YKTz4=; b=o
	82a1GFuLupdi2f3DTNtDSHpDK/z4t0s0WgGt/7mZI7mld2Jsm5n+VPZS15R6/CpI
	habdwW7aZtZHS4z8uWuHoqpMEsbA3lgXKFiV/soZ8FE9Caq8vcX77TPvTh2w+5Wm
	1Qdx5OIJtrKXtVOQC7XDtFfErtcI97N4sqccZwSE4WWCQJ2uRstNvO1t3FcubTXC
	NLEjEjyuZkQE2IgP28TEmVLFwrEesg7y5xUTb2F5Nb54oRi5GBcQfGUcP8oDi8zH
	/ZcGDiQuoVNub+W1aQQITBQ0FPqOlp8pntCIUOZsOPM6sbfUHtOlxxL9PZS+rM5y
	Ql2A/2p+fAu2jK+mIZsMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765460262; x=1765546662; bh=z
	A5C5PNW0/uFa37xkLqcgZ6/TZ5xC7fDMBu4P7YKTz4=; b=ikPmmeRBuksPJ7t73
	0XKq3myvQGmH9nND3o5Lwsq5d7q2jkBulKx/MA+aOLxWKdBudG1iHYnFqibJ9PA5
	AD7bs5G5oQrZmRccokvhfEXPYaCd2NMnKGtPc+awUA5Q99qCd/mRcrRL24kaG41H
	7ZcWjZHe3GtwXA+U5LuTXvsKo/PLUQXZGMhkSSB0ugColy78sahnydFJTMfBYIZR
	OyRbNmVNwnjIiJuXcqkI9Tq3KuPu/yFzGPDFllBn9VhD/S7+OWnyYdLZrxhV5DiH
	wJOFRsqdgUn7KoBlpVZjDwvFYRPNuslSim4FE0HTDuLwNBgNzjHDSfg9riRjgzXc
	r1fyQ==
X-ME-Sender: <xms:Jck6aaOV1zUdDk9toNH5FSHOE6yMYucLcOXh58jv2A-Zw4mjc5WKLQ>
    <xme:Jck6aVp0KfdAWZQJg9DHxc_c-BQqiwkSCmnG0sKHy_UQXe7Q-C_9kYZ3xOfj0-Z4M
    qPx10pij1eGLOKKQGuK59SsGAKJhifFshup3U0nhynrFpF7TCUeMug>
X-ME-Received: <xmr:Jck6aVJJFUSBf91RyGj5n8dviIr911ioqYLwa2MIZxw86CFzVOrk3egR43wZlZXwnh3NgOKvjZw0kcST>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilh
    grsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jck6aU3XTW4kd0xBwyxkgQxf2XLJ2Wzancykkprx9A1iVmAflHxKRw>
    <xmx:Jck6aWUnB-94On1jEB9N69xDrSruwolT75zLXxzPuu7MHceJdd8o4w>
    <xmx:Jck6aXzLDEvG24AZR6vdTmWnRyZnlbkLMtlFvm8NiOEXG93LDfdYyQ>
    <xmx:Jck6adyT_rD1hemS8dLt_9j3vLGNEss8qWF39WYCP6_LLxZcc2pY4w>
    <xmx:Jsk6aYz5kqByYQ3y2L47BPq8lloE7ZLdj1tY10pamoqm2JDMXF7nrxIH>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 08:37:40 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Thu, 11 Dec 2025 06:37:18 -0700
Message-ID: <20251211133721.18269-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211133721.18269-1-rebecca@bsdio.com>
References: <20251211133721.18269-1-rebecca@bsdio.com>
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
Content-Transfer-Encoding: 8bit

Document ASRock Rack ALTRAD8 (ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q)
compatibles.

Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..aefad2d02993 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -34,6 +34,7 @@ properties:
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
+              - asrock,altrad8-bmc
               - asrock,e3c246d4i-bmc
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
-- 
2.47.3



Return-Path: <linux-aspeed+bounces-283-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CADE77187
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 21:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YD6Ll0D4xz2xnc;
	Thu, 19 Dec 2024 08:31:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734557486;
	cv=none; b=Ebnl9qmdLepsEhLAwFwrwVkMF2WYfcSOvDkk4fLTP0QMVgD3ZYkukz6K2kuFnLIxWixyR7QTCAhPJ2XnRdYXkcypNVcc902d76jXSX/ea1CjetlbYxyVnkalDz+2SfogU4D+SuAeRZ7t5dNZhO6Vam0BH1c0THYb7WZfoHIEgKQBELqDJyWFXDdvRshrHY7RCIZAAj4R++jYv2SpMPmVHSamyKitjIPn/P1EQU0yzS+9EFOOGY5TsWRpGTeRByEOb6/x1pr47TTgJhk3k6kt8VOIB+DcjwKYvhCHm7HlQnWlWGVxbzmer+Z7tmuzqpEsC3SUhZxHrThyvamKfdIiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734557486; c=relaxed/relaxed;
	bh=ajF0q6OCJuLsYioDhwVmpl7KNWSqiP+JgnntFRjDDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmcNvyw344IdidyBvANgrDuL2HDjd6VcLCgdM6I4m7kdBF+cSIUe8rewlY2xijA1TYBxeug/Lr2pG4si/KwA552TnBeWXQX7JzUHlZCqfFP+LUac61QNnVmGwoxHR/Ru+wNk++B5x00cHFT4hoeBoSH4boSLDFpn2c1haQsFilqnP36xSmPQkPKdODVYA0VvzHugJRu5hUVJ9tuRaLsJlbgVVTUcE99+U+wKjtfPLtnVavVJQDqt5zH5C5ldvFY0X/4Az6JzPik3QZOQQ3uCROmx1Tzozhd4g2bExHbgAP8KukEdjh1aAv3tc/BAW5kuGFMUXQgg4cFJ5JB3+fpAMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm3 header.b=Dtbd3xaH; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=g9khhf41; dkim-atps=neutral; spf=pass (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org) smtp.mailfrom=stwcx.xyz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm3 header.b=Dtbd3xaH;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=g9khhf41;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=stwcx.xyz (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org)
X-Greylist: delayed 374 seconds by postgrey-1.37 at boromir; Thu, 19 Dec 2024 08:31:22 AEDT
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YD6Lf04l8z2xnS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Dec 2024 08:31:21 +1100 (AEDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F8D0114019F;
	Wed, 18 Dec 2024 16:25:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Dec 2024 16:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734557104; x=1734643504; bh=ajF0q6OCJuLsYioDhwVmp
	l7KNWSqiP+JgnntFRjDDG4=; b=Dtbd3xaH0xMu9DZFCIUFlLd+vTa/Lw8JpCQPy
	LDaOgII/NnRcEJuhJ0iya+tUp2A4usbLr8lXm4+pqO9JDR5I/TR+dTiCdCksnJPu
	RK+0RfdFMp2uLjJ3q2NCsWRg//g9/5WquZw4jaXzjph/jpghoGkqOgY/8E/qSpAY
	LEzzrgZ2KJM6LSnN9Zhz1Z1baIVqa0/XwgMkWTfu3wLuluD9dKdjzyrFjvey8JrK
	6sbPGusnhwn1KVYHpDom5ePTXjZOCj98eYAD03RN5lhS1TxxNtxQDPVNg1hlGctb
	xcgtf5yWHH7zos9rcxdlZuNDT4pxD/AR0Mw/BhgLwOiSHXhKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734557104; x=1734643504; bh=ajF0q6OCJuLsYioDhwVmpl7KNWSqiP+Jgnn
	tFRjDDG4=; b=g9khhf41+0tF12rxgfuLL5H3w/h4ATcUyNw6H7Ur+62IaIjQcz1
	TPWIYljCbZB5U4Nxs3vfOK2yg+jkUFf+NjRagJkrQu4VoMhk1daXGu28Mz2C3U38
	KJd/JC08wgnp6/jlUppWRC3/lXri00qdsn5bv6TZF/XfxNzRGUjGKFa7h5rbKmhw
	M52OJmWvNN8LLn/LXisZHmrZlVga2v+id1X/aDY8+fRwV8riYU1Vs3BKz+yZHxkE
	FIA3HZwYrm/CymaW3zSRhVBKerit0EABxerv/VzlPecxoXXRSDSiyUeAd4QR7wMZ
	PsjnCMINmii620Vd7MAsgt30mVzd6W4WT6w==
X-ME-Sender: <xms:rj1jZwgqEhEYT0ualcrzwbOq_gesttZYpkVSbCijZWA9YF-Mf17m3A>
    <xme:rj1jZ5Ax1Y0p1VdSd6ZJj_z5_c7Ds6WFZgvJdw5nxJuZb7KNqbWRsNVbDyIyHZP4M
    9nMA0d7tZa6tGhbTFg>
X-ME-Received: <xmr:rj1jZ4HSbXa7olTni3gDMsvMYFYDcg0OnMXSYklJQGUbtRD4hr1j22GIb7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoe
    hprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeevtdevgfdt
    hfefveejudelheeghefhhfdtteetheehudeiueefhfetkeejleefteenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthif
    tgigrdighiiipdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdought
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtoheprghn
    ughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehprg
    htrhhitghksehsthiftgigrdighiiipdhrtghpthhtohepuggvvhhitggvthhrvggvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrh
    hnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:rj1jZxTzsUkmJn4DSDqtvqRuCy041IwKMmvZl9gc042EIG-UC0VRNQ>
    <xmx:rj1jZ9w73Ou4inMQs4mpBe4G6QHix3j4nriQDqmigDnVAo3h5DLTAw>
    <xmx:rj1jZ_7AQ8LQIsia8H4AL0qOW1A34WoyWVVXrbaTcmq69sWOUc6oDA>
    <xmx:rj1jZ6zxAjciFvNk9hRNSP8ZmseV3_xyFdZglL9lrEP6BL79UxUTjw>
    <xmx:sD1jZyp9ectKCObsjwWr1aRtv55CMJU8WeTNvP--ACpX0ngj1mhnS4Sw>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 16:25:02 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Patrick Williams <patrick@stwcx.xyz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: yosemite4: adjust secondary flash name
Date: Wed, 18 Dec 2024 16:24:57 -0500
Message-ID: <20241218212458.3050775-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.44.2
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Meta (Facebook) has a preference for all of our secondary flash
chips to be labelled "alt-bmc" for consistency of userspace tools
deal with updates.  Bletchley, Harma, Minerva, and Catalina all
follow this convention but for some reason Yosemite4 is different.

Adjust the label in the dts to match the other platforms.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..e20816d9e077 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -112,7 +112,7 @@ flash@0 {
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
-		label = "bmc2";
+		label = "alt-bmc";
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
 	};
-- 
2.44.2



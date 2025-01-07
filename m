Return-Path: <linux-aspeed+bounces-339-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48151E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 16:27:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSGfr6fQmz3bX9;
	Wed,  8 Jan 2025 03:27:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736267252;
	cv=none; b=Y1EpQlwluBTv6Q++JAopmlfebb9YC96dQVvR4FjPmKVt7GK7J47OrherQ6tK0YWU4+PhQIabw6xC1wkKBG3YJcZWYi60WtE9vB52Ax4Ytb+V9WJB92oPBY2kUBbyi7px2VG6n6JfCtbvFwCEZCPt01VOTIVtFfyxtMhUrhi1V7gu/UZhdVCtAcOU/5lNIoj22ks6YBRzOtTixcSLHsnFcr6oqpu2hmml6RFYuUHwF49RW0Q1L5KG2inhL3Ghh6lzvfaVXB4KV+MpFSAm287bn/IahBKJQJjg+puYQHBmzIr08w1Wi2M1SHB8ZSwtAav/m4r+H7Sdnv5i/SeB2MoTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736267252; c=relaxed/relaxed;
	bh=RIzROz9khoj2BhgYd0nISvi0RDBvOsblgFIn28Lq6mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8L8OaldIsvSHR/3IXGqRipM+LMvwjuKUITJgvxjcERFhD7JzmGFTcJTAfdZMBVEQHVEOtbHE4G3TPZOFoLC1R+AkYzwoxUIau5hongtCsq1jM59MPhwzvPUxQ7Cu5fpGnMFMXm019uCrFnyMUI+M/Cyxz/a/MeGJZBLtJGQ8CTpPL/lSHJtRPwXOOHRQXTeEH+7an4wXu8P4EC3MazYQqwBAWZx0Xnp0RDs/p9WRDusnbEGTGF1lg/auK/2JveUDMhpG4d0+i8funuWJpcViYlwNHOeczH1Jx24l0mOP1eKheoenMx0scYZa6lUWnQq4ZP41gkDTWuuAsNzTCzgbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm1 header.b=JgJYzyfb; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v7fL1/cF; dkim-atps=neutral; spf=pass (client-ip=103.168.172.151; helo=fout-a8-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org) smtp.mailfrom=stwcx.xyz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm1 header.b=JgJYzyfb;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v7fL1/cF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=stwcx.xyz (client-ip=103.168.172.151; helo=fout-a8-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org)
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSGfq2WG3z3bWf
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 03:27:31 +1100 (AEDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B6A5138021D;
	Tue,  7 Jan 2025 11:27:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 11:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1736267248; x=1736353648; bh=RIzROz9khoj2BhgYd0nIS
	vi0RDBvOsblgFIn28Lq6mo=; b=JgJYzyfb6uWDMn3aPzlcl/3MJiH2QRXXcmkSK
	I0kdbVlIvZ7X79l4EIKV9TQSUQ3D/hgLZrGsE2BBPn1VHqf7Jc6d1HcExifAI1PO
	OE9q8rYyxLGuN73nUDDivs5+XYpFz6l4KIBJwT01fF4lDlX1ijgRZ4UGOYGYvC33
	bGnDwM7yKi+5WCxfsVWZaR2W2/4HkTgcJRIadJYespfqKUTXbAtY2PhnIkQ+UUqy
	rSj0+mF7g4xXp7A2XWd5CqBXctNlxt9qKvCx3tWAB+4dLovrXjMKzZ35yUHLp+xO
	s+bOUJJU1WSQdDEmeNKwBtPMXi4tMvYCXeNLjtF6PHJ9q1i+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736267248; x=1736353648; bh=RIzROz9khoj2BhgYd0nISvi0RDBvOsblgFI
	n28Lq6mo=; b=v7fL1/cFRe3LyWeEDJqbN+BHz84S4WxdXb/p2y2oyHbnQj7pIeb
	RUg9q8dSrlCzbFr99KizNdUXCWV2/k9UgcWNPOtNvdVqeD6ErQsvzjxymNQ6w5ou
	Z2vXTZwRhYdIBEaW1YLoH4wvMtsou8v7UhyJk8ksg9Q5IrDQgkYEk1ZFO5Mmjqpz
	YYp/gY2Dy8C4M3TyjoBH4at9tQP7yNvfbEqTDl0/YzfvWZZKIvC6sBSRSg2SIPpf
	OBmMf73L/QvH8IAMeN+d17mdMWlUVE63SMF1uQEvtgDcHM8BFMx9NuTn+W5GoGUW
	zxa/VCMEmFThJ2F+QAVk5wZItGXWnywtiTQ==
X-ME-Sender: <xms:8FV9Z1o58OmcY7bOpfDguii-4Dyq9EwnbKb2Rlia05Gm21v-ixVeqQ>
    <xme:8FV9Z3pjvaGGvKkTq73WqoYzNFeC3e4iojEfGBlDjf2Lt14Wr0Q7InFJrJR-BJ2hJ
    h1TSHm01SQFljv3v80>
X-ME-Received: <xmr:8FV9ZyNP23xLO3nAt_k5WbX6SXsU2lnNr4fel_B8nM5WdGDi7mjgAMR7mwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:8FV9Zw6QocUaHzH3d5RerqE4_65ciJ2PP1FhCYjR4buSwlZCzyAkrA>
    <xmx:8FV9Z06uYnqS91cIQ4aayYyOJP4doFTlVJpORD90oeKneZUjvlY8Yg>
    <xmx:8FV9Z4jnbJkStym_1S2pHwtjzWRHvnu6bkb9dx1K0bC8vklsDMaF3A>
    <xmx:8FV9Z25WYP8x5t4Io_naP6_mjO72FfUC1q5B4XAo1OBZS6DlO07Klw>
    <xmx:8FV9ZxxwKaQde-S-bbq_i_gl61gnJfILwioB6CCwFQKbwmmaL8X9x4NQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:27:27 -0500 (EST)
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
Subject: [PATCH v1 REBASE] ARM: dts: aspeed: yosemite4: adjust secondary flash name
Date: Tue,  7 Jan 2025 11:27:25 -0500
Message-ID: <20250107162726.232402-1-patrick@stwcx.xyz>
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
index ab4904cf2c0e..29f224bccd63 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -159,7 +159,7 @@ flash@0 {
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
-		label = "bmc2";
+		label = "alt-bmc";
 		spi-tx-bus-width = <2>;
 		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-- 
2.44.2



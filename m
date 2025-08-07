Return-Path: <linux-aspeed+bounces-1929-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF73DC87FCF
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Aug 2025 13:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bySg94cn5z3cRp;
	Thu,  7 Aug 2025 23:29:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754573349;
	cv=none; b=lZKMFEZGSml+ZYWnLe6Tmj1AS8zolJy9wlcUL7MeT/FVGH/9RAI9g1h+56qRWYdgnPdAoP6KDTjfUI2/Hnu10YDw9Gc+/odkLSPRpqpeoppTNs41a2hyuIWXS2N+Lpm6EYNRhSQTBNSB8sB60Qgrlzf1vNPx3PB52RdT9NPG9Sdl0IuimMk8/BT0TQupYhyf5yZ4yaVafvIw+Yr+6vY4jQtrp8Sl7/1o1+vlvT4LtB5RJ9HvLvDn9nQNEVm8R2JyIcvbAOaZwVB481JaYK8zoEz/GY+Jl1IQNDvQPqlT2ZJapPZb+BjzL1hgnNnfIUYiK1hW/HYJl4P3CEnXTGy/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754573349; c=relaxed/relaxed;
	bh=mWJZVh45JxWEpjMzzyOEhDUy8kia50rucaLKoGuxy+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bdm3GxrxaSgyAPrhUnfufP4LkNq0+bSBt2OTjdvFESTmbhYl+4J6vToOYkqsmqaXFtkt8kQuSF8vPN1o1Gx0QfkCBXr/AW/HXzsH8XqpI/mT+BrSuvhUbGSipaCTXTLQOl34fFyaeYK8+5+cXY81mdj0XRceuNkPRtj9VBB1MnGoVatVyP4L3qhqNuozcDyUSXyBOjmUjagUgTeUvl9OIpp9WGKletWJrc9IK62YkHgwlmbbJbS01/lGJQ+mEkBxFWndJF6sVZIGffW87bvipp6o6gIOg6Djcotbtb8lji04OJ3fYCj1Th3h+9gQGQQiIIlHIP1gE6/K0Bo3lKrNrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wl8h/3jS; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wl8h/3jS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bySg90ZJvz3cRn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 23:29:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC0275C5E69;
	Thu,  7 Aug 2025 13:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BCCC4CEEB;
	Thu,  7 Aug 2025 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573346;
	bh=1VQ4CEYYvmVtvSuzcssa91RQvPgNCUSDeA69SoGr7Ds=;
	h=From:To:Cc:Subject:Date:From;
	b=Wl8h/3jSD4YRguyd//yDPsjdV6kNSuDDUKJ5SfvtAJWCBJhkiE4QSNjMLu0MnWC1y
	 vMv4m852bgEVvnxbYtV2fLcZwEZB1pardhns//wJcH6XgzgCo/Ii0aVcQmQXpYnFzM
	 vQxVaZU3fbt/hY1p8+lm4KYYBgvcuL1SJkF2ohQhH7tcMYP90pnv/Hv3EyWIXILp+i
	 NgzbkISs+NzJ75baFVEHXjRzeDJVQtrQjzP4OpMG9NrWq6fCxDMjoFTRE/wKwEUfjQ
	 hbH2B8klSdMxyBsIx5oQ4p5f1th1cbJqjs7bykynKcBt2Op9EOzcfhyAjm14Q7DwvN
	 jq9+oS/MStvEA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Corey Minyard <corey@minyard.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing "clocks" property
Date: Thu,  7 Aug 2025 08:28:51 -0500
Message-ID: <20250807132852.3291305-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
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

The ASpeed kcs-bmc nodes have a "clocks" property which isn't
documented. It looks like all the LPC child devices have the same clock
source and some of the drivers manage their clock. Perhaps it is the
parent device that should have the clock, but it's too late for that.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
index 129e32c4c774..610c79863208 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
@@ -40,6 +40,9 @@ properties:
       - description: ODR register
       - description: STR register
 
+  clocks:
+    maxItems: 1
+
   aspeed,lpc-io-reg:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
-- 
2.47.2



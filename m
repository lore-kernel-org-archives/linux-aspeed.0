Return-Path: <linux-aspeed+bounces-2263-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204ECCAC59F
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwlk3nrfz302l;
	Thu, 18 Sep 2025 10:01:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758132677;
	cv=none; b=E6LLnrWMDeLW3d63bcQJLpEl+OI6Z3CUxJzhhY9tYfxhnriUKz0FoxukV58Ditn6tJ+Jh5LIm99+TjTOCbECZh8xFKksQAH0Qg2OKHv1AnRQFYTwkodxDif1vcNH6b3GRiTc9evCLxGjXBXV6h8D+K4MUlXvNjUuBRxInndFbHyMTbcn51tFQB3d/3yDsHTKbjkC8z8IojAhxQJmJ7cJRNNWNpm1VS/WDyNL4v69ktd21yzPXejj/QK67ibKatTUg48O7yqb9RO6Mk0s9bWi4V5gaUD1a9f5Rh6gSDKtc9Lv4/haTHqGJ8v8LVg7cEDEp0d/1YarsBOl4NxrzVcBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758132677; c=relaxed/relaxed;
	bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzFbet1pnRRMpmy+igwBU5jmDvW8Rq8wTxWrfpn4sTx0geZkx6dUWm6yWSAZU4aNZIGBInYjv+s4iyZkBlpQGy9SKN9oivhm+rosw+Ba2vdVETyptFjx4ymPzhryY+Ok0U0nBPg6ITTEoXGS3+pQyE12p824UkPFDTxR8/y/yEFq7DtN/NCjfHfOCofRMGOZ66mDEykkH5y/jTGM/ZqNs4vtFx4r5OKBV8CwAZxz0slDnTf3VzKbsGFRaJ+QGONbcOPqNaYCD+S7obZuzlf+CFktdkdwSAjie/eLY/ogxLFga5TeifWKwSrXs0rH7rvZf0iyU2p/FAl7ofaG6EjNAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=aroz2qbL; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=QbjkGlUM; dkim-atps=neutral; spf=pass (client-ip=103.168.172.146; helo=fout-a3-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=aroz2qbL;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=QbjkGlUM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.146; helo=fout-a3-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 396 seconds by postgrey-1.37 at boromir; Thu, 18 Sep 2025 04:11:14 AEST
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRmzk2pC1z2yMh
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 04:11:14 +1000 (AEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 36A80EC02AE;
	Wed, 17 Sep 2025 14:04:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 14:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758132277; x=
	1758218677; bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a
	roz2qbLh39Uro22WFxx12+H1FjHb/XWmkihYk5sG0MKDuGyc8HsHXVaDQRi9X+z5
	GiJSyTWV/UIWmw+LU/MNMWaeT1Jkoad3QyudTSRmw8vulEyjMSDFtNW0+vxOioVP
	dz+OLwp8NMmatF5lIZYuvh/3oFIZ9CQvM53WE31hGupYhPfnvDG1feitmL5z+xOO
	lceZZBWEG3bCefAmggqFfeppT1IFZ8h1W/ytxFBGrPMblTJBfXs5syWIZEhgwpkO
	9gxp6cvZ3mDTM+NkdzB7PZIBsz4Do26OabZuCkVMblvnI6FViqMa8M1IexgNuwp9
	2GPfZptAWa/RuOmm4fnVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758132277; x=1758218677; bh=9
	6KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=QbjkGlUMrqFKvLdZa
	u+CtFuI4OHpuwg5j56jSE6wwSye0Fxe4/fyNzmtkXj71nOB1qC8BNseHGuXKN/qy
	O4ocppJWVYJCqzdMDEMQKVXlH1FmG/8K4Rq47Yq9YmdOTbuRvCVggHdRJyqxQMFW
	QJDasKmWMjtQjqGWRUcYTE2WNHNjZ+e2mjGpB+urGCxfEVqOFv3Y7ZztJdZlW4mA
	XoyS4DOHrF/QfOYAC20bxfqmS0LiSGSoW9uOaoHQLJ/42fLuR2gEocPJ/mHUiQuy
	c2wG5OYj8cjjufF1T0igoPg5urKs2usyzSxNy+A2cpx2Lrl29/2BBGX5IKyOeJ47
	EwvVA==
X-ME-Sender: <xms:NPjKaNmR8g1Yo8teh1NYvfw0se9-ozpCYVLg3qPsjDUfUH5zyL3u-g>
    <xme:NPjKaIAqKFEL9ghA-mBSHePqCnFRp76SkcSdjLdY2fjCI-MJSeKV9XL4gmWGdrIed
    ag9CvSpCc6ZCtvY6Nc>
X-ME-Received: <xmr:NPjKaGWDeo_WnyFZpl0THchVoNB9wbPQcj_yL33-cpnfkAh2Alo6TWZEFTD1mnuCwM43cu_MO0wZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilh
    grsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NPjKaG_po6iOZSwVj7Unv_8UdhucGnhD85QxYx2uO4TvKZ5CZK2F9A>
    <xmx:NPjKaIRbhrihadeXI61DN9EIlLEoUx5MG7A5yzfogf32oyj1htEz4Q>
    <xmx:NPjKaLQlqGOHZcshpRN5BQHfIn9gAFU6UM3gICiqs1oFVX0zYK8gEw>
    <xmx:NPjKaE6XZoUQoQjb_cjDkbFYoLwYuHUFo-ywJQWEyeNh6C0QUIk_sw>
    <xmx:NfjKaGX1ZqKLoEO6WEIINu7iwQXkNoZ7oujs4AO83-JyF2QDoTh4cRby>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:04:35 -0400 (EDT)
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
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Wed, 17 Sep 2025 12:04:25 -0600
Message-ID: <20250917180428.810751-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
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
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..7d5c6bfaeb97 100644
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



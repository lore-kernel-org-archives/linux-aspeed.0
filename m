Return-Path: <linux-aspeed+bounces-2211-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E98CAC58E
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 23:41:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNDbq4cmRz2yGM;
	Fri, 12 Sep 2025 09:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757568038;
	cv=none; b=RWRBKeaAmnXCqtombHrN2CvjNlVM2xOto9TWm9ebpPl7drImZyW7dbnDNm2U3oYemSpsjfP4YESWucNeJp2BbEGALwupC/GIFiBqrXSycsN6hpnxKM++8/o6a5+SUK+BKQFAkmDvjXlsZW+Wr64ytVTTe0EEaeRoI1euxhdycj+jmIyVtRh1PKqgBKSGRG/BblaW/3KPyeakYyYC+naKILuhJk0Dob775RHoCAbemZcfBDapLTG3id+a97rKMMkeOuibopMuBoSapqVukrWlv0ZFhOmTB1BJqFadX7zbSaGfIXLZ2ffpkXalHGwYixmwu45FWDdbYqWhgcJ8vfBn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757568038; c=relaxed/relaxed;
	bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8vfwJtXM/2B8qu4lGb23Vg+s8M3+aJlijCqhKkvWJsmNJ/uxMaNpGDJLejQQC4gIyLwSixW+s8et6HokwS2JBqNcJbDOVMTGks38C94txBUL4lw8SoZW0FKVfiqqIIyP0Nf+2hPZN4O+p8d9BqsT6oIuEEnzzXLNnK90B7qfJZe/ri4B4n6HrycMb29q6bx4Roroy4xnxOvTyexrqhce2MtbCl0/fvWSgE/jCJKEiQinTAs5sZ47kct/BHMHAoLcxg5BxSw/Vloiv/TSHTIzaV9TvVdsYXJKxgcVlSaQbWQwYzc6kweQ4NNWw1KhuL/wBkC+UtM3iJzyAVapk2FiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=aWJfl+fH; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=a5eWwZ8A; dkim-atps=neutral; spf=pass (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=aWJfl+fH;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=a5eWwZ8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMm9J6zDmz2xnn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Sep 2025 15:20:36 +1000 (AEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D22827A007E;
	Thu, 11 Sep 2025 01:10:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 11 Sep 2025 01:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757567440; x=
	1757653840; bh=96KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a
	WJfl+fHaZw/mD4A0YC0DDJOpn1RfQz0b7oDnIS4Cn3YT3DDGOx1v3BByvwdPLXcP
	+94DKx3Fh/JjnNsB6jXkxua4CtkmOxh/EnQIe7ZWMUOXtZRMFZgHCa3d4VZodkTG
	XbR5AsAnmigWVPAXoAzig/NGqJVf64wNsxz+GlnFMm1Ty9vjOHuEdrnCSYttsYtq
	cmnk9E6JasQGtKBQqp4NAbrRIIIkEUC8UuBj5ps6DyegFCzPSuSXCN3zw5kFQaMc
	2oK9HdjqR4YdLlAEEWEvpR9rd4GEZsRm1WbL4uaSJFqRJVPYdh4R8JXvN3wmKvCu
	Fsy3ZH0GSJY+l3QnQsqfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757567440; x=1757653840; bh=9
	6KHcK7LleltChpzhPpywBhRsLQkTbjtjGXxMC2iELA=; b=a5eWwZ8AqMYi328tq
	iIvDYEDPtfp3mQWa+Ur0LcAfvGgtr6G48aA2a5dpxgopXrwMUltqxefgRE2wuFeT
	sAbKmsVqOp/S9wLOfHt3uS6l0bGHtupsiAQ4vF6H8jVoiASXvVytbCFI5XksTXHk
	IsY3p0my2Vbv31UyY2tzdI4iUTPrtoFCjcODDIZrAWZZfDbTuiHF4oepvoGz6j3g
	HONVJC3JG2ph7IXsJ3mdzKFDWJUB6fmGx8wKQLtuv9MLKdNj0JhsIntklBrmfT9c
	MjKsXz9t6sZSUptQsJoVFBeQOdpaWdsTQKNjOy1SLs95LlM77y6h2xJ2Wv0l+OdU
	58thQ==
X-ME-Sender: <xms:z1nCaD_CB9TG43YGVAaneaxCdz9KhcEr3RcIWQnDAxciVjO4WQM_Rg>
    <xme:z1nCaLi5F7EQmXnFqM7CBms-ZCtCQ3RK-pWgOrzaNR2TqChYVw5ENhdYnwCjFpRSI
    u7DlPjowmdbskiEbgk>
X-ME-Received: <xmr:z1nCaMac5kXWQ45oq7PRamOF5asNHOG-_IZoNxaloIPIbiJXrivhNkV-9Hm90zzjKqkUWvyACeig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeftdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:z1nCaI_hQGFWsU1qhnus-fPH1BiVd5n2pZ_Kp30_EZkcb2lkKSZn8g>
    <xmx:z1nCaGMapetGo919lVEcimdrpT_GODRNIXR9zZnD_30kFk0GvaYUXQ>
    <xmx:z1nCaNH_QwPvHo4_tHsqUzADeYSQYcFeMtjkoL3cUO7e8Wq8x57taQ>
    <xmx:z1nCaMy_Dli99A6M1XEgLcse_mFu7OdQRgWgNS-Vv-WvwRly0Mb9pw>
    <xmx:0FnCaFKkG9-3-SGs-M_ZnmneEUZZrdSaiDxquyQdUm_MhLIvZnLJLQju>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 01:10:38 -0400 (EDT)
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
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
Date: Wed, 10 Sep 2025 23:10:04 -0600
Message-ID: <20250911051009.4044609-2-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911051009.4044609-1-rebecca@bsdio.com>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
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



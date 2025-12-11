Return-Path: <linux-aspeed+bounces-3094-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD8AD41C38
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 13:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRv4p38y2z2xqr;
	Fri, 12 Dec 2025 00:46:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765460778;
	cv=none; b=h+Qa5ddtp4V5csFA8/DanAVu8KtsH5fNr7eBy33lE5j0nTg2wMS8mdrGOvOd6RHL8tFXHlMZ28sHnvUSzx+XpjCmnCQQgEB69ABSKCT0tGss2MRew/TEqJGuXvE9svrbLZdkUu4fX8t4nQlOTPsSFuIlIIR78u3WU6IYMRNhy17zLCJ9FRow0dq9hAybW8vSpOWe24q2IPTeVr3RlpE5mCBc9O+PoaBig5+5UgYdt2uDQvh6yl++0Wu4A5E1bfWRW0wsUfxrlnNjS630G9ztil8Ohxd1u28OqDDYWigOOtvc755NgEK8eUhQZoiu0mR6g3CQJ4PaktQnJGM8F1CUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765460778; c=relaxed/relaxed;
	bh=n1dFL102IvyRuI2M5K3t2JBa4JSeYgA6HETfVWFDo10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMII3EQ8aW125jeAqAsVSJ3DRn1BENuZVQ6EG+VrePaluvBcCP+ifoy3aEILF+i/RlYyja51NIG72PwU1KrK9+QvjQMNbNf5EMIb3Swiew+QiRQPr/hh7X1MXnF2z5G+prJG9jEbI+gHlyAvkKcfNguU7Hs9pG1Gd/exYcJmT3o7SmQ874+/JhgNbf6KSKnTsmwnEfUVUFLW3jklvdsvHhPCK3ss6D9SbQl6IF6fth9z9453IfGNc5nEcmu+XjNmXkDUwBaHgUgBbkeiIGJRQiz3gGTnxjLypu/2idbKC05XfU7WqN2HWC7hXXUO6s3bQn1XXuXEOflJkBt20MntPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rrJ0G2rS; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Cl5ftS57; dkim-atps=neutral; spf=pass (client-ip=202.12.124.156; helo=fhigh-b5-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rrJ0G2rS;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Cl5ftS57;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.156; helo=fhigh-b5-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRv4n5zWLz2xQr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 00:46:17 +1100 (AEDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F37D7A012A;
	Thu, 11 Dec 2025 08:37:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 11 Dec 2025 08:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1765460260; x=1765546660; bh=n1dFL102IvyRuI2M5K3t2
	JBa4JSeYgA6HETfVWFDo10=; b=rrJ0G2rS1KQBOSfjqstumfJ+ZM8ja8OJQjntI
	FK+AxEua5wOk02TohphvL1XRi4aJ16xPnf2MfsMjb6vvXHG/HupDdH0vFaUBDxV4
	kS7qj8gspnoQkQq2IPbRIZeIvoogkABEDjZsXWMlvyKgBBAioBOAP1Ooxgh2fbAQ
	TbTPNl71P5qdhSmZMserLeJNsNj1X/iqgiWBw3bOrhB8ezSbTYUV5+ZePTuNY7ub
	ecsflxjbmLMd0m+cBxzuxYWDfgSjItQw/l6wQSfexkH1ryrgMhuEN8CaaNV3gqf1
	PZsL+YZCB6ofKi4bzIcHXXnBLCGvf2sW2iZ1THMHUShkxrbYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765460260; x=1765546660; bh=n1dFL102IvyRuI2M5K3t2JBa4JSeYgA6HET
	fVWFDo10=; b=Cl5ftS57JbFLpAKWOskXemnucZI2X/0Mx44Xh+H4Z76nq8Jv889
	0BpBHGNhAiivHKhuVF7oBfiYqkLaK211EGnn70oLqHEwxP6EgN/IBH4cRgkrBE9x
	ZBpjaAekP6/Otuc4bFzxRJ29xbs85zkvtvzEtlZwl9Frb6Z57N//iG8hcuIHerIN
	Pz0fI31XOP17ZokAxqnNc0TvBiGpqLDoAYjgSs5ceooktkx6+3/y4jwhY7sSILaL
	8K5rGoLTW8Bbje7RI7iPyzIXgb3Y8t+ORpeZAiE6NFw/Fh+Z3PR0lb9a5qPmkmCJ
	7mhU3xuOE7+V7MjI6mAk+O4KRWdb0+CyNZQ==
X-ME-Sender: <xms:Isk6aTvxBFoJGOW7WCHFt3Uutkf_i7Qa3OeaoqgeDhy-_KFUSBcx4Q>
    <xme:Isk6acmJOHxII5sBwL4yvCKHrPYQNRNbWdAw1LipcqSSA4LWIIDRu5HO2RvcU1N3Q
    680w_HN5EGGQZGIx6tsvycPKi1AheMumYo3n9aLMvlQ0D5q3zAJ3Q>
X-ME-Received: <xmr:Isk6aWROwsxR11-LT_YMghAyK26oM_VR3KsW1sN1I3JkUXYwHcmQANTlG1ltEzAwtneVT3qi6yVgiR1N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    euvdektdelkeeukefgjeejteetffdtudeiffefheevfefgveeulefghfellefgvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggttg
    grsegsshguihhordgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpth
    htoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsg
    hsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:Isk6aSK3ww_qWNePEaEYZ2dWGaNjvuqPU5BVxy33_7oofLEBPmj2fw>
    <xmx:Isk6aQGnJVlsE478CXeT8V7b85APUovhu7lkF8r7v7mVoUkeS2pIUg>
    <xmx:Isk6af2gbAFc4i3pyDmnqlRG4Ta8cMYnw7A5QPitzuK952iHhvx2iw>
    <xmx:Isk6aYLkCZxjtr4hQnzHFijWy9aj89azZV0b4V9vIi4OmdJVAeorvA>
    <xmx:JMk6ad8Nm_TvHlDsujl3b0NbjgaaudIKNKmSp3sySbmeoA555NxM43sy>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 08:37:38 -0500 (EST)
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
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v4 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Thu, 11 Dec 2025 06:37:17 -0700
Message-ID: <20251211133721.18269-1-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
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

The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
processor. The BMC runs OpenBMC.

These patches add a device tree and binding for the BMC.

**Changes between v3 and v4**

- Re-added system fault LED after verifying it works with an
  LED connected to the AUX header.
- Fixed GPIOs based on Tan's feedback.
- Dropped DT schema commit in favour of Rob's changes.

**Testing**

Ran `make ARCH=arm CHECK_DTBS=y aspeed/aspeed-bmc-asrock-altrad8.dtb`.

Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 625 ++++++++++++++++++++
 3 files changed, 627 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts

-- 
2.47.3



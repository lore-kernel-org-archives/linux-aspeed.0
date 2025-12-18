Return-Path: <linux-aspeed+bounces-3143-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B4BD6D232
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Dec 2025 16:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXG7V5wTNz2xrk;
	Fri, 19 Dec 2025 03:18:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766074726;
	cv=none; b=UiKNrDEhKULFil679JySyEMcdhnQ/CZf79V/xbiFGdYqxMVbqa+ZLagOcE2VmobqwImYAJLyf6RWITwH5O21MQiDEBej8g+D1nET96biq410eLt1voepf8rfz1AQ1QTCOvmF4p8ytx4wvXWHivj7hJdgmpNeyAJwOamSwlIqEcrHf63sCL20KDzznnNpXmsHZ0m84iOp/S9nbnS+IGck21plplM/qPexNWVCDatQjHidnDbn4TVeodUzn2nIfO2l52+puWmX3i7aYjpuKd0H8kSYziXbL9IM8nVz3l5SJ9GLgVJ1uMusFfoPGLnyt5TXVjvUNhOg+Ls91eRRWOpyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766074726; c=relaxed/relaxed;
	bh=fOMAPBpqiDolFkcOOfLuDOPK8pbzW0rkKkcpmdMbel0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HodHo7+uwFqzE1c7vgMpssPycv8UWdrgC25WhR9YJG61Ol+cm/k490LYORE+YGeTYqDswJfN/tF6XJEk53Eb1fpqIrcAsmnfAMWrEvGkOAgvqqOyAs8Y1XKNed/tlzeVjqxq0GsXXZx+NwVNJwFH/giZGXCBQBtWP9RIqvLAFQJCRHC+7FPsp1R7eneSOOmKkwPlaCA/GZmOme82glbSx+gxDpjLOezNNJEUZiocvHN3/t0czfjBE49D9wLKfUVlDR39zNgvS7+MG8ACUhtMEECMNSr1jik+tWpDTnk64ceqCqxx9d759FTmOEWb4b0GgZcPXTBZ221MewGgrIf3CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=EIP+O6HU; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=rPWYe3iK; dkim-atps=neutral; spf=pass (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=EIP+O6HU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=rPWYe3iK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXG7R4xldz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 03:18:42 +1100 (AEDT)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7312C1D00106;
	Thu, 18 Dec 2025 11:18:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 18 Dec 2025 11:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1766074720; x=1766161120; bh=fOMAPBpqiDolFkcOOfLuD
	OPK8pbzW0rkKkcpmdMbel0=; b=EIP+O6HUlwDzOF882SOb1CBQqX36QThwOXWSZ
	Kd8l52fbrfw6vXl/jvOZiJnXL/P+7R3/dhS8Tfi/kEuq60BU/oBPHO5YrTgq0xLL
	LBS1yJJZgduUU0pgmqRxjAEZB93hBj0s3HVmNXLtVP8nzYE5FMTSYBS92HnUPKkm
	2zw7NhFGEc4VqFRts6AQFqii76og2bIXyLR05zrMAS/M3Bryj9nHTeXHgVOGbAFA
	Uy8SembkBpHjHH4v6Stsdci8VCJEHAwpaIqyDGe4KLOdmxryg7V0r/bveAAGPk8I
	eacZbRJ0TqI5GRgtFC4/AIoM8tTXgIjc/gh2fnnGwCXDs6CpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766074720; x=1766161120; bh=fOMAPBpqiDolFkcOOfLuDOPK8pbzW0rkKkc
	pmdMbel0=; b=rPWYe3iKNyVeGT3Qh96uYXq9jdpKMreGhcL6oTG0hKOlCzfUwAM
	Glc200gENEIcrXbjYDSEmzAC8dh1gFw0To2/HJL0h3d/Yz+lAws9ZDGgJvFq7TA4
	MUe0iR+KAN4V052rO8hIgf6iT6bXvwGp+32Xy9k/R8DJRLhJRGKDm8dbPkHY6tti
	Stv10rmR8L83kDoIs9koLkGzptC6G8u5W03/l0o+Ba8OUOIxvyjL4BKvMkfnFe+F
	mE3GAGSrbI3T9g7zk4xI58HvBMGLYUvmbmTbhLzSAj6os0mQChxHZqHSHtJ02dOZ
	bC59Yv40wkVwXCZ2Z3+yYyNrQiT4IZNWvVg==
X-ME-Sender: <xms:XilEaVnQGGwpt03wLTldXFgUuvSJex82Ipy0LAd1jW6wssaZEfae4g>
    <xme:XilEadj3dp-vMCTKdtw-v4j1D4xI2tuF67wOx6aIkdjhyqDLPzR4i2Omm3Mn-EV0q
    Qiy3j4M7_vxj7YMx1igtS1htRCDjqRzoRbtXdyfaT2nY8goioxIcg>
X-ME-Received: <xmr:XilEafh5YQ2II6HIXKgLnyW0hoo5RgeRAcX7ZGnOPPhNjaQoWkL8Qda7ExGbriPkmD1bkafVdmtiwoAV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    euvdektdelkeeukefgjeejteetffdtudeiffefheevfefgveeulefghfellefgvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggttg
    grsegsshguihhordgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpth
    htoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopehtrghnrdhsihgvfigvrhhtsehhvghtiihnvghrrdgtohhmpdhrtghpthhtohepug
    gvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhr
    gh
X-ME-Proxy: <xmx:XilEafuxe2QfUYWV2H12-EGQgNh3MHcGEoHEo9w77VvUIMZS5D2Qfg>
    <xmx:XilEaXuXbW8YBFw4qeIFrDqG_0KlKhYNbz33pCkUOqLM5_FRg8q_gQ>
    <xmx:XilEadpIpmdY1eQyErOAx0lMbn_CSPtuy-oBwcFMHTu_-dHwBU_4Fw>
    <xmx:XilEaeJoo9sIepRDih2LVIfISMJLpo2QXtOwP-DzPkKGBoho-g1VjQ>
    <xmx:YClEaWF12XHfceZmNHmiUU5UvHu7F8PAmKkSQo9tR5dWu6jQAYt_KChZ>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 11:18:37 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tan Siewert <tan.siewert@hetzner.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v6 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Thu, 18 Dec 2025 09:18:12 -0700
Message-ID: <20251218161816.38155-1-rebecca@bsdio.com>
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

**Changes between v5 and v6**

- Removed aspeed,external-nodes property.
- Added pinctrl properties to adc node to request the ADC lines used
  for iio-hwmon bridge.

**Testing**

Ran `make ARCH=arm CHECK_DTBS=y aspeed/aspeed-bmc-asrock-altrad8.dtb`.

Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 637 ++++++++++++++++++++
 3 files changed, 639 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts

-- 
2.47.3



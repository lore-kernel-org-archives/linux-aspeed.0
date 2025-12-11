Return-Path: <linux-aspeed+bounces-3100-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DBAD41D6B
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 16:57:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRzK772Bpz2xQr;
	Fri, 12 Dec 2025 03:57:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765472235;
	cv=none; b=cFNoDnVNvn4uTfnJQEacTLyJm17KJo/vKkKJBd2PH16vJfbsmEbrhb4NC4C9n2EQ2YZMIZfkZj/zHfsD+pEFlu9PndC9cUgR90hl8U6AkNi/yN66OjfYWvozXIZIsxvPgP5lzzDx4bgLxKZXUSo1HS1x9VaVlKCwBq1rRf+fbez/27aztChUFOJcJakCgER4Th1EOIZGM6xBECWsXCQxxJeI1Qzfj06Co2zfdhXb6WbrS5oDj6l3iLsNtXN5Ie1RDyxj/v2c4AGFptWdM5FGxgYk8gpQ1eu9fGZ8Y2rQ5cxYE99vJoyocI4f8//2TJZcuqDbftVgruHTaxGO2+jkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765472235; c=relaxed/relaxed;
	bh=FV+/mf1TDpvf9vv9dubhpTnpGcmZYUCXQBu8f7/hO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWE+k8a/t5zOm4foJl6DzSeKsKKqwU1/mNdlb8c6XVrRMR8ysPRJ+IjqW09x07Sft8NG5Y7rkT4/glVp8jRcQUr/EyTivISpZI/RFroDtsJCTIieZVcxjVE/SgYort6QO1EnS5fThs+5BCynYl9GkE498ZX4r2Jnz/KQbKs/paZvFwKSXCcHxCs6VidMH0EN07NaMZ6pkn4f4/rS1p0pKuqcIt06335kPyOnWwrWZVHfYj0P4rEnn44X7/x10OMeQKQXAs90pbqeb5pPz2XDiY94lQ0RD9jbxmZoZWVPsVUocb7S7VmFlcgpc/iBquASgCBdEqGCNOXptgF20/7itA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=zre2iYV2; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=jmQqp7yH; dkim-atps=neutral; spf=pass (client-ip=202.12.124.149; helo=fout-b6-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=zre2iYV2;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=jmQqp7yH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.149; helo=fout-b6-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRzK52Nkhz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 03:57:12 +1100 (AEDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EB7961D0005C;
	Thu, 11 Dec 2025 11:57:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 11 Dec 2025 11:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1765472229; x=1765558629; bh=FV+/mf1TDpvf9vv9dubhp
	TnpGcmZYUCXQBu8f7/hO8I=; b=zre2iYV2KpNCrrkml4JE+j4P2mn/oYCcIpn4K
	wqtDAv1VIS27KbWp7kxCzXOmnIBSMg8o3Yzj8/Shur9WnIoydJzU1WfMT27o8JXe
	0zDfvxb6UN4DhwVgY8AqSHy79kfPDSriP+fIbLnj2zyG1lre5viwrvGAZRIQOkd4
	EuAq0SWXxd9Lr+nknEVUNAyAUPmYGkzESbep9WELnCkeCYSMyKBy/v7nL9YP8iuj
	16/XaKw8Zaz3o1Qr84zg2x42D1iprs76Ioab02l6IgmnxSi8j8L2Ebp/jVOh0N76
	MC3JlKHpJ7EXHEpgKkHnGYGpjetQRNg/LwNk340kjbJRAly9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765472229; x=1765558629; bh=FV+/mf1TDpvf9vv9dubhpTnpGcmZYUCXQBu
	8f7/hO8I=; b=jmQqp7yHuKNzHHSQeDsE31pfLBJmQxTyXpTJQeFTMFQ3yCVK2AD
	dz9BeOWk0UFNo5fp6Glw2dPn8/RiWuGfI9SKvf0otJ9Tz1LtqU4W8KuSLp1yda+D
	LN+Gp1oeeARRCYrmEXRfGnwRVzx644cUqlp5ZJLc2YaSQVUyeAxH+2WD+p1ExQD9
	/8Jjcddy/BjOqCxVgCXiaM18gJJ+36Y1x5wtu8hC55TF7lqAsfMcxmEbRX2xaQko
	+WNZcjqR+HhBluuMGi4rMu5YdU1vayBKcrXwt3dBpBEL60rPgIu0Fv5e2GX7eZLC
	kE/Y/F4LgcJMwZDKvDxhm0ga1SRaYwoqxog==
X-ME-Sender: <xms:5Pc6aZWbJUUASrSVq0QUvyj3BppjvJIDJrHV2FScZ4sjfWhQApawag>
    <xme:5Pc6aRvuJQkQn9E5fxC_GolkwJH7Pio6H_Whl_oLiVzBRSJ18eu50Gcl1CTYWysWC
    AvutmEbi4r8jp_srw25qko8jN1C_2vE1YvXU7pt8Jn1vHaP9UNjsA4>
X-ME-Received: <xmr:5Pc6aU6xj63M3XnlaXtFWxMh702mfrLtWTvanLxt1mMF9kB_f0U5klZE8CuTLfQJ1fWd9o4TPezKoe0q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5Pc6acQQzWlHepqpVAiP5l-uNUdKFuz8OzeDGolhAicNDQM1IooTFQ>
    <xmx:5Pc6aftcADNT-RSR_rHD4O0VR4MsrbGs0ThHiB7g1ZnaBBHwNB_v8w>
    <xmx:5Pc6aW-4gtH1FrFLWvEvZz-5b_lf8T4Rhj9HIenJ7y--NPWqPRtP2g>
    <xmx:5Pc6aQxMmodAiQR2NNZIxJ_oYcCCT46CqGnAw8wdufWkMat07gIJ2g>
    <xmx:5fc6abEd8mY0s5x0s9HUxmRzxUPhnpR4H2UNLtvfdCdqyMqT4RzqmxEi>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 11:57:07 -0500 (EST)
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
Subject: [PATCH v5 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Thu, 11 Dec 2025 09:56:55 -0700
Message-ID: <20251211165700.29206-1-rebecca@bsdio.com>
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

**Changes between v4 and v5**

- Removed the uartx-mode1 GPIOs, which were wrong.
- Fixed button-power-n GPIO name.
- Removed backslash from end of line, which isn't needed.
- Removed duplicate/wrong bmc heartbeat GPIO.

**Testing**

Ran `make ARCH=arm CHECK_DTBS=y aspeed/aspeed-bmc-asrock-altrad8.dtb`.


Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 624 ++++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts

-- 
2.47.3



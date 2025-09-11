Return-Path: <linux-aspeed+bounces-2212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B1CAC587
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 23:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNDbq6bthz2xns;
	Fri, 12 Sep 2025 09:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757568038;
	cv=none; b=j3izldu4vHp1PEc+bK+g5IXyJkBgLo5BuYFasWeGJ9kZHtJwl+RYPQPxo352Mx2OBAqhDE3LhG6Kh4tx72pO8CbPRj9gwq1Onc+/be2ndN8u72MLjE24fmuS3tPvhYIAkfkmvSkalavYnxQ4+7no37OhlGRutb84Eut1LVQYLfYmjVd87xOGhm/zQR3mWv74on1Swj4YyaLKzy1aAhKqm1XswannFh6WR8KfI0q7/MdxY55iuRGmfTn+sruIjX0UO2jgVgQLFPR377j7nulNwD0WEkZsNkvxPSrxPft0Qt9LGRr4n7G08lx9x6XC8KDBviQGDcgP1/NnhsKIvaaMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757568038; c=relaxed/relaxed;
	bh=gaoZGBVm3mGzgQoEGG09Oyg+9a2qCQexgaNw5V5SpOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVIBs3HM+cAFG9RnZndA3yP1NmtVa8SN9yRgSX1YmqnWHLA+/iJRVPM+g+qfJWEpz7xifVkW0L9UFQltDJV5H1OvTj5aMjl+LTGa9wNDWGKV3fXSMOGuR917l72/zoA+JnU3undxunUvML3aCv9nT/fX+Sp6Q6MuSWXREgqtOgq8ExG/ZvFFATS5oSOkzsdtrqqHNiK8oOODFEItkljX57VnCWAwtpzeALBS6PxIIOEve+4O/UDuS1Q/FpxEhuRgCiJr1HTdbH3luquh/2BDUB/IHiYlQF+Wi6CiCGqtmEtfgHfRMoPtB70etFzgmT/URX0DGcKWaZHj075FUIQvVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=X4co1BvU; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=HwiLEaYa; dkim-atps=neutral; spf=pass (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=X4co1BvU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=HwiLEaYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 595 seconds by postgrey-1.37 at boromir; Thu, 11 Sep 2025 15:20:36 AEST
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMm9J6qr5z2xnM
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Sep 2025 15:20:36 +1000 (AEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7A037A0058;
	Thu, 11 Sep 2025 01:10:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Sep 2025 01:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1757567437; x=1757653837; bh=gaoZGBVm3mGzgQoEGG09O
	yg+9a2qCQexgaNw5V5SpOA=; b=X4co1BvUqcXccl62w8HrWO4by3iZzqmmRnMGP
	v+1Nr/PAbw6aI/wFoYJXhGZieFoivmIB1xTTPEGBAd0g0kidAHDxu+h9jXFfsSEC
	o/BuhtyAy1mgSmcxATpTROtG/yRcJxFTIJ+8/QLi+7ebeIbilUIyX7Kv5vDnwGxZ
	Ekej56pG1U+7XQ7RrMx+lvuYfIrvWV8gQjFCJdFGNiwx8N3KOBDzFDlA+7L8Fpit
	snfAL6cyNTR7pJAA2hQHBK3YKvEn0iSdEYXV/2B5PQPIlPLT/DDu+zRc3PvO2qCK
	JdBtUTCTZxYlQbO8a9gJjaWIllTpwXMldZZE4SkEJw+/VHPVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757567437; x=1757653837; bh=gaoZGBVm3mGzgQoEGG09Oyg+9a2qCQexgaN
	w5V5SpOA=; b=HwiLEaYaRDf1Tb75MashswycBlfp6ngPG26sVxUHmZbGl8zHbze
	OUuGHz7JhmSRpgsIcBqZgshalNQ4xkEpbwQvqLBywBU6YhVFiGzC3jXVPqV4jnye
	D/MOFaegpWxIeoPCtBgjt7BMlN6Ooftr7IBjjH3vA6GZBLZJ6ukk5l/sNt98TL4w
	68f1CM1YkM3y3AP8Sm3wpn8Zl3xLCf+tB9r5m4KwCZwEKX8Zco6jxS9rPKWGQNG6
	ZyqbuccGJOrjqDlj/1ndcWDxLwGk4O5GUXmV+TLPtxA52Nn1LnKRouMORb4Hh1LY
	DSzEIK2kq82zexB0fDCyBWnFp6NJdM7Qmig==
X-ME-Sender: <xms:zFnCaA4dh6MhsOHOJPaloeKGNsm7erRR37Q-mP14-CFd3Pe15VHgLA>
    <xme:zFnCaBEOVcHuMGQWoGByHIeHTwtYtvbVZR_GYqCeNRhFEvWUSg4FHb_qJhCxJNnN1
    yPdsr3lbZxk8sdWCq0>
X-ME-Received: <xmr:zFnCaCKuty7_tw_nRTJyLtCs4y-_kt0E2PSZzhGV0ovYmsRG4OOWjb5oq5hn7LW2-8i3VIDJ037J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    euvdektdelkeeukefgjeejteetffdtudeiffefheevfefgveeulefghfellefgvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggttg
    grsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpth
    htoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsg
    hsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:zFnCaOjpULaNaq4e1xD_KLBzFF6NGwlPqRm7a0NltOzraA7l1XcRMA>
    <xmx:zFnCaAlFKFeBaiEP4bdxWyztaaz3kt8_r7lgcOPIjgSoHMPyTDvjcw>
    <xmx:zFnCaFURAgP4cAmYx2kVdgkktgAy3bpt3VpC9qjHyrOmYurF2-B6Sw>
    <xmx:zFnCaNuQzv6IWjSKUioM0tkxfbRm6QMhkypO0VVlj2EQ6U8RjCEaHw>
    <xmx:zVnCaHIOo2_TRa6BAKadwQcbQ9yS37xiHhRyilljsUX9gsh-C3p5bUn4>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 01:10:35 -0400 (EDT)
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
Subject: [PATCH 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 10 Sep 2025 23:10:03 -0600
Message-ID: <20250911051009.4044609-1-rebecca@bsdio.com>
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

Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 647 ++++++++++++++++++++
 3 files changed, 649 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts


base-commit: 7aac71907bdea16e2754a782b9d9155449a9d49d
-- 
2.47.3



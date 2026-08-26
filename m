Return-Path: <linux-aspeed+bounces-4863-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73252C5DF97
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 11:01:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVMCH5KWNz2y32;
	Wed, 26 Aug 2026 21:01:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787742075;
	cv=none; b=Jn6jGXm7cd4gbJT8Hw8cDhnOiwEYOQ3LXuaDIVuNjdGox9mRjZDMQ3FHQy/N+DvzcSRFBJOJbOrx7ohtVzd9OyyTKomv8fRBrccNlCs+MypGH4WT1Lss1UqTNYGligzNlaAWK9VSpyPAok/k1Mtfh7AM/kSOsF7zFrym3YFXYzz0+N8BPGxo9NYYGcgG5JAqp496T14tK59EUParul4t1yuwS5FsaomHjgY1/JeyTOl0j2RXVJbmOw5MrksRDtsvFstk2p5GDXIZMol3RHUAOZRvwbecZ8UKNw/ngE3Ph9PXk8TdY9joa3Ce/dkT2d289pskCyQ9b44abp8usTiJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787742075; c=relaxed/relaxed;
	bh=Ey9RYH2RFNaz6azoD+KUbSwAq0kYLs0uc4QHAcA42gw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=VvpGWZoBoWd8jBUMKbI/pjvedq+wB8gHLUTE0NPwT8RRr2f1ilhdNQDdfzv0ZY33xImqhQboxtQvNYVK/AP/vK3lMyyx/j+FV5ltCeVBNZjTVkTKE1Dm6ArkwrMmo0vmAvAlU0IdZD0Sei+4HfqfJGazFsn/X2j7pwWX8KQlnD6BzUJIUFX+Sy64PvT8F7FqPFxqXv4Wy8XYZixZxaNdDIIbrq5zEeeVLywPzS7s4wHdJatShOVRfA4oWxS/gO8V2HOUdk866oGrqHRGm1SHwlhvzrUAyzuB9U2xCzfBiedTFIsLVTQZPDpbKyaDTmtHNj2AHhTL9Vwyn2Wo5s4FQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YwzOoaUv; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=luca.ceresoli@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YwzOoaUv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=luca.ceresoli@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 490 seconds by postgrey-1.37 at boromir; Wed, 26 Aug 2026 21:01:14 AEST
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVMCG6ZSSz2xLG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Aug 2026 21:01:13 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 72AB54E41317;
	Wed, 26 Aug 2026 10:52:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28841604ED;
	Wed, 26 Aug 2026 10:52:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23C1A11C7AC46;
	Wed, 26 Aug 2026 12:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787741569; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ey9RYH2RFNaz6azoD+KUbSwAq0kYLs0uc4QHAcA42gw=;
	b=YwzOoaUvCBxvOqya44IQRmcChvhXL8vgHGxbcCmbhbmECnpLcwRQMcP313YXEjBjIbGjtb
	I3Wid39NLAGygcDi2YmXtYo3AnvhAC8qiwoT3eV4cBJRzRjsj5XRyCYrw6G4qiA7F8Zjly
	vEXRD7XVgML/YjQ2Uyrc+ngfVs8rycv3oyvd6Hm0WMNZvz7S4w0rvpxlqOaEK5j0BYuwCJ
	L8Oeso8gBo83WUUPKcbxUYj/zwWIS4h0vUpJl6+JVbBurpBXA6XJKvKWQUQD1lfPaBrb6L
	0YOhDZdzMEyQk7IuWvSDDzCZv3a6OjEkFdKfO+U7ZZbKTgyueYwGfJ0tIk2zlA==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 12:52:21 +0200
Message-Id: <DKYTHI4WWQ6V.2CAMI1VACSS7N@bootlin.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values
 in <>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, "Mike Leach" <mike.leach@arm.com>,
 "James Clark" <james.clark@linaro.org>, "Leo Yan" <leo.yan@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Michal Simek"
 <michal.simek@amd.com>, "Andi Shyti" <andi.shyti@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Mirela
 Rabulea" <mirela.rabulea@nxp.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Lee Jones"
 <lee@kernel.org>, "Xiaowei Song" <songxiaowei@hisilicon.com>, "Binghui
 Wang" <wangbinghui@hisilicon.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Dvorkin Dmitry" <dvorkin@tibbo.com>, "Wells
 Lu" <wellslutw@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Chin-Ting
 Kuo" <chin-ting_kuo@aspeedtech.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Mark Brown" <broonie@kernel.org>, "Joel Stanley"
 <joel@jms.id.au>, "Andrew Jeffery" <andrew@codeconstruct.com.au>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>, "Billy Tsai" <billy_tsai@aspeedtech.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Boris Brezillon" <bbrezillon@kernel.org>,
 <info@mocean-labs.com>, "Olof Johansson" <olof@lixom.net>, "Shree
 Ramamoorthy" <s-ramamoorthy@ti.com>, <coresight@lists.linaro.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-i2c@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-media@vger.kernel.org>, <mfd@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
 <linux-spi@vger.kernel.org>, <linux-pm@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 26, 2026 at 12:20 PM CEST, Krzysztof Kozlowski wrote:
> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-aspeed+bounces-4862-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E52C61DBE
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 10:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVLwN5C9bz2y32;
	Wed, 26 Aug 2026 20:48:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787741300;
	cv=none; b=GQzUydLLtUQyMC0pIH4OCJX2nlG6DznBbWCJholj9hO6EO/VX611sNURcz/g3TcxRRpnN+v/b3nU9/1HAETjjXJVOc6FzK7DVSgWraTf1YIafZz+gmLfEy83F1RZQIag6zrkGpNLfu1RFYk/CR6wU5y0yIcnRfuqlgizWGMfn6X855kiUhimpnyJHCN5hsoSiNnFt73YKrpj64eIJsHs4xouuivO5VQTRdPN1SrcC8/AfVwoaLuOTMOWJSZ7aF40fvge82xGneaDfb/TSPMoevwBCAqVCS30bxq4Z+Evv66+GCOp8hYdr4bUCfQMaRmp9hH5JBsLoiJxJpXhhdAAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787741300; c=relaxed/relaxed;
	bh=2PBENmYs6fiknMrazp/50bVkNc1sBGJoebvvjy0eKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv3YIrX2/JKTS7rXXRbUAjF7UUXlGVsp/DfvXmM8+0O+fiMppTIQHC80IOMK6FG4OXQRIJdoiEf13dpE0kUTm7BmrVZnA7KT902Q1lXv+ohs9whtjqPAppTEP6CspJrNDF/5olRDmuOsF0iKRwP0jsfRqbVxAURf9pjVJ+H2x6VT2UaxejXhWok0DA9SsSPZKa18T6bnSqGqZEPTQF3nL5YxpBvFzApmYOsVBqCERh9IhGKiUzv2N4Yw9zwbcY8bJo0JEpPz1YgpOTBW6CdU7zZhXDcMCqfHFRh9gnNe3ZpBEkjkUSqcrIp8sf6kpcYNCmqGINQqA3aXJwHW3PX9HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbC9eXOZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbC9eXOZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVLwM3NhBz2xLG;
	Wed, 26 Aug 2026 20:48:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A71E8600C4;
	Wed, 26 Aug 2026 10:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB71F000E9;
	Wed, 26 Aug 2026 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787741295;
	bh=2PBENmYs6fiknMrazp/50bVkNc1sBGJoebvvjy0eKx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbC9eXOZ2dL6OuBJ1bWchF5seeE8ifsrT8Yw/a4Qo3Y5Rs2etS57xSuEdgQns99ei
	 QVPl74HmDPUGNZBf7+WL1hBpXywRwssYdENv9y3V+JkVXQ3w8kTmaN2R7sWY+TBwJt
	 rpd+iGj4akwD2mqMk+XymnQmIxApZFfAWUutiB9ezEi8bwZpp00uztIbITa3g+1Fx7
	 es9x6uOFAGNXG4NWRTnEbcER/UYbhW9caRHYj7iJhyEeIyDfIV9wtbDJ2QbkvyWlx0
	 dpH+wik6piKWJNDJwpfLl9XKfDWmEHKEB04XxOxRSgTnJpeatCCyZiHCa7kSHWZp/A
	 Z2tQRT+7IaTNA==
Date: Wed, 26 Aug 2026 11:47:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Boris Brezillon <bbrezillon@kernel.org>, info@mocean-labs.com,
	Olof Johansson <olof@lixom.net>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	imx@lists.linux.dev, linux-media@vger.kernel.org,
	mfd@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values in
 <>
Message-ID: <92dfaa64-18c6-4ac0-8b17-f0a202dcf737@sirena.org.uk>
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hP4PYOBKxN+fM2z6"
Content-Disposition: inline
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Cookie: Obey all traffic laws.


--hP4PYOBKxN+fM2z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2026 at 12:20:45PM +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.

Acked-by: Mark Brown <broonie@kernel.org>

--hP4PYOBKxN+fM2z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqOxF4ACgkQJNaLcl1U
h9Bdwwf+L6MG9Bumzzk/fUvAIBXVI/dikPCxxDKcuqi5O/yVCeQWiMHK4Kp/ca3l
imB6hoNyz9NRQmnZ45EXJhpRnz1LbTO357uK3N4zx/bi7V88563ixNa8HQIJZiCi
yBPtE5ToKgi349/KXca5/vSKWGfyCnD8DRL3icILcg9GwxUC14PEo2WFYcGR4/JP
ZmD11XU7MLSAhan3AUqcBiK9d+baT2FfEwmxCk4tm3wswPG29CNeUWP8OU145Yuq
YcOeBmOpgMeDFyqxfCLMwJTToaxX8FcAn5HDjE+mJ+/pTLge8S8d85cmy7dJrUoU
IMs1ngofm5Q82f4e9E8pPeXEh4y1iQ==
=ZN0I
-----END PGP SIGNATURE-----

--hP4PYOBKxN+fM2z6--


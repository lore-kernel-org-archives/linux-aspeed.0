Return-Path: <linux-aspeed+bounces-4869-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E952C61DC7
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Aug 2026 12:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hW1ds47YVz2y2b;
	Thu, 27 Aug 2026 22:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787835185;
	cv=none; b=EPDSbKjVyjnpC0RIjR0wNT/+cHC95ZsguybjZ9vqf5afXIYoVC2VZ1YnHsJGaurv3GsYobBugwaXGDLHLcccpNjsojyTcSE8jQakaJXwbsXagqRZadT5rk9m2tnssZQY97fV6KkS6ivhHcQlcZJdJcjjtDgUCO4KSV4uPbzICMrakUq4NWHvKMgu2B1cjvwJPA7b6ScjvsoJpUiZlyVauYO8T9XYkBlAifGpxXjQfWS0Pexl/9FEi0VYgTojILP0nllzLg05mWErbkSt4Ip6jWlEpr1ibGZ1PM7BsDucErofEeGvUbkYEI3JiFZQolr4VAzrq25X/tx/UxrTDst6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787835185; c=relaxed/relaxed;
	bh=Jv30IeE2s+n2A5GRghn5mbNA+ntwEskVEvnsJS/gqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJZsJwSkFnF0btcXG6V/ZnTlMgXXIcXHciLUbliZCTpaD2zaKRuhqpRvb+lRO+MUQggceKSpNmQBWBDIRYuvSZNhmJp3uU3dumJE5Zr+U7D23OFfmnXLZihPmwDYyBO403gR8BMM8uEd36pLcQI847krYwq/h6tnvyK8j2FPdUW9g42mdm6czPVOK0x437AAWup+l0u1Gk5SA3pyOjlzbHI5v2NRtFhBmJxdvYyaBnGZKqRjjUvRTwL7/LYO7Sb62S0/xPrFXM3Whc/+QZxq9dAAZuEF9xL0QjjSqEm/O+y7kgHezsiA3IJUQkOZTYHhGDLC1coVIICwLw+JXyiAng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpxQ/he4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpxQ/he4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hW1dr2qVNz2xwN;
	Thu, 27 Aug 2026 22:53:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 92D59600D2;
	Thu, 27 Aug 2026 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B61F000E9;
	Thu, 27 Aug 2026 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787835181;
	bh=Jv30IeE2s+n2A5GRghn5mbNA+ntwEskVEvnsJS/gqNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpxQ/he4c1l/67bjg6zHCWSh7AxGIRhKnrX19FKhID1R0BcbkibPRl+2xW0tbC0ak
	 hJFvx1qCJqhl53iZGTG/JR7u301HQSljASB0swdFEdVZiKibGOnJN2iCVJHXEYbnTf
	 GTCBUKdpsBjmlMtHpvbarSgA6dZyeIoEjTP+/Oeo1lq7Q8tVwMRTyOl2wZZNfvhYA1
	 9RM2gDKmt7oe1am3axpJpa781gtZmH8OBSvfT08Xeg0hRghVLZPfZNQDoRaVSKZks6
	 UT3rnJOuGjx34CvvC3Nvte8iWDqvxO3jI9R1oIEGE2wOgx6fk6r/6aGuzyfLhzB/cZ
	 qVz1y3R5ubGhg==
Date: Thu, 27 Aug 2026 13:52:45 +0100
From: Lee Jones <lee@kernel.org>
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
	Fabio Estevam <festevam@gmail.com>,
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
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
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
Message-ID: <20260827125245.GI770273@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>

On Wed, 26 Aug 2026, Krzysztof Kozlowski wrote:

> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Rob, Can you take it directly?
> ---
>  .../bindings/arm/arm,coresight-cti.yaml       |  2 +-
>  .../bindings/display/bridge/sil,sii9022.yaml  |  2 +-
>  .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml     |  4 ++--
>  .../bindings/iio/light/upisemi,us5182.yaml    |  2 +-
>  .../bindings/input/matrix-keymap.yaml         |  3 +--
>  .../devicetree/bindings/input/ti,tca8418.yaml | 21 +++++++++----------
>  .../bindings/media/nxp,imx8-jpeg.yaml         |  4 ++--
>  .../devicetree/bindings/mfd/ti,tps65910.yaml  |  2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  .../bindings/pci/hisilicon,kirin-pcie.yaml    |  4 ++--
>  .../pinctrl/sunplus,sp7021-pinctrl.yaml       |  2 +-
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  6 +++---
>  .../bindings/thermal/thermal-idle.yaml        |  2 +-
>  12 files changed, 26 insertions(+), 28 deletions(-)

-- 
Lee Jones


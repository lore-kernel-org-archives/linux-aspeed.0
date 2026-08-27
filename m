Return-Path: <linux-aspeed+bounces-4870-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32024C61DC6
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hW3Rq4PGlz2y2L;
	Fri, 28 Aug 2026 00:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787840071;
	cv=none; b=Q+MIQTJWwsaVygEOTl0n9+Y+iMNjtHFBYMhTTGDk9a20CqCyuA4dvzka2+09jdlcQibo3JEK8RM02hkt/GFO7IPtnUzKDVE6tP5sx3BRcX9ZpS2jDyLPtUt997ezAAB7fAOa6qFEth8JpTrhy0ireA2B80a2lFIy5KnPTzHUYe+LzQYND4TpvHBRrC0Gi3apFJTdKUqjU5y4i+UjY2Q3wj8dzHd5ObaXk89sFMHh/eDORAkcORfvU1lFjp1qGS7h2bxgPGyHWirkGYep5jWtUKZ2Iv6vUNpzBcfmWNaW0ZL/fQdWp6TNlFtAf7ZWGSFBwW+MGGucU38fUTSZIfRIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787840071; c=relaxed/relaxed;
	bh=iPd05vfVGTTXMu8o+Kz/ydj1//S090ZmEizU6uZMvXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Syfbv222jm3wtT6lBul7T779HrqkpQyZxGx8BCTFv28hxCe+mTBnUAIvtIrn0xbCXmlZrobOJBgFG1mXWSni2w7N+dW2XTefcENF0JiL+BgzCcXUHcUXp7HVVF0jrC/ZL5MVwE2sTvnUMuWskFOVvBJ89c4rHtuNMWBSkorisAQT3VfKpFtaFs4tJkEpJmDPpR8hG2FmRh+VJgz7X4/cZOAYTLk5fZpqH9KtBRhHeOCjCtlgf9ec4asle50UhCA/JPoRa3v31Df3w6ivKh9MS3vrdvUIqsvyYo2jOlfd6c37iYS3t1UcXbq9uttnmtruBJLCad7hl4k+qdReX4nR8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/mf54W+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/mf54W+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hW3Rp3cqKz2xGr;
	Fri, 28 Aug 2026 00:14:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B869B42A81;
	Thu, 27 Aug 2026 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6D41F00A3F;
	Thu, 27 Aug 2026 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840067;
	bh=iPd05vfVGTTXMu8o+Kz/ydj1//S090ZmEizU6uZMvXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/mf54W+MN//hu47JmgAU9exTPmvl0LBHB5ZzKhGEwexbRuvTYIkxj4GXgA835qnR
	 9UEt8YKMOrQNOLAFi3nx7pgRQfY25zqX+764+u84p08c1ffcviu+w56HZl/bCUCG0L
	 ihHFnT+8mC7h+ynswLMu1pkSIvecp+7uEK09sDoYo898fL5w+AT7uAHCJEisDnTdGu
	 nqenwjGFq5F6mhrGpgDFQqyTszGxV2iYC0cv81MuAExmXpeZ0TN/UNxfU3/4Szp6vv
	 o+MTXUDPIFfzalBFoZ+PepIPsLWVL0VjVaXlf2cPUDNh52Tp26khuu1cNEKxWPj+FD
	 a0defbS1Qxr8A==
Date: Thu, 27 Aug 2026 09:14:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, Mark Brown <broonie@kernel.org>,
	imx@lists.linux.dev, mfd@lists.linux.dev,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-aspeed@lists.ozlabs.org, Wells Lu <wellslutw@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>, linux-pci@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-spi@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-iio@vger.kernel.org, Robert Foss <rfoss@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
	coresight@lists.linaro.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Mike Leach <mike.leach@arm.com>,
	Andy Shevchenko <andy@kernel.org>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-i2c@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Simek <michal.simek@amd.com>, openbmc@lists.ozlabs.org,
	James Clark <james.clark@linaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>, info@mocean-labs.com
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values in
 <>
Message-ID: <178784006582.3145716.1041886875556731621.robh@kernel.org>
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


On Wed, 26 Aug 2026 12:20:45 +0200, Krzysztof Kozlowski wrote:
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
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    |  4 ++--
>  .../pinctrl/sunplus,sp7021-pinctrl.yaml       |  2 +-
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  6 +++---
>  .../bindings/thermal/thermal-idle.yaml        |  2 +-
>  12 files changed, 26 insertions(+), 28 deletions(-)
> 

Applied, thanks!



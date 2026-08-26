Return-Path: <linux-aspeed+bounces-4867-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85608C61DBE
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 23:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVh9w2Bngz2xdb;
	Thu, 27 Aug 2026 09:46:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787755945;
	cv=none; b=Zik6J6xBB96hXAqAMvzwfiehHMJSCGCBGuRM/mXvsjqPcUxFp/+BVcHZR6fWY/BdccKkq+RJ3e6S2v8PUl2uZMwxB9AbGwZ9uiF1MiMQ6MfPIUpcB8CPZM5xRBzw2fco7KZosQNc6sJadvKspcg7IQlp9kfaOBjpPjZKZxEw2mqjJQ5xt/4pPPGghJcUfPH6BuFNC/kbPNLg3jy3PN9npwrqfPnFU3TmmegfBWBjmKxMNpItGbwxnd9m1J0LxyoDxmudSyaeUpB5kNYheRNia3NBIMK9BFn6MI3QcshbAqjq3MUNGtYEn/vMUS2cmJS8VipOOfvBSdTNU60zm8LLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787755945; c=relaxed/relaxed;
	bh=/plmD0PSM0fUMcQXuLscFbLM0Wi54enkrMFT/XaxeUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbgRffj1E/bSXbEWEpPNaqpI9zwDGF+2ZiFAozwNLWT1GK4HD/NNF+ZWAi5Xr9ng+oSytIe/fRuEu6WpDbGAKDOHbTw8eahaHI9UywABhR8uus7m1oDnZy5p3ttp5GPo/RJiICqWr74w/d1fNgzWE8bZ592AmxY7bQgr3tvITY8BBPffgd12EiPP+TjbDwqpC0pWQkHibpHjJbdboX+YYIHpZKP1wzJJ1S2k81IOyfmY1jKnSdM3okYDS0x9r3dNPETAQauwNVJ7qHejbzZnVg1fk+FYtJtKPUvE0vDi/QvMRfXNvDk11tvtYZ/EquHJFclR7R2TzryMZg7eG+uxZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YXQ1DnZP; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=leo.yan@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YXQ1DnZP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=leo.yan@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVSKx4Dh3z2xGw;
	Thu, 27 Aug 2026 00:52:19 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C231756;
	Wed, 26 Aug 2026 07:51:43 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73BBD3F7D8;
	Wed, 26 Aug 2026 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787755906; bh=tOodu0VszRohRtMpFFB6dYKNtMAf7OMx0ItWyxqnr/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXQ1DnZPOLhXEtKbwELsDp94I7KPv6NJqCCc+P/ZvoSWmJ8KCcKahNh7+sQWL3CXe
	 Epva2iw+zUipeNYduk/uateqT+WdNJ2g8p5ZxLII6bzY6QQhqe7ssRQ+Ghq+nqNteW
	 f98Yr+78VjADUvqwt45aWv7UK+TBbIxawOLDtO68=
Date: Wed, 26 Aug 2026 15:51:44 +0100
From: Leo Yan <leo.yan@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20260826145144.GH8904@e132581.arm.com>
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

On Wed, Aug 26, 2026 at 12:20:45PM +0200, Krzysztof Kozlowski wrote:

[...]

> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -308,7 +308,7 @@ examples:
>              arm,trig-in-sigs = <0 1>;
>              arm,trig-in-types = <PE_DBGTRIGGER
>                                   PE_PMUIRQ>;
> -            arm,trig-out-sigs = <0 1 2 >;
> +            arm,trig-out-sigs = <0 1 2>;
>              arm,trig-out-types = <PE_EDBGREQ
>                                    PE_DBGRESTART
>                                    PE_CTIIRQ>;

For this CoreSight change:

Reviewed-by: Leo Yan <leo.yan@arm.com>


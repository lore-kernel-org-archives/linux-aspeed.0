Return-Path: <linux-aspeed+bounces-720-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF15C021A4
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 12:21:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvWPJ3vSvz3blT;
	Fri, 14 Feb 2025 23:21:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739535684;
	cv=none; b=eWzFGDwOEL1Xzk3Ge0GGqP5L4aDFttCo/eJVa4TqxVcpcu61Gov6D9iqHIRn8uDbD9GNwSqpih2BPvKB1tTEjII8Y8yqasquTEd0Mtb5GpWOQ2Je4A9IQ7jJNVJtCV7t/lCK3BRWWR2GwipfXWspXacVmvFYQ98wRiaqNnRDCoGrIvQWbsFf+jCLrYl8BkjBWd4pkGP1Nm0YgOwJ/WxeOXIt2dR4hAgVM8MgE3TAXEJc3l38BIAIvKYdfxOHX2m/hMzg8XEXihmkahQ0YkuqiHbdxtj161IHnQYkQmSE8EqRJyUQjftuk/xjiOaoLSgzGE2o86De4jzVIL69Cu0QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739535684; c=relaxed/relaxed;
	bh=TMCNnE3xOrLT5/r0SHnNMiW6p+8bEPbBTJKrhVZYNuA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=UqJgZi4gwrgJpiwPlK86rWa2gA4WfeMIzHOZdOhv+dj00UKHcZkYWOnk2oQJO02l8/4oMrW//ed6gFFYFUEZN3sixN4OSxWa/YBzXtvuP9JPXOWW3KoZKNQwxFTEiA+zOfbMPf2YE6lJhnSOn0gLZZA0LskMO6+rkmaBlo3niOqu39jEqOL9acEQ7bqZ9InJKRINdZrMggsSv7fWttvR+46s7jqY5ja+yxIVbFMH75aDv+05iye8auC7duNO2vZHTulk1s62umk3ITj2S8pBQUwWgViZlNfueoM26sDgufIQoWhLQWe2QjUc6nimOUNBsVgCF1RcGAp2HotSL4edLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AUjk/HNS; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AUjk/HNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvWPH5Qnsz3blK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 23:21:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A44A8A4292C;
	Fri, 14 Feb 2025 12:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDCC4CEDF;
	Fri, 14 Feb 2025 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739535680;
	bh=QVeyAHjLchA7WqNCbOqpcUiyNoAjfJYd0+puryVp7pk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=AUjk/HNSoYoQ/6J7hjZcAlA15HEnPLWX8YfTGndmLW2hjnNec5mewKqHd3o4W7hn1
	 BRejwhFBtkt0Ou/hhrCr7MBj8foKiGnTV43qoiKEdocEbiKnBmgLreJK/YOTEVKPN3
	 +A143cv0JRt5IesiDDjXgNTavFgIBYxDBRUaN00DB7p+FrFY2uJyHYz5UplrnP2F5q
	 g7zwJDQKL+1a6+P0N8QeTIIB/O1r8Ld7StCoKkmZ3d4Ixq2ekTm3LtkRLs1vDw8dNS
	 GehvDSkL6cE4lZUY9EYrRGBPRnZC6rukHydjIItJvaaudbv3dquLg/8mujJzlMYbNH
	 RxXBM5LjvADdw==
Message-ID: <c045b5b46c8daf79b124e6da9f951fe8@kernel.org>
Date: Fri, 14 Feb 2025 12:21:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 11/12] drm/vc4: move to devm_platform_ioremap_resource()
 usage
In-Reply-To: <20250213-mem-cocci-v3-v1-11-93466d165349@redhat.com>
References: <20250213-mem-cocci-v3-v1-11-93466d165349@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Alexey
 Brodkin" <abrodkin@synopsys.com>, "Alison Wang" <alison.wang@nxp.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Chunyan
 Zhang" <zhang.lyra@gmail.com>, "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Fabio Estevam" <festevam@gmail.com>, "Joel
 Stanley" <joel@jms.id.au>, "John Stultz" <jstultz@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek Vasut" <marex@denx.de>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Mikko
 Perttunen" <mperttunen@nvidia.com>, "Orson Zhai" <orsonzhai@gmail.com>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Philippe
 Cornu" <philippe.cornu@foss.st.com>, "Raphael Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Stefan Agner" <stefan@agner.ch>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Tian
 Tao" <tiantao6@hisilicon.com>, "Xinliang Liu" <xinliang.liu@linaro.org>, "Xinwei
 Kong" <kong.kongxinwei@hisilicon.com>, "Yannick Fertre" <yannick.fertre@foss.st.com>, "Yongqin
 Liu" <yongqin.liu@linaro.org>
Content-Transfer-Encoding: 7bit
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

On Thu, 13 Feb 2025 19:19:24 -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource_byname + devm_ioremap_resource
> with just devm_platform_ioremap_resource()
> 
> Used Coccinelle to do this change. SmPl patch:
> //rule s/(devm_)platform_get_resource_byname +
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


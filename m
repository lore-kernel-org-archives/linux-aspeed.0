Return-Path: <linux-aspeed+bounces-680-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E28C02199
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Feb 2025 14:16:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpfKh1Kw8z30C5;
	Fri,  7 Feb 2025 01:16:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738851384;
	cv=none; b=dcw74pVjiw/+76qnzvfBD8vgvNcv3/jFRf5o7cZqGrq4NdUPwr/KObtH9W+DaMSjfD1IhI2ZWeslszQVlHsB2L+hy3xghRA8ToUeKnytghnuqRHKqQmfz8qgwcaGY+giCLM/kllTmUPmqjNsgAn3ZNTyZqWKfXUfumtFGZ9stSxIhr6IUiGNiz9x2zosoR/Bp2XrABnpyupLxqaZeUiBHg7irgSzngJYw0CCoE7+e9GJw/DW+Sj/+Hn+GlrfCXTwNCY9rkB3FUy3Sei5Ss8clZsg2hndcyqQoJngC5rW4ZiJyTplO1AWxfxDXYrrzwsuBR1uEA9dNiX1bPNdXXpieA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738851384; c=relaxed/relaxed;
	bh=leY0h3tERW3OeUGKi9SVNC6gkRyitXalmxljJ5c8F7Q=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=RBA+4liRIZTMX6zWxQq+TWsgkvdf1kvea0e1MohZMg0OED/uTVypK1kselxY/H4J5XOhZdQnj0o8H8BmKDgXwtdXRsfbbp2z2weMtERNCKGoAwjlKuzC2aKCDhuZgKvaTGNuY0q2wmW2VMfrPhdrZ3VOjvnZTKQTRFHw4ULHD/1+wUla1cCNgEzMLELho5inaTTxru70lnqJf3A5FtWL7UnFzCv7Xzs9NAWq/rmYbfw9APe+Mp0x0IV6za9xOF1ZS3r6TAA0xyAZ2W4FOJs7AnK0a11tAiUIHY/Vk7pJEqaVbcjuc159KIrkpe1HXWnqRSsQlkNm+RWPeKVP5WA5wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oUgdH98X; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oUgdH98X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpfKg46qHz3089
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Feb 2025 01:16:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E40545C4A80;
	Thu,  6 Feb 2025 14:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A9DC4CEDD;
	Thu,  6 Feb 2025 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738851381;
	bh=TVrqcXFgqBq6YFt7saP+I5ihtXmckW23rwRocf2v0ks=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=oUgdH98XCy7hXa1ByUogw4wZqfQiUMbkICr6OB2xFmDDElLbT5m+D0XzwWV8BzN4F
	 aU9wIobTYhSktwzOBbHotD7pjFpro/6rKfp44cW1VTaAe/r3Tu9Dm3YATGZaMn2wgX
	 XVkzNpxRcchr65QYCKk9NSQ7aYVv5llZoLqveCPFe/hwdm/NdwmCWys1PY11NtWe5i
	 FNVVTG6tm05bKn3f29wvDj4nqSWIk0efSNkn3CEI6D9AALmnMa4ilpyTl2kDXAIIs0
	 Y2z6DwgguFYCR90SoCdiXek/5rFwYlX6uaKOVNi1aLNRYHKaG1yyJtQlIFNK0BPpYM
	 nRSntspicf8+g==
Message-ID: <ca7086893b5b7bf0e119144efc00733e@kernel.org>
Date: Thu, 06 Feb 2025 14:16:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 07/12] drm/sti: move to devm_platform_ioremap_resource()
 usage
In-Reply-To: <20250205-mem-cocci-newapi-v1-7-aebf2b0e2300@redhat.com>
References: <20250205-mem-cocci-newapi-v1-7-aebf2b0e2300@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Alexey
 Brodkin" <abrodkin@synopsys.com>, "Alison Wang" <alison.wang@nxp.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, "Andy Yan" <andy.yan@rock-chips.com>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Chunyan Zhang" <zhang.lyra@gmail.com>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Fabio
 Estevam" <festevam@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Joel
 Stanley" <joel@jms.id.au>, "John Stultz" <jstultz@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek Vasut" <marex@denx.de>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Mikko
 Perttunen" <mperttunen@nvidia.com>, "Orson Zhai" <orsonzhai@gmail.com>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Philippe
 Cornu" <philippe.cornu@foss.st.com>, "Raphael Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Sandy
 Huang" <hjc@rock-chips.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn
 Guo" <shawnguo@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Stefan
 Agner" <stefan@agner.ch>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Thierry
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

On Wed, 5 Feb 2025 15:08:03 -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource/_byname + devm_ioremap
> with just devm_platform_ioremap_resource()
> 
> Used Coccinelle to do this change. SmPl patch:
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


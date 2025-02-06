Return-Path: <linux-aspeed+bounces-678-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404AAC02199
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Feb 2025 14:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpfJk505Lz30C5;
	Fri,  7 Feb 2025 01:15:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738851334;
	cv=none; b=dwbYb6lFlM6FxpCOzYat05y4WnogIGbIvQPv6Wsc28FBiUT4stjQSGiniUIabhkNpSlUEP42XmFo9NpmPiUgKmLAAiCoGxfAXAXRXKsmix0lP9byWrMoCrxdNDGVmB4b8qZzIsoOEKd9kuYZrjNRRDPtqygyOKzmRpCdTe+uvCCS7gciaBfnpHTkdO7/1dIsLEkpYywxltQVEdwbyDMsDlrihnuRTvUUEhAlQ4yKZ2sw7bbjSz7GSSdRlQR4gmpcG8uVpYN40DD6WP45UDSKiL7276FCMPrPcfhmJ92IDGKl9aWVT2Uucqapz57RHnLVQr7IqgEEIOY6b/pPL3Btuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738851334; c=relaxed/relaxed;
	bh=6V51BqvMXsstVmBXrA58cJ8IeABrLgI422tA5NG01R4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=d7SCM913EKZ2iX0XuI2eXLW1cLL9E8NU9PECi+91jx0IwrsJw3dxmDXddyQaolLryUAtNpflR02iGfSjl+ZbeAAcZu0CbhpncxV4z3jZrALoUePQsYomVDSrnDG/QVX/p2vTLlrqlDj215236disjWYrIEjHDr4JG4uHEkVQzdvwJKgM73G8qJxP3fflMN4W10ZW2I25FRwD5HcyQcWh4C06FkWJyINnma4jGaoJzWcmFTmVW+2N2athpadyDLOcHKE/5POb0cdUgVGZgrrq1iN4j2k+wJdJZl3g32mTTCQ4Mhv1Fyoieadk6+uE8BHa0BHGEI/Sp7awOIgGhEFafA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QFN15TOt; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QFN15TOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpfJj3hyjz3089
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Feb 2025 01:15:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ABF5DA44301;
	Thu,  6 Feb 2025 14:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7EFC4CEDD;
	Thu,  6 Feb 2025 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738851330;
	bh=NnqBms1V+4E9EfQaAWHmp1xTPNsYHk4NHNYKw/gc4LE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=QFN15TOtrwkcAyA/lsiNaWymj//OCxIz5HucWhWHhCATirYavxVO59r4NPBM1VITc
	 e+0xwpj/6cllUySpG2J01BM9d912Jm9lleZqs3pU1O3HdQFqJuEnxhX7s3ayQaEn+J
	 uPpfKRER4ScCQc1p6C4esmKdk5fGJxU5pFXYI+hvewBb2q1GnMjw+Xc3wld5LiVHqL
	 IYNH2q5SCXspU0KCnOPUdyq4IYIMyYl8fk3Zlt4hpVsFdD3w+JsD/hYrMTc0fCojHr
	 fsXb+MFRghIZqpKoSuwq88hRtoc3i7eJ2eeyZkraYPppScjf4IDEprsKrWZYlzxnvI
	 kZYRg3Qh41w1w==
Message-ID: <a66f048616d94bd68f56fb73abb5fd60@kernel.org>
Date: Thu, 06 Feb 2025 14:15:27 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 04/12] drm/mediatek: move to
 devm_platform_ioremap_resource() usage
In-Reply-To: <20250205-mem-cocci-newapi-v1-4-aebf2b0e2300@redhat.com>
References: <20250205-mem-cocci-newapi-v1-4-aebf2b0e2300@redhat.com>
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

On Wed, 5 Feb 2025 15:08:00 -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource + devm_ioremap_resource
> with just devm_platform_ioremap_resource()
> 
> Used Coccinelle to do this change. SmPl patch:
> @rule_1@
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


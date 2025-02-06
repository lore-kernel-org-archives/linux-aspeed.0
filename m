Return-Path: <linux-aspeed+bounces-679-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB81C02194
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Feb 2025 14:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpfKB3njdz30CM;
	Fri,  7 Feb 2025 01:15:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738851358;
	cv=none; b=NRxPhaxOOlfbgrud7fU3eNX8x9+P4+7NBIB6PBGMmmeKezRqyoK1aT6kxifWnwg5yMVeox4KMnQT9KHGo/beBUMYigygAZXwdpnY58QpbpJGx5bqX5sFLPGfs63GDK9+IPuoPFJgr8SrwIu/pgJg028F7zVRbHZZzoXMsl9Qqci7Hw0Jz16UjroDL9q85hMDnmyFbqGaG8DHcXHAmzYcjgOyMx7oGpkRUkDj/yOJCr+fMRnQE+xN/kPW5fGBPF4FlViEnzyBkrpvwszzpvigCXBFn9i0idOXkOYOlI5vcBpdIOhlijssZgMIfH+hL3OfX4Di1wO+DXpJedTdfKUv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738851358; c=relaxed/relaxed;
	bh=qWu5oFTCU3VNxz0SGTMKRO4d74bklYTHSVu5SFFxqU4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=leTe9mHoztStzq0Wwy8lT8BhO5afrVEL8EOxL3xABWGJJujwHOubEniAJo/8fqvQ3tWv1bhrrivIP4V0ylxbLg95IL1Ul/7bPom65I/Yhxh12husk+P+mIwPc7GsqkI9hkZ7jAvgRMealTsRWxHP38yAKkfA5gfiuVromnpbxN+/JDfFeKdKGr6cpoSQ+lbxR/KMby1zkz9mOKOMQXEjWnixT8bxrbk1D3qWf+SUwch9sXsPobzCG79+TTJnhDyAO9qg6PPuQUTGTTiZlHmeO3TmSRxH6h876z/MHZZIdgkwnKQbjcWiRi2fQxq4dSgZ1TAJt3QxuQrew8mcgkZveA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tw26qhXb; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Tw26qhXb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpfK96lFSz3089
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Feb 2025 01:15:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ACF595C5FB1;
	Thu,  6 Feb 2025 14:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AD1C4CEDF;
	Thu,  6 Feb 2025 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738851352;
	bh=rcqJkuQ2HFzZga9D7cWTaXV3gW0ZCzU6MCc8Sw5hnyI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Tw26qhXbWI9iCvq7HWmZ+4tYuAvjyk3PNd0H5/RHxQbAHk3EHoktkmDnp5hHUKNkE
	 uXYtRJT8jv+nPZbdOaOPt8vcabrmRLHjVcJJblnVV3QoJbk7Flec/hEAfPFUUTH8z6
	 0jv8puc8+Qs2HLtihZHxlJKd2V6YatltV3ABPfOfT2YoYHEEQbelrqkyTQQOUgvnIB
	 iQD8DrJj53nVVEQQ6vKT1V4zR87O2x4mx1btTdfDGck0ndnt7NevNRM/BWj/aCIU0W
	 KGEyIlYD2VBin/BbbCTKxsuCGOL42lbvsBLOl2xELvoALwjfEimg+mCrfsTrYJJgy8
	 F2kZWWWe+Jqhg==
Message-ID: <d735c21055c438e756356ef288d8ab0f@kernel.org>
Date: Thu, 06 Feb 2025 14:15:49 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 06/12] drm/sprd: move to
 devm_platform_ioremap_resource() usage
In-Reply-To: <20250205-mem-cocci-newapi-v1-6-aebf2b0e2300@redhat.com>
References: <20250205-mem-cocci-newapi-v1-6-aebf2b0e2300@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Alexey
 Brodkin" <abrodkin@synopsys.com>, "Alison Wang" <alison.wang@nxp.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, "Andy Yan" <andy.yan@rock-chips.com>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Chunyan Zhang" <zhang.lyra@gmail.com>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Fabio Estevam" <festevam@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Joel Stanley" <joel@jms.id.au>, "John
 Stultz" <jstultz@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek
 Vasut" <marex@denx.de>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Mikko Perttunen" <mperttunen@nvidia.com>, "Orson
 Zhai" <orsonzhai@gmail.com>, "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Philippe Cornu" <philippe.cornu@foss.st.com>, "Raphael
 Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Sandy Huang" <hjc@rock-chips.com>, "Sascha
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

On Wed, 5 Feb 2025 15:08:02 -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource + devm_ioremap
> with just devm_platform_ioremap_resource()
> 
> Used Coccinelle to do this change. SmPl patch:
> @rule_2@
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


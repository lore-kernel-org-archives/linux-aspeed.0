Return-Path: <linux-aspeed+bounces-856-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B678C19F32
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Feb 2025 14:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2y5J68bsz3bmk;
	Thu, 27 Feb 2025 01:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740581300;
	cv=none; b=DH0vrkh2VTrerne7SLEM4FfNy9mP8EmJhZ2jxWupHxF6Hzo1nAsOUOxh+TqleKYvZW2DRfd4Ub5/q6fkkHP84mPDWp2vU50kXAcB3i/JjYS0/r6DaWydgxfhft05OgtdU6uxFN4EDADwwraOvQIJRYpGEGW8jbYVC2dROjAYp4IjFCEyFdifg7XfJ/JQxT56THhKAGr9pDHVS6ioIqUXO8p2YA1LJnNw+wnKqM9derDYxgoIYnLlselHzVG/rZd2xIZ+lw2J2FeElhUIraAgh3v8N/UA8VizQaBw+oLVKfmv7tCuVLtikg0NYROtk4EO7ZH89ZmhinT3TrUiszhNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740581300; c=relaxed/relaxed;
	bh=xRobENutosDGoPz+EeDkXH3Z6BoBNhVogrW7xMDjlcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh/ecIJgCwiEgNAN2uj1mrqftZkNxafBrRTFFGchU/K9NDBjhDrRLwPSGfVMxfBcULNXkK3YllGUX5aeighUdlGHSZRMerN6astOJy6AdTXZwFh/sS0ft0Er2bfRBNkWeMr2PDZFof5mC/ZBYlkVexSTcLk9YtF1EZe2QbEbW25qY+Dao+gobFVsTOqHZGFjGXzML5CfUtjtqFAfYb4gq2yp64IZk5Z6sWH/f8YjkQG6eh+8TeU4opDFgX4GZEOyzgJAotJVkI8X7FgnlVh2LHAkGk7yl4Rk1UtsNO1TAsTKaE1rsc6Ar359BboU+/hL0lHscMHRveEq5VvwhQDYCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WjJ45fyo; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WjJ45fyo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2y5J0hMHz3bmc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Feb 2025 01:48:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 760B65C6E5E;
	Wed, 26 Feb 2025 14:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C33C4CED6;
	Wed, 26 Feb 2025 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581298;
	bh=0v5WZmBpe5SBVBgT22KQI2o6QVoJJEH+p115jwbhoW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjJ45fyoUiA2qNtwcYoEem6dXH08tt8XAMrk1CpuF+An2j/4S+2f46koO2GAkdV8R
	 JYft5MzZF0a6bLJ9QPzt4XXGMGPuM87TWOWMvKJjH41WR/+TrY9a/6xP8/DQpPV810
	 Fy81WKJpsAnEK3DXA84OhXYjjoPHGJpLq8qzpz52TJxByGYioi0gUkYjvT9ufO2yEQ
	 oqIco61GTPPmWm/Rm1E5nFxFsRVN/JeMrh54MdhqWgQWs0PGdAEJmiPn1jtzsyyXac
	 NzioW81PJzDCSdzm7ofCoYdIx8bRJ8pOEajsVM22JhPzA1gUnJSeQWju4dZrKRDl93
	 Q+085zq69n3Ng==
From: Maxime Ripard <mripard@kernel.org>
To: Joel Stanley <joel@jms.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Marek Vasut <marex@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Anusha Srivatsa <asrivats@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND 10/12] drm/tiny: move to devm_platform_ioremap_resource() usage
Date: Wed, 26 Feb 2025 15:47:56 +0100
Message-ID: <174058126146.2737122.12919541255489679921.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225-memory-drm-misc-next-v1-10-9d0e8761107a@redhat.com>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com> <20250225-memory-drm-misc-next-v1-10-9d0e8761107a@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Feb 2025 17:20:51 -0500, Anusha Srivatsa wrote:
> Replace platform_get_resource + devm_ioremap_resource
> with just devm_platform_ioremap_resource()
> 
> Used Coccinelle to do this change. SmPl patch:
> @rule_1@
> identifier res;
> expression ioremap_res;
> identifier pdev;
> @@
> -struct resource *res;
> ...
> -res = platform_get_resource(pdev,...);
> -ioremap_res = devm_ioremap_resource(...);
> +ioremap_res = devm_platform_ioremap_resource(pdev,0);
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


Return-Path: <linux-aspeed+bounces-853-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C5C18E7C
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Feb 2025 14:48:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2y5B0yx9z3bmJ;
	Thu, 27 Feb 2025 01:48:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740581294;
	cv=none; b=PNwoTz4zvC5XB9lyxCtekr6iQ4AE3n570HONB3Gl0+maZI1Nm8fMM8XOApGW/eI4I+79XQH9240OlUBSpHGi+gejVb8J2EGrSGYyGJQ2YceCvXEeCms2iH3VsO3oRuQGBJRbrJ+IYuEZYMxPY/RxZnL+dHd082wp8Kmw7Fd2ZwSpaPQ2dc0l7Yq89rnUyj/w3XEy1A0neMo8kq5TEZoFGGWp5xRq2KydxTmp991KJDiVDX8JAQRB0K+uJbsOqaW8h6EI6n6ikyfiPeWcj60wM0GYuG2KSMtxmQto65xwGZOPLDmLBMNB4XUjtaWNObKOML21nHjPlO1ADTfV+N6SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740581294; c=relaxed/relaxed;
	bh=z3b7IO6UUGRXACgooMkPXl8HV31QOqDPJ9tLsrdWigk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJwgQHDNGs50CoXDQDRYFGiKc9LPXQP+HK73xXeNApUoypOI5kEIwypzjU4+BPoxypXC4EPQ4T5zu/fphhcPKdjKShRkOdGe8LScB+XRvlkILrNmaDVEnrry9GVWx+DO9oLRLXmkg1ehV28ysraQLVVN2BR03rV25XFOoprsjJPVxH0RgkSwyF566QYSDjvNQLSMcKAJWra0vNtfrMxtTUeu5ZrTTpRfH/s4LSkJAYoz+U+wlsSG8SNnngYKu7r1kKBqioc1W6GDTgUgqZ+KrN1/amilWQ/ISQ0s7dNuBog4rQAgluVEg53DXP0L0EFrLIxDwfrZAKV7x+u2f/FZGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nHrrOgkR; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nHrrOgkR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2y5921xMz3bm7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Feb 2025 01:48:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7AF5E5C67EA;
	Wed, 26 Feb 2025 14:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611C8C4CED6;
	Wed, 26 Feb 2025 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581289;
	bh=xd3neVQnKKxta6h/dkB0x1HKr/mwp+2cJLoVDQVsKqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHrrOgkRXHnaJloFeHcTWFMBS6+Fcuy0rjgphJAHpsvi2mcRgDXskJXRe9cOWAM/E
	 qWcdyAlnrIYnU/YXtzy91y/uCmVTRbC6NG2k3edfTHzrU0+t85qoTgvzMqQdmexUYg
	 mr9+yn7QMTIuQ88tg2bhQ62xsrJfU6xRQvlCCwiO3nCH6Sp5x5WkpK+wcLPpsNxp3R
	 gS82Bdf0KbW3RpECZNRxtrhyFtVe7JQB012Bpz4dzC0cXAH40wvOdCLVF5zAkIZ+Yo
	 VFILJ39/Ko+fJCQJPSn30MYVJgydxJQdZaL3EdvHCHu7HYo2T4UGp0ZOASwU4xCu75
	 P2Wgfmk+Jlr2g==
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
Subject: Re: (subset) [PATCH RESEND 01/12] drm/aspeed: move to devm_platform_ioremap_resource() usage
Date: Wed, 26 Feb 2025 15:47:53 +0100
Message-ID: <174058126145.2737122.17862276006786077975.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225-memory-drm-misc-next-v1-1-9d0e8761107a@redhat.com>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com> <20250225-memory-drm-misc-next-v1-1-9d0e8761107a@redhat.com>
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

On Tue, 25 Feb 2025 17:20:42 -0500, Anusha Srivatsa wrote:
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


Return-Path: <linux-aspeed+bounces-852-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2751FC021B8
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Feb 2025 12:48:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2vR161fJz3bmH;
	Wed, 26 Feb 2025 23:48:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740574109;
	cv=none; b=SDrVh0mJDiGh94E/rMgZ2AkEk6lpBHRnVqXxVIng7L9kUIdPtMrNHsZPK4JwZxBKRD0q9OrI6aZeP++FOyFsVSQeFCwfGeVPhLt8hnx2ai7V3m8ZmmWeaWymtAfcJbdfTFhoZ7/sEReBXw47Eba1yhXehxwMTKm9SBpuu9zARp3bn/MZp+PjIH/HMAo0genPoTJSd0VMdAvD+sVGQGyZE7tkb9jMSKgLH2dBWlxbJf8gxfuJRf+jfDaBoYl0YJmxRHNaG+gdhrwXjFY10S0DOelzmLi89JC25LwDsQElFQM271VSPAvTNSLT5MbMOZUOsUW7hzNdXp9yW9025aMPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740574109; c=relaxed/relaxed;
	bh=ch3NGv37NcB7K7eYD5lO4gl3z19aKzb9mYBAeq/Ppzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9VG3xTYnocuLVIU2l77JZZkTdU/p5e8iE9394tbsryxc9vadO5Bjp8QYHECvf0ZC/DLhwEdodyHjqYMTOzhGUXJtMhJcrco9bEsi6/5FoB6BWosaPv00e0oKCm/tgeyVlQI8RzMONbGxhLTk9bYVMh8IpPb+pf0SHA7F80D11Has8Ibe3rq2g9kOu7UJj2i6Y3aZgmODjxlHnKGkzHcU+5/UrM3FztyhQwi+sdsWHQiYRoCtxwbklfy3oYoMD1AxLIa8n6VO8WIsdT5plTU11nzTmUlQDqv6LbT1pGNn0584bHlrizBimeATUOoMlZlvvT3yqhelr7Fy1V4lNFS0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com; dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TVokcpGW; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:201:9162::2; helo=bali.collaboradmins.com; envelope-from=angelogioacchino.delregno@collabora.com; receiver=lists.ozlabs.org) smtp.mailfrom=collabora.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TVokcpGW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=collabora.com (client-ip=2a01:4f8:201:9162::2; helo=bali.collaboradmins.com; envelope-from=angelogioacchino.delregno@collabora.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 552 seconds by postgrey-1.37 at boromir; Wed, 26 Feb 2025 23:48:28 AEDT
Received: from bali.collaboradmins.com (bali.collaboradmins.com [IPv6:2a01:4f8:201:9162::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2vR01xWHz3bm3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 23:48:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740573548;
	bh=Be98U+3nuuSPxPyag9P+ADgagKKSNdsCQD96gtP6QyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TVokcpGW6T6rlNiHJ1PBSVs/Pu4XLYWfDKUY+5a+lNzwgyVZKfI/QCuF08TxawQfT
	 aNZnWSolzvrl8qXzo8n8PL0+VSi+EnT6bxaksECCHNGLx0cWH9+KR4CuiSYs5u3Y+M
	 etDWL3yql/ZsVhAWgBLlNQkrHvjZ5J1oOJurmjb3OjJD3fQSJOcZWfZVQpKndBHpWc
	 6EX/eg7UgJaPWjMuXc80TkOXXBqVEVXK3BHf9Cq/m+x5o+534iaQSaO47Ixp4nBdlU
	 kpp3ucNWUGGxM2lTo8EeQqXoLeUxmNbKL2YHzNBLCdjpKsYINxdNjxH5URJGHQ7P1E
	 D3LFh4MbhRc5Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44AF317E061D;
	Wed, 26 Feb 2025 13:39:06 +0100 (CET)
Message-ID: <17850817-123d-41d9-9b1c-41ded05e2be1@collabora.com>
Date: Wed, 26 Feb 2025 13:39:05 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 04/12] drm/mediatek: move to
 devm_platform_ioremap_resource() usage
To: Anusha Srivatsa <asrivats@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Stefan Agner
 <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu
 <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, Marek Vasut <marex@denx.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Alain Volmat
 <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>,
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
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org, CK Hu <ck.hu@mediatek.com>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
 <20250225-memory-drm-misc-next-v1-4-9d0e8761107a@redhat.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-memory-drm-misc-next-v1-4-9d0e8761107a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 23:20, Anusha Srivatsa ha scritto:
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
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




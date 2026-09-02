Return-Path: <linux-aspeed+bounces-4922-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA87C61DD6
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 21:02:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZwCW6w4Nz2ypW;
	Thu, 03 Sep 2026 07:02:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788382935;
	cv=none; b=aMVlDMuik5DyUCxGJcQi+2MKUooDzhrkaFFjdsKutX0oTyeTPXjyhxxqaTKGVrwKLVB/te2PP4Bve/bE0uoeTRH7gEWm31Ep1q2GHzFRKLqAt9EFUG0W7Xnq2CdycZVlg7lyO4ZPF1FmJwCqwYbVeJCCbEvcTOhAv1hFzcR/nHP+c88lLZx4Y4LjJ4631Hru5WXR4QZoGqTLSNoDi5J9RrVr1BeBoQ1j6Zs/XL2av3u0zH3x+f7SoWRCJGw1nWS+UUNm1mZg2ppd4lZndL+rGrkJ9QRjq62LsQKmbYwiQFtpTQqE/UonV234tzaUReQsDlrthfwo4gkfDDfHD5tKow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788382935; c=relaxed/relaxed;
	bh=pGq/NlxAtjsAJ0iHJZCbm34KD3FPa5RENh2bCBiou+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZGBioFvF64R1gvzcxRTSeziJDM4D5vSU0GszL8A13pmWg5nL98DzFCTUp0sLKV/1CN3z4SrJpTpaUP+2wvhUTf2NyTQxmQbFGNhKNpAL0abq+jOWEUY2zR9uu6vIEJqUBU2Ge8gII8INXKaYIa+R9PtCpTr7TtcCi4wQDaQ+qmHW9QYS4goWr2H3GiUexstMLFFUoKtWbYkbJIbr75QTicxsemjDw+KQgx3QFFAEDV1d/1VyTjgQCwMNPpSlNYDy+bAWUrR9cY41BfWM3veK8CZdcj1j8mbbWUOaOHBkwbrxpDkZR2JQxfpwoK0D5+6Cu4mIHxJ42hK9kMC6Z5TBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KNKy6ESq; dkim-atps=neutral; spf=pass (client-ip=213.167.242.64; helo=perceval.ideasonboard.com; envelope-from=laurent.pinchart@ideasonboard.com; receiver=lists.ozlabs.org) smtp.mailfrom=ideasonboard.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KNKy6ESq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ideasonboard.com (client-ip=213.167.242.64; helo=perceval.ideasonboard.com; envelope-from=laurent.pinchart@ideasonboard.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 361 seconds by postgrey-1.37 at boromir; Thu, 03 Sep 2026 07:02:09 AEST
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZwCP4llkz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 07:02:09 +1000 (AEST)
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 643231F8;
	Wed,  2 Sep 2026 22:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1788382461;
	bh=yOp/QwLcsFzKak6geScZDKKxKOKgTlwu0GRjCfP776Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNKy6ESqs9jc1DSUAxm2rIVPt6QfPXSje/ia548HWfrwix7W2Rg+9ymN3AXRk6YX0
	 +zkHv6srVg7BOqu3aakf7Dn42VXqKZ36oFDQwcEIsQfR9/sk4xoWhifJKpXyB0LFSM
	 Q0CH3JHEv1EanB5jfY7QzjWSrl+EYIK4tpKcO8Vw=
Date: Wed, 2 Sep 2026 23:55:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Cercueil <paul@crapouillou.net>,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH v2 9/11] drm: xlnx: zynqmp_dpsub: Use
 devm_of_reserved_mem_device_init()
Message-ID: <20260902205551.GC287496@killaraus.ideasonboard.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 01:46:38AM +0530, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index 53ab1a2a5aaf..e93a7a299b52 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>  
>  	/* Try the reserved memory. Proceed if there's none. */
> -	of_reserved_mem_device_init(&pdev->dev);
> +	devm_of_reserved_mem_device_init(&pdev->dev);
>  
>  	ret = zynqmp_dpsub_init_clocks(dpsub);
>  	if (ret < 0)
> @@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dpsub->apb_clk);
>  err_mem:
> -	of_reserved_mem_device_release(&pdev->dev);
>  	if (!dpsub->drm)
>  		zynqmp_dpsub_release(dpsub);
>  	return ret;
> @@ -276,7 +275,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dpsub->apb_clk);
> -	of_reserved_mem_device_release(&pdev->dev);
>  
>  	if (!dpsub->drm)
>  		zynqmp_dpsub_release(dpsub);

-- 
Regards,

Laurent Pinchart


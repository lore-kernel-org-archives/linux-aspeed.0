Return-Path: <linux-aspeed+bounces-737-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173F5C02198
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvcw1bTKz30Gq;
	Sat, 15 Feb 2025 14:32:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739497244;
	cv=none; b=S1ePYAoF0QXJgSL/I5Ih2nKDHST7QNcFMokxjZAvLmkVdbS5XVsQ/3e0BuBQkUuKGPdHCuMPjoNZs6UAKoYDn/KeTAGgOP51zgRgt82ngsOk5k5SYXnZKRO1LxYyblJRb9mn+POODVw0F0dBZcqIrtScNOuz81NAS22Nl4OWmX4jWODBYZ3w/XsV6urcn9o7Gb1Q0czrKWfBI8vZRW8BbxhwTYx6yDqYMa5SXaW0jmBvHkLLSBQcHpIIJs+L5+pXrHkeiHXqw1H5GylmtFJKZEFmJxYLENqkCxFrITF3n8eCqh43WnBvYDXO3JaAW38G61hJugzPtfqCDlf7mCuFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739497244; c=relaxed/relaxed;
	bh=p4aqqg9T7Texkg+zEN9mq7DtWDF92KdPzGxhWCeQ+QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARJNUX9FiSxI+n2N5TwAeg6AfNFfKpWeh+7XeYfndxYPzqzGeJIEUkpbhNF6es8Z6cIjDAbCiUR4veoXVME2Bm6oL6RZA4oc/1/MpYUN2DIZLyCb9GkMcL72npWKVYv1Go5bY+QCS84I0VEuC9OSlNLtzeu9A+qUQlcgEjG3vSeuaiSUwfIACczs7zTzBC23dHJJfewf0kswzpm2LwHnAvuiqpF39fpLox2O0MQGYpPbqx5SsuYo82x4STMf1DGh+02ONTMDi49F/Az7PyIGbhIMKpqnHtcrbmaF7/ic49j2UhQRcHaPoHmq7+fojUZKI4lwrX/VQUrUiK+cDbY7yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZT1XY0sK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=zhang.lyra@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZT1XY0sK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=zhang.lyra@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvFB24BD4z2yVX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 12:40:41 +1100 (AEDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5fc88d857d2so534556eaf.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 17:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739497238; x=1740102038; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4aqqg9T7Texkg+zEN9mq7DtWDF92KdPzGxhWCeQ+QA=;
        b=ZT1XY0sKYu9RUZOU9v0Fqs4ivxgsjLxCglokEY/BGk5xePyHjm6bVGkw53dTAH7Met
         9GAfd2iFTB8DCPVbSpeVccG4O2rjid5s4FJqf0XJVDgFTRRBCr8bVQQl9X6kdecsCAw0
         eHE/5ZYzWOhqsz1CI3HQi56nahjzSOVVfi5zDrKyOWqV7pdbUOWNJ/uO8vGvVkslm84W
         fxSLWL0ztzmsnxJMY6+WcYx5wBYNueSfzZSAJQ4KdQaPJI1YmzeD9Kf5SqFNubRnkdOH
         WB3RVBjvhfvbL7+GbXBX8Mswa4IUj2fgu0sINk4TGDk6kXkkplho+NGdEUh2OIpKPvR+
         pkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739497238; x=1740102038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4aqqg9T7Texkg+zEN9mq7DtWDF92KdPzGxhWCeQ+QA=;
        b=g2z+zNPaUH4HGiI0oWha8N2k9vOgtB8/Ywa3HXh6CWz33OjwWUebPY82jZVD4ruYQs
         4QyUeUzneNxxuzWy/5lDTtk0755hnZCdvQ0wNQ8eWVNLWjVrnh5+kCKtSWMyIjaeFwjr
         FNrzV4VT2gAf8T4USbiSwjscGAU7al/9hX2cVTjdFWR7cH3YixqM/J/2vZXFBiqG6Uyz
         0YmVsLEtz9gVnwEylPTASfqbKlBgs0OTdlLTefa1OPj0ZBc8gAarc79G36CeXb3khqg4
         RKvUsVEvBrTMWfTGEp0Pv/fhrxXZ0LS0As8cTipWqIgC0yYceT0z790EmYyTZA94ptSm
         CZjA==
X-Forwarded-Encrypted: i=1; AJvYcCVvzfU4mxnXcyY03DGC+sxp8U/SCdtTqayrGdnwxTsoyoow0DglVEsQaNtodjsodFNYKl4J+i5VLPkpgEg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yznf/3gtmDP2+cXTH3tu5tGxq1KMqkCBXEg3PUXMeVdiybDb7GC
	o+i6Cqg5hW35gF3MUllp0rvt95dYA5cF/565w02osJ2MhyQVkFxUfL3kWZPA5ZL9sMPoIirqPa4
	zoTXJkvnrazrQx2j0GeXRsPT/fkY=
X-Gm-Gg: ASbGnctVKg5P2WflrU5nzRMwkfYlCBSTcnJILr+B0fTZl3/IN/GcgdGp1JHq+ojS8aC
	DmHI6Xd7AV0Y9mcUQKG+Ho/IHR5lTmDDauLi0uebBW7qH4h4c7lwemrUb1uMFNPh7jcwrNtXveR
	dNABxWDjpDOZTQ1qJ4xhnDo5JrCAEN
X-Google-Smtp-Source: AGHT+IHaPhkpQ5sudo7SaVi7TcjcMdEkzloixKb0RO5UQ+Y460AaIBKtk0bx5VU/HVpLudsUAUuG+ituDRPvvbj3Blg=
X-Received: by 2002:a05:6870:3313:b0:29e:4578:5f74 with SMTP id
 586e51a60fabf-2b8f8aaf65amr3390978fac.4.1739497238239; Thu, 13 Feb 2025
 17:40:38 -0800 (PST)
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
References: <20250213-mem-cocci-v3-v1-0-93466d165349@redhat.com> <20250213-mem-cocci-v3-v1-6-93466d165349@redhat.com>
In-Reply-To: <20250213-mem-cocci-v3-v1-6-93466d165349@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 14 Feb 2025 09:40:01 +0800
X-Gm-Features: AWEUYZmNNW2GxKBvhWTtapwmiPwzOWM-ubPmXZmO79ZpLPJrrgzjYmiy7fGvf4g
Message-ID: <CAAfSe-tNuzNCi=oR4Yv=TLRPt5jUmcozv+mtfu=PBT+6LqsHDw@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/sprd: move to devm_platform_ioremap_resource() usage
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Joel Stanley <joel@jms.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Marek Vasut <marex@denx.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	linux-doc@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 08:20, Anusha Srivatsa <asrivats@redhat.com> wrote:
>
> Replace platform_get_resource + devm_ioremap
> with just devm_platform_ioremap_resource()
>
> Used Coccinelle to do this change. SmPl patch:
> @rule_2@
> identifier res;
> expression ioremap;
> identifier pdev;
> @@
> -struct resource *res;
> ...
> -res = platform_get_resource(pdev,...);
> <...
> -if (!res) {
> -...
> -}
> ...>
> -ioremap = devm_ioremap(...);
> +ioremap = devm_platform_ioremap_resource(pdev,0);
>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 9 +--------
>  drivers/gpu/drm/sprd/sprd_dsi.c | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index cb2816985305fd19eac27413c214681a5a1e9ffa..65cd5aa1634eee5a6735ccffa4ee3979844d92ce 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -784,16 +784,9 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct dpu_context *ctx = &dpu->ctx;
> -       struct resource *res;
>         int ret;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(dev, "failed to get I/O resource\n");
> -               return -EINVAL;
> -       }
> -
> -       ctx->base = devm_ioremap(dev, res->start, resource_size(res));
> +       ctx->base = devm_platform_ioremap_resource(pdev, 0);
>         if (!ctx->base) {
>                 dev_err(dev, "failed to map dpu registers\n");
>                 return -EFAULT;
> diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
> index 8fc26479bb6bce0aa94914f49d0986a7e19326c1..1668bb4166ab0ad3812c5654244544a9caf249a6 100644
> --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> @@ -901,15 +901,8 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi,
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct dsi_context *ctx = &dsi->ctx;
> -       struct resource *res;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(dev, "failed to get I/O resource\n");
> -               return -EINVAL;
> -       }
> -
> -       ctx->base = devm_ioremap(dev, res->start, resource_size(res));
> +       ctx->base = devm_platform_ioremap_resource(pdev, 0);
>         if (!ctx->base) {
>                 drm_err(dsi->drm, "failed to map dsi host registers\n");
>                 return -ENXIO;
>
> --
> 2.47.0
>


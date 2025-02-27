Return-Path: <linux-aspeed+bounces-862-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA72C021BE
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Feb 2025 11:06:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3T6g60zDz2yD8;
	Thu, 27 Feb 2025 22:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740621168;
	cv=none; b=oclCnIWw6PtdI0R5A3TBgfKinU9HpWXRQ0wHdEgqgvrayST3LC3fkq38dsaeEqL8wdDtePZuGB5Mq4sJNV4J+wYHcjeQHt2OK4mnprCMO1qvgqLXhbpsxtHEmbOsflGOyIV8LoQgwg42ZhVlCQhYpt6BEFPUqC4FCFex8XEIG+Ootub1GeZcEpKsRrSVRPhoQGotrI8dGYEGMWSdIUuHXI0GASxi1Tf2SbXW6bGoQwSMzMI75IU72NJsJEaiF7Z7ctVtaL7EOJZH1W3mvOVHAI9L0mGpfXZLEg8V0Dmv4wR8lIn5UxYuKtvSq/JKq4V/4cFDrwftVHUdeLYCcXn0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740621168; c=relaxed/relaxed;
	bh=ixz4rke/Pu4MIs/yXHWsa0RBvJ804N4RrG8GmiSG7vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4HQ80oMmMRxfiQxy17rAYhv8VjyHEy/5LbO2GFZR7G+01lsYfDbcDgqVBE+vycUveD0fW61JX/Ndzm5WozUrFUSKDFEW1XHmQ9W8zb6PK88Y6iTQRpmzHWW68+dfEikhg2e6RYE0jWLwELjQ0cdfVpO5TVUfv8XhbNomGTanmmDwB9oYsSo2DcgyZ83TkhPl5AEG22uJUWlBWu3UPJIC//YpQABnX4iFPP6OL5sc3c8Fx2x6+iMVn9X1AyUmVVsYNzAt7u481CApYQqb6Jj2pqp9t1HxH9smRvOVx5Oi7qqx16RSTaZl+AwwSsa4ycnXXuBgoibryldLALKJLPsuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y7HApC9+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=zhang.lyra@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y7HApC9+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=zhang.lyra@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3Dqy52V2z2yF4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Feb 2025 12:52:45 +1100 (AEDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3f422d6e3b0so163510b6e.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740621162; x=1741225962; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ixz4rke/Pu4MIs/yXHWsa0RBvJ804N4RrG8GmiSG7vE=;
        b=Y7HApC9+ryc5ZmSOjS7dwSxG8MQUNJ6puhLhQfiOg2RmzC5axdHb17UGNOTWPq4b7i
         aIBDgGv2I1c/9MHj25RH99Emo5oxJ8T/A1OpmQEhDYqq28KLsM8ujrNYcqaaN44ODLXU
         dV9V+Cee/Aj2lugs7CU0oGW6FWJILDrPKSGbiCfikPlyvLLRFoenRmqjGdBQfCG/NZZ3
         ZzweLOipoANw5YQa9c9lM+1KlSB7AO14xAmiQ9qZQmr7A/CQzm7hj0R0qpkv3eAZaTeB
         cF0jXw+c3u0Y9B4nJYO7yfAlk0z9ftogmJZ54vhA5rE+WJYLNR6f2bPY8O1cXytSyXE6
         YGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740621162; x=1741225962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixz4rke/Pu4MIs/yXHWsa0RBvJ804N4RrG8GmiSG7vE=;
        b=KaYCt+22zCcF8gtWvAxerCGzdqzZUyRgPrWawstJFhLRmtjhRywemxNuA+XAofFNlJ
         UcD/OwxNt8mm/DbJQnbR3129j5/dsEbNeHdv/cTGuvH7bhwfnezo9TYVv2jnwZUNznBe
         wnxLVnmVjL2Z7Kp0dvobLiBXLyzqlsYQ6rRAWzbMHirXlg0LAQULTAcLVyULJz80b+8r
         YPuf9r62/Uuo/66nXkPsCm5Vh5CVFnlgAw8hC/iU/4iqaYPiOK1lEqATCwB8yAloygnx
         hlCsV2gxabye8KuRl4JCNVRBHecrvudLpmMqfNy3t5BkHipZuZd6w5+hoC1U/cWeGg6S
         lkFA==
X-Forwarded-Encrypted: i=1; AJvYcCX3YjdAcgJnzT4oJiGAsox/dtVvW+XORYErQCwbgZi1RL+/Ul4ZCLw/X86/puUxsmqGV9s+AvHb5D+0Mlg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBKV9FAudvyRflHjh45NP4UePysluPeGBu+oNNC65/IxGiHLyM
	Qv31bVv4o/vQqnYsUkBMRiFSO+Q/6bHpOSzPbMfI/oHH3yM9iR0VE23QQ9Kxv/89t2hOBtDwdTJ
	RJ2ra7H9LgeijxGiUBYm3M27iQFg=
X-Gm-Gg: ASbGncuF5prf0MpElInAn/GGumxpKVdnIdWbDDXduBfJKgKbLYKNmt6Uq6hA+TCQ3UH
	njQ/SonR+pMida6BfzU/NY9vf18ey51qKLykM/k8V4klUtcRwWOkOy5TxsWW9/8muAa2tBVUE2G
	5KwLvoUnCVEU4WQc99yx7Q0OcYA5DVUtyrzDrT+mc=
X-Google-Smtp-Source: AGHT+IGqnXgTmRNVtKjZ/iy4Us2fHmhfpIjxOOKmUbGHr3+Ih8p+w6kJGd3DiiswHNSoSt374klMkalELnpHhT8BfD0=
X-Received: by 2002:a05:6808:1513:b0:3f3:f90b:f1b3 with SMTP id
 5614622812f47-3f425a658admr16487647b6e.5.1740621162105; Wed, 26 Feb 2025
 17:52:42 -0800 (PST)
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
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com> <20250225-memory-drm-misc-next-v1-6-9d0e8761107a@redhat.com>
In-Reply-To: <20250225-memory-drm-misc-next-v1-6-9d0e8761107a@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 27 Feb 2025 09:52:06 +0800
X-Gm-Features: AQ5f1Jo4V-x_aMe6cNu_t6bm5DyuMpmkfFoBZmOQ95iqLbLXuNwjk8JtAQUipWI
Message-ID: <CAAfSe-vGC2bA10yNRjSkLo3Y=2K8HJvssuM8qLeB=57vQk1eZg@mail.gmail.com>
Subject: Re: [PATCH RESEND 06/12] drm/sprd: move to devm_platform_ioremap_resource()
 usage
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

On Wed, 26 Feb 2025 at 06:22, Anusha Srivatsa <asrivats@redhat.com> wrote:
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

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 9 +--------
>  drivers/gpu/drm/sprd/sprd_dsi.c | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
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
> 2.48.1
>


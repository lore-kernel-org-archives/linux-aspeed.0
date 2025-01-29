Return-Path: <linux-aspeed+bounces-584-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689BC02194
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 22:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjyFH5599z30TL;
	Thu, 30 Jan 2025 09:56:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738177937;
	cv=none; b=Z7nU1uD1CYaDB2Mf3jHmxgdNV0Jsedhz0mw26nLqpK8HurgRlbJ4Pn9mBj+HLKM0rDAwqQBMXnYJh7BZfSrZw3jVruQvGEBBu1JjwiaOdTqzPTWvO6i65g2Ft4Fd5PzDWNd0MZGeWhY6sZiPmkoU0VRKFbquT27byz4/vFMyYOCa6gHTdF2n91JGLsm6MvPnTv0x1Kp3rNe9R3p2TROcmPGMd2CQxsn/Y2Qu1yV42AJiR25/wWy62Fr1V5eFmGxtkY4A8S7fZP+hYBoqLqeem/elcM2dW/13L04RadVm6M5aVXEm2tLhUPq9lZ0H/ShNMOiwmNgXVvenbxI+m6mXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738177937; c=relaxed/relaxed;
	bh=PQjrEwpUP6UAeiwxxjvqUmkvSvE9B0Xh2DKKvF3TdaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJgY2++4F0ohQjHU6vkf394by1HRJzSoOe3bcrNSgkHCStPchUMeT+pmChFSkFWojpdj69/ozhLKVfIsojJs13+ELjwV7wOcQFR5nTvL5EJVzA12hIP6OyTENBrgRmEJdAF5+pxhHYHg6ioDnuNV/1QDpn4NP3SWnl08eT70tU+i2hH8TAwghjYKZocgSoa5N3oo1bYVXlqPredUrtTDaUmojuJvf+Fa89LCETMzu1Tz3qh8rvMPufP8Hf9xW3iFzHeW9eimpHT4tPKy/pbVIJvqlzIVGwkkKg1/MZLr6DPrmzY2OZtr8EuJEVsuImP84tlMXLQguHCX/SAwrzzz8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RlFtGEJU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xl7SbB99; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RlFtGEJU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xl7SbB99;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjsGl5RLPz301N
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 06:12:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738177929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQjrEwpUP6UAeiwxxjvqUmkvSvE9B0Xh2DKKvF3TdaM=;
	b=RlFtGEJUU0qdlIbjK/j7hXwGIfBL4n7IdZnQeUZdcp/BTwBxhAu/TMIoa84xuTeAx4hbsl
	qPiErA2I+yowctxqGQFhJCotui+YqE/CcAXrnrkeSAYlRexAqkwFLhbjAiSFms/udSBFhU
	kFimsxtDk+wcvCEuaYQvaI0mst1Tc2U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738177930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQjrEwpUP6UAeiwxxjvqUmkvSvE9B0Xh2DKKvF3TdaM=;
	b=Xl7SbB99DSK4VHqIVy3Jlu8itPavzdeF60fjo+E0R5JdEVv2pMvGFUHKXaCYXFUl4ClUHy
	1oEnmz5TsI2AA0wZHMa9iS36b2HXBpAOss5I5NlBGHB54QDiR9kIiOJd3XTcBkAG5Un1Ia
	+YPlS7miGG37GsnkcOdDujTMWm8QKnU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-bTjMk3VDP7e4YFx1cB3vYA-1; Wed, 29 Jan 2025 14:12:05 -0500
X-MC-Unique: bTjMk3VDP7e4YFx1cB3vYA-1
X-Mimecast-MFC-AGG-ID: bTjMk3VDP7e4YFx1cB3vYA
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e5742f52896so130855276.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 11:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738177925; x=1738782725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQjrEwpUP6UAeiwxxjvqUmkvSvE9B0Xh2DKKvF3TdaM=;
        b=qWFzQN7n5ko+/ORNnKh9yX1FTB6IizojweFttDWbgnd331g4B28ZQS8KYUIMwwwE7O
         cViRY/nMIiV5RXDbhww/HII8mMX+7leVssWnTuMVGM7H4E4kXOjGQcSimEq0rb2i0phc
         NL/NBjcASQpFRKqdlS6vKEEQP3hSD54K/oq/9lSGJwPUR4LGbYLBQ2xonk8ltzv34llO
         4KDFmmZK0glNsxv1UB+aJKdkL3qQuEpKkEKxaGICB+onGH4eLvoVqWIrryRDH74ZEH5Y
         93D7qZNs5Ml2nriHezaTFpMK8ZBEJwHvmjKES8tJkFDK2gcmgG43bRh/nZdFR1N5E6z+
         Io1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/lu9yV3xGMYxCRNL2DGFiNulg1mKSxbCIalYMNSt6N6HOzWj7z7VnyMSgvIrnTkiaB6Lzxx/RP/5X3dM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLpbz2dX/Jr3Z3/j928C9mfdWazbFM8ebOYgrdzgdh032nrLPw
	+fe6XG67tNMdQ78zvKYljsistrC8hcuDLJ+Y+DWkbQ2IsqL7tZYEQog+g79qmv/kRSaMUSiH42s
	RMA5+Y9L2f75cAWcwZiV8TYjmBrx3rLNVQ7i3E8UgRC0jB9ihz8OPhqhNWgWI5x2hP65CMPdCjW
	E41X0ACqHpuERScm0Eka0MqUE08USWOHzMo0Y6vw==
X-Gm-Gg: ASbGnctOBWx60CnM74oL5AmHQz9Alts/U+eJ8jZuiONyks17UPrDr0sK0ADCXOnK/uO
	AHF0xaGhDeFYsuaMWNp3FfN4Dq5uG4LfH7oO6WlqHjfZf68rn8Y8Y74fPtBkK
X-Received: by 2002:a05:690c:6485:b0:6ef:7d51:ebb3 with SMTP id 00721157ae682-6f7a84239ecmr34718977b3.34.1738177925206;
        Wed, 29 Jan 2025 11:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfkoHnCQuBIcJh6oY5+rQ6ktnJX2Xz416ES4ywJdwRZyOlbhpvDnfPTBErdwnXtKh1mv+gPJUgRfYZ8LeT06g=
X-Received: by 2002:a05:690c:6485:b0:6ef:7d51:ebb3 with SMTP id
 00721157ae682-6f7a84239ecmr34718567b3.34.1738177924837; Wed, 29 Jan 2025
 11:12:04 -0800 (PST)
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
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
 <20250128-cocci-memory-api-v1-9-0d1609a29587@redhat.com> <83c922b8-9cf0-4c4f-9a10-ee7c26bd85c4@foss.st.com>
In-Reply-To: <83c922b8-9cf0-4c4f-9a10-ee7c26bd85c4@foss.st.com>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 29 Jan 2025 14:11:54 -0500
X-Gm-Features: AWEUYZmsqvdjh7AQQFgksY0USvNR-N5MS1gtek0KcZ8IxNBb50b5-jKINkKSLGc
Message-ID: <CAN9Xe3TKnt26G_+Lfn53j-CHxhjOqzSJ+Q6Xwx47oBtCJO6cQg@mail.gmail.com>
Subject: Re: [PATCH 09/14] drm/sti: move to devm_platform_ioremap_resource() usage
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Joel Stanley <joel@jms.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Marek Vasut <marex@denx.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Alexey Brodkin <abrodkin@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _90bst4taumSI92O2YeQwc5BA3trdRdkDn9xcReDEnI_1738177925
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c447d4062cdd152b"

--000000000000c447d4062cdd152b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:10=E2=80=AFAM Raphael Gallais-Pou <
raphael.gallais-pou@foss.st.com> wrote:

>
> On 1/28/25 23:29, Anusha Srivatsa wrote:
> > Replace platform_get_resource/_byname + devm_ioremap
> > with just devm_platform_ioremap_resource()
> >
> > Used Coccinelle to do this change. SmPl patch:
> >
> > @rule@
> > identifier res;
> > expression ioremap;
> > identifier pdev;
> > constant mem;
> > expression name;
> > @@
> > -struct resource *res;
> > ...
> > -res =3D platform_get_resource_byname(pdev,mem,name);
> > <...
> > -if (!res) {
> > -...
> > -}
> > ...>
> > -ioremap =3D devm_ioremap(...);
> > +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
> >
> > and
> > @rule_2@
> > identifier res;
> > expression ioremap;
> > identifier pdev;
> > @@
> > -struct resource *res;
> > ...
> > -res =3D platform_get_resource(pdev,...);
> > <...
> > -if (!res) {
> > -...
> > -}
> > ...>
> > -ioremap =3D devm_ioremap(...);
> > +ioremap =3D devm_platform_ioremap_resource(pdev,0);
> >
> > Cc: Alain Volmat <alain.volmat@foss.st.com>
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
>
>
> Hi Anusha,
>
>
> Thanks again for your work,
>
> > ---
> >  drivers/gpu/drm/sti/sti_compositor.c | 10 +---------
> >  drivers/gpu/drm/sti/sti_dvo.c        | 10 +---------
> >  drivers/gpu/drm/sti/sti_hda.c        | 10 +---------
> >  drivers/gpu/drm/sti/sti_hdmi.c       | 11 +----------
> >  drivers/gpu/drm/sti/sti_hqvdp.c      | 10 +---------
> >  drivers/gpu/drm/sti/sti_tvout.c      | 10 +---------
> >  drivers/gpu/drm/sti/sti_vtg.c        | 10 +---------
> >  7 files changed, 7 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_compositor.c
> b/drivers/gpu/drm/sti/sti_compositor.c
> > index
> 063f82d23d80c4ba83624a0066a18416a2b37351..7aefce6706ba2cd7d97a33228c9b981=
2edecf06f
> 100644
> > --- a/drivers/gpu/drm/sti/sti_compositor.c
> > +++ b/drivers/gpu/drm/sti/sti_compositor.c
> > @@ -177,7 +177,6 @@ static int sti_compositor_probe(struct
> platform_device *pdev)
> >       struct device_node *np =3D dev->of_node;
> >       struct device_node *vtg_np;
> >       struct sti_compositor *compo;
> > -     struct resource *res;
> >       unsigned int i;
> >
> >       compo =3D devm_kzalloc(dev, sizeof(*compo), GFP_KERNEL);
> > @@ -194,14 +193,7 @@ static int sti_compositor_probe(struct
> platform_device *pdev)
> >
> >       memcpy(&compo->data, of_match_node(compositor_of_match, np)->data=
,
> >              sizeof(struct sti_compositor_data));
> > -
> > -     /* Get Memory ressources */
> > -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (res =3D=3D NULL) {
> > -             DRM_ERROR("Get memory resource failed\n");
> > -             return -ENXIO;
> > -     }
> > -     compo->regs =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> > +     compo->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (compo->regs =3D=3D NULL) {
> >               DRM_ERROR("Register mapping failed\n");
> >               return -ENXIO;
> > diff --git a/drivers/gpu/drm/sti/sti_dvo.c
> b/drivers/gpu/drm/sti/sti_dvo.c
> > index
> c6c2abaa1891cd3ea025805b50d275ec314512c3..660588f01f90950a9b2c180ab230188=
c19901f26
> 100644
> > --- a/drivers/gpu/drm/sti/sti_dvo.c
> > +++ b/drivers/gpu/drm/sti/sti_dvo.c
> > @@ -511,7 +511,6 @@ static int sti_dvo_probe(struct platform_device
> *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct sti_dvo *dvo;
> > -     struct resource *res;
> >       struct device_node *np =3D dev->of_node;
> >
> >       DRM_INFO("%s\n", __func__);
> > @@ -523,14 +522,7 @@ static int sti_dvo_probe(struct platform_device
> *pdev)
> >       }
> >
> >       dvo->dev =3D pdev->dev;
> > -
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "dvo-reg");
> > -     if (!res) {
> > -             DRM_ERROR("Invalid dvo resource\n");
> > -             return -ENOMEM;
> > -     }
> > -     dvo->regs =3D devm_ioremap(dev, res->start,
> > -                     resource_size(res));
> > +     dvo->regs =3D devm_platform_ioremap_resource_byname(pdev, "dvo-re=
g");
> >       if (!dvo->regs)
> >               return -ENOMEM;
> >
> > diff --git a/drivers/gpu/drm/sti/sti_hda.c
> b/drivers/gpu/drm/sti/sti_hda.c
> > index
> b12863bea95559c4f874eb94cea8938609d435d4..28fde4c568d0069ecf2f2f69f5be0e8=
7c1d5f4f3
> 100644
> > --- a/drivers/gpu/drm/sti/sti_hda.c
> > +++ b/drivers/gpu/drm/sti/sti_hda.c
> > @@ -741,7 +741,6 @@ static int sti_hda_probe(struct platform_device
> *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct sti_hda *hda;
> > -     struct resource *res;
>
> There is a compile error, using an ARM toolchain on this patch and severa=
l
> others.
>
> struct ressource *res is used on other places, which does not allow to
> remove
> the instanciation here.
>
>
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c: In
> function
> =E2=80=98sti_hda_probe=E2=80=99:
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c:756:9:
> error:
> =E2=80=98res=E2=80=99 undeclared (first use in this function)
>   756 |         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM=
,
>       |         ^~~
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c:756:9:
> note:
> each undeclared identifier is reported only once for each function it
> appears in
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/core/event.o
> make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:19=
4:
> drivers/gpu/drm/sti/sti_hda.o] Error 1
> make[8]: *** Waiting for unfinished jobs....
>
>
> This can be applied:
>
>
> * regarding [PATCH 07/14] rockchip driver:
>
>
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_v=
op.c:
> In function =E2=80=98vop_bind=E2=80=99:
>
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_v=
op.c:2212:34:
> error: =E2=80=98res=E2=80=99 undeclared (first use in this function); did=
 you mean =E2=80=98ret=E2=80=99?
>  2212 |         vop->len =3D resource_size(res);
>       |                                  ^~~
>       |                                  ret
>
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_v=
op.c:2212:34:
> note: each undeclared identifier is reported only once for each function =
it
> appears in
>   CC [M]  drivers/gpu/drm/nouveau/nvif/fifo.o
> make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:19=
4:
> drivers/gpu/drm/rockchip/rockchip_drm_vop.o] Error 1
> make[8]: *** Waiting for unfinished jobs....
>
>
> * regarding  [PATCH 13/14] vc4 driver:
>
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c: In
> function
> =E2=80=98vc5_hdmi_init_resources=E2=80=99:
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c:2961:9:
> error:
> =E2=80=98res=E2=80=99 undeclared (first use in this function); did you me=
an =E2=80=98ret=E2=80=99?
>  2961 |         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM=
,
> "hd");
>       |         ^~~
>       |         ret
> /local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c:2961:9:
> note:
> each undeclared identifier is reported only once for each function it
> appears in
> make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:19=
4:
> drivers/gpu/drm/vc4/vc4_hdmi.o] Error 1
> make[8]: *** Waiting for unfinished jobs....
>
>
Raphael,
In the sti_hda_probe, does it make sense to remove the second
platform_get_resource_byname() (the one with video-dacs-ctrl resource) and
apply the coccinelle transformation to it like the rest of the subsystem?
I feel like that should be left as is and the rule should be adjusted to
ensure that if "res" is further used then do not remove it. THoughts?

anusha

>
> Regards,
> Rapha=C3=ABl
>
> >
> >       DRM_INFO("%s\n", __func__);
> >
> > @@ -750,14 +749,7 @@ static int sti_hda_probe(struct platform_device
> *pdev)
> >               return -ENOMEM;
> >
> >       hda->dev =3D pdev->dev;
> > -
> > -     /* Get resources */
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "hda-reg");
> > -     if (!res) {
> > -             DRM_ERROR("Invalid hda resource\n");
> > -             return -ENOMEM;
> > -     }
> > -     hda->regs =3D devm_ioremap(dev, res->start, resource_size(res));
> > +     hda->regs =3D devm_platform_ioremap_resource_byname(pdev, "hda-re=
g");
> >       if (!hda->regs)
> >               return -ENOMEM;
> >
> > diff --git a/drivers/gpu/drm/sti/sti_hdmi.c
> b/drivers/gpu/drm/sti/sti_hdmi.c
> > index
> ca2fe17de4a5d1e0199e59a97e6c7601e139ed9e..666143c48b0d0f2c20cd26323ddbc8e=
69d966622
> 100644
> > --- a/drivers/gpu/drm/sti/sti_hdmi.c
> > +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> > @@ -1380,7 +1380,6 @@ static int sti_hdmi_probe(struct platform_device
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct sti_hdmi *hdmi;
> >       struct device_node *np =3D dev->of_node;
> > -     struct resource *res;
> >       struct device_node *ddc;
> >       int ret;
> >
> > @@ -1399,15 +1398,7 @@ static int sti_hdmi_probe(struct platform_device
> *pdev)
> >       }
> >
> >       hdmi->dev =3D pdev->dev;
> > -
> > -     /* Get resources */
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "hdmi-reg");
> > -     if (!res) {
> > -             DRM_ERROR("Invalid hdmi resource\n");
> > -             ret =3D -ENOMEM;
> > -             goto release_adapter;
> > -     }
> > -     hdmi->regs =3D devm_ioremap(dev, res->start, resource_size(res));
> > +     hdmi->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "hdmi-reg");
> >       if (!hdmi->regs) {
> >               ret =3D -ENOMEM;
> >               goto release_adapter;
> > diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c
> b/drivers/gpu/drm/sti/sti_hqvdp.c
> > index
> 0f658709c9d0d398c4eed65202443db9d0b41f8c..420395598d119a403d531211022e600=
5d6a2bd59
> 100644
> > --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> > +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> > @@ -1356,7 +1356,6 @@ static int sti_hqvdp_probe(struct platform_device
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct device_node *vtg_np;
> >       struct sti_hqvdp *hqvdp;
> > -     struct resource *res;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > @@ -1367,14 +1366,7 @@ static int sti_hqvdp_probe(struct platform_devic=
e
> *pdev)
> >       }
> >
> >       hqvdp->dev =3D dev;
> > -
> > -     /* Get Memory resources */
> > -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (!res) {
> > -             DRM_ERROR("Get memory resource failed\n");
> > -             return -ENXIO;
> > -     }
> > -     hqvdp->regs =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> > +     hqvdp->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (!hqvdp->regs) {
> >               DRM_ERROR("Register mapping failed\n");
> >               return -ENXIO;
> > diff --git a/drivers/gpu/drm/sti/sti_tvout.c
> b/drivers/gpu/drm/sti/sti_tvout.c
> > index
> af6c06f448c4819def8cc0d0836e30f991529690..0bebe815f5e7567f84388af93723a6f=
a7d2cc7a2
> 100644
> > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > @@ -838,7 +838,6 @@ static int sti_tvout_probe(struct platform_device
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct device_node *node =3D dev->of_node;
> >       struct sti_tvout *tvout;
> > -     struct resource *res;
> >
> >       DRM_INFO("%s\n", __func__);
> >
> > @@ -850,14 +849,7 @@ static int sti_tvout_probe(struct platform_device
> *pdev)
> >               return -ENOMEM;
> >
> >       tvout->dev =3D dev;
> > -
> > -     /* get memory resources */
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "tvout-reg");
> > -     if (!res) {
> > -             DRM_ERROR("Invalid glue resource\n");
> > -             return -ENOMEM;
> > -     }
> > -     tvout->regs =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> > +     tvout->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "tvout-reg");
> >       if (!tvout->regs)
> >               return -ENOMEM;
> >
> > diff --git a/drivers/gpu/drm/sti/sti_vtg.c
> b/drivers/gpu/drm/sti/sti_vtg.c
> > index
> 5ba469b711b5318e9e9e6d8df127fb8933d1fac1..b5353fe774d72fd629ecd3ef75a5d28=
17ca8617f
> 100644
> > --- a/drivers/gpu/drm/sti/sti_vtg.c
> > +++ b/drivers/gpu/drm/sti/sti_vtg.c
> > @@ -380,20 +380,12 @@ static int vtg_probe(struct platform_device *pdev=
)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct sti_vtg *vtg;
> > -     struct resource *res;
> >       int ret;
> >
> >       vtg =3D devm_kzalloc(dev, sizeof(*vtg), GFP_KERNEL);
> >       if (!vtg)
> >               return -ENOMEM;
> > -
> > -     /* Get Memory ressources */
> > -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (!res) {
> > -             DRM_ERROR("Get memory resource failed\n");
> > -             return -ENOMEM;
> > -     }
> > -     vtg->regs =3D devm_ioremap(dev, res->start, resource_size(res));
> > +     vtg->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (!vtg->regs) {
> >               DRM_ERROR("failed to remap I/O memory\n");
> >               return -ENOMEM;
> >
>
>

--000000000000c447d4062cdd152b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 29,=
 2025 at 4:10=E2=80=AFAM Raphael Gallais-Pou &lt;<a href=3D"mailto:raphael.=
gallais-pou@foss.st.com">raphael.gallais-pou@foss.st.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 1/28/25 23:29, Anusha Srivatsa wrote:<br>
&gt; Replace platform_get_resource/_byname + devm_ioremap<br>
&gt; with just devm_platform_ioremap_resource()<br>
&gt;<br>
&gt; Used Coccinelle to do this change. SmPl patch:<br>
&gt;<br>
&gt; @rule@<br>
&gt; identifier res;<br>
&gt; expression ioremap;<br>
&gt; identifier pdev;<br>
&gt; constant mem;<br>
&gt; expression name;<br>
&gt; @@<br>
&gt; -struct resource *res;<br>
&gt; ...<br>
&gt; -res =3D platform_get_resource_byname(pdev,mem,name);<br>
&gt; &lt;...<br>
&gt; -if (!res) {<br>
&gt; -...<br>
&gt; -}<br>
&gt; ...&gt;<br>
&gt; -ioremap =3D devm_ioremap(...);<br>
&gt; +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);<br>
&gt;<br>
&gt; and<br>
&gt; @rule_2@<br>
&gt; identifier res;<br>
&gt; expression ioremap;<br>
&gt; identifier pdev;<br>
&gt; @@<br>
&gt; -struct resource *res;<br>
&gt; ...<br>
&gt; -res =3D platform_get_resource(pdev,...);<br>
&gt; &lt;...<br>
&gt; -if (!res) {<br>
&gt; -...<br>
&gt; -}<br>
&gt; ...&gt;<br>
&gt; -ioremap =3D devm_ioremap(...);<br>
&gt; +ioremap =3D devm_platform_ioremap_resource(pdev,0);<br>
&gt;<br>
&gt; Cc: Alain Volmat &lt;<a href=3D"mailto:alain.volmat@foss.st.com" targe=
t=3D"_blank">alain.volmat@foss.st.com</a>&gt;<br>
&gt; Signed-off-by: Anusha Srivatsa &lt;<a href=3D"mailto:asrivats@redhat.c=
om" target=3D"_blank">asrivats@redhat.com</a>&gt;<br>
<br>
<br>
Hi Anusha,<br>
<br>
<br>
Thanks again for your work,<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_compositor.c | 10 +---------<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_dvo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +-=
--------<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_hda.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +-=
--------<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_hdmi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +-=
---------<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_hqvdp.c=C2=A0 =C2=A0 =C2=A0 | 10 +------=
---<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_tvout.c=C2=A0 =C2=A0 =C2=A0 | 10 +------=
---<br>
&gt;=C2=A0 drivers/gpu/drm/sti/sti_vtg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +-=
--------<br>
&gt;=C2=A0 7 files changed, 7 insertions(+), 64 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/st=
i/sti_compositor.c<br>
&gt; index 063f82d23d80c4ba83624a0066a18416a2b37351..7aefce6706ba2cd7d97a33=
228c9b9812edecf06f 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt; @@ -177,7 +177,6 @@ static int sti_compositor_probe(struct platform_de=
vice *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;of_node;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *vtg_np;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_compositor *compo;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0compo =3D devm_kzalloc(dev, sizeof(*compo), =
GFP_KERNEL);<br>
&gt; @@ -194,14 +193,7 @@ static int sti_compositor_probe(struct platform_d=
evice *pdev)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;compo-&gt;data, of_match_node(co=
mpositor_of_match, np)-&gt;data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct sti_comp=
ositor_data));<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory ressources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (res =3D=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Get m=
emory resource failed\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0compo-&gt;regs =3D devm_ioremap(dev, res-&gt;star=
t, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0compo-&gt;regs =3D devm_platform_ioremap_resource=
(pdev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (compo-&gt;regs =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;=
Register mapping failed\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<b=
r>
&gt; diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_d=
vo.c<br>
&gt; index c6c2abaa1891cd3ea025805b50d275ec314512c3..660588f01f90950a9b2c18=
0ab230188c19901f26 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt; @@ -511,7 +511,6 @@ static int sti_dvo_probe(struct platform_device *p=
dev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_dvo *dvo;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;of_node;<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;%s\n&quot;, __func__);<br>
&gt; @@ -523,14 +522,7 @@ static int sti_dvo_probe(struct platform_device *=
pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dvo-&gt;dev =3D pdev-&gt;dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;dvo-reg&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Inval=
id dvo resource\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0dvo-&gt;regs =3D devm_ioremap(dev, res-&gt;start,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dvo-&gt;regs =3D devm_platform_ioremap_resource_b=
yname(pdev, &quot;dvo-reg&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dvo-&gt;regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_h=
da.c<br>
&gt; index b12863bea95559c4f874eb94cea8938609d435d4..28fde4c568d0069ecf2f2f=
69f5be0e87c1d5f4f3 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_hda.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_hda.c<br>
&gt; @@ -741,7 +741,6 @@ static int sti_hda_probe(struct platform_device *p=
dev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_hda *hda;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
<br>
There is a compile error, using an ARM toolchain on this patch and several =
others.<br>
<br>
struct ressource *res is used on other places, which does not allow to remo=
ve<br>
the instanciation here.<br>
<br>
<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c: In functio=
n<br>
=E2=80=98sti_hda_probe=E2=80=99:<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c:756:9: erro=
r:<br>
=E2=80=98res=E2=80=99 undeclared (first use in this function)<br>
=C2=A0 756 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D platfo=
rm_get_resource_byname(pdev, IORESOURCE_MEM,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/sti/sti_hda.c:756:9: note=
:<br>
each undeclared identifier is reported only once for each function it appea=
rs in<br>
=C2=A0 CC [M]=C2=A0 drivers/gpu/drm/nouveau/nvkm/core/event.o<br>
make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:194:=
<br>
drivers/gpu/drm/sti/sti_hda.o] Error 1<br>
make[8]: *** Waiting for unfinished jobs....<br>
<br>
<br>
This can be applied:<br>
<br>
<br>
* regarding [PATCH 07/14] rockchip driver:<br>
<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_vop=
.c:<br>
In function =E2=80=98vop_bind=E2=80=99:<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_vop=
.c:2212:34:<br>
error: =E2=80=98res=E2=80=99 undeclared (first use in this function); did y=
ou mean =E2=80=98ret=E2=80=99?<br>
=C2=A02212 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vop-&gt;len =
=3D resource_size(res);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/rockchip/rockchip_drm_vop=
.c:2212:34:<br>
note: each undeclared identifier is reported only once for each function it=
<br>
appears in<br>
=C2=A0 CC [M]=C2=A0 drivers/gpu/drm/nouveau/nvif/fifo.o<br>
make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:194:=
<br>
drivers/gpu/drm/rockchip/rockchip_drm_vop.o] Error 1<br>
make[8]: *** Waiting for unfinished jobs....<br>
<br>
<br>
* regarding=C2=A0 [PATCH 13/14] vc4 driver:<br>
<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c: In functi=
on<br>
=E2=80=98vc5_hdmi_init_resources=E2=80=99:<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c:2961:9: er=
ror:<br>
=E2=80=98res=E2=80=99 undeclared (first use in this function); did you mean=
 =E2=80=98ret=E2=80=99?<br>
=C2=A02961 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D platfo=
rm_get_resource_byname(pdev, IORESOURCE_MEM, &quot;hd&quot;);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret<br>
/local/home/gallais1/src/drm-misc/drivers/gpu/drm/vc4/vc4_hdmi.c:2961:9: no=
te:<br>
each undeclared identifier is reported only once for each function it appea=
rs in<br>
make[8]: *** [/local/home/gallais1/src/drm-misc/scripts/Makefile.build:194:=
<br>
drivers/gpu/drm/vc4/vc4_hdmi.o] Error 1<br>
make[8]: *** Waiting for unfinished jobs....<br>
<br></blockquote><div><br></div><div>Raphael,</div><div>In the sti_hda_prob=
e, does it make sense to remove the second platform_get_resource_byname() (=
the one with video-dacs-ctrl resource) and apply the coccinelle transformat=
ion to it like the rest of the subsystem?=C2=A0 I feel like that should be =
left as is and the rule should be adjusted to ensure that if &quot;res&quot=
; is further used then do not remove it. THoughts?</div><div><br></div><div=
>anusha<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Rapha=C3=ABl<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;%s\n&quot;, __func__);<br>
&gt;=C2=A0 <br>
&gt; @@ -750,14 +749,7 @@ static int sti_hda_probe(struct platform_device *=
pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hda-&gt;dev =3D pdev-&gt;dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Get resources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;hda-reg&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Inval=
id hda resource\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0hda-&gt;regs =3D devm_ioremap(dev, res-&gt;start,=
 resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hda-&gt;regs =3D devm_platform_ioremap_resource_b=
yname(pdev, &quot;hda-reg&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hda-&gt;regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_=
hdmi.c<br>
&gt; index ca2fe17de4a5d1e0199e59a97e6c7601e139ed9e..666143c48b0d0f2c20cd26=
323ddbc8e69d966622 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt; @@ -1380,7 +1380,6 @@ static int sti_hdmi_probe(struct platform_device=
 *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_hdmi *hdmi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;of_node;<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *ddc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 <br>
&gt; @@ -1399,15 +1398,7 @@ static int sti_hdmi_probe(struct platform_devic=
e *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hdmi-&gt;dev =3D pdev-&gt;dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Get resources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;hdmi-reg&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Inval=
id hdmi resource\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto release_adapter;=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0hdmi-&gt;regs =3D devm_ioremap(dev, res-&gt;start=
, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hdmi-&gt;regs =3D devm_platform_ioremap_resource_=
byname(pdev, &quot;hdmi-reg&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hdmi-&gt;regs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto release_ada=
pter;<br>
&gt; diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti=
_hqvdp.c<br>
&gt; index 0f658709c9d0d398c4eed65202443db9d0b41f8c..420395598d119a403d5312=
11022e6005d6a2bd59 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt; @@ -1356,7 +1356,6 @@ static int sti_hqvdp_probe(struct platform_devic=
e *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *vtg_np;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_hqvdp *hqvdp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(&quot;\n&quot;);<br>
&gt;=C2=A0 <br>
&gt; @@ -1367,14 +1366,7 @@ static int sti_hqvdp_probe(struct platform_devi=
ce *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hqvdp-&gt;dev =3D dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory resources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Get m=
emory resource failed\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0hqvdp-&gt;regs =3D devm_ioremap(dev, res-&gt;star=
t, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hqvdp-&gt;regs =3D devm_platform_ioremap_resource=
(pdev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hqvdp-&gt;regs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;=
Register mapping failed\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<b=
r>
&gt; diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti=
_tvout.c<br>
&gt; index af6c06f448c4819def8cc0d0836e30f991529690..0bebe815f5e7567f84388a=
f93723a6fa7d2cc7a2 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt; @@ -838,7 +838,6 @@ static int sti_tvout_probe(struct platform_device =
*pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *node =3D dev-&gt;of_node=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_tvout *tvout;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;%s\n&quot;, __func__);<br>
&gt;=C2=A0 <br>
&gt; @@ -850,14 +849,7 @@ static int sti_tvout_probe(struct platform_device=
 *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tvout-&gt;dev =3D dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* get memory resources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;tvout-reg&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Inval=
id glue resource\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tvout-&gt;regs =3D devm_ioremap(dev, res-&gt;star=
t, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tvout-&gt;regs =3D devm_platform_ioremap_resource=
_byname(pdev, &quot;tvout-reg&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tvout-&gt;regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_v=
tg.c<br>
&gt; index 5ba469b711b5318e9e9e6d8df127fb8933d1fac1..b5353fe774d72fd629ecd3=
ef75a5d2817ca8617f 100644<br>
&gt; --- a/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt; +++ b/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt; @@ -380,20 +380,12 @@ static int vtg_probe(struct platform_device *pde=
v)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_vtg *vtg;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vtg =3D devm_kzalloc(dev, sizeof(*vtg), GFP_=
KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vtg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory ressources */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Get m=
emory resource failed\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0vtg-&gt;regs =3D devm_ioremap(dev, res-&gt;start,=
 resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vtg-&gt;regs =3D devm_platform_ioremap_resource(p=
dev, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vtg-&gt;regs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;=
failed to remap I/O memory\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000c447d4062cdd152b--



Return-Path: <linux-aspeed+bounces-961-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D3C282EC
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Mar 2025 23:01:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7Shr63Jcz30Jc;
	Thu,  6 Mar 2025 10:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741192232;
	cv=none; b=N+KboTkzkTSR1wRqm6r6v8In5xGgQQXnGusdE9wIpyh34OvxMKD/VIp+vc8UsDVVvT0uk2x8Jfq1L/qaoOHGBPd14LY8+EjjFFeXnzHcCo6L4CafC4f8PIEI8I5n6U2C9U41yT1bR8hmjhg8+gs8WJ6ih4F04QiRBoSjxRbKXlLzpxadVRlnDiajOUVM9q3y+30E9UTcBGVUz3REuYl2cd3xbsfuyzas5lRsaU8iNA99/m0U1Z3egq2OoRYffcMHDk+JC/uNRvmtgb46IWQyNLUkSazNqe1SbDEOU2R8FZ84TQ03P5XYkg/0YgZMo0n3MJYd2JxGEQA01kudERQ6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741192232; c=relaxed/relaxed;
	bh=Krg0NsdBmdW1FofnS7x0xWg/isbE6a9AETHoNPfbUx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYWGFmKdvBL+FeTEu1ql75Il2DKLIg1acb3DrIAPMGD/b4vLBQhTxpDzaAZtmSm68u1ObxWjd/bPXbR9M2VOqz2i7iIynxrHQBviFreXF9UIvELDUv8OpbPKQv6A2aWHCNjgI8XLf5+cwCmQt2JVR3eU9kZDQYUJoC50cbIQEWjsuQH5cg5+rMf4KFdZs/Vh01LWMXA01eMAvHZ83nbCruRWvpraD2QansLhlbL9zew64SaN+zw7HJARciFvP7rJyblABrmIU1C0+fRZXy8yVrmbGKl0JWilN+xJNoiKC3II7/nkCw51yyx96UfxGz273W40K/5nuT8rGNj2jPGcwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUZo8Hk4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUZo8Hk4; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUZo8Hk4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bUZo8Hk4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7J1z058qz30Pl
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Mar 2025 03:30:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741192226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg0NsdBmdW1FofnS7x0xWg/isbE6a9AETHoNPfbUx4=;
	b=bUZo8Hk4mD2lOFU0597L+0+9bilv7+j0ZGZE/K0ga0Jyv6iPWUIKWf5m7FT8Jff8emTdNP
	lv7MasYZI1BicbH1KEp2qQTUmNlL6V7Gjr8KAjrKGer+iEZ6XBw8nwP3JN7oKAilO0MjEt
	QZ4Ar3vnxSlkXbUgn1YVk0VEwQjc430=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741192226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg0NsdBmdW1FofnS7x0xWg/isbE6a9AETHoNPfbUx4=;
	b=bUZo8Hk4mD2lOFU0597L+0+9bilv7+j0ZGZE/K0ga0Jyv6iPWUIKWf5m7FT8Jff8emTdNP
	lv7MasYZI1BicbH1KEp2qQTUmNlL6V7Gjr8KAjrKGer+iEZ6XBw8nwP3JN7oKAilO0MjEt
	QZ4Ar3vnxSlkXbUgn1YVk0VEwQjc430=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-kN5vAKQyPcmZEUYHcLXJ-Q-1; Wed, 05 Mar 2025 11:30:19 -0500
X-MC-Unique: kN5vAKQyPcmZEUYHcLXJ-Q-1
X-Mimecast-MFC-AGG-ID: kN5vAKQyPcmZEUYHcLXJ-Q_1741192219
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6fd5b2883b7so71210557b3.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Mar 2025 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192219; x=1741797019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krg0NsdBmdW1FofnS7x0xWg/isbE6a9AETHoNPfbUx4=;
        b=l0PBlHtVE0uQ809aoRjCCpSx8r9iKOluJfcvcJRPMSqP5o5ZSkm7bygBz3dZsr9gml
         K05cg5kMuKSz3ADhZJadEhypasAUpg0DRa/fKAK+k7DRClZFu5XlVIwZXHrXLErVGTLm
         v+d7yOAheWtqtIapM7atLwHQzvP6VX62S7tpkPh7ZqpjvRmn3EyUJqdcTzyiJm+R4Bvi
         XYiaDWhyAq7PU4cnoVjgrJ+w3QnBkOypO/pRAor+dGrgMsF46TVswYl/pbTsZ1k+Efh/
         WkvlXAj5XlpQh8HM2JBqBwGOEv69PC01NmwCRGk+Ohe5Z/zsiZtCCaOvKi08NIpinGt5
         UUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCURt8u9K9ouvu8K8EOT6IWXx01GUdJWNLX/qnWSUwUNjayaBXdTwmfhqfjo8N5SZuztRSvu6BesUQ91YKU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6OYCqhJPDcMlPdndLizoDUm4gLFvlL3xeeBJ7BeWuhlxX5+pD
	RZNdb3RN3CviwZt98KMFjnU4JQ61yD/s1v0UaErUfJN5MCY0MbgVvhIAq04RntUmKfqXbvMH7wQ
	WKoyxahR9fSykA6G5m8SXVRxxkfI6vQf23VFrj6YExVLjjwR4og2CUnGve3lhUEeVZ76W9/99uv
	lGV6so93hvTOobHkZQ+Timb+z0ae0OSMjiD9KG6g==
X-Gm-Gg: ASbGncsfG0NzAZQSfqeHwKWZAXcE8HtJLaJZtFTOvLXH4ft67rYQ0M21LPJDg6UJQy1
	frbfxuFf5D6HKNI9pIFqR9dxPPYOjJHb7fVLfWpKykNlGmGcMdh5l4qEjvAI3/JwZX7pXHI4=
X-Received: by 2002:a05:690c:30e:b0:6f9:4bb6:eb46 with SMTP id 00721157ae682-6fda30f2c8cmr58718017b3.31.1741192218797;
        Wed, 05 Mar 2025 08:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiOUhBrdak50rFGYgc9HMjXFPQMI0wt16d3+VH21fYr7RjkwT/0A9wQOztomXSXHmIdFP45l0MosfT2fUwwEc=
X-Received: by 2002:a05:690c:30e:b0:6f9:4bb6:eb46 with SMTP id
 00721157ae682-6fda30f2c8cmr58716747b3.31.1741192217961; Wed, 05 Mar 2025
 08:30:17 -0800 (PST)
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
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
 <20250225-memory-drm-misc-next-v1-7-9d0e8761107a@redhat.com>
 <24958ae8-6153-4798-abeb-e770d66ca8e4@foss.st.com> <CAN9Xe3Q8=_Tz51i6gxNM6445p-rhNiK7B5Ljcga8g_Nn676dCQ@mail.gmail.com>
 <3b173c1c-4e74-4907-961c-9c90d48a9412@foss.st.com>
In-Reply-To: <3b173c1c-4e74-4907-961c-9c90d48a9412@foss.st.com>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 5 Mar 2025 11:30:06 -0500
X-Gm-Features: AQ5f1JolwWYxQ6eprjUSd2FjdUCXt8_Q9i4a4kR1-mY6kbVrqdthS00tyj68Rtw
Message-ID: <CAN9Xe3SXnxqegs+BkcObDO4f0zuEduQc2Rkg6dRNBtabDAn-ZA@mail.gmail.com>
Subject: Re: [PATCH RESEND 07/12] drm/sti: move to devm_platform_ioremap_resource()
 usage
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Marek Vasut <marex@denx.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
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
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PsCt457l0L9NYxQlOckFnaDxm28r3ZbcVXx_W8Mno-c_1741192219
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a3411e062f9ae728"

--000000000000a3411e062f9ae728
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:59=E2=80=AFAM Raphael Gallais-Pou <
raphael.gallais-pou@foss.st.com> wrote:

>
> On 3/3/25 18:29, Anusha Srivatsa wrote:
> > On Wed, Feb 26, 2025 at 5:19=E2=80=AFAM Raphael Gallais-Pou <
> > raphael.gallais-pou@foss.st.com> wrote:
> >
> >> On 2/25/25 23:20, Anusha Srivatsa wrote:
> >>> Replace platform_get_resource/_byname + devm_ioremap
> >>> with just devm_platform_ioremap_resource()
> >>>
> >>> Used Coccinelle to do this change. SmPl patch:
> >>>
> >>> @rule@
> >>> identifier res;
> >>> expression ioremap;
> >>> identifier pdev;
> >>> constant mem;
> >>> expression name;
> >>> @@
> >>> -struct resource *res;
> >>> ...
> >>> -res =3D platform_get_resource_byname(pdev,mem,name);
> >>> <...
> >>> -if (!res) {
> >>> -...
> >>> -}
> >>> ...>
> >>> -ioremap =3D devm_ioremap(...);
> >>> +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
> >>>
> >>> and
> >>> @rule_2@
> >>> identifier res;
> >>> expression ioremap;
> >>> identifier pdev;
> >>> @@
> >>> -struct resource *res;
> >>> ...
> >>> -res =3D platform_get_resource(pdev,...);
> >>> <...
> >>> -if (!res) {
> >>> -...
> >>> -}
> >>> ...>
> >>> -ioremap =3D devm_ioremap(...);
> >>> +ioremap =3D devm_platform_ioremap_resource(pdev,0);
> >>>
> >>> v2: Fix compilation error.
> >>
> >> Hi Anusha,
> >>
> >>
> >> You did not take into account my comment regarding the changelog. :-)
> >>
> >>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#co=
mmentary
> >>
> >> While the commit summary do not specify the version, this changelog
> >> suggests
> >> that the version of your series as been incremented.
> >> If this is a v2, then a version descriptor should be applied to the
> >> patchset.
> >>
> >>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#su=
bject-line
> >>
> >> Hi  Raphael,
> > That is correct. While this patch is a v2, there is another patch or tw=
o
> in
> > the same series that is on v4 when it got acked and reviewed. Having
> > patches belonging to the same series with different version prefixes
> seemed
> > odd when I sent the series. Hence added what exactly changed in the
> commit
> > log.
>
>
> Indeed, the serie version should remain consistent across all patches.
>
> Maxime told you in an earlier answer, any modification of any patch what
> so ever
> increases the serie version. Thus all patches are at v5 (looking at your
> latest
> revision).
>
> Verbatim from the documentation :
>
> Other comments relevant only to the moment or the maintainer, not suitabl=
e
> for
> the permanent changelog, should also go here [under the --- marker]. A go=
od
> example of such comments might be patch changelogs which describe what ha=
s
> changed between the v1 and v2 version of the patch.
>
> Please put this information after the --- line which separates the
> changelog
> from the rest of the patch. The version information is not part of the
> changelog
> which gets committed to the git tree. It is additional information for th=
e
> reviewers. If it=E2=80=99s placed above the commit tags, it needs manual
> interaction to
> remove it. If it is below the separator line, it gets automatically
> stripped off
> when applying the patch:
>
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#co=
mmentary
>
> Rapha=C3=ABl
>
>
Thanks Raphael and Maxime for the detailed explanation. I had overlooked
this. Shall keep in mind going forward.

Anusha


>
> > Anusha
> >
> >
> >> Regards,
> >> Rapha=C3=ABl
> >>
> >>> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> >>> Cc: Alain Volmat <alain.volmat@foss.st.com>
> >>> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >>> Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> >>> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> >>> ---
> >>>  drivers/gpu/drm/sti/sti_compositor.c | 10 +---------
> >>>  drivers/gpu/drm/sti/sti_dvo.c        | 10 +---------
> >>>  drivers/gpu/drm/sti/sti_hda.c        |  9 +--------
> >>>  drivers/gpu/drm/sti/sti_hdmi.c       | 11 +----------
> >>>  drivers/gpu/drm/sti/sti_hqvdp.c      | 10 +---------
> >>>  drivers/gpu/drm/sti/sti_tvout.c      | 10 +---------
> >>>  drivers/gpu/drm/sti/sti_vtg.c        | 10 +---------
> >>>  7 files changed, 7 insertions(+), 63 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/sti/sti_compositor.c
> >> b/drivers/gpu/drm/sti/sti_compositor.c
> >>> index
> >>
> 063f82d23d80c4ba83624a0066a18416a2b37351..7aefce6706ba2cd7d97a33228c9b981=
2edecf06f
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_compositor.c
> >>> +++ b/drivers/gpu/drm/sti/sti_compositor.c
> >>> @@ -177,7 +177,6 @@ static int sti_compositor_probe(struct
> >> platform_device *pdev)
> >>>       struct device_node *np =3D dev->of_node;
> >>>       struct device_node *vtg_np;
> >>>       struct sti_compositor *compo;
> >>> -     struct resource *res;
> >>>       unsigned int i;
> >>>
> >>>       compo =3D devm_kzalloc(dev, sizeof(*compo), GFP_KERNEL);
> >>> @@ -194,14 +193,7 @@ static int sti_compositor_probe(struct
> >> platform_device *pdev)
> >>>       memcpy(&compo->data, of_match_node(compositor_of_match,
> np)->data,
> >>>              sizeof(struct sti_compositor_data));
> >>> -
> >>> -     /* Get Memory ressources */
> >>> -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> -     if (res =3D=3D NULL) {
> >>> -             DRM_ERROR("Get memory resource failed\n");
> >>> -             return -ENXIO;
> >>> -     }
> >>> -     compo->regs =3D devm_ioremap(dev, res->start, resource_size(res=
));
> >>> +     compo->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >>>       if (compo->regs =3D=3D NULL) {
> >>>               DRM_ERROR("Register mapping failed\n");
> >>>               return -ENXIO;
> >>> diff --git a/drivers/gpu/drm/sti/sti_dvo.c
> >> b/drivers/gpu/drm/sti/sti_dvo.c
> >>> index
> >>
> 4dcddd02629b6a1052be8fb8333bd3aa17c083c5..c877298a7f2bad171724eca4d43ea62=
2db4c81cd
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_dvo.c
> >>> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> >>> @@ -511,7 +511,6 @@ static int sti_dvo_probe(struct platform_device
> >> *pdev)
> >>>  {
> >>>       struct device *dev =3D &pdev->dev;
> >>>       struct sti_dvo *dvo;
> >>> -     struct resource *res;
> >>>       struct device_node *np =3D dev->of_node;
> >>>
> >>>       DRM_INFO("%s\n", __func__);
> >>> @@ -523,14 +522,7 @@ static int sti_dvo_probe(struct platform_device
> >> *pdev)
> >>>       }
> >>>
> >>>       dvo->dev =3D pdev->dev;
> >>> -
> >>> -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "dvo-reg");
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Invalid dvo resource\n");
> >>> -             return -ENOMEM;
> >>> -     }
> >>> -     dvo->regs =3D devm_ioremap(dev, res->start,
> >>> -                     resource_size(res));
> >>> +     dvo->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "dvo-reg");
> >>>       if (!dvo->regs)
> >>>               return -ENOMEM;
> >>>
> >>> diff --git a/drivers/gpu/drm/sti/sti_hda.c
> >> b/drivers/gpu/drm/sti/sti_hda.c
> >>> index
> >>
> 14fdc00d2ba03d4f96ba407ac8e576decb6f32c0..3ca3abb80d425901f4c031edfd327a7=
70d624e1c
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_hda.c
> >>> +++ b/drivers/gpu/drm/sti/sti_hda.c
> >>> @@ -750,14 +750,7 @@ static int sti_hda_probe(struct platform_device
> >> *pdev)
> >>>               return -ENOMEM;
> >>>
> >>>       hda->dev =3D pdev->dev;
> >>> -
> >>> -     /* Get resources */
> >>> -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "hda-reg");
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Invalid hda resource\n");
> >>> -             return -ENOMEM;
> >>> -     }
> >>> -     hda->regs =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> >>> +     hda->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "hda-reg");
> >>>       if (!hda->regs)
> >>>               return -ENOMEM;
> >>>
> >>> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c
> >> b/drivers/gpu/drm/sti/sti_hdmi.c
> >>> index
> >>
> 164a34d793d86f114394048667ae3189e1c39242..c64ce7a1ef58b9ce4429edd368269be=
a87d86984
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> >>> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> >>> @@ -1380,7 +1380,6 @@ static int sti_hdmi_probe(struct platform_devic=
e
> >> *pdev)
> >>>       struct device *dev =3D &pdev->dev;
> >>>       struct sti_hdmi *hdmi;
> >>>       struct device_node *np =3D dev->of_node;
> >>> -     struct resource *res;
> >>>       struct device_node *ddc;
> >>>       int ret;
> >>>
> >>> @@ -1399,15 +1398,7 @@ static int sti_hdmi_probe(struct platform_devi=
ce
> >> *pdev)
> >>>       }
> >>>
> >>>       hdmi->dev =3D pdev->dev;
> >>> -
> >>> -     /* Get resources */
> >>> -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "hdmi-reg");
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Invalid hdmi resource\n");
> >>> -             ret =3D -ENOMEM;
> >>> -             goto release_adapter;
> >>> -     }
> >>> -     hdmi->regs =3D devm_ioremap(dev, res->start, resource_size(res)=
);
> >>> +     hdmi->regs =3D devm_platform_ioremap_resource_byname(pdev,
> >> "hdmi-reg");
> >>>       if (!hdmi->regs) {
> >>>               ret =3D -ENOMEM;
> >>>               goto release_adapter;
> >>> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c
> >> b/drivers/gpu/drm/sti/sti_hqvdp.c
> >>> index
> >>
> 0f658709c9d0d398c4eed65202443db9d0b41f8c..420395598d119a403d531211022e600=
5d6a2bd59
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> >>> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> >>> @@ -1356,7 +1356,6 @@ static int sti_hqvdp_probe(struct platform_devi=
ce
> >> *pdev)
> >>>       struct device *dev =3D &pdev->dev;
> >>>       struct device_node *vtg_np;
> >>>       struct sti_hqvdp *hqvdp;
> >>> -     struct resource *res;
> >>>
> >>>       DRM_DEBUG_DRIVER("\n");
> >>>
> >>> @@ -1367,14 +1366,7 @@ static int sti_hqvdp_probe(struct
> platform_device
> >> *pdev)
> >>>       }
> >>>
> >>>       hqvdp->dev =3D dev;
> >>> -
> >>> -     /* Get Memory resources */
> >>> -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Get memory resource failed\n");
> >>> -             return -ENXIO;
> >>> -     }
> >>> -     hqvdp->regs =3D devm_ioremap(dev, res->start, resource_size(res=
));
> >>> +     hqvdp->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >>>       if (!hqvdp->regs) {
> >>>               DRM_ERROR("Register mapping failed\n");
> >>>               return -ENXIO;
> >>> diff --git a/drivers/gpu/drm/sti/sti_tvout.c
> >> b/drivers/gpu/drm/sti/sti_tvout.c
> >>> index
> >>
> af6c06f448c4819def8cc0d0836e30f991529690..0bebe815f5e7567f84388af93723a6f=
a7d2cc7a2
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_tvout.c
> >>> +++ b/drivers/gpu/drm/sti/sti_tvout.c
> >>> @@ -838,7 +838,6 @@ static int sti_tvout_probe(struct platform_device
> >> *pdev)
> >>>       struct device *dev =3D &pdev->dev;
> >>>       struct device_node *node =3D dev->of_node;
> >>>       struct sti_tvout *tvout;
> >>> -     struct resource *res;
> >>>
> >>>       DRM_INFO("%s\n", __func__);
> >>>
> >>> @@ -850,14 +849,7 @@ static int sti_tvout_probe(struct platform_devic=
e
> >> *pdev)
> >>>               return -ENOMEM;
> >>>
> >>>       tvout->dev =3D dev;
> >>> -
> >>> -     /* get memory resources */
> >>> -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "tvout-reg");
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Invalid glue resource\n");
> >>> -             return -ENOMEM;
> >>> -     }
> >>> -     tvout->regs =3D devm_ioremap(dev, res->start, resource_size(res=
));
> >>> +     tvout->regs =3D devm_platform_ioremap_resource_byname(pdev,
> >> "tvout-reg");
> >>>       if (!tvout->regs)
> >>>               return -ENOMEM;
> >>>
> >>> diff --git a/drivers/gpu/drm/sti/sti_vtg.c
> >> b/drivers/gpu/drm/sti/sti_vtg.c
> >>> index
> >>
> 5ba469b711b5318e9e9e6d8df127fb8933d1fac1..b5353fe774d72fd629ecd3ef75a5d28=
17ca8617f
> >> 100644
> >>> --- a/drivers/gpu/drm/sti/sti_vtg.c
> >>> +++ b/drivers/gpu/drm/sti/sti_vtg.c
> >>> @@ -380,20 +380,12 @@ static int vtg_probe(struct platform_device
> *pdev)
> >>>  {
> >>>       struct device *dev =3D &pdev->dev;
> >>>       struct sti_vtg *vtg;
> >>> -     struct resource *res;
> >>>       int ret;
> >>>
> >>>       vtg =3D devm_kzalloc(dev, sizeof(*vtg), GFP_KERNEL);
> >>>       if (!vtg)
> >>>               return -ENOMEM;
> >>> -
> >>> -     /* Get Memory ressources */
> >>> -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> -     if (!res) {
> >>> -             DRM_ERROR("Get memory resource failed\n");
> >>> -             return -ENOMEM;
> >>> -     }
> >>> -     vtg->regs =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> >>> +     vtg->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >>>       if (!vtg->regs) {
> >>>               DRM_ERROR("failed to remap I/O memory\n");
> >>>               return -ENOMEM;
> >>>
> >>
>
>

--000000000000a3411e062f9ae728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, =
2025 at 3:59=E2=80=AFAM Raphael Gallais-Pou &lt;<a href=3D"mailto:raphael.g=
allais-pou@foss.st.com">raphael.gallais-pou@foss.st.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 3/3/25 18:29, Anusha Srivatsa wrote:<br>
&gt; On Wed, Feb 26, 2025 at 5:19=E2=80=AFAM Raphael Gallais-Pou &lt;<br>
&gt; <a href=3D"mailto:raphael.gallais-pou@foss.st.com" target=3D"_blank">r=
aphael.gallais-pou@foss.st.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; On 2/25/25 23:20, Anusha Srivatsa wrote:<br>
&gt;&gt;&gt; Replace platform_get_resource/_byname + devm_ioremap<br>
&gt;&gt;&gt; with just devm_platform_ioremap_resource()<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Used Coccinelle to do this change. SmPl patch:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @rule@<br>
&gt;&gt;&gt; identifier res;<br>
&gt;&gt;&gt; expression ioremap;<br>
&gt;&gt;&gt; identifier pdev;<br>
&gt;&gt;&gt; constant mem;<br>
&gt;&gt;&gt; expression name;<br>
&gt;&gt;&gt; @@<br>
&gt;&gt;&gt; -struct resource *res;<br>
&gt;&gt;&gt; ...<br>
&gt;&gt;&gt; -res =3D platform_get_resource_byname(pdev,mem,name);<br>
&gt;&gt;&gt; &lt;...<br>
&gt;&gt;&gt; -if (!res) {<br>
&gt;&gt;&gt; -...<br>
&gt;&gt;&gt; -}<br>
&gt;&gt;&gt; ...&gt;<br>
&gt;&gt;&gt; -ioremap =3D devm_ioremap(...);<br>
&gt;&gt;&gt; +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; and<br>
&gt;&gt;&gt; @rule_2@<br>
&gt;&gt;&gt; identifier res;<br>
&gt;&gt;&gt; expression ioremap;<br>
&gt;&gt;&gt; identifier pdev;<br>
&gt;&gt;&gt; @@<br>
&gt;&gt;&gt; -struct resource *res;<br>
&gt;&gt;&gt; ...<br>
&gt;&gt;&gt; -res =3D platform_get_resource(pdev,...);<br>
&gt;&gt;&gt; &lt;...<br>
&gt;&gt;&gt; -if (!res) {<br>
&gt;&gt;&gt; -...<br>
&gt;&gt;&gt; -}<br>
&gt;&gt;&gt; ...&gt;<br>
&gt;&gt;&gt; -ioremap =3D devm_ioremap(...);<br>
&gt;&gt;&gt; +ioremap =3D devm_platform_ioremap_resource(pdev,0);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v2: Fix compilation error.<br>
&gt;&gt;<br>
&gt;&gt; Hi Anusha,<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; You did not take into account my comment regarding the changelog. =
:-)<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://www.kernel.org/doc/html/latest/process/submitti=
ng-patches.html#commentary" rel=3D"noreferrer" target=3D"_blank">https://ww=
w.kernel.org/doc/html/latest/process/submitting-patches.html#commentary</a>=
<br>
&gt;&gt;<br>
&gt;&gt; While the commit summary do not specify the version, this changelo=
g<br>
&gt;&gt; suggests<br>
&gt;&gt; that the version of your series as been incremented.<br>
&gt;&gt; If this is a v2, then a version descriptor should be applied to th=
e<br>
&gt;&gt; patchset.<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://www.kernel.org/doc/html/latest/process/submitti=
ng-patches.html#subject-line" rel=3D"noreferrer" target=3D"_blank">https://=
www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line=
</a><br>
&gt;&gt;<br>
&gt;&gt; Hi=C2=A0 Raphael,<br>
&gt; That is correct. While this patch is a v2, there is another patch or t=
wo in<br>
&gt; the same series that is on v4 when it got acked and reviewed. Having<b=
r>
&gt; patches belonging to the same series with different version prefixes s=
eemed<br>
&gt; odd when I sent the series. Hence added what exactly changed in the co=
mmit<br>
&gt; log.<br>
<br>
<br>
Indeed, the serie version should remain consistent across all patches.<br>
<br>
Maxime told you in an earlier answer, any modification of any patch what so=
 ever<br>
increases the serie version. Thus all patches are at v5 (looking at your la=
test<br>
revision).<br>
<br>
Verbatim from the documentation :<br>
<br>
Other comments relevant only to the moment or the maintainer, not suitable =
for<br>
the permanent changelog, should also go here [under the --- marker]. A good=
<br>
example of such comments might be patch changelogs which describe what has<=
br>
changed between the v1 and v2 version of the patch.<br>
<br>
Please put this information after the --- line which separates the changelo=
g<br>
from the rest of the patch. The version information is not part of the chan=
gelog<br>
which gets committed to the git tree. It is additional information for the<=
br>
reviewers. If it=E2=80=99s placed above the commit tags, it needs manual in=
teraction to<br>
remove it. If it is below the separator line, it gets automatically strippe=
d off<br>
when applying the patch:<br>
<br>
<a href=3D"https://www.kernel.org/doc/html/latest/process/submitting-patche=
s.html#commentary" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.=
org/doc/html/latest/process/submitting-patches.html#commentary</a><br>
<br>
Rapha=C3=ABl<br>
<br></blockquote><div><br></div><div>Thanks Raphael and Maxime for the deta=
iled explanation. I had overlooked this. Shall keep in mind going forward.<=
/div><div><br></div><div>Anusha <br></div><div><br></div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Anusha<br>
&gt;<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Rapha=C3=ABl<br>
&gt;&gt;<br>
&gt;&gt;&gt; Cc: Raphael Gallais-Pou &lt;<a href=3D"mailto:raphael.gallais-=
pou@foss.st.com" target=3D"_blank">raphael.gallais-pou@foss.st.com</a>&gt;<=
br>
&gt;&gt;&gt; Cc: Alain Volmat &lt;<a href=3D"mailto:alain.volmat@foss.st.co=
m" target=3D"_blank">alain.volmat@foss.st.com</a>&gt;<br>
&gt;&gt;&gt; Reviewed-by: Maxime Ripard &lt;<a href=3D"mailto:mripard@kerne=
l.org" target=3D"_blank">mripard@kernel.org</a>&gt;<br>
&gt;&gt;&gt; Acked-by: Raphael Gallais-Pou &lt;<a href=3D"mailto:rgallaispo=
u@gmail.com" target=3D"_blank">rgallaispou@gmail.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Anusha Srivatsa &lt;<a href=3D"mailto:asrivats@=
redhat.com" target=3D"_blank">asrivats@redhat.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_compositor.c | 10 +---------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_dvo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 10 +---------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_hda.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 9 +--------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_hdmi.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 11 +----------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_hqvdp.c=C2=A0 =C2=A0 =C2=A0 | 10=
 +---------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_tvout.c=C2=A0 =C2=A0 =C2=A0 | 10=
 +---------<br>
&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/sti/sti_vtg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 10 +---------<br>
&gt;&gt;&gt;=C2=A0 7 files changed, 7 insertions(+), 63 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 063f82d23d80c4ba83624a0066a18416a2b37351..7aefce6706ba2cd7d97a3322=
8c9b9812edecf06f<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_compositor.c<br>
&gt;&gt;&gt; @@ -177,7 +177,6 @@ static int sti_compositor_probe(struct<br>
&gt;&gt; platform_device *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;o=
f_node;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *vtg_np;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_compositor *compo;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0compo =3D devm_kzalloc(dev, sizeof(*=
compo), GFP_KERNEL);<br>
&gt;&gt;&gt; @@ -194,14 +193,7 @@ static int sti_compositor_probe(struct<br=
>
&gt;&gt; platform_device *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;compo-&gt;data, of_match=
_node(compositor_of_match, np)-&gt;data,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct =
sti_compositor_data));<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory ressources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORES=
OURCE_MEM, 0);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (res =3D=3D NULL) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Get memory resource failed\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO=
;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0compo-&gt;regs =3D devm_ioremap(dev, res-=
&gt;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0compo-&gt;regs =3D devm_platform_ioremap_=
resource(pdev, 0);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (compo-&gt;regs =3D=3D NULL) {<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERRO=
R(&quot;Register mapping failed\n&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENXIO;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 4dcddd02629b6a1052be8fb8333bd3aa17c083c5..c877298a7f2bad171724eca4=
d43ea622db4c81cd<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_dvo.c<br>
&gt;&gt;&gt; @@ -511,7 +511,6 @@ static int sti_dvo_probe(struct platform_d=
evice<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt=
;dev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_dvo *dvo;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;o=
f_node;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;%s\n&quot;, __func__)=
;<br>
&gt;&gt;&gt; @@ -523,14 +522,7 @@ static int sti_dvo_probe(struct platform_=
device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dvo-&gt;dev =3D pdev-&gt;dev;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev=
, IORESOURCE_MEM,<br>
&gt;&gt; &quot;dvo-reg&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Invalid dvo resource\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOME=
M;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0dvo-&gt;regs =3D devm_ioremap(dev, res-&g=
t;start,<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0dvo-&gt;regs =3D devm_platform_ioremap_re=
source_byname(pdev, &quot;dvo-reg&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dvo-&gt;regs)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_hda.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_hda.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 14fdc00d2ba03d4f96ba407ac8e576decb6f32c0..3ca3abb80d425901f4c031ed=
fd327a770d624e1c<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_hda.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_hda.c<br>
&gt;&gt;&gt; @@ -750,14 +750,7 @@ static int sti_hda_probe(struct platform_=
device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hda-&gt;dev =3D pdev-&gt;dev;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* Get resources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev=
, IORESOURCE_MEM,<br>
&gt;&gt; &quot;hda-reg&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Invalid hda resource\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOME=
M;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0hda-&gt;regs =3D devm_ioremap(dev, res-&g=
t;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0hda-&gt;regs =3D devm_platform_ioremap_re=
source_byname(pdev, &quot;hda-reg&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hda-&gt;regs)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 164a34d793d86f114394048667ae3189e1c39242..c64ce7a1ef58b9ce4429edd3=
68269bea87d86984<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_hdmi.c<br>
&gt;&gt;&gt; @@ -1380,7 +1380,6 @@ static int sti_hdmi_probe(struct platfor=
m_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt=
;dev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_hdmi *hdmi;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;o=
f_node;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *ddc;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -1399,15 +1398,7 @@ static int sti_hdmi_probe(struct platfo=
rm_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hdmi-&gt;dev =3D pdev-&gt;dev;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* Get resources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev=
, IORESOURCE_MEM,<br>
&gt;&gt; &quot;hdmi-reg&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Invalid hdmi resource\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOM=
EM;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto release_=
adapter;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0hdmi-&gt;regs =3D devm_ioremap(dev, res-&=
gt;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0hdmi-&gt;regs =3D devm_platform_ioremap_r=
esource_byname(pdev,<br>
&gt;&gt; &quot;hdmi-reg&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hdmi-&gt;regs) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
-ENOMEM;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto rel=
ease_adapter;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 0f658709c9d0d398c4eed65202443db9d0b41f8c..420395598d119a403d531211=
022e6005d6a2bd59<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_hqvdp.c<br>
&gt;&gt;&gt; @@ -1356,7 +1356,6 @@ static int sti_hqvdp_probe(struct platfo=
rm_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt=
;dev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *vtg_np;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_hqvdp *hqvdp;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(&quot;\n&quot;);<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -1367,14 +1366,7 @@ static int sti_hqvdp_probe(struct platf=
orm_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hqvdp-&gt;dev =3D dev;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory resources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORES=
OURCE_MEM, 0);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Get memory resource failed\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO=
;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0hqvdp-&gt;regs =3D devm_ioremap(dev, res-=
&gt;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0hqvdp-&gt;regs =3D devm_platform_ioremap_=
resource(pdev, 0);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hqvdp-&gt;regs) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERRO=
R(&quot;Register mapping failed\n&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENXIO;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; af6c06f448c4819def8cc0d0836e30f991529690..0bebe815f5e7567f84388af9=
3723a6fa7d2cc7a2<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_tvout.c<br>
&gt;&gt;&gt; @@ -838,7 +838,6 @@ static int sti_tvout_probe(struct platform=
_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt=
;dev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *node =3D dev-&gt=
;of_node;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_tvout *tvout;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;%s\n&quot;, __func__)=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -850,14 +849,7 @@ static int sti_tvout_probe(struct platfor=
m_device<br>
&gt;&gt; *pdev)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tvout-&gt;dev =3D dev;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* get memory resources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev=
, IORESOURCE_MEM,<br>
&gt;&gt; &quot;tvout-reg&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Invalid glue resource\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOME=
M;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0tvout-&gt;regs =3D devm_ioremap(dev, res-=
&gt;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0tvout-&gt;regs =3D devm_platform_ioremap_=
resource_byname(pdev,<br>
&gt;&gt; &quot;tvout-reg&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tvout-&gt;regs)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt;&gt; b/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt;&gt;&gt; index<br>
&gt;&gt; 5ba469b711b5318e9e9e6d8df127fb8933d1fac1..b5353fe774d72fd629ecd3ef=
75a5d2817ca8617f<br>
&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/sti/sti_vtg.c<br>
&gt;&gt;&gt; @@ -380,20 +380,12 @@ static int vtg_probe(struct platform_dev=
ice *pdev)<br>
&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt=
;dev;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sti_vtg *vtg;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vtg =3D devm_kzalloc(dev, sizeof(*vt=
g), GFP_KERNEL);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vtg)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0/* Get Memory ressources */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORES=
OURCE_MEM, 0);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!res) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&qu=
ot;Get memory resource failed\n&quot;);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOME=
M;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0vtg-&gt;regs =3D devm_ioremap(dev, res-&g=
t;start, resource_size(res));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0vtg-&gt;regs =3D devm_platform_ioremap_re=
source(pdev, 0);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vtg-&gt;regs) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERRO=
R(&quot;failed to remap I/O memory\n&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENOMEM;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000a3411e062f9ae728--



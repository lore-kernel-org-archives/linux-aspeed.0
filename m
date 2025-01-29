Return-Path: <linux-aspeed+bounces-585-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4DFC02190
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jan 2025 22:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjyFJ1jdPz30TQ;
	Thu, 30 Jan 2025 09:56:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738173633;
	cv=none; b=mnpDFEj/qI6VHaaAP3dAMOlcpUPVxcICrrXQ5d/Cv4B56mo1HVURXxf4IIRbC2sZ5lL2PkrvCTZHRq162Zlgh1p0LUWVS2YoyZmDUsW4Rii9Ebdjau0ouyfWVss9Z2jYRvYBe8SThRq7LqmDTtbTOMWonPYtHDoWaU5ZNzEp8oQ73lVPyaRAdlk2kHexpBbajHBFSZ9Zx8fNTi2awRmvOrpYn3ngkBN1Ykoq1HWWT3QYDM/AwZEVpyGa5b7NvZ3PN+M4NqS7D6MdR0BZedDRtnZdv/w/Qav9uYIu/DPy+bCe4boctcOVFOSU7k1q29Ws+Boec/NXB8YhTr25+LyXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738173633; c=relaxed/relaxed;
	bh=nqyDkjvRUysrwh4PELuHmLTFtieFiuB96Vrt8jInMXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aep+U+FrGzx3v5BoGZSaT+u5U7YRgjCdP7DPRtL8NQ44XQax5o4w98I88D3KuHnYv7LQgUCHzZ1lx43ToPlnzf4bu6iTFVX2gVDw95ceRmbxvo8JF7FChm21yvsIxmd0FxxHfU6tMDgz9Qm90byD3gXJaZNE36n6pA4nubZM3OJsA4aX+eZdDVuazdSpGpeDCn4HTx2ad/RpdKHs2EBb5Cr7/upd83TzCm6zK5cpDOgZZu1aunuoiYSgH4aiTHQ3Z6FazsVBYsSuUvygdSWprd6YECysk0Elr2dKo+NPjqC6iwwj5dGib9zQkXGMt7eeB8u0MBU1C+NmCLQGHGnGfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOQ76sYl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOQ76sYl; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOQ76sYl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOQ76sYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yjqgx24j9z2ywC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 05:00:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738173622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqyDkjvRUysrwh4PELuHmLTFtieFiuB96Vrt8jInMXw=;
	b=DOQ76sYlMNCTPDYSc2bow1cnXCLpefLGSpfVtE0ujqJcRErPELJcxbd7lOZdFvdMWg1uke
	lzRJT0V2T+qgyglSHPi3hxekH9cAk+PqFdIKBt29CuVmx/Z59dONPCVvTjn0Itme3Xbf3t
	OIRWPtZufVgrze9jCAvj1ZU4Xa6zErc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738173622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqyDkjvRUysrwh4PELuHmLTFtieFiuB96Vrt8jInMXw=;
	b=DOQ76sYlMNCTPDYSc2bow1cnXCLpefLGSpfVtE0ujqJcRErPELJcxbd7lOZdFvdMWg1uke
	lzRJT0V2T+qgyglSHPi3hxekH9cAk+PqFdIKBt29CuVmx/Z59dONPCVvTjn0Itme3Xbf3t
	OIRWPtZufVgrze9jCAvj1ZU4Xa6zErc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Ak8JJBOHOiWWKp1qTifL1w-1; Wed, 29 Jan 2025 13:00:19 -0500
X-MC-Unique: Ak8JJBOHOiWWKp1qTifL1w-1
X-Mimecast-MFC-AGG-ID: Ak8JJBOHOiWWKp1qTifL1w
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e399d4ef55cso19328723276.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 10:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738173618; x=1738778418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqyDkjvRUysrwh4PELuHmLTFtieFiuB96Vrt8jInMXw=;
        b=WtXozYgXkD4osonuiGM5WvdUKD6Tm255rzhzg9GuC0z9qvf49l4D94nqSUWE9gCZr9
         tDmaHnM9+xlpYvNXTyJONHOkIfRfijTybCTSGQ3vFqYproWcuhykNVHwWys+kV8jMGA0
         dTI5xwwUaeKPUqbPY2CVdZInJFURnlkcUUxv5zIYc9dBC0Vt0XDabrewd8evzxJ1eexL
         AYICAzv7oKXCSBMG/wVbpzwRS7ypTZsWzJV/tolbJc4vZtnl4jsyaFNSZoSj/7LoNjHK
         8DdlhelayLxoaAtYjUdcgC0NgRMzQ031tWLnlO7I8lSpSRcai/xKkw8GwjFOSDZCjEzz
         3RXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiGxbDh1VcZUiaIBHfY0VMZXq1F9uuAzFOe3nqQIl2fk+4Ym05gZBTNLnAmAmM4/uIDfzskkNrEb3cV4o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9VmlWKlHKK2qVvOP1j2Cb7NchUj3I0tks2Uw49ywFai77QMeq
	GIQQLk4NhpWq+E8IkYlfzAIsE/1KDZYirhqtlOD/+DQ17buTFf6HFtmoz60rWqyc1EDG7PhkX8+
	imLElB30kwlXn44wjkJ7/5MiTtq7wU3xdCksU81Fys81FGIai5tHi70neL5Ugx8Oyk5Ye0YEJVV
	7pBcUnGX+qvdMwOEDbIoyn76Z+RqnyNBdPLqXzzA==
X-Gm-Gg: ASbGncs6+gJ/BM3+OaHIV5+YbsS2eO8uY8opN1tGqHEwDfb3hTbc06ydIH02B1VJtk0
	ZD5oYAO8I5QdBCxe7iWvFWg4EPXFToowZrDNEiiv59xX1ips7nkcBlbQqLnDz
X-Received: by 2002:a05:690c:6b0e:b0:6ef:8c41:dee0 with SMTP id 00721157ae682-6f7a837a551mr33579857b3.20.1738173618114;
        Wed, 29 Jan 2025 10:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNwNDB7SeoR2hOqJ83NGvf+7/6aagiTUDM5yFm91TKvfpUEtQemjfCIOkHEzx0pR6XBCyUXQDsQ7LBiLTNnPI=
X-Received: by 2002:a05:690c:6b0e:b0:6ef:8c41:dee0 with SMTP id
 00721157ae682-6f7a837a551mr33578737b3.20.1738173617562; Wed, 29 Jan 2025
 10:00:17 -0800 (PST)
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
 <20250128-cocci-memory-api-v1-13-0d1609a29587@redhat.com> <CAPY8ntBvJpSFhOwqBPmiN59Z0EpienEm-=M-euHdQU8XLGgXUA@mail.gmail.com>
In-Reply-To: <CAPY8ntBvJpSFhOwqBPmiN59Z0EpienEm-=M-euHdQU8XLGgXUA@mail.gmail.com>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 29 Jan 2025 13:00:06 -0500
X-Gm-Features: AWEUYZkNBFsPsHrKCDC5xJ-gNE5tqY69PNKeLsi61kNwK-N1agru8qUFF63-ZWw
Message-ID: <CAN9Xe3SbqYNqZzPtywWOX3Uj3a76GT7pDBwaa=YM2zWAcGj8Gg@mail.gmail.com>
Subject: Re: [PATCH 13/14] drm/vc4: move to devm_platform_ioremap_resource() usage
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
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
	Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Alexey Brodkin <abrodkin@synopsys.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GiHUUbEaHmQOYJFxQ0CFRKBGuBVhs_HxmyIReg3gObw_1738173618
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000087f3b062cdc15a4"

--000000000000087f3b062cdc15a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:18=E2=80=AFAM Dave Stevenson <
dave.stevenson@raspberrypi.com> wrote:

> Hi Anusha
>
> On Tue, 28 Jan 2025 at 22:33, Anusha Srivatsa <asrivats@redhat.com> wrote=
:
> >
> > Replace platform_get_resource_byname + devm_ioremap_resource
> > with just devm_platform_ioremap_resource()
> >
> > Used Coccinelle to do this change. SmPl patch:
> > //rule s/(devm_)platform_get_resource_byname +
> > //(devm_)ioremap/devm_platform_ioremap_resource.
> > @rule_3@
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
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Cc: "Ma=C3=ADra Canal" <mcanal@igalia.com>
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c
> b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index
> 47d9ada98430634cfd8c1e21c2a4d00d501bab7e..e22733f8159aa4b247a915e24a236f6=
20bae932c
> 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -2951,15 +2951,10 @@ static int vc5_hdmi_init_resources(struct
> drm_device *drm,
> >  {
> >         struct platform_device *pdev =3D vc4_hdmi->pdev;
> >         struct device *dev =3D &pdev->dev;
> > -       struct resource *res;
> >         int ret;
> >
> > -       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdm=
i");
> > -       if (!res)
> > -               return -ENODEV;
> > -
> > -       vc4_hdmi->hdmicore_regs =3D devm_ioremap(dev, res->start,
> > -                                              resource_size(res));
> > +       vc4_hdmi->hdmicore_regs =3D
> devm_platform_ioremap_resource_byname(pdev,
> > +
>  "hdmi");
>
> Whilst I totally agree with this change, why was only one of the 8
> instances of this pattern within this function updated? Is that a
> limitation in your script?
>
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/vc4/vc4_hdm=
i.c#L2957-L3020
>
>
Yes! looks like it is. My script is missing one set of ellipses which makes
it apply the rule only to the first appearance of the pattern. Will rectify
this. Thanks!!

Anusha

>   Dave
>
> >         if (!vc4_hdmi->hdmicore_regs)
> >                 return -ENOMEM;
> >
> >
> > --
> > 2.47.0
> >
>
>

--000000000000087f3b062cdc15a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 29,=
 2025 at 8:18=E2=80=AFAM Dave Stevenson &lt;<a href=3D"mailto:dave.stevenso=
n@raspberrypi.com">dave.stevenson@raspberrypi.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Anusha<br>
<br>
On Tue, 28 Jan 2025 at 22:33, Anusha Srivatsa &lt;<a href=3D"mailto:asrivat=
s@redhat.com" target=3D"_blank">asrivats@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Replace platform_get_resource_byname + devm_ioremap_resource<br>
&gt; with just devm_platform_ioremap_resource()<br>
&gt;<br>
&gt; Used Coccinelle to do this change. SmPl patch:<br>
&gt; //rule s/(devm_)platform_get_resource_byname +<br>
&gt; //(devm_)ioremap/devm_platform_ioremap_resource.<br>
&gt; @rule_3@<br>
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
&gt; Cc: Maxime Ripard &lt;<a href=3D"mailto:mripard@kernel.org" target=3D"=
_blank">mripard@kernel.org</a>&gt;<br>
&gt; Cc: Dave Stevenson &lt;<a href=3D"mailto:dave.stevenson@raspberrypi.co=
m" target=3D"_blank">dave.stevenson@raspberrypi.com</a>&gt;<br>
&gt; Cc: &quot;Ma=C3=ADra Canal&quot; &lt;<a href=3D"mailto:mcanal@igalia.c=
om" target=3D"_blank">mcanal@igalia.com</a>&gt;<br>
&gt; Signed-off-by: Anusha Srivatsa &lt;<a href=3D"mailto:asrivats@redhat.c=
om" target=3D"_blank">asrivats@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ++-------<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_=
hdmi.c<br>
&gt; index 47d9ada98430634cfd8c1e21c2a4d00d501bab7e..e22733f8159aa4b247a915=
e24a236f620bae932c 100644<br>
&gt; --- a/drivers/gpu/drm/vc4/vc4_hdmi.c<br>
&gt; +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c<br>
&gt; @@ -2951,15 +2951,10 @@ static int vc5_hdmi_init_resources(struct drm_=
device *drm,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *pdev =3D vc4_=
hdmi-&gt;pdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;=
dev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev,=
 IORESOURCE_MEM, &quot;hdmi&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!res)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hdmicore_regs =3D devm_iorema=
p(dev, res-&gt;start,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hdmicore_regs =3D devm_platfo=
rm_ioremap_resource_byname(pdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;hdmi&quot;);<br>
<br>
Whilst I totally agree with this change, why was only one of the 8<br>
instances of this pattern within this function updated? Is that a<br>
limitation in your script?<br>
<a href=3D"https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/vc=
4/vc4_hdmi.c#L2957-L3020" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/torvalds/linux/blob/master/drivers/gpu/drm/vc4/vc4_hdmi.c#L2957-L302=
0</a><br>
<br></blockquote><div><br></div><div>Yes! looks like it is. My script is mi=
ssing one set of ellipses which makes it apply the rule only to the first a=
ppearance of the pattern. Will rectify this. Thanks!!</div><div><br></div><=
div>Anusha<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 Dave<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vc4_hdmi-&gt;hdmicore_regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
NOMEM;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; 2.47.0<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000087f3b062cdc15a4--



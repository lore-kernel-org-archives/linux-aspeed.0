Return-Path: <linux-aspeed+bounces-696-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C29C021A1
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Feb 2025 22:46:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YsxPn4nsZz2yVT;
	Wed, 12 Feb 2025 09:46:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739293760;
	cv=none; b=mH6EHy3wigws4sCKlsvzLRidtsjW9MX4R2hFeoIJ5qTDXNBcVbd5spTDG+moS3ge4VY9KpVEzw41FSnmj90zAmYp8adz+L2HBMKbnWNegcupvLxCRxBH05KR1gc4hwEAoxjSsSTYQACQx3RnYw6cUyvj3hq9KtRiwTte03HoWG+TNl5e+5NPwarbpRRKBipScITPhiu4QAiUWVKZqxL8GiMJx4wRdmqH4F1GOGfjfWuGn25TI4sYmsIe1S5YkOVJejytQkj1/0xxQ3FZjQGRwNnf5yMZAVoW69SM0oNpsx9akgdcmZ4bRDNuqbKz1OJoErJ7f5kUbIKKOG7GtmeUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739293760; c=relaxed/relaxed;
	bh=6KqtiPP9cAbKw9pLfJEtjIYHOv1qD2Gmu69RxwYEKDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2V0SxYJiNl9OY0+vW8n75Et00QUqU3sNLz0jPBViyJ4cNHol4p1ESFbDcZEYXeZ+sQeVvYHUwrTkpruIfyCDHz27Fvh8+R7WFfNdKhRngBbOXyyMA5EhvMhyh0YuaJrDiVp8Nuo2DlBfpoiYOHuuocd41cw4BUT2GiplVJAZJXnF/agp0W+y1bF/Dju6Tegecs4i7JJBsMubXbqUOrNIiGeoYsZ0hJzpkx6sbKed6Jndb4rxxnv8BD0R+mTKG7UkzuF1Zne1YqKr2vHR6ElBJZTFrwN1lpEEfdqFN8rodoM2M8Rfizvqg76VvlszJ/YDne2/9i2mj4qfpogod/g3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERypdz9/; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERypdz9/; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERypdz9/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERypdz9/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysnwt6Vr3z30J8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 04:09:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739293752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KqtiPP9cAbKw9pLfJEtjIYHOv1qD2Gmu69RxwYEKDs=;
	b=ERypdz9/HgePkHbYSQ2eHs25/7AKSc3j7kPNsB9II0YoSFDoQn/N2Iu6nBtdgSbutIVbem
	zSMymg+9T8Ow7VwKYesMgIBCYAFRBYqdOrxM6m8xQPNr0e9Wpy1/B2tOwkh2iK9KwbPPbI
	v7ljWYYzTaQxjF+REq/RGZ4FmA2FkpA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739293752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KqtiPP9cAbKw9pLfJEtjIYHOv1qD2Gmu69RxwYEKDs=;
	b=ERypdz9/HgePkHbYSQ2eHs25/7AKSc3j7kPNsB9II0YoSFDoQn/N2Iu6nBtdgSbutIVbem
	zSMymg+9T8Ow7VwKYesMgIBCYAFRBYqdOrxM6m8xQPNr0e9Wpy1/B2tOwkh2iK9KwbPPbI
	v7ljWYYzTaQxjF+REq/RGZ4FmA2FkpA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-KM79UTrGOhCwpVMSH6gTsw-1; Tue, 11 Feb 2025 12:09:10 -0500
X-MC-Unique: KM79UTrGOhCwpVMSH6gTsw-1
X-Mimecast-MFC-AGG-ID: KM79UTrGOhCwpVMSH6gTsw
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6f2b082731eso65161447b3.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Feb 2025 09:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293750; x=1739898550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KqtiPP9cAbKw9pLfJEtjIYHOv1qD2Gmu69RxwYEKDs=;
        b=PD9oXn7XQ/t9egTkB+N8CtFeW32dAt2stCpIj5O7cz0gXePjm4IatCOmVioHHoCDZE
         UUrC1bAejHf3P6NuualQZgKff0zns0El02PkW6M+vUYSXj6Tgq5KS4VdJPBcgY695HZh
         iM7OagYGTq97nXrSPcBzQ8p/68mHaCfXQWNjfb3+IBgrSAVpOsfm+f2ILCVzkII1Li/n
         sHym5VmzsyJeHVex40+UrV+MBZxxzRy++LSmg6BuiG5+1o00OHThXoqPqzSOGDcAVjWl
         JfEyR50jskUq/szwLl9yB5+Eek7xVgWjFsXCELTc8iOhftVjgWSgvcv6211bl8neF8bJ
         RNWw==
X-Forwarded-Encrypted: i=1; AJvYcCW1KJD4Yf9BzAdtPVa8jVTrI5CaY2giwqdSrubteifhnaZsRMkU6nYtjoOb105aRv1ZnQHO4L27zm+6fm8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzesjyShUwLJMqEuhPfYyROzqX36ug9PwDB3FdSPQQGB/VF9+Xj
	LB8rvY1IUUPCUenr52YBMOzBEnl0aViWhI8sjCjenSNnLP2xlUWMUMvfun1Ck2us5ocqGBeKAu1
	ez3D3azEESJmus7nHPynkx5MAkAxSL27HmoviWk0fYq32jpopgycyGZkQcS55TxhyEIx5RhAqKo
	sZxH4UqsVHJPLqwv2f7nOck+W8GJERVXPg2b8RBg==
X-Gm-Gg: ASbGncuL1PMpicQy5dyyLOyxS3C9XalrGirW2tki/e90ILqfLUW3RI41JGHKk9hJZ1Z
	/unoye5TAeXRpnFSesXBuJgMpBRCA0I+ZELqMCw2B4jZgnARRNF1npKSJUKxd
X-Received: by 2002:a05:690c:620b:b0:6f7:598d:34c2 with SMTP id 00721157ae682-6fb1f68334dmr2317587b3.24.1739293749958;
        Tue, 11 Feb 2025 09:09:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfKa1KCPRXDPfQeav0M9USwT61j5FjOY5ty4cMA/v4gmNerkCy0F091v6rJjoChnCBHioJN5La+YrVT3vOwcs=
X-Received: by 2002:a05:690c:620b:b0:6f7:598d:34c2 with SMTP id
 00721157ae682-6fb1f68334dmr2315547b3.24.1739293748119; Tue, 11 Feb 2025
 09:09:08 -0800 (PST)
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
References: <20250205-mem-cocci-newapi-v1-0-aebf2b0e2300@redhat.com>
 <20250205-mem-cocci-newapi-v1-11-aebf2b0e2300@redhat.com> <20250206-hallowed-ultra-tiger-cfec8e@houat>
In-Reply-To: <20250206-hallowed-ultra-tiger-cfec8e@houat>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 11 Feb 2025 12:08:57 -0500
X-Gm-Features: AWEUYZnpF-xtMX2zoqL1SmW6M0UxWIfNDoln_2D_Wz78SFwXrsyRItY4Zv4vDPk
Message-ID: <CAN9Xe3SpTG7r2UkN7_pH0uMXhU5u+dkWhaM9+w5VyOQZp9byNg@mail.gmail.com>
Subject: Re: [PATCH 11/12] drm/vc4: move to devm_platform_ioremap_resource() usage
To: Maxime Ripard <mripard@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Marek Vasut <marex@denx.de>, 
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
	Alexey Brodkin <abrodkin@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GyvFKLKMcCZqiLKLnQI37XjYQZzZxgogx0dKCvKYqaw_1739293750
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000004607d062de0e274"

--00000000000004607d062de0e274
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 11:13=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:

> On Wed, Feb 05, 2025 at 03:08:07PM -0500, Anusha Srivatsa wrote:
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
> > <+...
> > -res =3D platform_get_resource_byname(pdev,mem,name);
> > <...
> > -if (!res) {
> > -...
> > -}
> > ...>
> > -ioremap =3D devm_ioremap(...);
> > +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);
> > ...+>
> >
> > v2: Change the SmPl patch to work on multiple occurences of
> > the pattern. This also fixes the compilation error.
> >
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Cc: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 55
> +++++++++++-------------------------------
> >  1 file changed, 14 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c
> b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index
> 47d9ada98430634cfd8c1e21c2a4d00d501bab7e..066f1246dab420ee889845b0c573d80=
ce7c88595
> 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -2951,71 +2951,44 @@ static int vc5_hdmi_init_resources(struct
> drm_device *drm,
> >  {
> >       struct platform_device *pdev =3D vc4_hdmi->pdev;
> >       struct device *dev =3D &pdev->dev;
> > -     struct resource *res;
> >       int ret;
> >
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdmi"=
);
> > -     if (!res)
> > -             return -ENODEV;
> > -
> > -     vc4_hdmi->hdmicore_regs =3D devm_ioremap(dev, res->start,
> > -                                            resource_size(res));
> > +     vc4_hdmi->hdmicore_regs =3D
> devm_platform_ioremap_resource_byname(pdev,
> > +
>  "hdmi");
> >       if (!vc4_hdmi->hdmicore_regs)
> >               return -ENOMEM;
> >
> > -     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hd");
> > -     if (!res)
> > -             return -ENODEV;
> > -
> > -     vc4_hdmi->hd_regs =3D devm_ioremap(dev, res->start,
> resource_size(res));
> > +     vc4_hdmi->hd_regs =3D devm_platform_ioremap_resource_byname(pdev,
> "hd");
> >       if (!vc4_hdmi->hd_regs)
> >               return -ENOMEM;
>
> I *think* that one is shared between both HDMI controllers on the
> RaspberryPi4, so we can't claim them from both instances. We should add
> a comment there to document that it's on purpose.
>
> How about vc4_hdmi->hdmicore_regs? It also has another instance
vc4_hdmi_init_resources(). Looks like that also doesnt need any converting
and shold be left as is.

Anusha

> The rest looks good.
>
> Maxime
>

--00000000000004607d062de0e274
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 6, =
2025 at 11:13=E2=80=AFAM Maxime Ripard &lt;<a href=3D"mailto:mripard@kernel=
.org">mripard@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Wed, Feb 05, 2025 at 03:08:07PM -0500, Anusha Sr=
ivatsa wrote:<br>
&gt; Replace platform_get_resource_byname + devm_ioremap_resource<br>
&gt; with just devm_platform_ioremap_resource()<br>
&gt; <br>
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
&gt; &lt;+...<br>
&gt; -res =3D platform_get_resource_byname(pdev,mem,name);<br>
&gt; &lt;...<br>
&gt; -if (!res) {<br>
&gt; -...<br>
&gt; -}<br>
&gt; ...&gt;<br>
&gt; -ioremap =3D devm_ioremap(...);<br>
&gt; +ioremap =3D devm_platform_ioremap_resource_byname(pdev,name);<br>
&gt; ...+&gt;<br>
&gt; <br>
&gt; v2: Change the SmPl patch to work on multiple occurences of<br>
&gt; the pattern. This also fixes the compilation error.<br>
&gt; <br>
&gt; Cc: Maxime Ripard &lt;<a href=3D"mailto:mripard@kernel.org" target=3D"=
_blank">mripard@kernel.org</a>&gt;<br>
&gt; Cc: Dave Stevenson &lt;<a href=3D"mailto:dave.stevenson@raspberrypi.co=
m" target=3D"_blank">dave.stevenson@raspberrypi.com</a>&gt;<br>
&gt; Cc: Ma=C3=ADra Canal &lt;<a href=3D"mailto:mcanal@igalia.com" target=
=3D"_blank">mcanal@igalia.com</a>&gt;<br>
&gt; Signed-off-by: Anusha Srivatsa &lt;<a href=3D"mailto:asrivats@redhat.c=
om" target=3D"_blank">asrivats@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/vc4/vc4_hdmi.c | 55 +++++++++++-----------------=
--------------<br>
&gt;=C2=A0 1 file changed, 14 insertions(+), 41 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_=
hdmi.c<br>
&gt; index 47d9ada98430634cfd8c1e21c2a4d00d501bab7e..066f1246dab420ee889845=
b0c573d80ce7c88595 100644<br>
&gt; --- a/drivers/gpu/drm/vc4/vc4_hdmi.c<br>
&gt; +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c<br>
&gt; @@ -2951,71 +2951,44 @@ static int vc5_hdmi_init_resources(struct drm_=
device *drm,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *pdev =3D vc4_hdmi-&g=
t;pdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;hdmi&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hdmicore_regs =3D devm_ioremap(dev, =
res-&gt;start,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hdmicore_regs =3D devm_platform_iore=
map_resource_byname(pdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;hdmi&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vc4_hdmi-&gt;hdmicore_regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(pdev, IORESO=
URCE_MEM, &quot;hd&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!res)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hd_regs =3D devm_ioremap(dev, res-&g=
t;start, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vc4_hdmi-&gt;hd_regs =3D devm_platform_ioremap_re=
source_byname(pdev, &quot;hd&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vc4_hdmi-&gt;hd_regs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
<br>
I *think* that one is shared between both HDMI controllers on the<br>
RaspberryPi4, so we can&#39;t claim them from both instances. We should add=
<br>
a comment there to document that it&#39;s on purpose.<br>
<br></blockquote><div>How about vc4_hdmi-&gt;hdmicore_regs? It also has ano=
ther instance vc4_hdmi_init_resources(). Looks like that also doesnt need a=
ny converting and shold be left as is.</div><div><br></div><div>Anusha<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
The rest looks good.<br>
<br>
Maxime<br>
</blockquote></div></div>

--00000000000004607d062de0e274--



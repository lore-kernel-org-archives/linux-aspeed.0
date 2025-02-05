Return-Path: <linux-aspeed+bounces-667-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB6C02192
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 22:51:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpFpC2Hn6z305m;
	Thu,  6 Feb 2025 09:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738775782;
	cv=none; b=IAS1Yf4DsqjnDlXxvKiqNG5JX5OOrHlUpaNKiZ2PvvbgPktWiGa0+KZmIghj85GapLnP/7fpjF4kkAlbYjt2SLespaAow0rghtFqvwkKBUrkdrn7jWdJ1IDRs6fqZ43MPNW1m85u8Ocn6lVaXu7m3SYNxV9xJtc/zrB21bb6RpV7rxee0bf8xpH0W8iYL3e/Xuimg7hb9URdzeye+jBIz2dKUdsNBXPZW7ExdkIrQ5MfLVCYQSPeVnF3juklAPU0VVuemtWfac7o5ecojLUS7l5+4PNZU+DdqeSGvEM0P3cNiBikf/LLaKfJW/ZFJ3vypkfI0fPzqWDv1wHAyJmB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738775782; c=relaxed/relaxed;
	bh=zeSidYCdYJnARtwshAoVNn6AXIZ4ayw7DuR83E+9hlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP+1M73ESpUfjUp6x5R4/H6QWVIWKSrAdPTSFEcpPfLmAh6YkdtVzrXWUXyj4BzAHUcTXIGOYMK3mjJ8+6lL+NpfyPCHlIGrUTxww0QaxK66DGpIFbCbK7uOXDYlrqzdgJMCuoBG1iEBc6t/l06J+4R3FFlNUwwLotxlT6M+51Dz9nNtQjo+d9G2g3Yb+C43x1S/wxeVCMTuwS/PAJxuyYUFz86izikJgc8VgrUf3KQmSUGLjGSvqQNUOVtGeS6OefMVWZfWv65RwZj+/C3GDzNzmZdEw/TQm+F1f6c9RdcvGL7ijpjARJIwxpYUrVNYHWwEkNUK4PugyqZylDZZVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejkGPFJi; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OzVljpOy; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejkGPFJi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OzVljpOy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yp6Mn33B9z2xJ8
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Feb 2025 04:16:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738775775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zeSidYCdYJnARtwshAoVNn6AXIZ4ayw7DuR83E+9hlo=;
	b=ejkGPFJiif/LRtUA5EKrAsnn8tsdPUmtc3eWWBda6Gcxe1FnBdSNXZ7AZjlnN4qp/i2JtP
	v4ZHuxVI2LSCBSfyXvy449GMm4cl27XbNGKx9vcAjm/JIumnuR3ssHBXtJb0c7Tka4WioN
	wm5lnmHYo+K9XNl2EwrHCIUz8l69IVA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738775776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zeSidYCdYJnARtwshAoVNn6AXIZ4ayw7DuR83E+9hlo=;
	b=OzVljpOyisTd20SPRvgNRNsbWfedGsLmPTglCktx5xMb/5RH57A+g/zLagsXcWNQE7/KIK
	UHt2voSmcWKVMsmZIE78PfKraQWdJb8aZsx4xZiHnzxTRPes2Cc2lqKlXZR+K+iAcBrAAn
	lNubUL18yCsq3U8DZHPNP5djw37/3GI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-iVCuChiANkqqSJGEhdQHuw-1; Wed, 05 Feb 2025 12:16:13 -0500
X-MC-Unique: iVCuChiANkqqSJGEhdQHuw-1
X-Mimecast-MFC-AGG-ID: iVCuChiANkqqSJGEhdQHuw
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f46924f63eso14503287b3.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Feb 2025 09:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775773; x=1739380573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeSidYCdYJnARtwshAoVNn6AXIZ4ayw7DuR83E+9hlo=;
        b=dMyPCvOh6VxkDKkzBtzu98AxSaY7BsKUMBnvL6018I9mCX+B+MA7qrgWNUmtFfs6EK
         AoXrjOXfnuAJBwBX0zfRD7nk3kulMGprZNPOxwoUHSEiwiE9MPOl1VL+Cd9+rAAwDESF
         AlU0GMiYBgFyIxHKJmcAVCQzM9nXRrAkknqHPrZB3+wZmeytrqeP9OoiD1T9f+pSwVTQ
         ySsUWMlEoeAg9Dpo19FLx2N3sH1MJBF5bp/rk+tLZX5aZ3spMrbnlYfmfrqGGjTkGuUq
         3DqQDT7wPfTNE3pBFuzlKR2zv6qJie8EKY3T5neKnbEldZIsoMQj5Awo4qosLPLGORQU
         weGw==
X-Forwarded-Encrypted: i=1; AJvYcCWdIL5VaC0XuwR0WBMPHABJ5gWGQTzrONuje4TwbR4nOPk849Yqf9XOyMydleQSEjnZ4VT4oKUxNTIxCRg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw7bZmIc90Upl1nvar3dHydAJfjjIklqCGxYSc1YywvAG/zh9R4
	8/vtLqyXxoVqvvRpKX8CMsqImrUg2AHTFXKLCZi6Rv24t/Hrlk0vCXjvVFwkedyif/o04cw9xot
	3+FOTFPI3R8Gt/8Pb0WONDNx1PXWGOiE1NLWY483sbYaGRfTKUimnLCeFDywBS+mfDmWeZu+xkV
	+9DzuRB+IdmZHCV4EPP1ozANoamTKLZ1gs2UxPhg==
X-Gm-Gg: ASbGnctg3yfHyYosq3svrB+liP4bL1gkMNXc/I4nTZ2LW8r3It6AgGaLwA+vEPSdyA2
	wrATRBB42Wa/3dJKnf19xv4r/AKSzJAQEfTzxhdcWSc61ioyQhfhIp7f2Xwkl
X-Received: by 2002:a05:690c:6c0c:b0:6f9:4195:8195 with SMTP id 00721157ae682-6f99a60b0cdmr1342277b3.15.1738775773244;
        Wed, 05 Feb 2025 09:16:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo2HkXE9/PB8TiTOCOmlpYI4+BLO/SI3ZFeKcGKfVuRa8aoXdOtxFKnY5ClyavR5vDRDWGBJn3fTqfR8+aXmM=
X-Received: by 2002:a05:690c:6c0c:b0:6f9:4195:8195 with SMTP id
 00721157ae682-6f99a60b0cdmr1341537b3.15.1738775772906; Wed, 05 Feb 2025
 09:16:12 -0800 (PST)
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
 <20250128-cocci-memory-api-v1-14-0d1609a29587@redhat.com> <a389f799-442e-45f3-8609-2eb2f0b7a825@suse.de>
 <li2awsqmdoye3u7n3gi2mrhbfxs77e3edjmsg5zclnyjinsnul@2bjkc5agyu5u> <0ae17de1-c6dc-48eb-aed2-b099b2abbea5@suse.de>
In-Reply-To: <0ae17de1-c6dc-48eb-aed2-b099b2abbea5@suse.de>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 5 Feb 2025 12:16:02 -0500
X-Gm-Features: AWEUYZllqvGkhQf1gMIyypHoBPrhgiNdZ-ww_BiUqVz8q-uL_n50cYGcicLCGMU
Message-ID: <CAN9Xe3S3E_LzU7zF1UCE7fD9OE2bU7BcLy6xQOQk2s7=k+6v=A@mail.gmail.com>
Subject: Re: [PATCH 14/14] Documentation: Update the todo
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
	Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Alexey Brodkin <abrodkin@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yp8IlWvYOP901ArPRf3IqY3kxFj3yvlPsnPTsbb4H10_1738775773
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000049d89e062d68488b"

--00000000000049d89e062d68488b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 7:53=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de>
wrote:

> Hi Maxime
>
>
> Am 29.01.25 um 15:31 schrieb Maxime Ripard:
> > Hi Thomas,
> >
> > On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:
> >> Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:
> >>> Remove the TODO now that this series addresses
> >>> the changes needed.
> >> While your series is fine, this TODO item is unrelated. It's about
> various
> >> ancient fbdev drivers that do not reserve their memory regions
> correctly. So
> >> please drop patch 14 form the series.
> > Is it? Could we rephrase the entry then? I'm the one that suggested
> > Anusha to work on this, and it's still not clear to me what it means
> > exactly if it's not what she worked on :)
>
> I guess, we could make this more precise.
>
> Some old graphics drivers don't request their memory ranges correctly.
> It's usually a problem with hardware that has exclusive ranges, such as
> the VGA. Vga16fb doesn't request the range as it should. Someone needs
> to audit all those old drivers and fix them.
>
>
This sounds like a good next approach. I will make the documentation more
clear.

Thanks for feedback everyone!

Anusha

> Best regards
> Thomas
>
>
> >
> > Maxime
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>

--00000000000049d89e062d68488b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31,=
 2025 at 7:53=E2=80=AFAM Thomas Zimmermann &lt;<a href=3D"mailto:tzimmerman=
n@suse.de">tzimmermann@suse.de</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Maxime<br>
<br>
<br>
Am 29.01.25 um 15:31 schrieb Maxime Ripard:<br>
&gt; Hi Thomas,<br>
&gt;<br>
&gt; On Wed, Jan 29, 2025 at 02:06:15PM +0100, Thomas Zimmermann wrote:<br>
&gt;&gt; Am 28.01.25 um 23:29 schrieb Anusha Srivatsa:<br>
&gt;&gt;&gt; Remove the TODO now that this series addresses<br>
&gt;&gt;&gt; the changes needed.<br>
&gt;&gt; While your series is fine, this TODO item is unrelated. It&#39;s a=
bout various<br>
&gt;&gt; ancient fbdev drivers that do not reserve their memory regions cor=
rectly. So<br>
&gt;&gt; please drop patch 14 form the series.<br>
&gt; Is it? Could we rephrase the entry then? I&#39;m the one that suggeste=
d<br>
&gt; Anusha to work on this, and it&#39;s still not clear to me what it mea=
ns<br>
&gt; exactly if it&#39;s not what she worked on :)<br>
<br>
I guess, we could make this more precise.<br>
<br>
Some old graphics drivers don&#39;t request their memory ranges correctly. =
<br>
It&#39;s usually a problem with hardware that has exclusive ranges, such as=
 <br>
the VGA. Vga16fb doesn&#39;t request the range as it should. Someone needs =
<br>
to audit all those old drivers and fix them.<br>
<br></blockquote><div><br></div><div>This sounds like a good next approach.=
 I will make the documentation more clear.</div><div><br></div><div>Thanks =
for feedback everyone!</div><div><br></div><div>Anusha <br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
Best regards<br>
Thomas<br>
<br>
<br>
&gt;<br>
&gt; Maxime<br>
<br>
-- <br>
--<br>
Thomas Zimmermann<br>
Graphics Driver Developer<br>
SUSE Software Solutions Germany GmbH<br>
Frankenstrasse 146, 90461 Nuernberg, Germany<br>
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman<br>
HRB 36809 (AG Nuernberg)<br>
<br>
</blockquote></div></div>

--00000000000049d89e062d68488b--


